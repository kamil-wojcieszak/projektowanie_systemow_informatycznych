import React from "react";
import { useTranslation } from "react-i18next";
import "./CarCard.css";

const CarCard = ({ car, onClick, onBookVisit }) => {
  const { t } = useTranslation();

  return (
    <div className="car-card" onClick={onClick}>
      <div className="car-image-box">
        <div className="cross-line line-1"></div>
        <div className="cross-line line-2"></div>
      </div>

      <h2 className="car-title">{car.name}</h2>

      <div className="car-info-row">
        <span className="car-brand">{car.brand}</span>
        <span className="car-price">{car.price}</span>
        <span className="car-year">{car.year}</span>
      </div>

      <button
        className="car-link"
        onClick={(e) => {
          e.stopPropagation();
          onBookVisit(car);
        }}
      >
        {t("car.bookVisit")}
      </button>
    </div>
  );
};

export default CarCard;
