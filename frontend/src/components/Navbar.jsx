import { Link, useNavigate } from "react-router-dom";
import { djangoApi } from "../services/api";

function Navbar() {
  const navigate = useNavigate();

  const logout = async () => {
    const refresh = localStorage.getItem("refresh_token");

    try {
      if (refresh) {
        await djangoApi.post("/auth/logout/", { refresh });
      }
    } catch (error) {
      console.error("Logout request failed");
    }

    localStorage.removeItem("access_token");
    localStorage.removeItem("refresh_token");

    navigate("/login");
  };

  return (
    <nav className="bg-slate-900 text-white px-6 py-4 flex flex-wrap gap-5 items-center">
      <Link to="/dashboard" className="font-bold text-xl">
        Payment System
      </Link>

      <div className="flex flex-wrap gap-4 ml-auto">
        <Link to="/dashboard">Dashboard</Link>
        <Link to="/cards">Cards</Link>
        <Link to="/payment">Payment</Link>
        <Link to="/transactions">Transactions</Link>
        <Link to="/admin-dashboard">Admin</Link>

        <button
          onClick={logout}
          className="bg-red-600 px-3 py-1 rounded"
        >
          Logout
        </button>
      </div>
    </nav>
  );
}

export default Navbar;