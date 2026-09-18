from datetime import date

from rest_framework import serializers

from .models import Card


def luhn_valid(number):
    """
    Validate a card number using the Luhn algorithm.
    """
    digits = [int(digit) for digit in number]

    checksum = 0
    parity = len(digits) % 2

    for index, digit in enumerate(digits):
        if index % 2 == parity:
            digit *= 2

            if digit > 9:
                digit -= 9

        checksum += digit

    return checksum % 10 == 0


class CardSerializer(serializers.ModelSerializer):
    # Full card number is accepted only as input.
    # It is never saved in the Card model.
    card_number = serializers.CharField(
        write_only=True,
        min_length=12,
        max_length=19,
    )

    class Meta:
        model = Card

        fields = [
            "id",
            "card_holder_name",
            "card_type",
            "card_number",
            "masked_card_number",
            "last_four",
            "expiry_month",
            "expiry_year",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "masked_card_number",
            "last_four",
            "created_at",
        ]

    def validate_card_number(self, value):
        # Allow spaces and hyphens in user input.
        number = value.replace(" ", "").replace("-", "")

        if not number.isdigit():
            raise serializers.ValidationError(
                "Card number must contain only digits."
            )

        if not 12 <= len(number) <= 19:
            raise serializers.ValidationError(
                "Card number must contain between 12 and 19 digits."
            )

        if not luhn_valid(number):
            raise serializers.ValidationError(
                "Invalid card number."
            )

        return number

    def validate_expiry_month(self, value):
        if value < 1 or value > 12:
            raise serializers.ValidationError(
                "Expiry month must be between 1 and 12."
            )

        return value

    def validate(self, attrs):
        month = attrs.get("expiry_month")
        year = attrs.get("expiry_year")

        today = date.today()

        if month is not None and year is not None:
            if year < today.year or (
                year == today.year
                and month < today.month
            ):
                raise serializers.ValidationError(
                    {
                        "expiry_date": "Card has expired."
                    }
                )

        return attrs

    def create(self, validated_data):
        # Remove the full card number before saving.
        card_number = validated_data.pop("card_number")

        last_four = card_number[-4:]

        masked_card_number = (
            "*" * (len(card_number) - 4)
            + last_four
        )

        return Card.objects.create(
            masked_card_number=masked_card_number,
            last_four=last_four,
            **validated_data,
        )