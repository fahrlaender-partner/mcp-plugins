# Modul MWG - Mietwohnung

Bewertungs-Tool: `mwg`.

## Fachliche Regeln

- Technische Pflicht- und Optionalfelder ausschliesslich aus dem aktuellen `mwg`-Schema ableiten.
- Wohnfläche nur zusammen mit einer schema-konformen Flächennorm verwenden. Für Deutschland gilt der Abschnitt `Wohnfläche in Deutschland`.
- Zimmerzahl, Baujahr, Stockwerk, Ausbaustandard, Zustand und Mikrolage nicht frei schätzen.
- Mikrolage mit `mikrat` für Mietwohnung bestimmen und den passenden Gesamtrating-Wert als `mikro` verwenden.
- Bei manueller Mikrolage-Übersteuerung `mikro` mit der im aktuellen Schema für Mietwohnung vorgesehenen Nutzung verwenden.
- Fehlt der Ausbaustandard, `stand` anbieten, sofern die Nutzung im aktuellen `stand`-Schema unterstützt wird.
- `zust` nur verwenden, wenn Mietwohnung im aktuellen `zust`-Schema unterstützt wird. Andernfalls Nutzerwert erfragen; keine automatische Heuristik erzeugen.

## Wohnfläche in Deutschland

Gilt nur, wenn die Bewertung in Deutschland erfolgt.

- Die Wohnfläche als Hauptnutzfläche gemäss Wohnflächenverordnung (WoFlV) erheben und so benennen.
- Die Flächennorm nicht abfragen. `wohnflc` still auf den Code für HNF setzen, aktuell 1, und den Code vor dem Aufruf am aktuellen Schema prüfen.
- Im Bewertungs-Gate die Flächennorm als Modellvorgabe ausweisen, nicht als offene Nutzerangabe.
- Fragt der Nutzer nach der Flächennorm, mitteilen, dass das Modell in Deutschland mit der Hauptnutzfläche gemäss Wohnflächenverordnung rechnet.

## Ergebnis

Den allgemeinen Ergebnisstandard verwenden und die vom aktuellen `mwg`-Tool gelieferte Mietwertkennzahl bzw. Marktmiete korrekt bezeichnen. Keinen Marktwert behaupten, wenn das Tool eine Marktmiete liefert.
