import React, { useEffect, useState } from "react";
// import { ChevronDown } from "lucide-react";
import "./ShippingForm.css";
import { useNavigate } from "react-router-dom";
import { IoIosArrowDropdownCircle } from "react-icons/io";
import toast, { Toaster } from "react-hot-toast";

const ShippingForm = ({ isSummary }) => {
  const navigate = useNavigate();

  const goToSummary = () => {
    localStorage.setItem("shippingData", JSON.stringify(formData));
    navigate(`/koszyk/podsumowanie`);
  };

  const [formData, setFormData] = useState({
    street: "",
    city: "",
    country: "",
    houseNumber: "",
    zipCode: "",
    provider: "DPD",
  });

  useEffect(() => {
    if (isSummary != true) {
      localStorage.removeItem("shippingData");
    } else {
      const shData = localStorage.getItem("shippingData");
      if (shData != null) {
        setFormData(JSON.parse(shData));
      }
    }
  }, []);

  // Uniwersalna funkcja do obsługi zmian w polach input i select
  const handleChange = (e) => {
    const { name, value } = e.target;
    let finalValue = value;
    if (name == "zipCode") {
      finalValue = handleZipChange(value);
    }
    setFormData((prevData) => ({
      ...prevData,
      [name]: finalValue,
    }));
  };

  const handleZipChange = (val) => {
    let value = val.replace(/\D/g, ""); // Usuwamy wszystko co nie jest cyfrą

    // Auto-formatowanie: jeśli mamy więcej niż 2 cyfry, wstawiamy myślnik
    if (value.length > 2) {
      value = value.substring(0, 2) + "-" + value.substring(2, 5);
    }

    return value;
  };

  const validate = () => {
    const regex = /^\d{2}-\d{3}$/;
    if (!regex.test(formData.zipCode)) {
      toast.error("Błędny format kodu (00-000)", {
        style: {
          borderRadius: "50px",
          background: "#fff1f1",
          color: "#ff4d4d",
        },
      });
    } else {
      toast.success("Kod poprawny!");
    }
  };

  return (
    <div className="shipping-container">
      <h2 className="shipping-title">Dane dostawy</h2>
      <div className="shipping-divider"></div>

      <form className="shipping-grid">
        {/* Wiersz 1 */}
        <div className="input-group">
          <label>Ulica</label>
          <input
            type="text"
            placeholder="Śliczna"
            name="street"
            value={formData.street}
            onChange={handleChange}
            disabled={isSummary}
          />
        </div>
        <div className="input-group">
          <label>Miasto</label>
          <input
            type="text"
            placeholder="Wrocław"
            name="city"
            value={formData.city}
            onChange={handleChange}
            disabled={isSummary}
          />
        </div>
        <div className="input-group">
          <label>Kraj</label>
          <input
            type="text"
            placeholder="Polska"
            name="country"
            value={formData.country}
            onChange={handleChange}
            disabled={isSummary}
          />
        </div>

        {/* Wiersz 2 */}
        <div className="input-group">
          <label>Numer domu / mieszkania</label>
          <input
            type="text"
            placeholder="3A / 5"
            name="houseNumber"
            value={formData.houseNumber}
            onChange={handleChange}
            disabled={isSummary}
          />
        </div>
        <div className="input-group">
          <label>Kod pocztowy</label>
          <input
            type="text"
            name="zipCode"
            value={formData.zipCode}
            onChange={handleChange}
            placeholder="00-000"
            onBlur={validate} // Walidacja przy opuszczeniu pola
            maxLength="6"
            pattern="\d{2}-\d{3}"
            disabled={isSummary}
          />
        </div>
        <div className="input-group">
          <label>Dostawca</label>
          <div className="select-wrapper">
            <select
              defaultValue="DPD"
              name="provider"
              value={formData.provider}
              onChange={handleChange}
              disabled={isSummary}
            >
              <option value="DPD">DPD</option>
              <option value="InPost">InPost</option>
              <option value="DHL">DHL</option>
            </select>
            <IoIosArrowDropdownCircle className="payment-select-icon" />
          </div>
        </div>
      </form>

      {isSummary != true && (
        <div className="shipping-action">
          <button type="submit" className="summary-btn" onClick={goToSummary}>
            Przejdź do podsumowania
          </button>
        </div>
      )}
    </div>
  );
};

export default ShippingForm;
