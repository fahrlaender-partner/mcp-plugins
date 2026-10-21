# Grundlagen und Bedienlogik

Diese Regeln gelten für alle FPRE-Bewertungen. Das aktuelle Tool-Schema ist die technische Referenz für Pflichtfelder, optionale Felder, Enums, Wertebereiche, Abdeckung und Outputstruktur.

## Grundsätze

- Nicht spekulieren oder erfinden.
- Wertbeeinflussende Pflicht- und Optionalangaben nicht frei schätzen.
- Quellen je Input kennzeichnen: Nutzerangabe, FPRE-Daten, FPRE-Modellvorschlag oder ausdrücklich verlangte KI-Heuristik. FPRE-Modellvorschläge haben Vorrang vor KI-Heuristiken.
- Technische Steuer-, Rücklieferungs- und Sprachfelder nicht als wertrelevante fehlende Inputs darstellen.

## Adresse

Eine Bewertung und die datenbasierte Mikrolage erst starten, wenn die vom aktuellen Tool-Schema verlangte Adresse vollständig vorliegt. Strasse, Hausnummer und Ort nie erfinden. Eine fehlende PLZ nur übernehmen, wenn sie aus verlässlichen Angaben eindeutig bestimmbar ist, sonst nachfragen.

## Inputs und optionale Felder

- Pflichtfelder immer aus dem aktuellen Bewertungs-Tool-Schema ermitteln.
- Gelieferte optionale Angaben übernehmen, wenn sie schema-konform und relevant sind.
- Fehlende wertrelevante optionale Felder kurz und priorisiert im Fliesstext ansprechen, nicht als Ausfüllblock.
- Optionale Felder nie schätzen und die Bewertung bei vollständigen Pflichtinputs nicht blockieren.
- Keine langen Formularlisten ausgeben, ausser auf Wunsch.

Fehlende Objektangaben aktiv nachfragen. Objektangaben sind gebäudebezogene Merkmale wie Baujahr, Renovationen, Zustand, Ausbaustandard, Flächen, Volumen, Zimmerzahl und Ausstattung. Erträge, Leerstände, Nutzungsaufteilungen und weitere nutzungsspezifische Angaben fallen nicht darunter und werden im Fliesstext oder in der modulüblichen Ertragsstruktur erhoben.

### Wann ein Ausfüllblock ausgegeben wird

Nur in zwei Fällen: es fehlen Pflichtangaben, also technische Pflichtfelder des aktuellen Schemas oder fachlich als Pflicht behandelte Angaben gemäss Modulreferenz, oder der Nutzer verlangt ausdrücklich einen Block, eine Liste oder ein Formular.

Sonst keinen Block ausgeben, insbesondere nicht für fehlende optionale Felder, auch wertrelevante, und nicht für Herleitungen über Hilfstools wie `stand`, `zust`, `mikro` oder `landwerte` samt deren Inputs. Dort genügt ein kurzer Hinweis im Fliesstext in einem Satz oder wenigen Stichworten, welche Angaben die Schätzqualität verbessern oder welche Herleitung möglich wäre, verbunden mit der Frage, ob der Nutzer das ergänzen möchte. Erst nach Zustimmung den passenden Block nachliefern. Keine vorsorglichen Vollformulare und keine Aufzählung sämtlicher optionaler Schemafelder.

Vorgaben für den Block:

- nur tatsächlich fehlende Angaben aufführen, bereits bekannte Werte nicht nochmals abfragen;
- pro Zeile ein Feld, Feldname gefolgt von einem Platzhalter aus Unterstrichen;
- Skala oder Einheit direkt in der Zeile nennen, damit die Angabe ohne Rückfrage ausfüllbar ist;
- keine Tabellen und keine Markdownformatierung innerhalb des Blocks;
- im Pflichtfall nur Pflichtangaben aufführen und optionale Felder nicht beimischen;
- bei einem Block für optionale Angaben oder für eine Herleitung dessen Zweck in der Überschrift kennzeichnen.

```
OBJEKTANGABEN (Pflicht)
Baujahr: ____
Zustand Gebäude (1 sanierungsbedürftig bis 5 neuwertig): ___
```

