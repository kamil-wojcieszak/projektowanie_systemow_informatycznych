import { Outlet } from "react-router-dom";
import Header from "../../components/Header/Header";

export default function MainLayout() {
  return (
    <>
      <Header />
      <div style={{ padding: "24px" }}>
        <Outlet />
      </div>
    </>
  );
}
