import Navbar from "../components/Navbar";

function AdminDashboard() {
  const token = localStorage.getItem("access_token");

  const exportCSV = async () => {
    try {
      const response = await fetch(
        "http://127.0.0.1:8000/api/transactions/export/csv/",
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (response.status === 403) {
        alert("Admin access required.");
        return;
      }

      if (!response.ok) {
        alert("Unable to export transactions.");
        return;
      }

      const blob = await response.blob();

      const url = window.URL.createObjectURL(blob);

      const link = document.createElement("a");
      link.href = url;
      link.download = "transactions.csv";

      document.body.appendChild(link);
      link.click();
      link.remove();

      window.URL.revokeObjectURL(url);
    } catch (error) {
      alert("CSV export failed.");
    }
  };

  return (
    <>
      <Navbar />

      <main className="max-w-5xl mx-auto p-6">
        <h1 className="text-3xl font-bold">
          Admin Dashboard
        </h1>

        <p className="text-gray-600 mt-2">
          Administrative tools and reports
        </p>

        <div className="grid md:grid-cols-2 gap-5 mt-8">
          <AdminCard
            title="Django Administration"
            description="Manage users, cards and transactions."
            url="http://127.0.0.1:8000/admin/"
          />

          <AdminCard
            title="Daily Payment Summary"
            description="View today's payment summary."
            url="http://127.0.0.1:8000/admin-dashboard/daily-summary/"
          />

          <button
            onClick={exportCSV}
            className="bg-white shadow rounded-xl p-6 text-left hover:shadow-lg"
          >
            <h2 className="font-bold text-xl">
              Export Transactions
            </h2>

            <p className="text-gray-600 mt-2">
              Download the complete transaction report as CSV.
            </p>
          </button>
        </div>
      </main>
    </>
  );
}

function AdminCard({ title, description, url }) {
  return (
    <a
      href={url}
      target="_blank"
      rel="noreferrer"
      className="bg-white shadow rounded-xl p-6 hover:shadow-lg"
    >
      <h2 className="font-bold text-xl">{title}</h2>
      <p className="text-gray-600 mt-2">{description}</p>
    </a>
  );
}

export default AdminDashboard;