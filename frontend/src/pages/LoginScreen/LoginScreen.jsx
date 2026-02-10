import React, { useState } from "react";
import "./LoginScreen.css";
import { useNavigate } from "react-router-dom";

const LoginScreen = () => {
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    // Tutaj Twoja logika sprawdzania hasła
    localStorage.setItem("isLoggedIn", "true"); // Zapisujemy stan
    navigate("/sklep"); // Przekierowanie
  };
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  return (
    <div className="login-page">
      <div className="login-container">
        <h1 className="login-logo">SuperCars</h1>

        <form onSubmit={handleSubmit} className="login-form">
          <div className="login-field-group">
            <label>Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="login-input"
              placeholder="Twój adres email"
              required
            />
          </div>

          <div className="login-field-group">
            <label>Hasło</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="login-input"
              placeholder="••••••••"
              required
            />
          </div>

          <div className="login-options">
            <button type="button" className="text-link">
              Zapomniałem hasła
            </button>
          </div>

          <button type="submit" className="login-submit-btn">
            Zaloguj się
          </button>

          <div className="register-option">
            <button type="button" className="text-link">
              Zarejestruj się
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default LoginScreen;
