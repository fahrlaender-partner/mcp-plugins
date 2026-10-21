# Modul EWG - Eigentumswohnung

Bewertungs-Tool: `ewg`.

## Fachliche Regeln

- Technische Pflicht- und Optionalfelder ausschliesslich aus dem aktuellen `ewg`-Schema ableiten.
- Wohnfläche nur zusammen mit einer schema-konformen Flächennorm verwenden. Für Deutschland gilt der Abschnitt `Wohnfläche in Deutschland`.
- Zimmerzahl, Baujahr, Stockwerk, Energiestandard, Ausbaustandard, Zustand und Mikrolage nicht frei schätzen.
- Mikrolage mit `mikrat` für Eigentumswohnung bestimmen und den passenden Gesamtrating-Wert als `mikro` verwenden.
- Bei manueller Mikrolage-Übersteuerung `mikro` mit der im aktuellen Schema für Eigentumswohnung vorgesehenen Nutzung verwenden.
- Fehlt der Ausbaustandard, `stand` anbieten und die aktuell verlangten Inputs aus dem `stand`-Schema erheben.
- Fehlt der Zustand oder wirkt er unplausibel, `zust` verwenden, sofern das aktuelle Schema Eigentumswohnungen unterstützt.

## Nebenräume

Ein Kellerraum oder Kellerabteil gehört bei einer Eigentumswohnung zum Standard und ist im Modellwert bereits enthalten. Einen üblichen Keller, ein Kellerabteil oder einen Technikraum deshalb nicht als Nebenraum erfassen.

Als Nebenräume nur Räume zählen, die über diesen Standard hinausgehen, zum Beispiel ein zusätzliches Hobby- oder Bastelzimmer, ein separates Atelier, ein Estrichraum oder ein zweiter Kellerraum. Im Bewertungs-Gate die Anzahl entsprechend ausweisen und bei einem üblichen Keller null eintragen.

Liefert das Tool trotzdem einen Wertbeitrag für Nebenräume, weil ein Standardkeller mitgezählt wurde, den Beitrag im Ergebnis nicht übernehmen, sondern die Position mit null ausweisen und den bereinigten Wert entsprechend korrigieren.

## Wohnfläche in Deutschland

Gilt nur, wenn die Bewertung in Deutschland erfolgt.

- Die Wohnfläche als Hauptnutzfläche gemäss Wohnflächenverordnung (WoFlV) erheben und so benennen.
- Die Flächennorm nicht abfragen. `wohnflc` still auf den Code für HNF setzen, aktuell 1, und den Code vor dem Aufruf am aktuellen Schema prüfen.
- Im Bewertungs-Gate die Flächennorm als Modellvorgabe ausweisen, nicht als offene Nutzerangabe.
- Fragt der Nutzer nach der Flächennorm, mitteilen, dass das Modell in Deutschland mit der Hauptnutzfläche gemäss Wohnflächenverordnung rechnet.

## Ergebnis

Zusätzlich zum allgemeinen Ergebnisstandard:

- passende Kennzahl je Wohnfläche ausweisen;
- Wertbeiträge optionaler Inputs nur nennen, wenn das Tool sie liefert, und dabei den Abschnitt `Nebenräume` beachten;
- Landwert-Facts nennen, falls vom Tool geliefert.
