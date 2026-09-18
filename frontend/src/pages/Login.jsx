import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { djangoApi } from "../services/api";


function Login() {
  const navigate = useNavigate();

  const [form, setForm] = useState({
    username: "",
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
      const response = await djangoApi.post(
        "/auth/login/",
        form
      );

      localStorage.setItem(
        "access_token",
        response.data.access
      );

      localStorage.setItem(
        "refresh_token",
        response.data.refresh
      );

      navigate("/dashboard");
    } catch (err) {
      setError(
        err.response?.data?.detail ||
        "Invalid username or password."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-4">

      <div className="bg-white shadow-lg rounded-xl p-8 w-full max-w-md">

        <h1 className="text-3xl font-bold text-center mb-2">
          Welcome Back
        </h1>

        <p className="text-gray-500 text-center mb-6">
          Sign in to continue
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
              Password
            </label>

            <input
              type="password"
              name="password"
              value={form.password}
              onChange={handleChange}
              required
              className="w-full border rounded-lg p-3"
            />
          </div>

          <button
            disabled={loading}
            className="w-full bg-blue-600 hover:bg-blue-700 text-white p-3 rounded-lg font-semibold disabled:opacity-50"
          >
            {loading ? "Signing in..." : "Login"}
          </button>

        </form>

        <p className="text-center mt-5 text-gray-600">
          Don't have an account?{" "}

          <Link
            to="/register"
            className="text-blue-600 font-medium"
          >
            Register
          </Link>
        </p>

      </div>
    </div>
  );
}


export default Login;