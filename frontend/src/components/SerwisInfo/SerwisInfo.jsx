import React from "react";
import "./SerwisInfo.css";

const SerwisInfo = () => {
  const services = [
    { name: "Wymiana oleju", price: "150 zł" },
    { name: "Przegląd techniczny", price: "200 zł" },
    { name: "Wymiana opon", price: "100 zł" },
    { name: "Diagnostyka komputerowa", price: "120 zł" },
  ];

  return (
    <div className="service-list">
      {services.map((s, i) => (
        <div key={i} className="service-card">
          <h3>{s.name}</h3>
          <p>Cena: {s.price}</p>
        </div>
      ))}
    </div>
  );
};

export default SerwisInfo;
