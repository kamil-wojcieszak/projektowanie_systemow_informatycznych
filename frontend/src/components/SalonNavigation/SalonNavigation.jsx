import "./SalonNavigation.css";
import { useTranslation } from "react-i18next";

export default function SalonNavigation({ activeTab, setActiveTab }) {
  const { t } = useTranslation();

  return (
    <aside className="categories">
      <ul>
        <li
          className={activeTab === "cars" ? "active" : ""}
          onClick={() => setActiveTab("cars")}
        >
          {t("salonNavigation.cars")}
        </li>
        <li
          className={activeTab === "visit" ? "active" : ""}
          onClick={() => setActiveTab("visit")}
        >
          {t("salonNavigation.visitForm")}
        </li>
      </ul>
    </aside>
  );
}
