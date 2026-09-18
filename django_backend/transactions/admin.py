from django.contrib import admin
from .models import Transaction


@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "user",
        "card_id",
        "amount",
        "status",
        "created_at",
        "updated_at",
    )

    list_filter = (
        "status",
        "created_at",
    )

    search_fields = (
        "user__username",
        "user__email",
    )

    readonly_fields = (
        "id",
        "user",
        "card_id",
        "amount",
        "status",
        "created_at",
        "updated_at",
    )

    ordering = ("-created_at",)

    def has_add_permission(self, request):
        return False