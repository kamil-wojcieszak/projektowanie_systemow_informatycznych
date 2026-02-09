import { useState } from "react";
import Categories from "../components/Categories/Categories";
import Filters from "../components/Filters/Filters";
import ProductContainer from "../components/ProductContainer/ProductContainer";
import ProductDetails from "../components/ProductDetails/ProductDetails";

export default function Shop() {
  const [selectedProduct, setSelectedProduct] = useState();

  const onClick = () => {
    console.log("clicked");
    setSelectedProduct(true);
  };
  return (
    <div style={{ display: "flex", gap: "24px" }}>
      <Categories />

      <div style={{ flex: 1 }}>
        <Filters />
        {selectedProduct ? (
          <ProductDetails />
        ) : (
          <ProductContainer onClick={onClick} />
        )}
      </div>
    </div>
  );
}
