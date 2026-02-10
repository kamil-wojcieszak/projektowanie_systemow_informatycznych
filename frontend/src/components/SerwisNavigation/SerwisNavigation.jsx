import "./SerwisNavigation.css";
import { useTranslation } from "react-i18next";

export default function SerwisNavigation({ activeTab, setActiveTab }) {
  const { t } = useTranslation();

  return (
    <aside className="categories">
      <ul>
        <li
          className={activeTab === "cars" ? "active" : ""}
          onClick={() => setActiveTab("cars")}
        >
          {t("serviceNavigation.offer")}
        </li>
        <li
          className={activeTab === "visit" ? "active" : ""}
          onClick={() => setActiveTab("visit")}
        >
          {t("serviceNavigation.visitForm")}
        </li>
      </ul>
    </aside>
  );
}
