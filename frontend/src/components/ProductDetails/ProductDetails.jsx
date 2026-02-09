import React from "react";
import "./ProductDetails.css";

const ProductDetails = () => {
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

  return (
    <div className="product-page">
      {/* Sekcja Górna: Zdjęcie i Podstawowe Info */}
      <div className="product-header">
        <div className="product-main-image">
          <img src="https://via.placeholder.com/150" alt="Opona T3" />
        </div>
        <div className="product-summary">
          <h1 className="summary-title">Opona T3</h1>
          <p className="summary-price">599.00 zł</p>
          <div className="summary-rating">
            <span className="star-blue">★</span>
            <span>4.0 / 5.0 (34)</span>
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
              <strong>Opis:</strong> Świetnej jakości opona T3. Sprawdza się
              idealnie w warunkach śnieżnych
            </p>
          </div>

          <div className="info-pill">
            <p>
              <strong>Marka:</strong> FastTire
            </p>
          </div>

          <div className="info-pill">
            <p>
              <strong>Stan magazynowy:</strong> 41 sztuk
            </p>
          </div>
        </div>

        <div className="action-column">
          <button className="add-to-cart-btn">Dodaj do koszyka</button>
        </div>
      </div>

      {/* Sekcja Dolna: Opinie */}
      <div className="reviews-section">
        <h2 className="section-title">Opinie</h2>
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
  );
};

export default ProductDetails;
