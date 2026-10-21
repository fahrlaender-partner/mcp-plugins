---
name: fpre-standortanalyse
description: Erstellt FPRE-Standortanalysen zu Makrolage und Mikrolage mit den FPRE Tools makrat, maktext, mikrat und miktext. Diesen Skill immer verwenden, wenn ein Nutzer eine Lagebeurteilung, Standortanalyse, Makrolage, Mikrolage, ein Lagerating, einen Lagetext, eine Quartierbeurteilung oder eine Einschätzung zu einem Ort oder einer Adresse wünscht, auch wenn er die Begriffe Makrolage oder Mikrolage nicht ausdrücklich nennt und auch dann, wenn die Lageanalyse nur Teil einer grösseren Frage zu einer Liegenschaft ist. Der Skill regelt Adressanforderungen, Nutzungsgewichtung, Kennzeichnung von FPRE-Originaltexten und das Ausgabeformat inklusive Mikrolage-Spider. Er deckt keine Wertermittlung ab.
---

# FPRE Standortanalyse

## Ziel

Standortanalysen ausschliesslich auf Basis der FPRE Tools erstellen und die Ergebnisse so ausgeben, dass Herkunft, Bezugsebene und Nutzung jederzeit klar sind. Für Wertermittlungen den Skill `fpre-bewertung` verwenden.

Bei Bezug zu Standorten in der Schweiz Schweizer Rechtschreibung verwenden, also `ss` statt `ß`.

## Quellenhierarchie

1. Aktuelles Schema von `makrat`, `maktext`, `mikrat` und `miktext` für Felder, Enums, Wertebereiche und Output verwenden.
2. Fachliche Ausgabe- und Workflowregeln aus diesem Skill verwenden.
3. Bei technischen Widersprüchen gilt das Live-Schema, bei Darstellungsfragen dieser Skill.

Keine Werte erfinden, keine Ratings interpolieren und keine Lageeinschätzungen aus Allgemeinwissen ergänzen. Fehlt eine Angabe im Toolresultat, fehlt sie auch in der Ausgabe.

## Bezugsebenen

Die vier Tools beziehen sich auf unterschiedliche Ebenen. Das prägt Adressanforderung und Formulierung.

| Tool | Bezugsebene | Adressanforderung |
|---|---|---|
| `makrat` | Ortschaft bzw. Gemeinde | Ortschaft genügt inhaltlich |
| `maktext` | Ortschaft bzw. Gemeinde | Ortschaft genügt inhaltlich |
| `mikrat` | exakte Adresse | Strasse, Hausnummer und Ort zwingend |
| `miktext` | exakte Adresse | Strasse, Hausnummer und Ort zwingend |

### Makrolage ohne exakte Adresse

Makrolageresultate gelten für die Ortschaft. Fehlen Strasse oder Hausnummer, blockiert das die Analyse nicht und es wird auch nicht nachgefragt. Das Toolschema verlangt technisch dennoch alle vier Adressfelder. In diesem Fall eine zentrale, real existierende Adresse der Ortschaft als Platzhalter verwenden, etwa Gemeindehaus, Bahnhof oder Hauptstrasse. Bei Unsicherheit die Existenz kurz per Websuche prüfen.

Der Platzhalter wird nicht ungefragt genannt, da er das Resultat auf Gemeindeebene nicht beeinflusst. Im Ergebnis festhalten, dass die Aussagen für die Ortschaft gelten und nicht für eine einzelne Adresse.

### Mikrolage ohne exakte Adresse

Mikrolageresultate gelten punktgenau. Fehlen Strasse, Hausnummer oder Ort, sofort nachfragen und `mikrat` sowie `miktext` erst nach vollständiger Adresse aufrufen. Keine Nachbaradresse, keine Hausnummer aus der Umgebung, keine Ortsmitte und keinen Platzhalter verwenden, die Platzhalterregel der Makrolage gilt hier nicht. Eine fehlende Postleitzahl nur übernehmen, wenn sie eindeutig folgt.

