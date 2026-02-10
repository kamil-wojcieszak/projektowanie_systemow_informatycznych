import { Outlet } from "react-router-dom";
import Header from "../../components/Header/Header";
import { useTranslation } from "react-i18next";

export default function MainLayout() {
  const { i18n } = useTranslation();

  const changeLanguage = (lang) => {
    i18n.changeLanguage(lang);
  };

  return (
    <>
      <Header />
      <div style={{ padding: "24px" }}>
        {/* Przycisk do zmiany języka */}
        <div style={{ marginBottom: "16px" }}>
          <button onClick={() => changeLanguage("pl")} style={{ marginRight: "8px" }}>
            PL
          </button>
          <button onClick={() => changeLanguage("en")}>EN</button>
        </div>

        <Outlet />
      </div>
    </>
  );
}
