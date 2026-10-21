---
name: fpre-bewertung
description: Führt Nutzer durch FPRE-gestützte Immobilienbewertungen mit den FPRE Tools. Verwenden, wenn ein Nutzer eine Eigentumswohnung, ein Einfamilienhaus, eine Mietwohnung, eine Büro- oder Verkaufsfläche oder eine Renditeliegenschaft bewerten, Bewertungsinputs vorbereiten, eine Mikrolage bestimmen oder ein FPRE-Bewertungsergebnis strukturiert ausgeben möchte. Der Skill wählt das passende Bewertungsmodul, erhebt fehlende Inputs ohne zu raten, nutzt FPRE-Modellvorschläge wo passend, verlangt vor kontingentwirksamen Bewertungsaufrufen eine explizite Freigabe und gibt Ergebnisse faktenorientiert aus. Er setzt Zugriff auf die aktuellen FPRE Tools voraus und behandelt deren aktuelles Schema als technische Referenz.
---

# FPRE Bewertung

## Ziel

FPRE-Bewertungen aus natürlicher Sprache in einen kontrollierten, nachvollziehbaren Workflow überführen. Aktuelle FPRE-Tool-Schemas für technische Details verwenden und nur fachliche Regeln aus diesem Skill ergänzen.

Bei deutschsprachigen Antworten richtet sich die Rechtschreibung nach dem Land der Bewertung. In der Schweiz und in Liechtenstein immer `ss` statt `ß`, in Deutschland und Luxemburg die deutsche Schreibweise mit `ß`.

## Quellenhierarchie

1. Aktuelles FPRE-Tool-Schema für Felder, Pflichtstatus, Enums, Wertebereiche, Abdeckung und technischen Output verwenden.
2. `references/grundlagen.md` für allgemeine Bewertungs- und Bedienlogik laden.
3. Nur wenn ein Dossier, Exposé oder eine vergleichbare Objektunterlage eingelesen und als Bewertungsquelle verwendet wird, zusätzlich `references/dossier.md` laden. Diese Referenz bei Bewertungen ohne Dossier nicht laden.
4. Genau die passende Modulreferenz laden:
   - Eigentumswohnung -> `references/ewg.md`
   - Einfamilienhaus -> `references/efh.md`
   - Mietwohnung -> `references/mwg.md`
   - Renditeliegenschaft / Anlageobjekt / Mehrfamilienhaus DCF -> `references/ren.md`
   - Büro- oder Verkaufsfläche -> `references/bueverk.md`
5. Bei technischen Widersprüchen das aktuelle Tool-Schema verwenden. Bei Workflow- oder Ausgaberegeln diesen Skill und seine Referenzen verwenden.

Welche Referenzen nötig sind, steht nach dem Lesen dieses Skills fest. Sie deshalb in einem einzigen Schritt parallel laden und nicht nacheinander.

Keine Feldlisten, Enums oder Wertebereiche aus den Referenzen ableiten, wenn sie im aktuellen Tool-Schema verfügbar sind.

## Toolbeschaffung und Aufrufreihenfolge

Sind die FPRE Tools nicht geladen, eine einzige Suche über den vollständigen Toolsatz des Moduls ausführen. Nicht pro Tool einzeln suchen. Eine zweite Suche nur, wenn danach ein benötigtes Tool tatsächlich fehlt.

Voraussetzung ist eine Verbindung zum FPRE MCP-Server `https://mcp.fpre.ch` mit den von FPRE zugestellten Zugangsdaten. Fehlen die Tools auch nach der Suche, ist der Server nicht verbunden. Dann keine Bewertung simulieren und keine Ersatzwerte erzeugen, sondern den Nutzer auf die Anleitung verweisen: https://imbas.fpre.ch/public/imbas/mcp/manuals/Anleitung%20Claude%20und%20ChatGPT.pdf

| Modul | Benötigter Toolsatz |
|---|---|
| Eigentumswohnung | `ewg`, `mikrat`, `zust`, `stand` |
| Einfamilienhaus | `efh`, `mikrat`, `zust`, `stand` |
| Mietwohnung | `mwg`, `mikrat`, `zust`, `stand` |
| Büro- oder Verkaufsfläche | `bueverk`, `mikrat`, `zust` |
| Renditeliegenschaft | `hedonicdcf`, `mikrat` |