### Geokodierung zwingend prüfen

Findet der Geocoder die eingegebene Strasse nicht, meldet er keinen Fehler, sondern rechnet still mit einer Ersatzadresse innerhalb derselben Postleitzahl. Das Resultat sieht dann vollständig und plausibel aus, bezieht sich aber auf einen anderen Punkt. Das Feld `Precision` schlägt in diesem Fall nicht aus und taugt nicht als Kontrolle.

Deshalb nach jedem `mikrat`- und `miktext`-Aufruf `GeocodedLocation` mit der Eingabe vergleichen. Weichen Strasse oder Hausnummer ab, gilt die Adresse als nicht gefunden. Dann keine Ratings, keinen Lagetext und keinen Spider ausgeben, sondern mitteilen, dass die Adresse in den FPRE-Daten nicht gefunden wurde, die zurückgelieferte Ersatzadresse nennen und nach der korrekten Adresse fragen. Die Ersatzadresse nicht stillschweigend übernehmen und keine eigene Strasse vorschlagen. Die Makroresultate bleiben gültig, sofern die Ortschaft korrekt erkannt wurde.

## Nutzung und Gewichtung

Nutzung und Gewichtung bestimmen das Resultat. Ergibt sich die Nutzung aus dem Anliegen des Nutzers, diese verwenden. Bei mehreren Hauptnutzungen die Gewichte gemäss aktuellem Schema setzen, Summe 1.0.

Fehlt eine Angabe zur Nutzung vollständig, gilt folgende Abstufung.

- Deutet nichts auf eine Geschäftsnutzung oder einen Nutzungsmix hin, Mietwohnung als Vorgabe verwenden und die Analyse ohne Rückfrage ausführen. Die Annahme im Ergebnis in einer Zeile ausweisen und den Wechsel auf eine andere Nutzung anbieten.
- Deutet etwas auf Büro, Verkauf, Gewerbe, Logistik oder einen Nutzungsmix hin, nachfragen statt annehmen.

Die Rückfrage kostet eine volle Interaktionsrunde. Sie ist deshalb nur dann gerechtfertigt, wenn die Vorgabe Mietwohnung erkennbar falsch wäre, und nicht als reine Absicherung.

Die Gewichtung nur bei echtem Nutzungsmix nennen. Liegt ein Einzelgewicht bei 1.0, ergibt sich die Nutzung bereits aus der Überschrift und der Hinweis ist redundant. Verteilen sich die Gewichte auf mehrere Nutzungen, alle verwendeten Gewichte ausweisen, da das Gesamtrating sonst nicht nachvollziehbar ist.

## Toolbeschaffung und Aufrufreihenfolge

Sind die FPRE Tools nicht geladen, eine einzige Suche ausführen, die alle vier abdeckt, etwa `makrat maktext mikrat miktext Makrolage Mikrolage` mit Limit 8. Nicht pro Tool einzeln suchen. Eine zweite Suche nur, wenn danach ein benötigtes Tool tatsächlich fehlt.

Voraussetzung ist eine Verbindung zum FPRE MCP-Server `https://mcp.fpre.ch` mit den von FPRE zugestellten Zugangsdaten. Fehlen die Tools auch nach der Suche, ist der Server nicht verbunden. Dann keine Lageaussagen aus Allgemeinwissen erzeugen, sondern den Nutzer auf die Anleitung verweisen: https://imbas.fpre.ch/public/imbas/mcp/manuals/Anleitung%20Claude%20und%20ChatGPT.pdf

Die vier Tools sind voneinander unabhängig. Sobald Nutzung und Adresse feststehen, alle benötigten Aufrufe in einem einzigen Schritt parallel absetzen und nicht nacheinander. Die Geokodierungsprüfung erfolgt damit nach Erhalt der Resultate und vor der Ausgabe.

## Kennzeichnung von FPRE-Texten

