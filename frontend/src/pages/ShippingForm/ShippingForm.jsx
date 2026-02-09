import React from "react";
// import { ChevronDown } from "lucide-react";
import "./ShippingForm.css";
import { useNavigate } from "react-router-dom";

const ShippingForm = ({ isSummary }) => {
  const navigate = useNavigate();

  const goToSummary = () => {
    navigate(`/koszyk/podsumowanie`);
  };

  return (
    <div className="shipping-container">
      <h2 className="shipping-title">Dane dostawy</h2>
      <div className="shipping-divider"></div>

      <form className="shipping-grid">
        {/* Wiersz 1 */}
        <div className="input-group">
          <label>Ulica</label>
          <input type="text" placeholder="Śliczna" />
        </div>
        <div className="input-group">
          <label>Miasto</label>
          <input type="text" placeholder="Wrocław" />
        </div>
        <div className="input-group">
          <label>Kraj</label>
          <input type="text" placeholder="Polska" />
        </div>

        {/* Wiersz 2 */}
        <div className="input-group">
          <label>Numer domu / mieszkania</label>
          <input type="text" placeholder="3A / 5" />
        </div>
        <div className="input-group">
          <label>Kod pocztowy</label>
          <input type="text" placeholder="12-345" />
        </div>
        <div className="input-group">
          <label>Dostawca</label>
          <div className="select-wrapper">
            <select defaultValue="DPD">
              <option value="DPD">DPD</option>
              <option value="InPost">InPost</option>
              <option value="DHL">DHL</option>
            </select>
            {/* <ChevronDown className="select-icon" size={18} /> */}
          </div>
        </div>
      </form>

      {isSummary != false && (
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
