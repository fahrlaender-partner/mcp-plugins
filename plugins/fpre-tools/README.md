# FPRE Tools

Skills von Fahrländer Partner AG für Immobilienbewertung und Standortanalyse in der Schweiz. Das Plugin führt durch hedonische Marktwertschätzungen für Einfamilienhäuser, Eigentums- und Mietwohnungen sowie Büro- und Verkaufsflächen, durch DCF-Bewertungen von Renditeliegenschaften und durch Makro- und Mikrolage-Analysen für jede Adresse.

## Voraussetzung

Die Skills arbeiten ausschliesslich mit den Tools des FPRE MCP-Servers `https://mcp.fpre.ch`. Der Server ist nicht Teil dieses Plugins und muss separat als App (ChatGPT) oder Connector (Claude) verbunden werden. Dafür sind eine Client ID und ein Client Secret nötig, die FPRE lizenzierten Kunden zustellt. Anleitung: https://imbas.fpre.ch/public/imbas/mcp/manuals/Anleitung%20Claude%20und%20ChatGPT.pdf

Ohne verbundenen Server erzeugen die Skills keine Ersatzwerte, sondern verweisen auf die Anleitung.

In Claude muss "Code execution and file creation" aktiviert sein (Einstellungen > Capabilities), sonst werden die Skill-Inhalte nicht geladen und der Mikrolage-Spider kann nicht erzeugt werden.

## Skills

- **fpre-bewertung**: wählt das passende Bewertungsmodul, erhebt fehlende Inputs ohne zu raten, nutzt FPRE-Modellvorschläge für Mikrolage, Ausbaustandard und Zustand, verlangt vor jedem kontingentwirksamen Bewertungsaufruf eine explizite Freigabe und gibt Ergebnisse faktenorientiert aus.
- **fpre-standortanalyse**: erstellt Makro- und Mikrolage-Analysen mit Ratings und Lagetexten, kennzeichnet FPRE-Originaltexte, prüft die Geokodierung und erzeugt einen Mikrolage-Spider als PNG.

## Nutzung

Beispiel: "Bewerte ein Einfamilienhaus an der Bahnhofstrasse 1, 8001 Zürich. Wohnfläche 150 m², Baujahr 2010, guter Zustand, Grundstück 400 m²." Der Skill erfragt fehlende Pflichtangaben, zeigt alle Inputs vor dem Aufruf und wartet auf die Freigabe.

## Daten

Die Skills senden Adressen und Objektangaben, die der Nutzer eingibt, über den verbundenen Connector an `mcp.fpre.ch`. Das Plugin selbst speichert nichts und kontaktiert keine anderen Dienste. Das Script `scripts/mikrolage_spider.py` läuft lokal und zeichnet nur die übergebenen Ratings.

## Support

support@fpre.ch, https://www.fpre.ch
