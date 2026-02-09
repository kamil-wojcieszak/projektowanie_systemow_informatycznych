import React, { useState } from "react";
import SerwisNavigation from "../components/SerwisNavigation/SerwisNavigation";
import SerwisInfo from "../components/SerwisInfo/SerwisInfo";
import SerwisForm from "../components/SerwisForm/SerwisForm";

export default function Service() {
  const [activeTab, setActiveTab] = useState("cars"); // "cars" = oferta, "visit" = formularz

  return (
    <div style={{ display: "flex", gap: "24px" }}>
      <SerwisNavigation activeTab={activeTab} setActiveTab={setActiveTab} />
      <div style={{ flex: 1, minWidth: 0 }}>
        {activeTab === "cars" ? <SerwisInfo /> : <SerwisForm />}
      </div>
    </div>
  );
}
