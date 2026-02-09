import React, { useEffect, useState } from "react";
import "./ProductDetails.css";
import { useParams } from "react-router-dom";
import Filters from "../../components/Filters/Filters";
import Categories from "../../components/Categories/Categories";

const ProductDetails = () => {
  const { id } = useParams();

  const [product, setProduct] = useState();

  const [isAddingReview, setIsAddingReview] = useState(false);

  const [myComment, setMyComment] = useState();

  const [myRate, setMyRate] = useState(0);

  const handleRateChange = (e) => {
    const val = parseFloat(e.target.value);
    // Dodatkowe zabezpieczenie w logice, gdyby ktoś wpisał ręcznie > 5
    if (val > 5) setMyRate(5);
    else if (val < 0) setMyRate(0);
    else setMyRate(val);
  };

  const handleCommentChange = (e) => {
    setMyComment(e.target.value);
    console.log(myComment);
  };

  const reviews = [
    {
      id: 1,
      author: "Przemek Nowak",
      date: "24.07.2024",
      rating: "4.0/5.0",
      text: "Świetne",
      stars: 5,
    },
    {
      id: 2,
      author: "Przemek Nowak",
      date: "24.07.2024",
      rating: "4.0/5.0",
      text: "Całkiem dobre",
      stars: 4,
    },
  ];

  useEffect(() => {
    //TODO: here get product by id
    setProduct({
      group_id: 1,
      name: "Opona T3",
      price: 599.0,
      rate: 4.0,
      reviews: 34,
      mark: "FastTire",
      product_condition: "nowy",
      description: "Świetnej jakości opona T3",
      stock_status: 10,
      image_url: null,
      category_id: 2,
    });
  }, []);

  const addToCart = () => {
    //TODO: here add to cart

    // if (product != null) {
    //   const itemFromCart = localStorage.getItem(
    //     `product_group_${product.group_id}`,
    //   );
    //   let stock = 1;

    //   if (itemFromCart != null) {
    //     stock = JSON.parse(itemFromCart).stock + 1;
    //   }
    //   const itemToSave = {
    //     product: product,
    //     stock: stock,
    //   };

    //   localStorage.setItem(
    //     `product_group_${product.group_id}`,
    //     JSON.stringify(itemToSave),
    //   );
    // }

    if (product != null) {
      // 1. Pobierz aktualną listę z localStorage (jeden wspólny klucz)
      const cartData = localStorage.getItem("shopping_cart");

      // 2. Sparsuj dane do tablicy lub zainicjalizuj pustą listę, jeśli nic nie ma
      let cartList = cartData ? JSON.parse(cartData) : [];

      // 3. Znajdź indeks produktu w liście na podstawie group_id
      const existingItemIndex = cartList.findIndex(
        (item) => item.product.group_id === product.group_id,
      );

      if (existingItemIndex !== -1) {
        // 4a. Jeśli grupa produktów już istnieje, zwiększ stock o 1
        cartList[existingItemIndex].stock += 1;
      } else {
        // 4b. Jeśli to nowy produkt, dodaj go jako nowy obiekt do listy
        const newItem = {
          product: product,
          stock: 1,
        };
        cartList.push(newItem);
      }

      console.log(JSON.stringify(cartList));

      // 5. Zapisz całą zaktualizowaną listę pod jednym kluczem
      localStorage.setItem("shopping_cart", JSON.stringify(cartList));
    }
  };

  const addReview = () => {
    //TODO: submit review
  };

  const submitReview = () => {
    setIsAddingReview(!isAddingReview);
  };

  return (
    product && (
      <div style={{ display: "flex", gap: "24px" }}>
        <Categories selected={product.category_id} />

        <div style={{ flex: 1 }}>
          <div className="product-page">
            {/* Sekcja Górna: Zdjęcie i Podstawowe Info */}
            <div className="product-header">
              <div className="product-main-image">
                <img src="https://via.placeholder.com/150" alt="Opona T3" />
              </div>
              <div className="product-summary">
                <h1 className="summary-title">{product.name}</h1>
                <p className="summary-price">{product.price} zł</p>
                <div className="summary-rating">
                  <span className="star-blue">★</span>
                  <span>
                    {product.rate} / 5.0 ({product.reviews})
                  </span>
                </div>
              </div>
            </div>

            <hr className="divider" />

            {/* Sekcja Środkowa: Dane produktu i przycisk */}
            <div className="product-body">
              <div className="details-column">
                <h2 className="section-title">Dane produktu</h2>

                <div className="info-pill description-pill">
                  <p>
                    <strong>Opis:</strong> {product.description}
                  </p>
                </div>

                <div className="info-pill">
                  <p>
                    <strong>Marka:</strong> {product.mark}
                  </p>
                </div>

                <div className="info-pill">
                  <p>
                    <strong>Stan magazynowy:</strong> {product.stock_status}
                  </p>
                </div>
              </div>

              <div className="action-column">
                <button className="add-to-cart-btn" onClick={addToCart}>
                  Dodaj do koszyka
                </button>
              </div>
            </div>

            {/* Sekcja Dolna: Opinie */}
            <div className="reviews-section">
              <h2 className="section-title">Opinie</h2>
              {isAddingReview == true ? (
                <div className="review-card">
                  <div className="review-rating-row">
                    <div className="stars-row"></div>
                    <span className="rating-text">
                      <div className="rating-input-group">
                        <label className="rating-label">
                          Twoja ocena (0-5, co 0.5):
                        </label>
                        <input
                          type="number"
                          min="0"
                          max="5"
                          step="0.5"
                          value={myRate}
                          onChange={handleRateChange}
                          className="half-step-input"
                        />
                        <div className="rating-value-display">
                          Wybrano: <strong>{myRate.toFixed(1)}</strong>
                        </div>
                      </div>
                    </span>
                  </div>
                  <p className="review-content">
                    <input
                      type="text"
                      placeholder="____________________"
                      className="blik-input"
                      onChange={handleCommentChange}
                    />
                  </p>
                  <div className="action-column">
                    <button className="add-to-cart-btn" onClick={addReview}>
                      Zatwierdź
                    </button>
                  </div>
                </div>
              ) : (
                <div className="action-column">
                  <button className="add-to-cart-btn" onClick={addReview}>
                    Dodaj Opinię
                  </button>
                </div>
              )}
              {reviews.map((rev) => (
                <div key={rev.id} className="review-card">
                  <div className="review-header">
                    <span className="review-author">{rev.author}</span>
                    <span className="review-date">{rev.date}</span>
                  </div>
                  <div className="review-rating-row">
                    <div className="stars-row">
                      {[...Array(5)].map((_, i) => (
                        <span
                          key={i}
                          className={i < rev.stars ? "star-fill" : "star-empty"}
                        >
                          ★
                        </span>
                      ))}
                    </div>
                    <span className="rating-text">{rev.rating}</span>
                  </div>
                  <p className="review-content">{rev.text}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    )
  );
};

export default ProductDetails;
