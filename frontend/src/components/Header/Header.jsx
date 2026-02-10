import { NavLink } from "react-router-dom";
import "./Header.css";
import { useTranslation } from "react-i18next";

export default function Header() {
  const { t } = useTranslation();

  return (
    <header className="header">
      <div className="header-left">
        <div className="logo">SC</div>
        <input
          className="search"
          placeholder={t("header.search")}
        />
      </div>

      <nav className="header-nav">
        <NavLink to="/start" end>
          🏠 {t("header.start")}
        </NavLink>
        <NavLink to="/salon">
          🚗 {t("header.salon")}
        </NavLink>
        <NavLink to="/sklep">
          💲 {t("header.shop")}
        </NavLink>
        <NavLink to="/serwis">
          ⚙️ {t("header.service")}
        </NavLink>
        <NavLink to="/koszyk">
          🛒 {t("header.cart")}
        </NavLink>
      </nav>

      <div className="header-user">👤 username</div>
    </header>
  );
}
