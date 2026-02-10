import React from "react";
import { FaStar } from "react-icons/fa";
import "./ProductContainer.css";
import { useTranslation } from "react-i18next";

const ProductContainer = ({ product, onClick }) => {
  const { t } = useTranslation();

  return (
    <div className="widget-container" onClick={() => onClick(product.group_id)}>
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
          {t("product.brand")}: <span>{product.mark}</span>
        </p>
        <p>
          {t("product.description")}: <span>{product.description}</span>
        </p>
        <p>
          {t("product.condition")}: <span>{product.product_condition}</span>
        </p>
      </div>

      <button className="widget-link">{t("product.showMore")}</button>
    </div>
  );
};

export default ProductContainer;
