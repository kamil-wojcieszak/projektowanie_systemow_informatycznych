import React, { useEffect, useState } from "react";
import "./ProductDetails.css";
import { useParams } from "react-router-dom";
import Categories from "../../components/Categories/Categories";
import toast, { Toaster } from "react-hot-toast";
import { ENDPOINTS } from "../../api/endpoints";

const ProductDetails = () => {
  const { id } = useParams();

  const [product, setProduct] = useState(null);
  const [isAddingReview, setIsAddingReview] = useState(false);
  const [myComment, setMyComment] = useState("");
  const [myRate, setMyRate] = useState(0);

  // Przykładowe opinie
  const [reviews, setReviews] = useState([]);

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        const res = await fetch(ENDPOINTS.PRODUCTS.DETAILS(id));
        if (!res.ok) throw new Error(`Błąd pobierania produktu: ${res.status}`);
        const data = await res.json();

        // Zakładamy, że produkt jest w data.data.product
        const fetchedProduct = data.data.product || data.data.products?.[0] || {};

        setProduct({
          ...fetchedProduct,
          reviews: fetchedProduct.reviews || 0,
          product_condition: fetchedProduct.product_condition || "N/A",
          image_url: fetchedProduct.image_url || "https://via.placeholder.com/150",
        });

        // Jeśli API zwraca opinie, ustaw je, inaczej pustą listę
        setReviews(fetchedProduct.reviews_list || []);
      } catch (err) {
        console.error(err);
        toast.error("Nie udało się pobrać produktu");
      }
    };

    fetchProduct();
  }, [id]);

  const handleRateChange = (e) => {
    let val = parseFloat(e.target.value);
    if (val > 5) val = 5;
    if (val < 0) val = 0;
    setMyRate(val);
  };

  const handleCommentChange = (e) => {
    setMyComment(e.target.value);
  };

  const addToCart = () => {
    if (!product) return;

    const cartData = localStorage.getItem("shopping_cart");
    let cartList = cartData ? JSON.parse(cartData) : [];

    const existingItemIndex = cartList.findIndex(
      (item) => item.product.group_id === product.group_id
    );

    if (existingItemIndex !== -1) {
      cartList[existingItemIndex].stock += 1;
    } else {
      cartList.push({ product, stock: 1 });
    }

    localStorage.setItem("shopping_cart", JSON.stringify(cartList));

    toast.success("Dodano do koszyka!", {
      style: {
        border: "2px solid #a5f3fc",
        padding: "16px",
        color: "#5d83ff",
        borderRadius: "50px",
        background: "#e0f7ff",
      },
      iconTheme: {
        primary: "#5d83ff",
        secondary: "#FFFAEE",
      },
    });
  };

  const addReview = () => {
    if (!myComment || myRate <= 0) {
      toast.error("Podaj ocenę i komentarz!");
      return;
    }

    const newReview = {
      id: Date.now(), // unikalny klucz
      author: "Ty",
      date: new Date().toLocaleDateString(),
      rating: `${myRate}/5.0`,
      text: myComment,
      stars: myRate,
    };

    setReviews([newReview, ...reviews]);
    setIsAddingReview(false);
    setMyComment("");
    setMyRate(0);

    toast.success("Dodano opinię!");
  };

  if (!product) return <p>Ładowanie produktu...</p>;

  return (
    <div className="main-container">
      <Toaster />
      <Categories selected={product.category_id} />

      <div style={{ flex: 1 }}>
        <div className="product-page">
          {/* Sekcja Górna */}
          <div className="product-header">
            <div className="product-main-image">
              <img src={product.image_url} alt={product.name} />
            </div>
            <div className="product-summary">
              <h1 className="summary-title">{product.name}</h1>
              <p className="summary-price">{product.price} zł</p>
              <div className="summary-rating">
                <span className="star-blue">★</span>
                <span>
                  {product.rate || 0} / 5.0 ({reviews.length})
                </span>
              </div>
            </div>
          </div>

          <hr className="divider" />

          {/* Sekcja Środkowa */}
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

              <div className="info-pill">
                <p>
                  <strong>Stan produktu:</strong> {product.product_condition}
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

            {isAddingReview ? (
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
                <div className="review-content">
                  <input
                    type="text"
                    placeholder="Twój komentarz"
                    className="blik-input"
                    value={myComment}
                    onChange={handleCommentChange}
                  />
                </div>
                <div className="action-column">
                  <button className="add-to-cart-btn" onClick={addReview}>
                    Zatwierdź
                  </button>
                </div>
              </div>
            ) : (
              <div className="action-column">
                <button
                  className="add-to-cart-btn"
                  onClick={() => setIsAddingReview(true)}
                >
                  Dodaj opinię
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
  );
};

export default ProductDetails;
