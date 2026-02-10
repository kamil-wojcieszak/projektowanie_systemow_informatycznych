import React from "react";
import CarCard from "../CarCard/CarCard";
import "./CarContainer.css";

const CarContainer = ({ onClick, onBookVisit }) => {
  const cars = [
    {
      name: "SC30",
      brand: "SuperCars",
      price: "250 000 zł",
      year: 2023
    },
    {
      name: "Xtreme 500",
      brand: "SuperCars",
      price: "320 000 zł",
      year: 2024
    },
  ];

  return (
    <div className="car-list">
      {cars.map((car, i) => (
        <CarCard
          key={i}
          car={car}
          onClick={() => onClick(car)}
          onBookVisit={onBookVisit}
        />
      ))}
    </div>
  );
};

export default CarContainer;
