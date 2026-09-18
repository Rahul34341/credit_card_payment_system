from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import models
from database import engine
from payments import router as payment_router


models.Base.metadata.create_all(bind=engine)


app = FastAPI(
    title="Credit Card Payment System - Payment API",
    description="Simulated payment processing service",
    version="1.0.0",
)


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def root():
    return {
        "message": "FastAPI Payment Service is running"
    }


app.include_router(payment_router)