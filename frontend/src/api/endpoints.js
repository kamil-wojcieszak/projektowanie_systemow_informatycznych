export const ENDPOINTS = {
  AUTH: {
    LOGIN: "/auth/login",
    REGISTER: "/auth/register",
  },
  PRODUCTS: {
    LIST: "https://z9zib25bsh.execute-api.eu-west-1.amazonaws.com/DEV/products/list?page=1&page_size=100",
    DETAILS: (id) => `https://z9zib25bsh.execute-api.eu-west-1.amazonaws.com/DEV/products/${id}`,
  },
};
