export const ENDPOINTS = {
  AUTH: {
    LOGIN: "/auth/login",
    REGISTER: "/auth/register",
  },
  PRODUCTS: {
    LIST: "/products",
    DETAILS: (id) => `/products/${id}`,
  },
};
