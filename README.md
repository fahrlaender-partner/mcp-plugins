# FPRE MCP Plugins

Skills von Fahrländer Partner AG für KI-Clients (ChatGPT, Codex, Claude), die mit dem FPRE MCP-Server `https://mcp.fpre.ch` arbeiten.

Die Skills werden hier einmal gepflegt und über die Plugin-Verzeichnisse von ChatGPT und Claude verteilt. Der MCP-Server selbst ist nicht Teil dieses Repos, die Verbindung richtet der Kunde mit seinen FPRE-Zugangsdaten ein (siehe `docs/anleitung-claude-chatgpt.md`). Das Repo enthält keine Zugangsdaten und ist öffentlich, weil das Claude Directory ein öffentliches Repo verlangt.

## Struktur

```
.agents/plugins/marketplace.json      Katalog für Codex und ChatGPT-Workspace-Import
.claude-plugin/marketplace.json       Katalog für Claude Code und Claude Desktop
plugins/fpre-tools/                   Das Plugin, Ordner wird bei Anthropic eingereicht
  plugin.json                         Agent-Plugins-Manifest (ChatGPT-Submission)
  .claude-plugin/plugin.json          Claude-Manifest
  README.md                           Listing-Beschreibung im Claude Directory
  LICENSE                             Proprietäre Lizenz
  assets/icon.svg
  skills/fpre-bewertung/              Geführte Immobilienbewertung
  skills/fpre-standortanalyse/        Makro- und Mikrolage
docs/anleitung-claude-chatgpt.md      Kundenanleitung
scripts/pack.ps1                      Baut das Submission-ZIP für ChatGPT nach dist/
```

Jeder Skill ist in sich geschlossen. `scripts/mikrolage_spider.py` liegt deshalb bewusst in beiden Skills.

## Release

1. Skills anpassen, `version` in beiden `plugin.json` erhöhen, auf `main` mergen.
2. **Claude**: Das Directory liest `main` automatisch, scannt den Commit und publiziert gemäss Auto-Publish-Einstellung im Portal `claude.ai/directory/manage`.
3. **ChatGPT**: `.\scripts\pack.ps1` ausführen, ZIP aus `dist/` im Submission-Portal hochladen, Release Notes eintragen, Review abwarten, publizieren.

## Verteilkanäle

| Kanal | Mechanismus |
|---|---|
| ChatGPT Plugin Directory | ZIP-Submission über das OpenAI-Portal |
| Claude Directory | Plugin-Ordner `plugins/fpre-tools` aus diesem Repo, eingereicht über `claude.ai/directory/manage` |
| Codex / Claude Code (intern, Tests) | `codex plugin marketplace add <repo-url>` bzw. `claude plugin marketplace add fahrlaender-partner/mcp-plugins` |

## Lokaler Test vor Einreichung

- ChatGPT: ZIP aus `dist/` über Plugins > Upload im eigenen Konto laden.
- Claude: Ordner `plugins/fpre-tools` zippen und unter Customize > Plugins > Add > Upload plugin laden, oder `claude --plugin-dir .\plugins\fpre-tools`.
- FPRE-App bzw. Connector verbinden und beide Skills mit einer Beispielanfrage durchspielen.
