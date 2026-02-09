// CarCard.jsx
import React from "react";
import "./CarCard.css";

const CarCard = ({ car, onClick, onBookVisit }) => {
  return (
    <div className="car-card" onClick={onClick}>
      {/* Placeholder grafiki z krzyżykiem */}
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
        Umów wizytę
      </button>
    </div>
  );
};

export default CarCard;