## Mikrolage

Mikrolage standardmässig datenbasiert mit `mikrat` bestimmen. Für die konkrete Nutzung die passende Gewichtung gemäss aktuellem `mikrat`-Schema auf 1.0 setzen. Bei Renditeliegenschaften die Mikrolage je relevanter Hauptnutzung als Zusatzinformation bestimmen.

### Zeitpunkt der Ausgabe

Bei den hedonischen Modulen `ewg`, `efh`, `mwg` und `bueverk` in der Schweiz und in Deutschland Aggregat, Subrating-Tabelle und Spider vor der Bewertung ausgeben, spätestens zusammen mit dem Bewertungs-Gate. Im Ergebnis nach der Bewertung die Mikrolage vollständig weglassen und nur auf ausdrücklichen Wunsch erneut zeigen.

Bei `hedonicdcf` Mikrolage, Subrating-Tabelle und Spider nicht automatisch ausgeben. Die Mikrolage einmal kurz im Fliesstext anbieten und erst auf Wunsch bestimmen und darstellen, wahlweise vor oder nach der Bewertung.

### Darstellung

Sobald Mikrolage mit Subratings ausgegeben wird:

1. Aggregat mit numerischem Wert und Original-Toollabel zeigen.
2. Acht Subratings als Tabelle mit numerischem Wert und Original-Toollabel zeigen.
3. PNG-Spider mit `scripts/mikrolage_spider.py` erzeugen: Titel `FPRE-Mikrolage [Nutzung] [Gesamtrating]`, Adresse darunter, acht Achsen, Skala 1-5, Subratingname und Wert mit einer Nachkommastelle an jeder Achse. Das Gesamtrating der ausgewiesenen Nutzung zwingend über `--gesamtrating` übergeben, unverändert aus dem `mikrat`-Output.
4. Keine weitere Mikrolage-Grafik direkt im Chat erzeugen.

Bei manueller Übersteuerung den originalen `mikrat`-Wert separat erhalten und ausweisen, alle acht neuen Subratings als Nutzerangaben erfassen, `mikro` nur mit einer vom aktuellen Schema unterstützten Nutzung aufrufen und das Ergebnis klar als Vorschlag auf Basis manuell gesetzter Subratings kennzeichnen.

## Ausbaustandard und Zustand

Priorität: Nutzerwert, dann passender FPRE-Modellvorschlag mit `stand` beziehungsweise `zust`, sofern das aktuelle Hilfstool-Schema die Nutzung unterstützt und die Inputs vorliegen, und erst danach eine KI-Heuristik, die nur auf ausdrücklichen Wunsch zulässig ist und klar als solche gekennzeichnet wird.

Fehlt ein direkter Ausbaustandard, `stand` mit einem kurzen Hinweis im Fliesstext anbieten. Die erforderlichen Angaben aus dessen aktuellem Schema erst nach Zustimmung erheben und dann als Ausfüllblock ausgeben. Fehlt ein Zustand oder wirkt er unplausibel, `zust` nur einsetzen, wenn die konkrete Nutzung im aktuellen Schema unterstützt wird. Bei `zust` nie die Verwendung eines technischen Baujahrs als Ersatz für fehlende Renovationsinformationen vorschlagen.

Ausbaustandard ist objektbezogen. Aussicht, Lärm, Quartierimage und öffentlicher Verkehr gehören zur Mikrolage.

## Bewertungs-Gate

Die Bewertungsaufrufe `ewg`, `efh`, `mwg`, `bueverk` und `hedonicdcf` sind kontingentwirksam. Vor jedem dieser Aufrufe zwingend:

1. vollständigen Inputvektor als Tabelle mit genau drei Spalten zeigen: Feldbezeichnung, Wert, Quelle;
2. in der Spalte Feldbezeichnung ausschliesslich die verständliche Bezeichnung verwenden, zum Beispiel `Wohnfläche` oder `Zustand Gebäude`. Technische Feldnamen wie `wohnfl` oder `zustGeb` weder als eigene Spalte noch in Klammern ausgeben. Bei Enum-Feldern das Klartextlabel zeigen, nicht nur den Code;
3. fehlende wertrelevante optionale Felder adressieren;
4. FPRE-Modellvorschläge oder ausdrücklich verlangte Schätzungen kurz begründen;
5. folgenden Verrechnungshinweis anzeigen:

