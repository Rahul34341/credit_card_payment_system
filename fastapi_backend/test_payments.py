import os

os.environ.setdefault(
    "JWT_SIGNING_KEY",
    "test-only-jwt-signing-key-123456789"
)

from fastapi.testclient import TestClient
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool

import models
from auth import get_current_user_id
from database import Base, get_db
from main import app


# --------------------------------------------------
# Test database
# --------------------------------------------------

engine = create_engine(
    "sqlite://",
    connect_args={"check_same_thread": False},
    poolclass=StaticPool,
)

TestingSessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
)

Base.metadata.create_all(bind=engine)


# payments.py directly queries these Django tables,
# so create minimal test versions of them.
with engine.begin() as connection:

    connection.execute(
        text("""
            CREATE TABLE IF NOT EXISTS auth_user (
                id INTEGER PRIMARY KEY
            )
        """)
    )

    connection.execute(
        text("""
            CREATE TABLE IF NOT EXISTS cards_card (
                id INTEGER PRIMARY KEY,
                user_id INTEGER NOT NULL
            )
        """)
    )


def override_get_db():
    db = TestingSessionLocal()

    try:
        yield db
    finally:
        db.close()


app.dependency_overrides[get_db] = override_get_db


# During payment logic tests we don't need to generate
# a real JWT. Pretend the authenticated user is user 1.
def override_current_user():
    return 1


client = TestClient(app)


# --------------------------------------------------
# Helpers
# --------------------------------------------------

def reset_database():

    db = TestingSessionLocal()

    try:
        db.query(models.Payment).delete()

        db.execute(
            text("DELETE FROM cards_card")
        )

        db.execute(
            text("DELETE FROM auth_user")
        )

        db.execute(
            text("""
                INSERT INTO auth_user (id)
                VALUES (1)
            """)
        )

        db.execute(
            text("""
                INSERT INTO auth_user (id)
                VALUES (2)
            """)
        )

        db.execute(
            text("""
                INSERT INTO cards_card (id, user_id)
                VALUES (1, 1)
            """)
        )

        db.execute(
            text("""
                INSERT INTO cards_card (id, user_id)
                VALUES (2, 2)
            """)
        )

        db.commit()

    finally:
        db.close()


def setup_function():

    reset_database()

    app.dependency_overrides[
        get_current_user_id
    ] = override_current_user


# --------------------------------------------------
# Tests
# --------------------------------------------------

def test_root():

    response = client.get("/")

    assert response.status_code == 200

    assert response.json()["message"] == (
        "FastAPI Payment Service is running"
    )


def test_create_payment_pending():

    response = client.post(
        "/payments",
        json={
            "card_id": 1,
            "amount": 500
        }
    )

    assert response.status_code == 200

    data = response.json()

    assert data["card_id"] == 1
    assert float(data["amount"]) == 500
    assert data["status"] == "PENDING"


def test_invalid_card_rejected():

    response = client.post(
        "/payments",
        json={
            "card_id": 999,
            "amount": 500
        }
    )

    assert response.status_code == 404

    assert response.json()["detail"] == (
        "Card not found for this user"
    )


def test_another_users_card_rejected():

    # Card 2 belongs to user 2.
    # Current authenticated user is user 1.

    response = client.post(
        "/payments",
        json={
            "card_id": 2,
            "amount": 500
        }
    )

    assert response.status_code == 404

    assert response.json()["detail"] == (
        "Card not found for this user"
    )


def test_process_payment():

    create_response = client.post(
        "/payments",
        json={
            "card_id": 1,
            "amount": 500
        }
    )

    assert create_response.status_code == 200

    payment_id = create_response.json()["id"]

    response = client.post(
        f"/payments/{payment_id}/process"
    )

    assert response.status_code == 200

    data = response.json()

    assert data["status"] in [
        "SUCCESS",
        "FAILED"
    ]


def test_payment_cannot_be_processed_twice():

    create_response = client.post(
        "/payments",
        json={
            "card_id": 1,
            "amount": 500
        }
    )

    payment_id = create_response.json()["id"]

    first_response = client.post(
        f"/payments/{payment_id}/process"
    )

    assert first_response.status_code == 200

    second_response = client.post(
        f"/payments/{payment_id}/process"
    )

    assert second_response.status_code == 400

    assert second_response.json()["detail"] == (
        "Payment has already been processed"
    )


def test_payment_not_found():

    response = client.post(
        "/payments/999/process"
    )

    assert response.status_code == 404

    assert response.json()["detail"] == (
        "Payment not found"
    )