// import React, { useState } from "react";
// // import { ChevronDown } from "lucide-react";
// import "./PaymentMethod.css";
// import { useLocation } from "react-router-dom";
// import { useNavigate } from "react-router-dom";
// import { IoIosArrowDropdownCircle } from "react-icons/io";

// const PaymentMethod = () => {
//   const amountToPay = "599.00 zł";

//   const [selectedPaymentMethod, setSelectedPaymentMethod] = useState();

//   const [isPaid, setIsPayed] = useState();

//   const { state } = useLocation();

//   const navigate = useNavigate();

//   const paymentMethods = ["transfer", "blik", "cash"];

//   const pay = () => {
//     setIsPayed(true);
//   };

//   const goToShop = () => {
//     navigate(`/sklep`);
//   };

//   return state && isPaid != true ? (
//     <div className="payment-container">
//       <h2 className="payment-main-title">Metoda płatności</h2>

//       <div className="payment-box">
//         <div className="payment-summary">
//           <span>Kwota do zapłaty:</span>
//           <span className="payment-amount">
//             {state.amountToPay.toFixed(2)} zł
//           </span>
//         </div>

//         <div className="payment-field-group">
//           <label>Metoda płatności</label>
//           <div className="payment-select-wrapper">
//             <select defaultValue="Blik">
//               <option value="Blik">Blik</option>
//               <option value="Karta">Karta płatnicza</option>
//               <option value="Przelew">Przelew online</option>
//             </select>
//             <IoIosArrowDropdownCircle size={20} />
//           </div>
//         </div>

//         <div className="payment-field-group">
//           <label>Kod blik</label>
//           <input
//             type="text"
//             placeholder="_ _ _ _ _ _"
//             className="blik-input"
//             maxLength="6"
//           />
//         </div>

//         <div className="payment-action">
//           <button className="pay-btn" onClick={pay}>
//             Zapłać
//           </button>
//         </div>
//       </div>
//     </div>
//   ) : (
//     state && isPaid == true && (
//       <div className="payment-container">
//         <div className="payment-box">
//           <div className="payment-summary">
//             <span>Płatność zakończona sukcesem!</span>
//           </div>

//           <div className="payment-action">
//             <button className="pay-btn" onClick={goToShop}>
//               Wróć do sklepu
//             </button>
//           </div>
//         </div>
//       </div>
//     )
//   );
// };

// export default PaymentMethod;
import React, { useState } from "react";
import "./PaymentMethod.css";
import { useLocation, useNavigate } from "react-router-dom";
import { IoIosArrowDropdownCircle } from "react-icons/io";
import toast, { Toaster } from "react-hot-toast";

const PaymentMethod = () => {
  const [selectedPaymentMethod, setSelectedPaymentMethod] = useState("blik");
  const [isPaid, setIsPayed] = useState(false);
  const { state } = useLocation();
  const navigate = useNavigate();
  const [blikCode, setBlikCode] = useState();
  const [cardNumber, setCardNumber] = useState();
  const [expiry, setExpiry] = useState();
  const [cvv, setCvv] = useState();

  const pay = () => {
    setIsPayed(true);
    localStorage.clear();
  };

  const goToShop = () => {
    navigate(`/sklep`);
  };

  const handleBlikChange = (e) => {
    // Usuwamy wszystko co nie jest cyfrą
    const value = e.target.value.replace(/\D/g, "");
    // Ograniczamy do 6 znaków
    if (value.length <= 6) {
      setBlikCode(value);
    }
  };

  const handleCardNumberChange = (e) => {
    let value = e.target.value.replace(/\D/g, ""); // Tylko cyfry

    // Grupowanie po 4 znaki: "XXXX XXXX XXXX XXXX"
    const formattedValue = value.match(/.{1,4}/g)?.join(" ") || "";

    if (value.length <= 16) {
      setCardNumber(formattedValue);
    }
  };

  const handleExpiryChange = (e) => {
    let value = e.target.value.replace(/\D/g, "");

    if (value.length >= 2) {
      const month = parseInt(value.substring(0, 2));
      // Prosta walidacja miesiąca
      if (month > 12) value = "12" + value.substring(2);
      if (month === 0) value = "01" + value.substring(2);

      value = value.substring(0, 2) + " / " + value.substring(2, 4);
    }

    if (value.replace(/\D/g, "").length <= 4) {
      setExpiry(value);
    }
  };

  const handleCvvChange = (e) => {
    const value = e.target.value.replace(/\D/g, "");
    if (value.length <= 3) {
      setCvv(value);
    }
  };

  if (!state) return null;

  return !isPaid ? (
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
            <select
              value={selectedPaymentMethod}
              onChange={(e) => setSelectedPaymentMethod(e.target.value)}
            >
              <option value="blik">Blik</option>
              <option value="card">Karta płatnicza</option>
              <option value="cash">Gotówka (Cash)</option>
            </select>
            <IoIosArrowDropdownCircle className="payment-select-icon" />
          </div>
        </div>

        {/* Formularz dla BLIK */}
        {selectedPaymentMethod === "blik" && (
          <div className="payment-field-group">
            <label>Kod blik</label>
            <input
              type="text"
              placeholder="_ _ _ _ _ _"
              className="blik-input"
              maxLength="6"
              inputMode="numeric" // Wymusza klawiaturę numeryczną na mobile
              value={blikCode}
              onChange={handleBlikChange}
              style={{ letterSpacing: "4px", textAlign: "center" }}
            />
          </div>
        )}

        {/* Formularz dla KARTY */}
        {selectedPaymentMethod === "card" && (
          <div className="payment-field-group">
            <label>Numer karty</label>
            <input
              type="text"
              placeholder="0000 0000 0000 0000"
              className="blik-input"
              value={cardNumber}
              onChange={handleCardNumberChange}
              maxLength="19" // 16 cyfr + 3 spacje
            />
            <div style={{ display: "flex", gap: "10px" }}>
              <input
                type="text"
                placeholder="MM/YY"
                className="blik-input"
                value={expiry}
                onChange={handleExpiryChange}
              />
              <input
                type="text"
                placeholder="CVV"
                className="blik-input"
                value={cvv}
                onChange={handleCvvChange}
                maxLength="3"
              />
            </div>
          </div>
        )}

        {/* Dla CASH nie wyświetlamy dodatkowych pól */}
        {selectedPaymentMethod === "cash" && (
          <div className="payment-field-group">
            <p style={{ textAlign: "center", color: "#5d83ff" }}>
              Płatność przy odbiorze.
            </p>
          </div>
        )}

        <div className="payment-action">
          <button className="pay-btn" onClick={pay}>
            Zapłać
          </button>
        </div>
      </div>
    </div>
  ) : (
    <div className="payment-container">
      <div className="payment-box">
        <p className="payment-main-title">Płatność zakończona sukcesem!</p>
        <button className="pay-btn" onClick={goToShop}>
          Wróć do sklepu
        </button>
      </div>
    </div>
  );
};

export default PaymentMethod;