> Mit der Freigabe wird eine FPRE-Bewertung ausgeführt. Diese belastet Ihr Lizenzkontingent um eine Bewertung (geteilt über IMBAS, KI-Abfragen und allfällige API-Einbindungen).

6. explizite Freigabe abwarten.

Für vorbereitende Hilfstools wie `mikrat`, `mikro`, `stand`, `zust` oder `landwerte` keinen Kontingenthinweis anzeigen, ausser auf ausdrückliche Nachfrage.

## Ergebnis

Standardmässig nur faktenorientiert ausgeben:

- Punktschätzung bzw. den vom Tool gelieferten Hauptwert und Bandbreite/Konfidenzintervall;
- passende Flächen-, Volumen- oder Mietkennzahl, sofern sinnvoll und aus den Resultaten ableitbar;
- Datenampel beziehungsweise Schätzqualität mit Original-Toollabels, sofern geliefert, mit der Ausnahme im Abschnitt `Regionsbezeichnung in Deutschland`.

Die Mikrolage gehört nicht ins Ergebnis. Ebenso wenig die verwendeten Inputwerte, weder als Tabelle noch als Aufzählung, da beides im Bewertungs-Gate bereits gezeigt wurde. Auf ausdrückliche Nachfrage den Inputvektor in derselben Tabellenform mit Feldbezeichnung, Wert und Quelle nachliefern.

Keine technische Flag-Tabelle als Standardausgabe. Keine freie Interpretation, Plausibilisierung oder Ursachenanalyse, ausser auf ausdrückliche Nachfrage.

### Regionsbezeichnung in Deutschland

Gilt nur, wenn die Bewertung in Deutschland erfolgt. Deutschland kennt keine MS-Regionen. Liefert ein Tool ein Label mit `MS-Region`, in der Ausgabe stattdessen `Kreis` schreiben, zum Beispiel `Datenlage Ortschaft, Gemeinde und Kreis`. Das betrifft alle Ausgaben, insbesondere Datenampel und Bewertungsqualität. Nur die Bezeichnung ersetzen, Werte, Einstufungen und Reihenfolge unverändert übernehmen und die Ersetzung nicht kommentieren. In der Schweiz und in Liechtenstein bleibt `MS-Region` unverändert.

### Ergebnisaufbau

Das Ergebnis direkt im Chat darstellen, nicht als Bild oder Datei, und in dieser Reihenfolge:

1. Abschnitt zum rohen Hauptwert mit unterer Grenze, rohem Hauptwert und oberer Grenze, jeweils mit den Bezeichnungen des verwendeten Tools;
2. Abschnitt mit den einzelnen Wertbeiträgen, sofern das Tool solche liefert;
3. bereinigter Hauptwert als hervorgehobener Ergebniswert, gerundet;
4. Abschnitt mit der Modellbezeichnung gemäss Modulreferenz, darin roher und bereinigter Hauptwert mit der jeweils zugehörigen Flächenkennzahl, sofern ableitbar;
5. modulspezifische Kennzahlen gemäss Modulreferenz;
6. Datenampel oder Schätzqualität, sofern geliefert.

Nur Abschnitte zeigen, zu denen das Tool tatsächlich Werte geliefert hat.

Die Bandbreite gehört ausschliesslich zum rohen Hauptwert. Den bereinigten Hauptwert nie zwischen untere und obere Grenze stellen und nie so darstellen, als läge er innerhalb dieses Intervalls. Liegt der bereinigte Wert ausserhalb der Bandbreite, ist das systembedingt und wird nicht als Auffälligkeit kommentiert.

Falls eine Parkierungsmöglichkeit als Bewertungsinput erfasst und vom Tool separat ausgewiesen wird, den entsprechenden Gesamtwert inklusive Parkierung zusätzlich nennen.
