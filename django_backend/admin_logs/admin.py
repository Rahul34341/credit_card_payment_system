from django.contrib import admin

from .models import AdminLog


@admin.register(AdminLog)
class AdminLogAdmin(admin.ModelAdmin):

    list_display = (
        "id",
        "admin",
        "action",
        "created_at",
    )

    search_fields = (
        "admin__username",
        "action",
        "description",
    )

    list_filter = (
        "action",
        "created_at",
    )

    readonly_fields = (
        "admin",
        "action",
        "description",
        "created_at",
    )

    def has_add_permission(self, request):
        return False