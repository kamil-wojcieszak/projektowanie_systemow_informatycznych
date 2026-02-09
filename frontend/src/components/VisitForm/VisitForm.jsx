import React, { useState } from "react";
import "./VisitForm.css";

const VisitForm = ({ car }) => {
  const [formData, setFormData] = useState({
    date: "2025-12-15",
    time: "13:30",
    brand: car?.brand || "",
    model: car?.name || "",
    visitType: "Jazda testowa",
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Form submitted", formData);
    alert("Wizyta umówiona!");
  };

  return (
    <form className="visit-form" onSubmit={handleSubmit}>
      <h2>Formularz umówienia wizyty w salonie</h2>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="date">Termin wizyty:</label>
          <input
            type="datetime-local"
            id="date"
            name="date"
            value={`${formData.date}T${formData.time}`}
            onChange={handleChange}
          />
        </div>

        <div className="form-group">
          <label htmlFor="brand">Marka:</label>
          <input
            type="text"
            id="brand"
            name="brand"
            value={formData.brand}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="visitType">Rodzaj wizyty:</label>
          <select
            id="visitType"
            name="visitType"
            value={formData.visitType}
            onChange={handleChange}
          >
            <option>Jazda testowa</option>
            <option>Konsultacja</option>
            <option>Zakup</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="model">Model:</label>
          <input
            type="text"
            id="model"
            name="model"
            value={formData.model}
            onChange={handleChange}
          />
        </div>

        <div className="form-button">
          
        </div>
        

      </div>
      <div className="form-button">
        <button type="submit">Umów</button>
      </div>
    </form>
  );
};

export default VisitForm;
