import { useEffect, useState } from "react";
import Navbar from "../components/Navbar";
import { djangoApi } from "../services/api";

function Transactions() {
  const [transactions, setTransactions] = useState([]);

  const [filters, setFilters] = useState({
    status: "",
    min_amount: "",
    max_amount: "",
    start_date: "",
    end_date: "",
  });

  const [message, setMessage] = useState("");

  const loadTransactions = async () => {
    try {
      const params = {};

      Object.entries(filters).forEach(([key, value]) => {
        if (value) {
          params[key] = value;
        }
      });

      const response = await djangoApi.get(
        "/transactions/",
        { params }
      );

      setTransactions(response.data);
      setMessage("");
    } catch (error) {
      setMessage("Unable to load transactions.");
    }
  };

  useEffect(() => {
    loadTransactions();
  }, []);

  const handleChange = (e) => {
    setFilters({
      ...filters,
      [e.target.name]: e.target.value,
    });
  };

  const filterTransactions = (e) => {
    e.preventDefault();
    loadTransactions();
  };

  const clearFilters = () => {
    setFilters({
      status: "",
      min_amount: "",
      max_amount: "",
      start_date: "",
      end_date: "",
    });

    setTimeout(() => {
      window.location.reload();
    }, 0);
  };

  return (
    <>
      <Navbar />

      <main className="max-w-7xl mx-auto p-6">
        <h1 className="text-3xl font-bold mb-6">
          Transaction History
        </h1>

        <form
          onSubmit={filterTransactions}
          className="bg-white shadow rounded-xl p-5 grid md:grid-cols-5 gap-3"
        >
          <select
            name="status"
            value={filters.status}
            onChange={handleChange}
            className="border p-2 rounded"
          >
            <option value="">All Statuses</option>
            <option value="SUCCESS">Success</option>
            <option value="FAILED">Failed</option>
            <option value="PENDING">Pending</option>
          </select>

          <input
            type="number"
            name="min_amount"
            value={filters.min_amount}
            onChange={handleChange}
            placeholder="Min Amount"
            className="border p-2 rounded"
          />

          <input
            type="number"
            name="max_amount"
            value={filters.max_amount}
            onChange={handleChange}
            placeholder="Max Amount"
            className="border p-2 rounded"
          />

          <input
            type="date"
            name="start_date"
            value={filters.start_date}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="date"
            name="end_date"
            value={filters.end_date}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <button className="bg-blue-600 text-white p-2 rounded">
            Apply Filters
          </button>

          <button
            type="button"
            onClick={clearFilters}
            className="bg-gray-600 text-white p-2 rounded"
          >
            Clear
          </button>
        </form>

        {message && (
          <p className="text-red-600 mt-4">{message}</p>
        )}

        <div className="overflow-x-auto mt-6">
          <table className="w-full bg-white shadow rounded-lg">
            <thead className="bg-slate-900 text-white">
              <tr>
                <th className="p-3">ID</th>
                <th className="p-3">Card</th>
                <th className="p-3">Amount</th>
                <th className="p-3">Status</th>
                <th className="p-3">Date</th>
              </tr>
            </thead>

            <tbody>
              {transactions.map((transaction) => (
                <tr
                  key={transaction.id}
                  className="border-b text-center"
                >
                  <td className="p-3">
                    {transaction.id}
                  </td>

                  <td className="p-3">
                    {transaction.card_id}
                  </td>

                  <td className="p-3">
                    ₹{transaction.amount}
                  </td>

                  <td className="p-3">
                    <strong>
                      {transaction.status}
                    </strong>
                  </td>

                  <td className="p-3">
                    {new Date(
                      transaction.created_at
                    ).toLocaleString()}
                  </td>
                </tr>
              ))}

              {transactions.length === 0 && (
                <tr>
                  <td
                    colSpan="5"
                    className="p-5 text-center"
                  >
                    No transactions found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </main>
    </>
  );
}

export default Transactions;