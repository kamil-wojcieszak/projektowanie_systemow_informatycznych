import "./Filters.css";

export default function Filters() {
  return (
    <section className="filters">
      <h3>Filtry</h3>

      <div className="filter-chip">
        Cena: 5.00 – 2 000.00 zł
        <span className="remove">×</span>
      </div>

      <button className="add-filter">+</button>
    </section>
  );
}
