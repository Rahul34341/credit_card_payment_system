import { useEffect, useState } from "react";
import Navbar from "../components/Navbar";
import { djangoApi } from "../services/api";

function AddCard() {
  const [cards, setCards] = useState([]);

  const [form, setForm] = useState({
    card_holder_name: "",
    card_type: "CREDIT",
    card_number: "",
    expiry_month: "",
    expiry_year: "",
  });

  const [message, setMessage] = useState("");

  const loadCards = async () => {
    try {
      const response = await djangoApi.get("/cards/");
      setCards(response.data);
    } catch (error) {
      setMessage("Unable to load cards.");
    }
  };

  useEffect(() => {
    loadCards();
  }, []);

  const handleChange = (e) => {
    setForm({
      ...form,
      [e.target.name]: e.target.value,
    });
  };

  const addCard = async (e) => {
    e.preventDefault();
    setMessage("");

    try {
      await djangoApi.post("/cards/", {
        ...form,
        expiry_month: Number(form.expiry_month),
        expiry_year: Number(form.expiry_year),
      });

      setMessage("Card added successfully.");

      setForm({
        card_holder_name: "",
        card_type: "CREDIT",
        card_number: "",
        expiry_month: "",
        expiry_year: "",
      });

      loadCards();
    } catch (error) {
      const data = error.response?.data;

      if (data) {
        setMessage(
          typeof data === "string"
            ? data
            : Object.values(data).flat().join(" ")
        );
      } else {
        setMessage("Unable to add card.");
      }
    }
  };

  const deleteCard = async (id) => {
    if (!window.confirm("Delete this card?")) {
      return;
    }

    try {
      await djangoApi.delete(`/api/cards/${id}/`);
      setMessage("Card deleted successfully.");
      loadCards();
    } catch (error) {
      setMessage("Unable to delete card.");
    }
  };

  return (
    <>
      <Navbar />

      <main className="max-w-5xl mx-auto p-6">
        <h1 className="text-3xl font-bold mb-6">
          Card Management
        </h1>

        <div className="bg-white rounded-xl shadow p-6">
          <h2 className="text-xl font-semibold mb-4">
            Add Card
          </h2>

          <form
            onSubmit={addCard}
            className="grid md:grid-cols-2 gap-4"
          >
            <input
              name="card_holder_name"
              value={form.card_holder_name}
              onChange={handleChange}
              placeholder="Card Holder Name"
              required
              className="border p-3 rounded-lg"
            />

            <select
              name="card_type"
              value={form.card_type}
              onChange={handleChange}
              className="border p-3 rounded-lg"
            >
              <option value="CREDIT">Credit Card</option>
              <option value="DEBIT">Debit Card</option>
            </select>

            <input
              name="card_number"
              value={form.card_number}
              onChange={handleChange}
              placeholder="Test Card Number"
              required
              className="border p-3 rounded-lg"
            />

            <div className="grid grid-cols-2 gap-3">
              <input
                type="number"
                name="expiry_month"
                value={form.expiry_month}
                onChange={handleChange}
                placeholder="Month"
                min="1"
                max="12"
                required
                className="border p-3 rounded-lg"
              />

              <input
                type="number"
                name="expiry_year"
                value={form.expiry_year}
                onChange={handleChange}
                placeholder="Year"
                required
                className="border p-3 rounded-lg"
              />
            </div>

            <button
              className="md:col-span-2 bg-blue-600 text-white p-3 rounded-lg"
            >
              Add Card
            </button>
          </form>

          <p className="text-sm text-gray-500 mt-4">
            CVV is never requested or stored. Only masked card
            information is saved.
          </p>

          {message && (
            <p className="mt-4">{message}</p>
          )}
        </div>

        <h2 className="text-xl font-semibold mt-8 mb-4">
          Saved Cards
        </h2>

        <div className="grid md:grid-cols-2 gap-4">
          {cards.map((card) => (
            <div
              key={card.id}
              className="bg-slate-800 text-white rounded-xl p-6"
            >
              <p className="text-sm">{card.card_type}</p>

              <p className="text-xl tracking-widest mt-5">
                {card.masked_card_number}
              </p>

              <p className="mt-5">
                {card.card_holder_name}
              </p>

              <p>
                Expires: {card.expiry_month}/{card.expiry_year}
              </p>

              <button
                onClick={() => deleteCard(card.id)}
                className="bg-red-600 px-4 py-2 rounded mt-5"
              >
                Delete
              </button>
            </div>
          ))}
        </div>
      </main>
    </>
  );
}

export default AddCard;