import { NavLink } from "react-router-dom";
import "./Header.css";
import { useTranslation } from "react-i18next";
import { HiSearchCircle } from "react-icons/hi";
import { BiHomeAlt } from "react-icons/bi";
import { FaCar } from "react-icons/fa";
import { FaDollarSign } from "react-icons/fa";
import { IoSettingsOutline } from "react-icons/io5";
import { MdOutlineShoppingCart } from "react-icons/md";
import { FaRegUser } from "react-icons/fa6";

export default function Header() {
  const { t } = useTranslation();

  return (
    <div className="header-container">
      <header className="header">
        <div className="header-left">
          <div className="logo">SC</div>
          <HiSearchCircle color="#3b6cff" size={30} />
        </div>
        <nav className="header-nav">
          <NavLink to="/start" end>
            {<BiHomeAlt />} {t("header.start")}
          </NavLink>
          <NavLink to="/salon">
            {<FaCar />} {t("header.salon")}
          </NavLink>
          <NavLink to="/sklep">
            {<FaDollarSign />} {t("header.shop")}
          </NavLink>
          <NavLink to="/serwis">
            {<IoSettingsOutline />} {t("header.service")}
          </NavLink>
          <NavLink to="/koszyk">
            {<MdOutlineShoppingCart />} {t("header.cart")}
          </NavLink>
        </nav>
        <div className="header-user">{<FaRegUser />} username</div>
      </header>
      <div className="under-header-container"></div>
    </div>
  );
}
