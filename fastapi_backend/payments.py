import random

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import text
from sqlalchemy.orm import Session

import models
import schemas

from auth import get_current_user_id
from database import get_db


router = APIRouter(
    prefix="/payments",
    tags=["Payments"]
)


@router.post(
    "",
    response_model=schemas.PaymentResponse
)
def make_payment(
    payment: schemas.PaymentRequest,
    user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db)
):
    user = db.execute(
        text(
            """
            SELECT id
            FROM auth_user
            WHERE id = :user_id
            """
        ),
        {"user_id": user_id}
    ).first()

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    card = db.execute(
        text(
            """
            SELECT id
            FROM cards_card
            WHERE id = :card_id
              AND user_id = :user_id
            """
        ),
        {
            "card_id": payment.card_id,
            "user_id": user_id
        }
    ).first()

    if not card:
        raise HTTPException(
            status_code=404,
            detail="Card not found for this user"
        )

    new_payment = models.Payment(
        user_id=user_id,
        card_id=payment.card_id,
        amount=payment.amount,
        status="PENDING"
    )

    db.add(new_payment)
    db.commit()
    db.refresh(new_payment)

    return new_payment


@router.post(
    "/{payment_id}/process",
    response_model=schemas.PaymentResponse
)
def process_payment(
    payment_id: int,
    user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db)
):
    payment = (
        db.query(models.Payment)
        .filter(
            models.Payment.id == payment_id,
            models.Payment.user_id == user_id
        )
        .first()
    )

    if not payment:
        raise HTTPException(
            status_code=404,
            detail="Payment not found"
        )

    if payment.status != "PENDING":
        raise HTTPException(
            status_code=400,
            detail="Payment has already been processed"
        )

    payment.status = random.choice([
        "SUCCESS",
        "FAILED"
    ])

    db.commit()
    db.refresh(payment)

    return payment