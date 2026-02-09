import "./SerwisNavigation.css";

export default function SerwisNavigation({ activeTab, setActiveTab }) {
  return (
    <aside className="categories">
      <ul>
        <li
          className={activeTab === "cars" ? "active" : ""}
          onClick={() => setActiveTab("cars")}
        >
          Oferta serwisu
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
