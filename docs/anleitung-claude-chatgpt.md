# Anleitung: FPRE Tools in ChatGPT und Claude

Fahrländer Partner AG, Oktober 2026

Die FPRE Tools bestehen aus zwei Teilen:

1. **FPRE MCP-Server** `https://mcp.fpre.ch`: liefert die Bewertungs- und Lagetools. Die Verbindung braucht die von FPRE zugestellte Client ID und das Client Secret.
2. **Plugin "FPRE Tools"**: enthält die Skills `fpre-bewertung` und `fpre-standortanalyse`, die ChatGPT und Claude durch Bewertungen und Standortanalysen führen. Das Plugin enthält keine Zugangsdaten und ist in den Plugin-Verzeichnissen von ChatGPT und Claude öffentlich verfügbar.

Beide Teile sind nötig. Ohne verbundenen MCP-Server findet das Plugin keine Tools.

## ChatGPT

### Schritt 1: FPRE MCP-Server als App verbinden

**Variante A: Business/Enterprise, Admin richtet einmal für alle ein**

1. `https://chatgpt.com/admin/apps?tab=drafts` öffnen, "New App" wählen.
2. Server URL: `https://mcp.fpre.ch/`
3. Authentication: OAuth
4. Registration method: User-Defined OAuth Client (Advanced Settings)
5. OAuth Client ID: die von FPRE zugestellte Client ID
6. OAuth Client Secret: das von FPRE zugestellte Secret
7. Token endpoint auth method: `client_secret_post`
8. "Connect" ausführen, danach "Publish" für den Workspace.

Hinweis: Beim ersten Publish können die Tools noch fehlen, weil die OAuth-Verbindung erst beim ersten Connect aufgebaut wird. Erscheint "Failed to refresh app actions – Unauthorized", zuerst Connect, dann Publish wiederholen.

Mitarbeitende müssen keine Zugangsdaten eingeben. Die App erscheint bei ihnen unter Apps mit der Kennzeichnung "custom".

**Variante B: Plus/Pro, Einzelnutzer**

Gleiche Schritte wie Variante A in den eigenen Einstellungen unter Apps, Developer Mode. Die Zugangsdaten gelten für den eigenen Account.

### Schritt 2: Plugin "FPRE Tools" installieren

In ChatGPT in der Seitenleiste "Plugins" öffnen, nach "FPRE Tools" suchen und installieren. Bei Business/Enterprise kann der Admin das Plugin unter Admin > Plugins für den Workspace freigeben.

### Schritt 3: Prüfen

Beispielanfrage: "Bewerte ein Einfamilienhaus an der Bahnhofstrasse 1, 8001 Zürich. Wohnfläche 150 m², Baujahr 2010, guter Zustand, Grundstück 400 m²."

Der Skill `fpre-bewertung` sollte die Pflichtinputs erfragen und vor dem Bewertungsaufruf eine Freigabe verlangen.

## Claude

Voraussetzung: Pro, Max, Team oder Enterprise. Im Free-Plan sind Directory-Plugins nicht verfügbar.

### Schritt 1: FPRE MCP-Server als Connector verbinden

1. In Claude unter Customize > Connectors "Custom Connector hinzufügen" wählen.
2. URL: `https://mcp.fpre.ch/`
3. Advanced Settings: OAuth Client ID und Client Secret von FPRE eintragen.
4. Verbinden. Ein Login-Dialog erscheint nicht, die Verbindung wird direkt bestätigt.

Bei Team/Enterprise legt der Owner den Connector für die Organisation an. Mitglieder verbinden ihn danach mit einem Klick unter Customize > Connectors.

### Schritt 2: Plugin "FPRE Tools" installieren

1. Customize > Plugins > Discover öffnen.
2. "FPRE Tools" suchen und "Add" wählen.
3. Die Skills erscheinen unter Customize > Skills und im `/`-Menü des Chats. Sie sind damit auch in Claude Desktop, Mobile, Cowork und Claude Code verfügbar.

Bei Team/Enterprise kann der Owner das Plugin unter Organisationseinstellungen für alle Mitglieder als "installed by default" setzen.

### Schritt 3: Prüfen

Gleiche Beispielanfrage wie bei ChatGPT.

## Troubleshooting

| Symptom | Ursache und Lösung |
|---|---|
| Tools werden nicht angezeigt (ChatGPT) | Connect der App wiederholen, danach Publish. |
| 401 Unauthorized beim Tool-Aufruf | Client Secret abgelaufen oder falsch. Neues Secret bei support@fpre.ch anfordern. |
| Skill meldet, der FPRE-Server sei nicht verbunden | Schritt 1 nicht abgeschlossen. |
| invalid_redirect_uri | Der Host des KI-Clients ist bei FPRE nicht freigegeben. An support@fpre.ch wenden. |
| Plugin nicht im Claude-Directory sichtbar | Free-Plan, oder der Owner hat das Directory für die Organisation ausgeblendet. |

Support: support@fpre.ch
