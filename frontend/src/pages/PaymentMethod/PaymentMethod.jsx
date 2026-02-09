import React, { useState } from "react";
// import { ChevronDown } from "lucide-react";
import "./PaymentMethod.css";
import { useLocation } from "react-router-dom";
import { useNavigate } from "react-router-dom";

const PaymentMethod = () => {
  const amountToPay = "599.00 zł";

  const [selectedPaymentMethod, setSelectedPaymentMethod] = useState();

  const [isPaid, setIsPayed] = useState();

  const { state } = useLocation();

  const navigate = useNavigate();

  const paymentMethods = ["transfer", "blik", "cash"];

  const pay = () => {
    setIsPayed(true);
  };

  const goToShop = () => {
    navigate(`/sklep`);
  };

  return state && isPaid != true ? (
    <div className="payment-container">
      <h2 className="payment-main-title">Metoda płatności</h2>

      <div className="payment-box">
        <div className="payment-summary">
          <span>Kwota do zapłaty:</span>
          <span className="payment-amount">
            {state.amountToPay.toFixed(2)} zł
          </span>
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
          <button className="pay-btn" onClick={pay}>
            Zapłać
          </button>
        </div>
      </div>
    </div>
  ) : (
    state && isPaid == true && (
      <div className="payment-container">
        <div className="payment-box">
          <div className="payment-summary">
            <span>Płatność zakończona sukcesem!</span>
          </div>

          <div className="payment-action">
            <button className="pay-btn" onClick={goToShop}>
              Wróć do sklepu
            </button>
          </div>
        </div>
      </div>
    )
  );
};

export default PaymentMethod;
