import { NavLink } from "react-router-dom";
import "./Header.css";

export default function Header() {
  return (
    <header className="header">
      <div className="header-left">
        <div className="logo">SC</div>
        <input className="search" placeholder="Szukaj..." />
      </div>

      <nav className="header-nav">
        <NavLink to="/sklep" end>
          🏠 Start
        </NavLink>
        <NavLink to="/salon">🚗 Salon</NavLink>
        <NavLink to="/sklep">💲 Sklep</NavLink>
        <NavLink to="/serwis">⚙️ Serwis</NavLink>
        <NavLink to="/koszyk">🛒 Koszyk</NavLink>
      </nav>

      <div className="header-user">👤 username</div>
    </header>
  );
}
