import "./SalonNavigation.css";

export default function SalonNavigation({ activeTab, setActiveTab }) {
  return (
    <aside className="categories">
      <ul>
        <li
          className={activeTab === "cars" ? "active" : ""}
          onClick={() => setActiveTab("cars")}
        >
          Samochody
        </li>
        <li
          className={activeTab === "visit" ? "active" : ""}
          onClick={() => setActiveTab("visit")}
        >
          Formularz wizyty
        </li>
      </ul>
    </aside>
  );
}
