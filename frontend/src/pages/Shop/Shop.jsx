import { useEffect, useState } from "react";
import Categories from "../../components/Categories/Categories";
import Filters from "../../components/Filters/Filters";
import ProductContainer from "../../components/ProductContainer/ProductContainer";
import ProductDetails from "../ProductDetails/ProductDetails";
import { useNavigate } from "react-router-dom";
import "./Shop.css";

export default function Shop() {
  const [products, setProducts] = useState();

  const navigate = useNavigate();

  useEffect(() => {
    setProducts([
      {
        group_id: 1,
        name: "Opona T3",
        price: 599.0,
        rate: 4.0,
        reviews: 34,
        mark: "FastTire",
        product_condition: "nowy",
        description: "Świetnej jakości opona T3",
        stock_status: 10,
        image_url: null,
        category_id: 2,
      },
      {
        group_id: 1,
        name: "Kierownica K35",
        price: 599.0,
        rate: 3.5,
        reviews: 6,
        mark: "Soft hold",
        product_condition: "nowy",
        description: "Wygodna kierownica K35",
        stock_status: 10,
        image_url: null,
        category_id: 2,
      },
      {
        group_id: 1,
        name: "Hamulec C8",
        price: 275.99,
        rate: 4.5,
        reviews: 128,
        mark: "Safe&Strong",
        product_condition: "nowy",
        description: "Hamulec C8. Przeznaczony dla",
        stock_status: 10,
        image_url: null,
        category_id: 2,
      },
    ]);
  }, []);

  // const products = [
  //   {
  //     group_id: 1,
  //     name: "Opona T3",
  //     price: "599.00 zł",
  //     rate: 4.0,
  //     reviews: 34,
  //     mark: "FastTire",
  //     product_condition: "nowy",
  //     description: "Świetnej jakości opona T3",
  //     stock_status: 10,
  //     image_url: null,
  //   },
  //   {
  //     group_id: 1,
  //     name: "Kierownica K35",
  //     price: "599.00 zł",
  //     rate: 3.5,
  //     reviews: 6,
  //     mark: "Soft hold",
  //     product_condition: "nowy",
  //     description: "Wygodna kierownica K35",
  //     stock_status: 10,
  //     image_url: null,
  //   },
  //   {
  //     group_id: 1,
  //     name: "Hamulec C8",
  //     price: "275.99 zł",
  //     rate: 4.5,
  //     reviews: 128,
  //     mark: "Safe&Strong",
  //     product_condition: "nowy",
  //     description: "Hamulec C8. Przeznaczony dla",
  //     stock_status: 10,
  //     image_url: null,
  //   },
  // ];

  const onClick = (id) => {
    console.log("clicked");
    // setSelectedProduct(true);
    navigate(`/sklep/szczegoly-produktu/${id}`);
  };
  return (
    <div className="main-container">
      <Categories />

      <div style={{ flex: 1 }}>
        <Filters />
        <div className="products-main-container">
          {products != null &&
            products.map((p) => (
              <ProductContainer onClick={onClick} product={p} />
            ))}
        </div>
      </div>
    </div>
  );
}
