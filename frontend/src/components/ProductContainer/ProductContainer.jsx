import React from "react";
import { FaStar } from "react-icons/fa";
import "./ProductContainer.css";

const ProductContainer = ({ product, onClick }) => {
  return (
    <div className="widget-container" onClick={() => onClick(product.group_id)}>
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
            <span>{product.rate} / 5.0</span>
            <span>({product.reviews})</span>
          </div>
        </div>
      </div>

      <div className="widget-details">
        <p>
          Marka: <span>{product.mark}</span>
        </p>
        <p>
          Opis: <span>{product.description}</span>
        </p>
        <p>
          Stan: <span>{product.product_condition}</span>
        </p>
      </div>

      <button className="widget-link">Pokaż więcej...</button>
    </div>
  );
};

export default ProductContainer;
