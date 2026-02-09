import React, { useState } from "react";
import "./SerwisForm.css";

const SerwisForm = () => {
  const [formData, setFormData] = useState({
    date: "2025-12-15",
    time: "09:00",
    service: "Wymiana oleju",
    customerName: "",
    phone: "",
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Form submitted", formData);
    alert("Wizyta w serwisie umówiona!");
  };

  return (
    <form className="visit-form" onSubmit={handleSubmit}>
      <h2>Formularz umawiania wizyty w serwisie</h2>

      <div className="form-grid">
        <label htmlFor="date">Termin:</label>
        <input
          type="datetime-local"
          id="date"
          name="date"
          value={`${formData.date}T${formData.time}`}
          onChange={handleChange}
        />

        <label htmlFor="service">Usługa:</label>
        <select
          id="service"
          name="service"
          value={formData.service}
          onChange={handleChange}
        >
          <option>Wymiana oleju</option>
          <option>Przegląd techniczny</option>
          <option>Wymiana opon</option>
          <option>Diagnostyka komputerowa</option>
        </select>

        <label htmlFor="customerName">Imię i nazwisko:</label>
        <input
          type="text"
          id="customerName"
          name="customerName"
          value={formData.customerName}
          onChange={handleChange}
        />

        <label htmlFor="phone">Telefon:</label>
        <input
          type="tel"
          id="phone"
          name="phone"
          value={formData.phone}
          onChange={handleChange}
        />
      </div>

      <button type="submit">Umów wizytę</button>
    </form>
  );
};

export default SerwisForm;
