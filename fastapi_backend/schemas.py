from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, Field


class PaymentRequest(BaseModel):
    card_id: int = Field(gt=0)

    amount: Decimal = Field(
        gt=0,
        max_digits=10,
        decimal_places=2
    )


class PaymentResponse(BaseModel):
    id: int
    user_id: int
    card_id: int
    amount: Decimal
    status: str
    created_at: datetime

    model_config = {
        "from_attributes": True
    }