import React, { useEffect, useState } from "react";
// import { Trash2, ChevronUp, ChevronDown } from "lucide-react";
import "./ShoppingCart.css";
import ShippingForm from "../ShippingForm/ShippingForm";
import { data, useNavigate } from "react-router-dom";
import { IoIosArrowDropupCircle } from "react-icons/io";
import { IoIosArrowDropdownCircle } from "react-icons/io";
import RemoveFromCartModal from "../../components/RemoveFromCartModal/RemoveFromCartModal";

const ShoppingCart = ({ isSummary }) => {
  // const [quantity, setQuantity] = useState(1);
  const pricePerItem = 599.0;

  const [items, setItems] = useState([]);

  const [summaryShippingData, setSummaryShippingData] = useState();

  const [itemToDelete, setItemToDelete] = useState();

  const navigate = useNavigate();

  useEffect(() => {
    //TODO: get items from localstorage
    const data = localStorage.getItem("shopping_cart");
    if (data) {
      setItems(JSON.parse(data));
      console.log(data);
    }

    // if (isSummary) {
    //   const shData = localStorage.getItem("shippingData");
    //   if (shData != null) {
    //     setSummaryShippingData(JSON.parse(shData));
    //   }
    // }
  }, []);

  const getAmount = () => {
    if (items != null && items.length > 0) {
      return items.reduce((acc, item) => {
        const itemTotal = item.product.price * item.stock;
        return acc + itemTotal;
      }, 0);
    } else {
      return 0;
    }
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

  const setQuantity = (group_id, quantity) => {
    // items[item_index].stock = quantity;
    setItems((prevCart) =>
      prevCart.map(
        (item) =>
          item.product.group_id === group_id
            ? { ...item, stock: quantity } // Jeśli to ten produkt, stwórz nową kopię z nowym stockiem
            : item, // W przeciwnym razie zwróć niezmieniony element
      ),
    );
    console.log(items);
    localStorage.setItem("shopping_cart", JSON.stringify(items));
  };

  const confirmDelete = () => {
    // 1. Tworzymy nową listę w stałej (zmienna lokalna)
    const updatedItems = items.filter(
      (item) => item.product.group_id !== itemToDelete.product.group_id,
    );

    // 2. Aktualizujemy stan React (dla widoku)
    setItems(updatedItems);

    // 3. Zapisujemy TĘ SAMĄ nową listę do localStorage
    localStorage.setItem("shopping_cart", JSON.stringify(updatedItems));

    // Czyścimy stan pomocniczy
    setItemToDelete(null);
  };

  const cancelDelete = () => {
    setItemToDelete(null);
  };

  const askWhetherRemove = (group_id) => {
    if (items != null) {
      setItemToDelete(items.find((item) => item.product.group_id === group_id));
    }
  };

  return (
    <div className="cart-page">
      <RemoveFromCartModal
        confirmDelete={confirmDelete}
        isModalOpen={itemToDelete != null}
        itemToDelete={itemToDelete?.product}
        cancel={cancelDelete}
      />
      <h2 className="cart-main-title">Przedmioty</h2>

      <div className="cart-layout">
        {/* Karta produktu w koszyku */}
        <div className="cart-card">
          {items.map((item) => (
            <div>
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
                  {isSummary != true && (
                    <div className="qty-buttons">
                      <button
                        onClick={() =>
                          setQuantity(item.product.group_id, item.stock + 1)
                        }
                      >
                        {/* <ChevronUp size={20} /> */}
                        <IoIosArrowDropupCircle size={20} />
                      </button>
                      <button
                        onClick={() =>
                          item.stock > 1
                            ? setQuantity(item.product.group_id, item.stock - 1)
                            : askWhetherRemove(item.product.group_id)
                        }
                      >
                        {/* <ChevronDown size={20} /> */}
                        <IoIosArrowDropdownCircle size={20} />
                      </button>
                    </div>
                  )}
                  <button className="delete-btn">
                    {/* <Trash2 size={24} /> */}
                  </button>
                </div>
              </div>
              <div className="cart-divider"></div>
            </div>
          ))}

          <div className="cart-summary-row">
            <span>Łącznie: {getAmount()} zł</span>
          </div>
        </div>

        {/* Przycisk przejścia dalej */}
        {items.length > 0 &&
          (isSummary ? (
            <div className="cart-action-area">
              <ShippingForm isSummary={true} />
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
          ))}
      </div>
    </div>
  );
};

export default ShoppingCart;
