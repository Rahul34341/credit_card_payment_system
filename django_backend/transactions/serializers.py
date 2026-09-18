from rest_framework import serializers
from .models import Transaction

class TransactionSerializer(serializers.ModelSerializer):
    username = serializers.CharField(
        source="user.username",
        read_only=True
    )

    class Meta:
        model = Transaction
        fields = [
            "id",
            "user_id",
            "username",
            "card_id",
            "amount",
            "status",
            "created_at",
            "updated_at",
        ]