`maktext` und `miktext` liefern fertige Texte. Bei jeder Textausgabe klar angeben, welcher der beiden Fälle vorliegt.

- **Unverändert übernommen**, wenn der FPRE-Text wörtlich wiedergegeben wird.
- **Auf Basis des FPRE-Texts generiert**, wenn gekürzt, umformuliert, zusammengefasst oder umgestellt wird. Auch dann keine Inhalte ergänzen, die nicht im Toolresultat stehen.

Standard ist die Kurzfassung. Ohne weitere Spezifikation durch den Nutzer werden Makrolagetext und Mikrolagetext zusammengefasst ausgegeben und mit dem Vermerk «Zusammengefasst auf Basis des FPRE-Texts» gekennzeichnet.

Für die Kurzfassung gilt:

- Nur Inhalte aus dem Toolresultat verwenden, nichts ergänzen, nichts interpretieren und keine Zahlen runden oder umrechnen.
- Die tragenden Aussagen und die dafür massgebenden Kennzahlen behalten, Aufzählungen von Detailwerten straffen.
- Als Fliesstext ausgeben, nicht als Stichwortliste.

Den vollständigen Originaltext unverändert ausgeben, wenn der Nutzer ihn verlangt, etwa mit «Volltext», «Originaltext» oder «unverändert». Dann mit «Unverändert übernommen» kennzeichnen. Am Ende der Kurzfassung anbieten, den Originaltext nachzuliefern.

### Textbausteine nicht offenlegen

Namen von Textbausteinen und Feldern wie `AllgT1`, `MakT_W1`, `MIKTEXT` oder `MIKTEXT_WOHN` sind interne Bezeichnungen und gehören nicht in die Ausgabe, weder in Überschriften noch in Klammerzusätzen, Fussnoten oder Aufzählungen. Auch nicht umschreiben, etwa als «Baustein 1». Die Kennzeichnung beschränkt sich damit auf die Herkunft des Texts.

Text und Rating stammen aus unterschiedlichen Bausteinen und können sprachlich abweichen, etwa bei der Aussicht. Solche Abweichungen weder kommentieren noch angleichen noch als Widerspruch melden, sondern beides unverändert wiedergeben.

## Ausgabe Makrolage

Enthält je nach Anliegen den Makrolagetext, das Makrolagerating oder beides.

**Makrolagetext**

- Text aus `maktext` mit passendem Texttyp, standardmässig als Kurzfassung gemäss Abschnitt Kennzeichnung von FPRE-Texten.
- Hinweis, dass sich die Aussagen auf die Ortschaft beziehen.

**Makrolagerating**

- Gesamtrating der relevanten Nutzung, aktuell und prospektiv.
- Teilratings derselben Nutzung, aktuell und prospektiv.
- Das Teilrating Risikofaktor Prognose ist eine reine Prognosegrösse. Den Wert deshalb ausschliesslich in der Spalte prospektiv ausweisen und die Spalte aktuell leer lassen, ohne Strich, ohne Wiederholung des Werts und ohne Fussnote.
- Nur Felder anzeigen, die das Tool tatsächlich geliefert hat. Nicht gelieferte Ratings weglassen, nicht als leer, nicht als `null` und nicht als Platzhalterzeile führen. Fragt der Nutzer nach einem erwarteten, aber fehlenden Rating, offenlegen, dass das Tool dazu nichts geliefert hat, und keine Ursache behaupten.
- Gelieferte Zusatzangaben wie Einschätzung, Markttemperatur, Trend und Angebotsentwicklung mit Originallabel zeigen.

## Ausgabe Mikrolage

**Mikrolagetext**

- Text aus `miktext` für die gewählte Nutzung, standardmässig als Kurzfassung gemäss Abschnitt Kennzeichnung von FPRE-Texten.
- Hinweis, dass sich die Aussagen auf die exakte Adresse beziehen.

**Mikrolagerating**

