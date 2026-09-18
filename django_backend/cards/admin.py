from django.contrib import admin
from .models import Card


@admin.register(Card)
class CardAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "user",
        "card_holder_name",
        "card_type",
        "masked_card_number",
        "last_four",
        "expiry_month",
        "expiry_year",
        "created_at",
    )

    list_filter = (
        "card_type",
        "created_at",
    )

    search_fields = (
        "user__username",
        "user__email",
        "card_holder_name",
        "last_four",
    )

    readonly_fields = (
        "user",
        "card_holder_name",
        "card_type",
        "masked_card_number",
        "last_four",
        "expiry_month",
        "expiry_year",
        "created_at",
    )

    ordering = ("-created_at",)

    def has_add_permission(self, request):
        return False