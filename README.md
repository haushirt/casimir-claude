# casimir-claude

Casimirs Arbeits-Setup für Claude Code, als Plugin.
Ein Ort für alle Repos – Regeln, Befehle und der Check vor „fertig".

## In einem Repo einschalten

`.claude/settings.json` im jeweiligen Repo:

```json
{
  "extraKnownMarketplaces": {
    "casimir": {
      "source": { "source": "github", "repo": "haushirt/casimir-claude" }
    }
  },
  "enabledPlugins": { "c@casimir": true }
}
```

Danach eine **neue** Session starten – Plugins werden beim Start geladen.

Leeres Repo ohne diese Datei? Dann das Plugin im claude.ai-Konto aktivieren
(Synced Plugin), dann ist es überall dabei. Oder in der Session einmal sagen:
„Richte dieses Repo nach haushirt/casimir-claude ein."

## Befehle

| Befehl | Modell | Wofür |
|---|---|---|
| `/c:plan` | Opus | Projektstart oder größerer Schritt, gemeinsam |
| `/c:tag` | Opus | Autonom durcharbeiten, Casimir ist erreichbar |
| `/c:nacht` | Opus | Autonom durcharbeiten, ohne Casimir |
| `/c:fix` | Sonnet | Kleine Änderung, max. 3 Dateien |
| `/c:mockup` | – | Bild vor Code bei allem Optischen |
| `/c:zurueck` | – | Letzte Änderung sicher zurücknehmen |
| `/c:neu` | – | Neues Repo einrichten |

`/c:mockup` springt auch von allein an, sobald das Wort „mockup" in einer
Nachricht steht.

## Was automatisch läuft

* **Beim Sessionstart:** die Regeln R1–R7 kommen automatisch in den Kontext,
  plus der Hinweis, zuerst `STAND.md` zu lesen. Es gibt dafür keinen Befehl –
  die Regeln sind einfach da.
* **Vor „fertig":** `npm run lint`, `typecheck` und `test` – soweit im Projekt
  vorhanden. Rot blockt genau einmal je Anfrage, dann lässt der Hook durch.
  Läuft nur, wenn es wirklich Änderungen gibt.

Andere Skripte prüfen lassen: `C_CHECK_SCRIPTS="test build"` in den
Umgebungsvariablen der Cloud-Umgebung setzen.

## Aufbau

```
.claude-plugin/marketplace.json   Katalog
plugins/c/
  .claude-plugin/plugin.json      Manifest
  skills/<name>/SKILL.md          die Befehle
  hooks/hooks.json                Sessionstart + Check vor fertig
  scripts/regeln.sh               die Regeln R1–R7, automatisch beim Start
  scripts/fertig-check.sh         der Check
  scripts/mockup-shot.cjs         Bilder in 393x852 / 744x1133 / 1440x900
```
