import React from "react";
// import { ChevronDown } from "lucide-react";
import "./PaymentMethod.css";

const PaymentMethod = () => {
  const amountToPay = "599.00 zł";

  return (
    <div className="payment-container">
      <h2 className="payment-main-title">Metoda płatności</h2>

      <div className="payment-box">
        <div className="payment-summary">
          <span>Kwota do zapłaty:</span>
          <span className="payment-amount">{amountToPay}</span>
        </div>

        <div className="payment-field-group">
          <label>Metoda płatności</label>
          <div className="payment-select-wrapper">
            <select defaultValue="Blik">
              <option value="Blik">Blik</option>
              <option value="Karta">Karta płatnicza</option>
              <option value="Przelew">Przelew online</option>
            </select>
            {/* <ChevronDown className="payment-select-icon" size={20} /> */}
          </div>
        </div>

        <div className="payment-field-group">
          <label>Kod blik</label>
          <input
            type="text"
            placeholder="_ _ _ _ _ _"
            className="blik-input"
            maxLength="6"
          />
        </div>

        <div className="payment-action">
          <button className="pay-btn">Zapłać</button>
        </div>
      </div>
    </div>
  );
};

export default PaymentMethod;
