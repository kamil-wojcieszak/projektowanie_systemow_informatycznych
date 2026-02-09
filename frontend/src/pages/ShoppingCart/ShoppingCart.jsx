import React, { useState } from "react";
// import { Trash2, ChevronUp, ChevronDown } from "lucide-react";
import "./ShoppingCart.css";
import ShippingForm from "../../components/ShippingForm/ShippingForm";

const ShoppingCart = () => {
  const [quantity, setQuantity] = useState(1);
  const pricePerItem = 599.0;

  return (
    <div className="cart-page">
      <h2 className="cart-main-title">Przedmioty</h2>

      <div className="cart-layout">
        {/* Karta produktu w koszyku */}
        <div className="cart-card">
          <div className="cart-item-row">
            <div className="cart-item-img">
              <img src="https://via.placeholder.com/100" alt="Opona T3" />
            </div>

            <div className="cart-item-info">
              <h3 className="cart-item-name">Opona T3</h3>
              <p className="cart-item-price">{pricePerItem.toFixed(2)} zł</p>
              <div className="cart-item-rating">
                <span className="star-mini">★</span> 4.0 / 5.0 (34)
              </div>
            </div>

            <div className="cart-item-controls">
              <span className="qty-label">Liczba: {quantity}</span>
              <div className="qty-buttons">
                <button onClick={() => setQuantity((q) => q + 1)}>
                  {/* <ChevronUp size={20} /> */}
                </button>
                <button onClick={() => setQuantity((q) => (q > 1 ? q - 1 : 1))}>
                  {/* <ChevronDown size={20} /> */}
                </button>
              </div>
              <button className="delete-btn">
                {/* <Trash2 size={24} /> */}
              </button>
            </div>
          </div>

          <div className="cart-divider"></div>

          <div className="cart-summary-row">
            <span>Łącznie: {(pricePerItem * quantity).toFixed(2)} zł</span>
          </div>
        </div>

        {/* Przycisk przejścia dalej */}
        <div className="cart-action-area">
          <button className="checkout-btn">Przejdź do danych dostawy</button>
        </div>
      </div>
    </div>

    // <ShippingForm />
  );
};

export default ShoppingCart;
