from django.urls import path

from .views import (
    TransactionCSVExportView,
    TransactionListView,
)


urlpatterns = [
    path(
        "",
        TransactionListView.as_view(),
        name="transaction-list",
    ),

    path(
        "export/csv/",
        TransactionCSVExportView.as_view(),
        name="transaction-export-csv",
    ),
]