# Modul BUEVERK - Büro und Verkauf

Bewertungs-Tool: `bueverk`.

## Fachliche Regeln

- Technische Pflicht- und Optionalfelder ausschliesslich aus dem aktuellen `bueverk`-Schema ableiten.
- Nutzfläche nur zusammen mit einem schema-konformen Flächencode verwenden.
- Baujahr, Stockwerk, Ausbauart, Ausbaustandard, Zustand und Mikrolage nicht frei schätzen.
- Mikrolage mit `mikrat` für die konkrete Nutzung Büro oder Verkauf bestimmen und den passenden Gesamtrating-Wert als `mikro` verwenden.
- Bei manueller Mikrolage-Übersteuerung `mikro` mit der im aktuellen Schema für Büro beziehungsweise Verkauf vorgesehenen Nutzung verwenden.
- Fehlt der Ausbaustandard, `stand` anbieten, sofern die konkrete Nutzung im aktuellen `stand`-Schema unterstützt wird.
- Einen Zustand-Modellvorschlag nur verwenden, wenn ein aktuelles FPRE-Hilfstool die konkrete Nutzung tatsächlich unterstützt. Sonst Nutzerwert erfragen.
- Transaktionsangaben nur dann aktiv thematisieren, wenn sie für den konkreten Fall fachlich relevant sind. Reine Rücklieferungs- oder Steuerfelder nicht als qualitätsrelevant darstellen.

## Ergebnis

Den vom aktuellen `bueverk`-Tool gelieferten Hauptwert fachlich korrekt bezeichnen. Insbesondere keinen Marktwert behaupten, wenn das aktuelle Tool eine Marktmiete liefert. Passende Kennzahl je Nutzfläche ausweisen, sofern sinnvoll.
