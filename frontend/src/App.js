import logo from "./logo.svg";
import "./App.css";
import Shop from "./pages/Shop";
import Start from "./pages/Start";
import Service from "./pages/Service";
import { Routes, Route, Link } from "react-router-dom";
import MainLayout from "./layouts/MainLayout/MainLayout";
import ShoppingCart from "./pages/ShoppingCart/ShoppingCart";
import ShippingForm from "./pages/ShippingForm/ShippingForm";
import PaymentMethod from "./pages/PaymentMethod/PaymentMethod";
import { Navigate } from "react-router-dom";
import ProductDetails from "./pages/ProductDetails/ProductDetails";
import Salon from "./pages/Salon";
import { Toaster } from "react-hot-toast";
import LoginScreen from "./pages/LoginScreen/LoginScreen";
import ProtectedRoute from "./components/ProtectedRoute/ProtectedRoute";

function App() {
  return (
    <>
      <Toaster position="bottom-center" reverseOrder={false} />

      <Routes>
        {/* 1. Ekran logowania jako publiczna ścieżka */}
        <Route path="/login" element={<LoginScreen />} />

        {/* 2. Chronione ścieżki */}
        <Route
          path="/*"
          element={
            <ProtectedRoute>
              <>
                <MainLayout /> {/* Layout widoczny tylko dla zalogowanych */}
                <Routes>
                  <Route path="/" element={<Navigate to="/sklep" replace />} />
                  <Route path="sklep" element={<Shop />} />
                  <Route
                    path="sklep/szczegoly-produktu/:id"
                    element={<ProductDetails />}
                  />
                  <Route path="serwis" element={<Service />} />
                  <Route path="koszyk" element={<ShoppingCart />} />
                  <Route path="salon" element={<Salon />} />
                  <Route
                    path="koszyk/dane-dostawy"
                    element={<ShippingForm />}
                  />
                  <Route
                    path="koszyk/podsumowanie"
                    element={<ShoppingCart isSummary={true} />}
                  />
                  <Route
                    path="koszyk/metoda-platnosci"
                    element={<PaymentMethod />}
                  />
                  {/* Catch-all dla zalogowanych */}
                  <Route path="*" element={<Navigate to="/sklep" replace />} />
                </Routes>
              </>
            </ProtectedRoute>
          }
        />
      </Routes>
    </>
    // <>
    //   <Toaster position="bottom-center" reverseOrder={false} />
    //   <MainLayout />

    //   <Routes>
    //     <Route path="start" element={<Navigate to="/sklep" replace />} />
    //     <Route path="sklep" element={<Shop />} />
    //     <Route
    //       path="sklep/szczegoly-produktu/:id"
    //       element={<ProductDetails />}
    //     />
    //     <Route path="serwis" element={<Service />} />
    //     <Route path="koszyk" element={<ShoppingCart />} />
    //     <Route path="salon" element={<Salon />} />
    //     <Route path="koszyk/dane-dostawy" element={<ShippingForm />} />
    //     <Route
    //       path="koszyk/podsumowanie"
    //       element={<ShoppingCart isSummary={true} />}
    //     />
    //     <Route path="koszyk/metoda-platnosci" element={<PaymentMethod />} />
    //   </Routes>
    // </>
  );
}

export default App;
