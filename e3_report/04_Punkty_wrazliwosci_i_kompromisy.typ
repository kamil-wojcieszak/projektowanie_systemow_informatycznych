= Punkty wrażliwości i kompromisy

*S1:*

Mechanizm autoskalowania backendu jest wrażliwy na nieprawidłowo dobrane progi obciążenia. Zbyt późne uruchamianie nowych instancji może prowadzić do chwilowego spadku wydajności systemu.

*S2:*

Autoskalowanie warstwy frontendowej wpływa na zdolność obsługi dużej liczby jednoczesnych połączeń HTTP. Wrażliwość dotyczy synchronizacji skalowania frontendu z backendem.

*T1:*

Autoskalowanie backendu umożliwia obsługę zwiększonego obciążenia kosztem większej złożoności infrastruktury i konieczności monitorowania.

*T2:*

Skalowanie frontendu poprawia dostępność aplikacji, ale generuje dodatkowe koszty infrastrukturalne.