- Mikro-Lagerating der relevanten Nutzung mit numerischem Wert und Originallabel.
- Das Gesamtrating Mikrolage für die Liegenschaft nicht ausweisen, auch nicht als Nebenbemerkung. Es vermischt Nutzungen und ist für die Standortanalyse nicht die gesuchte Grösse.
- Die acht Teilratings als Tabelle mit numerischem Wert und Originallabel.
- PNG-Spider gemäss nächstem Abschnitt.

## Nur auf Nachfrage

Folgendes gehört weder bei Makro- noch bei Mikrolage in die Standardausgabe, auf ausdrückliche Nachfrage aber vollständig liefern.

- Skalenerläuterung, Modellversion, Datenstand, Geokodierung und Ortschaftencode
- verwendete Textbausteine und Feldnamen
- Ratings weiterer Nutzungen
- verwendete Gewichtung, auch wenn ein Einzelgewicht bei 1.0 liegt
- verwendete Platzhalteradresse bei Makrolageanalysen ohne exakte Adresse

## Mikrolage-Spider

Sobald ein Mikrolagerating ausgegeben wird, zusätzlich eine PNG-Datei mit `scripts/mikrolage_spider.py` erzeugen und bereitstellen. Die acht Werte und das Gesamtrating der ausgewiesenen Nutzung unverändert aus dem `mikrat`-Output übernehmen. Keine zweite Mikrolagegrafik im Chat rendern.

Vorgaben der Grafik:

- Titel `FPRE-Mikrolage [Nutzung] [Gesamtrating]`
- Adresse direkt unter dem Titel
- acht Achsen, Skala 1 bis 5
- Subratingname und Wert mit einer Nachkommastelle direkt an jeder Achse

Das Skript arbeitet deterministisch. Die erzeugte PNG-Datei nicht zusätzlich einlesen oder visuell nachkontrollieren, sondern direkt bereitstellen. Nur bei einem Fehler des Skripts prüfen.

```bash
python scripts/mikrolage_spider.py \
  --nutzung "Mietwohnung" \
  --adresse "Beispielstrasse 1, 8000 Zürich" \
  --werte '{"sonne":3.5,"sicht":4.0,"quartier":3.5,"dienstl":4.5,"freiz":3.0,"oeverk":4.5,"strassen":4.0,"laerm":3.0}' \
  --gesamtrating 3.8 \
  --output mikrolage.png
```

## Workflow

1. Anliegen klären, also Makrolage, Mikrolage oder beides.
2. Nutzung bestimmen. Fehlt die Angabe, Vorgabe gemäss Abschnitt Nutzung und Gewichtung anwenden statt nachzufragen.
3. Adresse prüfen. Für Mikrolage bei fehlender Strasse, Hausnummer oder Ort sofort nachfragen. Für Makrolage bei fehlenden Adressteilen eine zentrale Adresse der Ortschaft als Platzhalter bestimmen.
4. Tools laden und in einem Schritt parallel aufrufen, Makrolage mit `makrat` und `maktext`, Mikrolage mit `mikrat` und `miktext`.
5. Bei Mikrolage die Geokodierung gegen die Eingabe prüfen und bei Abweichung die Mikroausgabe abbrechen und nachfragen. Sonst den Spider erzeugen und ohne Nachkontrolle bereitstellen.
6. Ergebnis gemäss den Ausgabeabschnitten strukturieren und die Herkunft der FPRE-Texte kennzeichnen.

## Grenzen

- Keine Wertermittlung, keine Miet- oder Preisschätzung aus diesem Skill heraus. Dafür auf `fpre-bewertung` verweisen.
- Keine freie Marktinterpretation, Prognose oder Ursachenanalyse, ausser der Nutzer verlangt sie ausdrücklich. Dann klar als eigene Einschätzung kennzeichnen und von den FPRE-Resultaten trennen.
- Keine Vermischung von Makro- und Mikroaussagen in einem Absatz, da die Bezugsebenen unterschiedlich sind.