`mikrat`, `zust` und `stand` hängen nicht voneinander ab. Alle in einem Schritt parallel aufrufen und nicht nacheinander. Der Bewertungsaufruf folgt separat nach der Freigabe.

## Workflow

1. Bewertungsziel und Objekttyp bestimmen. Bei unklarem Objekttyp gezielt nachfragen.
2. Modul, Modulreferenz und benötigte Referenzen bestimmen und parallel laden.
3. Vollständige Adresse sicherstellen. Keine Adressbestandteile erfinden.
4. Bei einer Bewertung anhand eines Dossiers dessen Text, Tabellen, Pläne und relevante Bilder auswerten und `references/dossier.md` anwenden.
5. Toolsatz gemäss Abschnitt Toolbeschaffung laden und die aktuellen Schemas prüfen.
6. Pflichtinputs aus Nutzerangaben und zulässigen FPRE-Modellvorschlägen vervollständigen. Wertbeeinflussende Angaben nie frei schätzen.
7. Fehlende wertrelevante optionale Inputs knapp im Fliesstext nennen und fragen, ob sie ergänzt werden sollen. Dafür keinen Ausfüllblock ausgeben. Technische Steuer-, Rücklieferungs- und Sprachfelder nicht als Schätzqualitätsfaktoren darstellen.
8. Mikrolage, Ausbaustandard und Zustand gemäss `references/grundlagen.md`, der Modulreferenz und bei Dossiers zusätzlich `references/dossier.md` behandeln. Die dafür nötigen Hilfstools parallel aufrufen.
9. Vor jedem kontingentwirksamen Bewertungsaufruf das Bewertungs-Gate aus `references/grundlagen.md` vollständig durchlaufen und explizite Freigabe abwarten.
10. Erst nach Freigabe das Bewertungs-Tool aufrufen.
11. Ergebnis gemäss `references/grundlagen.md` und Modulreferenz faktenorientiert ausgeben.

## Tool-Nutzung

- FPRE Tools als einzige Quelle für FPRE-Modellwerte verwenden.
- Vor jedem Tool-Aufruf dessen aktuelles Schema lesen; keine im Skill gespeicherten technischen Annahmen gegen das Schema durchsetzen.
- Modellvorschläge nur mit Tools erzeugen, deren aktuelles Schema die konkrete Nutzung unterstützt.
- Wenn ein Hilfstool eine Nutzung aktuell nicht unterstützt, keinen Ersatzwert erfinden. Nutzerwert erfragen oder nur auf ausdrücklichen Wunsch eine klar bezeichnete KI-Heuristik anbieten.
- Kontingenthinweise nur für die in `references/grundlagen.md` definierten Bewertungsaufrufe verwenden.

## Mikrolage-Spider

Ob und wann Mikrolage ausgegeben wird, richtet sich nach `references/grundlagen.md`. Wenn sie ausgegeben wird, neben Aggregat und Subrating-Tabelle eine PNG-Datei mit `scripts/mikrolage_spider.py` erzeugen. Die acht Werte und das Gesamtrating der Nutzung aus dem aktuellen `mikrat`-Output übergeben, ohne sie umzudeuten. Der Titel weist Nutzung und Gesamtrating aus.

Das Skript arbeitet deterministisch. Die erzeugte PNG-Datei nicht zusätzlich einlesen oder visuell nachkontrollieren, sondern direkt bereitstellen. Nur bei einem Fehler des Skripts prüfen.

```bash
python scripts/mikrolage_spider.py \
  --nutzung "Eigentumswohnung" \
  --adresse "Beispielstrasse 1, 8000 Zürich" \
  --werte '{"sonne":3.5,"sicht":4.0,"quartier":3.5,"dienstl":4.5,"freiz":3.0,"oeverk":4.5,"strassen":4.0,"laerm":3.0}' \
  --gesamtrating 3.8 \
  --output mikrolage.png
```

## Grenzen

- Keine Bewertung ohne die vom aktuellen Tool verlangten Pflichtinputs ausführen.
- Keine freie Plausibilisierung, Ursachenanalyse oder Marktinterpretation liefern, ausser der Nutzer verlangt dies ausdrücklich.
- Keine technischen Tooldetails als dauerhafte Fachregel behandeln, wenn sie aus dem Live-Schema gelesen werden können.
