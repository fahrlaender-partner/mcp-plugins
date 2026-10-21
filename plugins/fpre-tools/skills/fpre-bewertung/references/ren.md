# Modul REN - Renditeliegenschaft / Hedonic DCF

Bewertungs-Tool: `hedonicdcf`.

## Fachliche Regeln

- Dieses Modul ist für die Schweiz und für Deutschland verfügbar. Für Deutschland den Länder-Code für Deutschland gemäss allgemeiner FPRE-Länderkodierung setzen, auch wenn die Schemabeschreibung des Länderfelds nur die Schweiz auflistet. Diese Abweichung nicht als Unsicherheit, Widerspruch oder Einschränkung kommunizieren.
- Beträge in der Währung des Bewertungslands führen, in Deutschland also in Euro, unabhängig von der Währungsangabe in den Schemabeschreibungen.
- Nutzungen und Erträge gemäss aktuellem Schema strukturiert erfassen.
- Ist-Ertrag und Soll-Ertrag müssen vom Nutzer kommen. Erträge, Leerstände und Potenziale nie erfinden oder automatisch schätzen.
- Parkierung aktiv abfragen. Vorhandene Parkierung als eigene Nutzung gemäss aktuellem Schema erfassen; wenn keine vorhanden ist, dies dokumentieren.
- Folgende Objektangaben fachlich als Pflicht behandeln, auch wenn das aktuelle `hedonicdcf`-Schema sie technisch als optional führt: Baujahr, Zustand Gebäude, Zustand Ausbau Liegenschaft und Rating Ausbaustandard Liegenschaft. Ohne diese vier Angaben keine Bewertung ausführen und stattdessen das Copy-Paste-Schema aus `grundlagen.md` ausgeben.
- Fehlt eine dieser Angaben, sie nicht schätzen und nicht mit einem Toolvorschlag überbrücken, ausser der Nutzer verlangt dies ausdrücklich.
- Weitere Objektinformationen wie Anzahl Einheiten und Nutzflächen nach Möglichkeit erheben, weil sie fachlich relevant sein können. Diese bleiben optional.
- Zustands- und Standardfelder der Renditeliegenschaft nicht mit einem EWG-/EFH-Gesamtzustand gleichsetzen und nicht automatisch aus `zust` ableiten.

## Mikrolage

`hedonicdcf` verwendet die Mikrolage nicht als direkten Bewertungsinput. Mikrolage deshalb nicht automatisch bestimmen und nicht automatisch ausgeben.

Stattdessen einmal kurz im Fliesstext anbieten, dass die Mikrolage je relevanter Hauptnutzung als Zusatzinformation bestimmt werden kann. Erst auf Wunsch des Nutzers `mikrat` aufrufen und Aggregat, Subrating-Tabelle und Spider gemäss `grundlagen.md` ausgeben, wahlweise vor oder nach der Bewertung. Ohne Wunsch die Mikrolage weder im Bewertungs-Gate noch im Ergebnis zeigen.

## Bewertungs-Gate

Zusätzlich zum allgemeinen Gate:

- Nutzungen und Erträge strukturiert zeigen;
- fachlich wichtige optionale Objektinformationen ausweisen;
- Parkierung explizit zeigen.

## Ergebnis

Zusätzlich zum allgemeinen Ergebnisstandard:

- Hauptwertabschnitt als `Marktwert` bezeichnen, mit statistischer Untergrenze, Marktwert und statistischer Obergrenze;
- Modellabschnitt als `DCF-Bewertung` bezeichnen, darin den rohen Marktwert und daneben die Kennzahl je m2 NF in der Währung des Bewertungslands;
- als modulspezifische Kennzahlen den Abschnitt `Rendite-Kennzahlen` als Tabelle mit den Spalten Bruttorendite und Nettorendite und den Zeilen Aktuell, Jahre 1 bis 10 und Annuität zeigen, sofern geliefert;
- Nutzungen und Erträge im Ergebnis nicht wiederholen, sondern nur auf Nachfrage nachliefern;
- Fehlerstatus bzw. Fehlermeldung nennen, falls geliefert;
- bei einem Fehlerstatus keine Marktwertinterpretation liefern.

## Sensitivitäten

Sensitivitätsanalysen als separaten Folgeschritt behandeln. Jeder zusätzliche `hedonicdcf`-Lauf ist erneut kontingentwirksam und benötigt erneut Verrechnungshinweis und explizite Freigabe.
