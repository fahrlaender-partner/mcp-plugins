# Modul EFH - Einfamilienhaus

Bewertungs-Tool: `efh`.

## Fachliche Regeln

- Technische Pflichtlogik einschliesslich länderspezifischer Flächen-/Volumengruppen ausschliesslich aus dem aktuellen `efh`-Schema ableiten.
- Grundstücksfläche, Fläche, Volumen, Zimmerzahl, Baujahr, Energiestandard, Ausbaustandard, Zustand und Mikrolage nicht frei schätzen.
- Methodisch Fläche und Volumen erfassen, wenn beides verlässlich bekannt ist; keine zusätzlichen Werte erfinden.
- Mikrolage mit `mikrat` für Einfamilienhaus bestimmen und den passenden Gesamtrating-Wert als `mikro` verwenden.
- Bei manueller Mikrolage-Übersteuerung `mikro` mit der im aktuellen Schema für Einfamilienhaus vorgesehenen Nutzung verwenden.
- Fehlt der Ausbaustandard, `stand` anbieten und die aktuell verlangten Inputs aus dem `stand`-Schema erheben.
- Fehlt der Zustand oder wirkt er unplausibel, `zust` verwenden, sofern das aktuelle Schema Einfamilienhäuser unterstützt.

## Wohnfläche in Deutschland

Gilt nur, wenn die Bewertung in Deutschland erfolgt.

- Die Wohnfläche als Hauptnutzfläche gemäss Wohnflächenverordnung (WoFlV) erheben und so benennen.
- Die Flächennorm nicht abfragen. `wohnflc` still auf den Code für HNF setzen, aktuell 1, und den Code vor dem Aufruf am aktuellen Schema prüfen.
- Kein Gebäudevolumen erheben, solange das aktuelle Schema die Volumengruppe für Deutschland nicht unterstützt.
- Im Bewertungs-Gate die Flächennorm als Modellvorgabe ausweisen, nicht als offene Nutzerangabe.
- Fragt der Nutzer nach der Flächennorm, mitteilen, dass das Modell in Deutschland mit der Hauptnutzfläche gemäss Wohnflächenverordnung rechnet.

## Ergebnis

Zusätzlich zum allgemeinen Ergebnisstandard:

- passende Kennzahl je Wohnfläche oder Gebäudevolumen ausweisen, abhängig von den verwendeten Inputs und dem Tool-Output;
- Landwert-Facts nennen, falls vom Tool geliefert.
