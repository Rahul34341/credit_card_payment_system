from django.conf import settings
from django.db import models

class Transaction(models.Model):
    STATUS_CHOICES = [
        ("PENDING", "Pending"),
        ("SUCCESS", "Success"),
        ("FAILED", "Failed"),
    ]

    id = models.AutoField(primary_key=True)

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.DO_NOTHING,
        db_column="user_id",
        related_name="payment_transactions",
    )

    card_id = models.IntegerField()

    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2
    )

    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES
    )

    created_at = models.DateTimeField()

    updated_at = models.DateTimeField()

    class Meta:
        db_table = "payments"
        managed = False
        ordering = ["-created_at"]

    def __str__(self):
        return f"Transaction {self.id} - {self.status}"