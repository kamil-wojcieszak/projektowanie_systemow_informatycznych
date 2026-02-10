import "./Filters.css";
import { useTranslation } from "react-i18next";

export default function Filters() {
  const { t } = useTranslation();

  return (
    <section className="filters">
      <h3>{t("filters.title")}</h3>

      <div className="filter-chip">
        {t("filters.price")}: 5.00 – 2 000.00 zł
        <span className="remove">×</span>
      </div>

      <button className="add-filter">+</button>
    </section>
  );
}
