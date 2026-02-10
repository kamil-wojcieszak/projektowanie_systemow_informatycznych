import React, { useState } from "react";
import "./RemoveFromCartModal.css";

const RemoveFromCartModal = ({
  isModalOpen,
  confirmDelete,
  itemToDelete,
  cancel,
}) => {
  //   const [isModalOpen, setIsModalOpen] = useState(false);
  //   const [itemToDelete, setItemToDelete] = useState(null);

  //   // Funkcja otwierająca popup
  //   const confirmDelete = (product) => {
  //     setItemToDelete(product);
  //     // setIsModalOpen(true);
  //   };

  //   // Funkcja wykonująca faktyczne usuwanie
  //   const handleDelete = () => {
  //     console.log("Usuwam:", itemToDelete);
  //     // Tutaj dodaj swoją logikę usuwania z listy/localStorage
  //     // setIsModalOpen(false);
  //   };

  return (
    <div className="container">
      {/* Przykładowy przycisk usuwania (ikona kosza z Twojego projektu) */}
      {/* <button
        onClick={() => confirmDelete({ id: 1, name: "Opona T3" })}
        className="trash-btn"
      >
        🗑️
      </button> */}

      {/* Warunkowe renderowanie popupu */}
      {isModalOpen && (
        <div className="modal-overlay">
          <div className="modal-content">
            <h3 className="modal-title">Czy na pewno chcesz usunąć?</h3>
            <p className="modal-text">Produkt: {itemToDelete.name}</p>

            <div className="modal-actions">
              <button onClick={() => cancel()} className="btn-cancel">
                Anuluj
              </button>
              <button onClick={confirmDelete} className="btn-confirm">
                Usuń
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default RemoveFromCartModal;
