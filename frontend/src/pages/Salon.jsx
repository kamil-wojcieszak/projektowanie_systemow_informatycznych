import { useState } from "react";
import CarContainer from "../components/CarContainer/CarContainer";
import VisitForm from "../components/VisitForm/VisitForm";
import SalonNavigation from "../components/SalonNavigation/SalonNavigation";

export default function Salon() {
  const [selectedCar, setSelectedCar] = useState(null);
  const [activeTab, setActiveTab] = useState("cars"); // "cars" lub "visit"

  const onCarClick = (car) => {
    setSelectedCar(car);
    setActiveTab("cars"); // zostajemy w zakładce "Samochody"
  };

  const onBookVisit = (car) => {
    setSelectedCar(car);
    setActiveTab("visit"); // przechodzimy do formularza
  };

  return (
    <div style={{ display: "flex", gap: "24px" }}>
      <SalonNavigation activeTab={activeTab} setActiveTab={setActiveTab} />
      <div style={{ flex: 1, minWidth: 0  }}>
        {activeTab === "cars" ? (
          <CarContainer onClick={onCarClick} onBookVisit={onBookVisit} />
        ) : (
          <VisitForm car={selectedCar} />
        )}
      </div>
    </div>
  );
}
