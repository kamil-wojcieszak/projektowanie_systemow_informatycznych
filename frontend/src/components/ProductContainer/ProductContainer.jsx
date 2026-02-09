import React from "react";
import { FaStar } from "react-icons/fa";
import "./ProductContainer.css";

const ProductContainer = ({ onClick }) => {
  const product = {
    name: "Lampa żarowa",
    price: "9.00 zł",
    rating: 4.0,
    reviews: 34,
    title: "Strong lamp",
    status: "nowy",
  };

  return (
    <div className="widget-container" onClick={onClick}>
      {/* Kontener na grafikę z krzyżykiem */}
      <div className="widget-image-box">
        <div className="cross-line line-1"></div>
        <div className="cross-line line-2"></div>
      </div>

      <h2 className="widget-title">{product.name}</h2>

      <div className="widget-info-row">
        <span className="widget-price">{product.price}</span>
        <div className="widget-rating">
          <FaStar />
          <div className="rating-details">
            <span>{product.rating} / 5.0</span>
            <span>({product.reviews})</span>
          </div>
        </div>
      </div>

      <div className="widget-details">
        <p>
          Marka: <span>{product.title}</span>
        </p>
        <p>
          Stan: <span>{product.status}</span>
        </p>
      </div>

      <button className="widget-link">Pokaż więcej...</button>
    </div>
  );
};

export default ProductContainer;
