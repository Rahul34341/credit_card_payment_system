from datetime import date

from django.contrib.admin.views.decorators import staff_member_required
from django.db.models import Count, Sum
from django.shortcuts import render

from transactions.models import Transaction


@staff_member_required
def admin_dashboard(request):
    today = date.today()

    today_transactions = Transaction.objects.filter(
        created_at__date=today
    )

    summary = today_transactions.aggregate(
        total_transactions=Count("id"),
        total_amount=Sum("amount"),
    )

    successful_transactions = today_transactions.filter(
        status="SUCCESS"
    )

    failed_transactions = today_transactions.filter(
        status="FAILED"
    )

    pending_transactions = today_transactions.filter(
        status="PENDING"
    )

    successful_summary = successful_transactions.aggregate(
        count=Count("id"),
        amount=Sum("amount"),
    )

    context = {
        "today": today,

        "total_transactions":
            summary["total_transactions"] or 0,

        "total_amount":
            summary["total_amount"] or 0,

        "successful_count":
            successful_summary["count"] or 0,

        "successful_amount":
            successful_summary["amount"] or 0,

        "failed_count":
            failed_transactions.count(),

        "pending_count":
            pending_transactions.count(),

        "transactions":
            today_transactions.order_by("-created_at"),
    }

    return render(
        request,
        "dashboard/admin_dashboard.html",
        context,
    )