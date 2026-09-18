import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import Navbar from "../components/Navbar";
import { djangoApi } from "../services/api";

function Dashboard() {
  const [user, setUser] = useState(null);
  const [cards, setCards] = useState([]);
  const [transactions, setTransactions] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadDashboard = async () => {
      try {
        const [userResponse, cardResponse, transactionResponse] =
          await Promise.all([
             djangoApi.get("/auth/me/"),
             djangoApi.get("/cards/"),
             djangoApi.get("/transactions/"),
      ]);

        setUser(userResponse.data);
        setCards(cardResponse.data);
        setTransactions(transactionResponse.data);
      } catch (err) {
        setError("Unable to load dashboard.");
      }
    };

    loadDashboard();
  }, []);

  const successful = transactions.filter(
    (item) => item.status === "SUCCESS"
  ).length;

  const pending = transactions.filter(
    (item) => item.status === "PENDING"
  ).length;

  const failed = transactions.filter(
    (item) => item.status === "FAILED"
  ).length;

  return (
    <>
      <Navbar />

      <main className="max-w-6xl mx-auto p-6">
        <h1 className="text-3xl font-bold">
          Welcome {user?.username || ""}
        </h1>

        <p className="text-gray-600 mt-1">
          Credit Card Payment Dashboard
        </p>

        {error && (
          <p className="text-red-600 mt-4">{error}</p>
        )}

        <div className="grid md:grid-cols-4 gap-4 mt-8">
          <SummaryCard title="Saved Cards" value={cards.length} />
          <SummaryCard title="Successful" value={successful} />
          <SummaryCard title="Pending" value={pending} />
          <SummaryCard title="Failed" value={failed} />
        </div>

        <h2 className="text-xl font-semibold mt-10 mb-4">
          Quick Actions
        </h2>

        <div className="grid md:grid-cols-3 gap-4">
          <ActionCard
            title="Add Card"
            description="Add a new credit or debit card."
            path="/cards"
          />

          <ActionCard
            title="Make Payment"
            description="Create and process a payment."
            path="/payment"
          />

          <ActionCard
            title="Transactions"
            description="View your transaction history."
            path="/transactions"
          />
        </div>
      </main>
    </>
  );
}

function SummaryCard({ title, value }) {
  return (
    <div className="bg-white shadow rounded-xl p-5">
      <p className="text-gray-500">{title}</p>
      <p className="text-3xl font-bold mt-2">{value}</p>
    </div>
  );
}

function ActionCard({ title, description, path }) {
  return (
    <Link
      to={path}
      className="bg-white shadow rounded-xl p-6 hover:shadow-lg"
    >
      <h3 className="font-bold text-lg">{title}</h3>
      <p className="text-gray-600 mt-2">{description}</p>
    </Link>
  );
}

export default Dashboard;