import React, { useEffect, useState } from "react";
// import { Trash2, ChevronUp, ChevronDown } from "lucide-react";
import "./ShoppingCart.css";
import ShippingForm from "../ShippingForm/ShippingForm";
import { useNavigate } from "react-router-dom";

const ShoppingCart = ({ isSummary }) => {
  const [quantity, setQuantity] = useState(1);
  const pricePerItem = 599.0;

  const [items, setItems] = useState();

  const navigate = useNavigate();

  useEffect(() => {
    //TODO: get items from localstorage
    const data = localStorage.getItem("shopping_cart");
    if (data) {
      setItems(JSON.parse(data));
      console.log(data);
    }
  }, []);

  const getAmount = () => {
    return items.reduce((acc, item) => {
      const itemTotal = item.product.price * item.stock;
      return acc + itemTotal;
    }, 0);
  };

  const goToPaymentMethod = () => {
    navigate(`/koszyk/metoda-platnosci`, {
      state: {
        amountToPay: getAmount(),
      },
    });
  };

  const goToShippingForm = () => {
    navigate(`/koszyk/dane-dostawy`);
  };

  return (
    <div className="cart-page">
      <h2 className="cart-main-title">Przedmioty</h2>

      <div className="cart-layout">
        {/* Karta produktu w koszyku */}
        {items &&
          items.map((item) => (
            <div key={item.product.group_id} className="cart-card">
              <div className="cart-item-row">
                <div className="cart-item-img">
                  <img src="https://via.placeholder.com/100" alt="Opona T3" />
                </div>

                <div className="cart-item-info">
                  <h3 className="cart-item-name">{item.product.name}</h3>
                  <p className="cart-item-price">
                    {pricePerItem.toFixed(2)} zł
                  </p>
                  <div className="cart-item-rating">
                    <span className="star-mini">★</span> {item.product.rating} /
                    5.0 ({item.product.reviews})
                  </div>
                </div>

                <div className="cart-item-controls">
                  <span className="qty-label">Liczba: {item.stock}</span>
                  <div className="qty-buttons">
                    <button onClick={() => setQuantity((q) => q + 1)}>
                      {/* <ChevronUp size={20} /> */}
                    </button>
                    <button
                      onClick={() => setQuantity((q) => (q > 1 ? q - 1 : 1))}
                    >
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
                <span>
                  Łącznie: {(item.product.price * item.stock).toFixed(2)} zł
                </span>
              </div>
            </div>
          ))}

        {/* Przycisk przejścia dalej */}
        {isSummary ? (
          <div className="cart-action-area">
            <ShippingForm isSummary={false} />
            <button className="checkout-btn" onClick={goToPaymentMethod}>
              Przejdź do płatności
            </button>
          </div>
        ) : (
          <div className="cart-action-area">
            <button className="checkout-btn" onClick={goToShippingForm}>
              Przejdź do danych dostawy
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default ShoppingCart;
