import { useEffect, useState } from "react";
import "./Categories.css";

export default function Categories({ selected }) {
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    // TODO: tutaj można pobierać kategorie z API
    setCategories([
      { category_id: 1, name: "Oleje i płyny" },
      { category_id: 2, name: "Opony" },
      { category_id: 3, name: "Akumulatory" },
      { category_id: 4, name: "Części zamienne" },
      { category_id: 5, name: "Silniki" },
    ]);
  }, []);

  return (
    <aside className="categories">
      <h3>Kategorie</h3>
      <ul>
        {categories.map((c) => (
          <li
            key={c.category_id} // dodany key
            className={
              c.category_id === selected
                ? "categories-selected"
                : "categories-not-selected"
            }
          >
            {c.name}
          </li>
        ))}
      </ul>
    </aside>
  );
}
