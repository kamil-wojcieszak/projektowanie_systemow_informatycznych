import React, { useState } from "react";
import "./SerwisForm.css";
import { useTranslation } from "react-i18next";

const SerwisForm = () => {
  const { t } = useTranslation();

  const [formData, setFormData] = useState({
    date: "2025-12-15",
    time: "09:00",
    service: "oilChange",
    customerName: "",
    phone: "",
  });

  const services = [
    "oilChange",
    "inspection",
    "tireChange",
    "diagnostics"
  ];

  const handleChange = (e) => {
    const { name, value } = e.target;

    // datetime-local zwraca jedną wartość — rozbijamy ją
    if (name === "date") {
      const [date, time] = value.split("T");
      setFormData({ ...formData, date, time });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Form submitted", formData);
    alert(t("serviceForm.success"));
  };

  return (
    <form className="visit-form" onSubmit={handleSubmit}>
      <h2>{t("serviceForm.title")}</h2>

      <div className="form-grid">
        <label htmlFor="date">{t("serviceForm.date")}:</label>
        <input
          type="datetime-local"
          id="date"
          name="date"
          value={`${formData.date}T${formData.time}`}
          onChange={handleChange}
        />

        <label htmlFor="service">{t("serviceForm.service")}:</label>
        <select
          id="service"
          name="service"
          value={formData.service}
          onChange={handleChange}
        >
          {services.map((key) => (
            <option key={key} value={key}>
              {t(`serviceForm.services.${key}`)}
            </option>
          ))}
        </select>

        <label htmlFor="customerName">{t("serviceForm.name")}:</label>
        <input
          type="text"
          id="customerName"
          name="customerName"
          value={formData.customerName}
          onChange={handleChange}
        />

        <label htmlFor="phone">{t("serviceForm.phone")}:</label>
        <input
          type="tel"
          id="phone"
          name="phone"
          value={formData.phone}
          onChange={handleChange}
        />
      </div>

      <button type="submit">{t("serviceForm.submit")}</button>
    </form>
  );
};

export default SerwisForm;
