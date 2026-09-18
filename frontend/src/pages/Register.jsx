import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { djangoApi } from "../services/api";


function Register() {
  const navigate = useNavigate();

  const [form, setForm] = useState({
    username: "",
    email: "",
    password: "",
  });

  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleChange = (event) => {
    setForm({
      ...form,
      [event.target.name]: event.target.value,
    });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    setError("");
    setLoading(true);

    try {
      await djangoApi.post("/auth/register/", form);
      navigate("/login");
    } catch (err) {
      const data = err.response?.data;

      if (data) {
        setError(
          Object.values(data).flat().join(" ")
        );
      } else {
        setError("Unable to register.");
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-4">
      <div className="bg-white shadow-lg rounded-xl p-8 w-full max-w-md">

        <h1 className="text-3xl font-bold text-center mb-2">
          Create Account
        </h1>

        <p className="text-gray-500 text-center mb-6">
          Credit Card Payment System
        </p>

        {error && (
          <div className="bg-red-50 text-red-600 p-3 rounded-lg mb-4">
            {error}
          </div>
        )}

        <form
          onSubmit={handleSubmit}
          className="space-y-4"
        >
          <div>
            <label className="block mb-1 font-medium">
              Username
            </label>

            <input
              name="username"
              value={form.username}
              onChange={handleChange}
              required
              className="w-full border rounded-lg p-3"
            />
          </div>

          <div>
            <label className="block mb-1 font-medium">
              Email
            </label>

            <input
              type="email"
              name="email"
              value={form.email}
              onChange={handleChange}
              required
              className="w-full border rounded-lg p-3"
            />
          </div>

          <div>
            <label className="block mb-1 font-medium">
              Password
            </label>

            <input
              type="password"
              name="password"
              value={form.password}
              onChange={handleChange}
              required
              minLength={8}
              className="w-full border rounded-lg p-3"
            />
          </div>

          <button
            disabled={loading}
            className="w-full bg-blue-600 hover:bg-blue-700 text-white p-3 rounded-lg font-semibold disabled:opacity-50"
          >
            {loading ? "Creating..." : "Register"}
          </button>
        </form>

        <p className="text-center mt-5 text-gray-600">
          Already have an account?{" "}
          <Link
            to="/login"
            className="text-blue-600 font-medium"
          >
            Login
          </Link>
        </p>

      </div>
    </div>
  );
}


export default Register;