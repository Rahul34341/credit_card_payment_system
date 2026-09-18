import axios from "axios";

export const djangoApi = axios.create({
  baseURL:
    import.meta.env.VITE_DJANGO_API_URL ||
    "http://127.0.0.1:8000/api",
});

export const fastApi = axios.create({
  baseURL:
    import.meta.env.VITE_FASTAPI_API_URL ||
    "http://127.0.0.1:8001",
});

const addToken = (config) => {
  const token =
    localStorage.getItem("access_token");

  if (token) {
    config.headers.Authorization =
      `Bearer ${token}`;
  }

  return config;
};

djangoApi.interceptors.request.use(addToken);
fastApi.interceptors.request.use(addToken);