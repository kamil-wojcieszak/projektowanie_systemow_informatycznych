import React from "react";
import "./SerwisInfo.css";
import { useTranslation } from "react-i18next";

const SerwisInfo = () => {
  const { t } = useTranslation();

  // Pobranie listy usług z pliku słownika
  const services = t("services", { returnObjects: true });

  return (
    <div className="service-list">
      {services.map((s, i) => (
        <div key={i} className="service-card">
          <h3>{s.name}</h3>
          <p>
            {t("price")}: {s.price}
          </p>
        </div>
      ))}
    </div>
  );
};

export default SerwisInfo;
