import csv

from django.http import HttpResponse
from django.utils.dateparse import parse_date

from rest_framework import generics, permissions
from rest_framework.exceptions import ValidationError
from rest_framework.views import APIView

from .models import Transaction
from .serializers import TransactionSerializer
from drf_spectacular.utils import (
    extend_schema,
    OpenApiParameter,
)

@extend_schema(
    parameters=[
        OpenApiParameter(
            name="status",
            type=str,
            location=OpenApiParameter.QUERY,
            description="Filter by PENDING, SUCCESS, or FAILED",
            required=False,
            enum=["PENDING", "SUCCESS", "FAILED"],
        ),
        OpenApiParameter(
            name="min_amount",
            type=float,
            location=OpenApiParameter.QUERY,
            description="Minimum transaction amount",
            required=False,
        ),
        OpenApiParameter(
            name="max_amount",
            type=float,
            location=OpenApiParameter.QUERY,
            description="Maximum transaction amount",
            required=False,
        ),
        OpenApiParameter(
            name="start_date",
            type=str,
            location=OpenApiParameter.QUERY,
            description="Start date in YYYY-MM-DD format",
            required=False,
        ),
        OpenApiParameter(
            name="end_date",
            type=str,
            location=OpenApiParameter.QUERY,
            description="End date in YYYY-MM-DD format",
            required=False,
        ),
    ]
)

class TransactionListView(generics.ListAPIView):
    serializer_class = TransactionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        queryset = Transaction.objects.filter(
            user=self.request.user
        ).select_related("user")

        status_value = self.request.query_params.get("status")
        min_amount = self.request.query_params.get("min_amount")
        max_amount = self.request.query_params.get("max_amount")
        start_date = self.request.query_params.get("start_date")
        end_date = self.request.query_params.get("end_date")

        if status_value:
            status_value = status_value.upper()

            if status_value not in {
                "PENDING",
                "SUCCESS",
                "FAILED",
            }:
                raise ValidationError({
                    "status": "Use PENDING, SUCCESS, or FAILED."
                })

            queryset = queryset.filter(status=status_value)

        try:
            if min_amount:
                queryset = queryset.filter(
                    amount__gte=min_amount
                )

            if max_amount:
                queryset = queryset.filter(
                    amount__lte=max_amount
                )
        except (ValueError, TypeError):
            raise ValidationError({
                "amount": "Invalid amount."
            })

        if start_date:
            parsed_start = parse_date(start_date)

            if not parsed_start:
                raise ValidationError({
                    "start_date": "Use YYYY-MM-DD format."
                })

            queryset = queryset.filter(
                created_at__date__gte=parsed_start
            )

        if end_date:
            parsed_end = parse_date(end_date)

            if not parsed_end:
                raise ValidationError({
                    "end_date": "Use YYYY-MM-DD format."
                })

            queryset = queryset.filter(
                created_at__date__lte=parsed_end
            )

        return queryset.order_by("-created_at")


class TransactionCSVExportView(APIView):
    permission_classes = [permissions.IsAdminUser]

    def get(self, request):
        transactions = (
            Transaction.objects
            .select_related("user")
            .order_by("-created_at")
        )

        response = HttpResponse(
            content_type="text/csv"
        )

        response["Content-Disposition"] = (
            'attachment; filename="transactions.csv"'
        )

        writer = csv.writer(response)

        writer.writerow([
            "Transaction ID",
            "User ID",
            "Username",
            "Card ID",
            "Amount",
            "Status",
            "Created At",
            "Updated At",
        ])

        for transaction in transactions:
            writer.writerow([
                transaction.id,
                transaction.user_id,
                transaction.user.username,
                transaction.card_id,
                transaction.amount,
                transaction.status,
                transaction.created_at,
                transaction.updated_at,
            ])

        return response