import logo from "./logo.svg";
import "./App.css";
import Shop from "./pages/Shop";
import Start from "./pages/Start";
import Service from "./pages/Service";
import { Routes, Route, Link } from "react-router-dom";
import MainLayout from "./layouts/MainLayout/MainLayout";
import ShoppingCart from "./pages/ShoppingCart/ShoppingCart";
import Salon from "./pages/Salon";

function App() {
  return (
    <>
      <MainLayout />

      <Routes>
        <Route path="sklep" element={<Shop />} />
        <Route path="serwis" element={<Service />} />
        <Route path="koszyk" element={<ShoppingCart />} />
        <Route path="salon" element={<Salon />} />
      </Routes>
    </>
  );
}

export default App;
