import React, { useState } from "react";
import "./VisitForm.css";
import { useTranslation } from "react-i18next";

const VisitForm = ({ car }) => {
  const { t } = useTranslation();

  const [formData, setFormData] = useState({
    date: "2025-12-15",
    time: "13:30",
    brand: car?.brand || "",
    model: car?.name || "",
    visitType: "testDrive",
  });

  const visitTypes = ["testDrive", "consultation", "purchase"];

  const handleChange = (e) => {
    const { name, value } = e.target;

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
    alert(t("salonVisitForm.success"));
  };

  return (
    <form className="visit-form" onSubmit={handleSubmit}>
      <h2>{t("salonVisitForm.title")}</h2>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="date">{t("salonVisitForm.date")}:</label>
          <input
            type="datetime-local"
            id="date"
            name="date"
            value={`${formData.date}T${formData.time}`}
            onChange={handleChange}
          />
        </div>

        <div className="form-group">
          <label htmlFor="brand">{t("salonVisitForm.brand")}:</label>
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
          <label htmlFor="visitType">{t("salonVisitForm.visitType")}:</label>
          <select
            id="visitType"
            name="visitType"
            value={formData.visitType}
            onChange={handleChange}
          >
            {visitTypes.map((type) => (
              <option key={type} value={type}>
                {t(`salonVisitForm.visitTypes.${type}`)}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="model">{t("salonVisitForm.model")}:</label>
          <input
            type="text"
            id="model"
            name="model"
            value={formData.model}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-button">
        <button type="submit">
          {t("salonVisitForm.submit")}
        </button>
      </div>
    </form>
  );
};

export default VisitForm;
