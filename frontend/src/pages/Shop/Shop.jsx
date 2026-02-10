import { useEffect, useState } from "react";
import Categories from "../../components/Categories/Categories";
import Filters from "../../components/Filters/Filters";
import ProductContainer from "../../components/ProductContainer/ProductContainer";
import { useNavigate } from "react-router-dom";
import { ENDPOINTS } from "../../api/endpoints"; // dopasuj ścieżkę
import toast, { Toaster } from "react-hot-toast";
import "./Shop.css";

export default function Shop() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const res = await fetch(ENDPOINTS.PRODUCTS.LIST);
        console.log("status:", res.status);

        if (!res.ok) throw new Error(`Błąd pobierania: ${res.status}`);

        // Tylko jedno odczytanie strumienia
        const data = await res.json();
        console.log("Odpowiedź z API:", data);

        // Zakładamy, że API zwraca { data: { products: [...] } }
        const fetchedProducts = data.data.products.map((p) => ({
          ...p,
          reviews: p.reviews || 0,
          product_condition: p.product_condition || "N/A",
        }));

        setProducts(fetchedProducts);
        setLoading(false);
      } catch (err) {
        console.error(err);
        toast.error("Nie udało się pobrać produktów");
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  const onClick = (id) => {
    navigate(`/sklep/szczegoly-produktu/${id}`);
  };

  if (loading) return <p>Ładowanie produktów...</p>;

  return (
    <div className="main-container">
      <Toaster />
      <Categories />
      <div style={{ flex: 1 }}>
        <Filters />
        <div className="products-main-container">
          {products.map((p) => (
            <ProductContainer
              key={`${p.group_id}-${p.name}`} // unikalny key
              onClick={onClick}
              product={p}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
