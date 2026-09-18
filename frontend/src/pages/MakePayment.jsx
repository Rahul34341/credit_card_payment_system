import { useEffect, useState } from "react";
import Navbar from "../components/Navbar";
import { djangoApi, fastApi } from "../services/api";

function MakePayment() {
  const [cards, setCards] = useState([]);
  const [cardId, setCardId] = useState("");
  const [amount, setAmount] = useState("");
  const [payment, setPayment] = useState(null);
  const [message, setMessage] = useState("");

  useEffect(() => {
    const loadCards = async () => {
      try {
        const response = await djangoApi.get("/cards/");
        setCards(response.data);

        if (response.data.length > 0) {
          setCardId(String(response.data[0].id));
        }
      } catch (error) {
        setMessage("Unable to load cards.");
      }
    };

    loadCards();
  }, []);

  const createPayment = async (e) => {
    e.preventDefault();
    setMessage("");

    try {
      const response = await fastApi.post(
        "/payments",
        {
          card_id: Number(cardId),
          amount: Number(amount),
        }
      );

      setPayment(response.data);
      setMessage("Payment created with PENDING status.");
    } catch (error) {
    console.error("Payment error:", error);
    console.error("Response:", error.response?.data);

    const detail = error.response?.data?.detail;

    if (Array.isArray(detail)) {
    setMessage(
      detail
        .map((item) => item.msg)
        .join(", ")
    );
  } else if (typeof detail === "string") {
    setMessage(detail);
  } else if (error.message) {
    setMessage(error.message);
  } else {
    setMessage("Unable to create payment.");
  }
}
  };

  const processPayment = async () => {
    if (!payment) {
      return;
    }

    try {
      const response = await fastApi.post(
        `/payments/${payment.id}/process`
      );

      setPayment(response.data);
      setMessage(
        `Payment processed: ${response.data.status}`
      );
    } catch (error) {
      setMessage(
        error.response?.data?.detail ||
        "Unable to process payment."
      );
    }
  };

  return (
    <>
      <Navbar />

      <main className="max-w-2xl mx-auto p-6">
        <h1 className="text-3xl font-bold mb-6">
          Make Payment
        </h1>

        <div className="bg-white shadow rounded-xl p-6">
          {cards.length === 0 ? (
            <p>
              You don't have a saved card. Add a card first.
            </p>
          ) : (
            <form
              onSubmit={createPayment}
              className="space-y-4"
            >
              <div>
                <label className="block mb-2">
                  Select Card
                </label>

                <select
                  value={cardId}
                  onChange={(e) => setCardId(e.target.value)}
                  className="border p-3 rounded-lg w-full"
                >
                  {cards.map((card) => (
                    <option key={card.id} value={card.id}>
                      {card.card_type} - {card.masked_card_number}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block mb-2">
                  Amount
                </label>

                <input
                  type="number"
                  min="0.01"
                  step="0.01"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  required
                  className="border p-3 rounded-lg w-full"
                  placeholder="500.00"
                />
              </div>

              <button className="bg-blue-600 text-white p-3 rounded-lg w-full">
                Create Payment
              </button>
            </form>
          )}

          {message && (
            <p className="mt-5 font-medium">{message}</p>
          )}

          {payment && (
            <div className="border rounded-lg p-5 mt-6">
              <p>
                Payment ID: <strong>{payment.id}</strong>
              </p>

              <p>
                Amount: <strong>₹{payment.amount}</strong>
              </p>

              <p>
                Status: <strong>{payment.status}</strong>
              </p>

              {payment.status === "PENDING" && (
                <button
                  onClick={processPayment}
                  className="bg-green-600 text-white px-5 py-2 rounded-lg mt-4"
                >
                  Process Payment
                </button>
              )}
            </div>
          )}
        </div>
      </main>
    </>
  );
}

export default MakePayment;