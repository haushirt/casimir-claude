# casimir-claude

Casimirs Arbeits-Setup für Claude Code.
Ein Ort für alle Repos – Regeln, Befehle und der Check vor „fertig".

Es gibt zwei Wege, das in ein Repo zu bekommen. **Kopieren ist der empfohlene
Weg**, weil das Plugin in den Cloud-Sessions nur geladen wird, wenn dieses Repo
dort mit angehängt ist.

## Weg 1 (empfohlen): Dateien ins Repo kopieren

Der Ordner `.claude/` in diesem Repo ist die Vorlage. Sie wird unverändert in
das Zielrepo kopiert:

```bash
TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/haushirt/casimir-claude "$TMP/cc"
mkdir -p .claude
cp -R "$TMP/cc/.claude/skills" "$TMP/cc/.claude/scripts" .claude/
cp -n "$TMP/cc/.claude/settings.json" .claude/settings.json
chmod +x .claude/scripts/*.sh
rm -rf "$TMP"
```

Gibt es schon eine `.claude/settings.json`, nur den Schlüssel `hooks` daraus
ergänzen. Danach eine **neue** Session starten.

Kürzer geht es in der Session mit `/neu` – der Befehl macht genau das.

## Weg 2: als Plugin

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

Die Befehle heißen dann `/c:plan`, `/c:tag` usw. **Achtung:** In einer
Cloud-Session, an der nur das Zielrepo hängt, wird das Plugin nicht geladen –
der Marketplace wird dort nicht geholt. Dann fehlen Befehle, Regeln und Hooks
stillschweigend.

## Befehle

| Befehl | Modell | Wofür |
|---|---|---|
| `/plan` | Opus | Projektstart oder größerer Schritt, gemeinsam |
| `/tag` | Opus | Autonom durcharbeiten, Casimir ist erreichbar |
| `/nacht` | Opus | Autonom durcharbeiten, ohne Casimir |
| `/fix` | Sonnet | Kleine Änderung, max. 3 Dateien |
| `/mockup` | – | Bild vor Code bei allem Optischen |
| `/zurueck` | – | Letzte Änderung sicher zurücknehmen |
| `/neu` | – | Neues Repo einrichten |

`/mockup` springt auch von allein an, sobald das Wort „mockup" in einer
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
.claude/                          die Vorlage zum Kopieren (Weg 1)
  settings.json                   Hooks: Sessionstart + Check vor fertig
  skills/<name>/SKILL.md          die Befehle, ohne Namensraum
  scripts/regeln.sh               die Regeln R1–R7, automatisch beim Start
  scripts/fertig-check.sh         der Check
  scripts/mockup-shot.cjs         Bilder in 393x852 / 744x1133 / 1440x900

.claude-plugin/marketplace.json   Katalog (Weg 2)
plugins/c/                        dieselben Dateien als Plugin, Befehle /c:…
```

Die beiden Bäume werden von Hand gleich gehalten. Wird etwas in `plugins/c/`
geändert, gehört es auch nach `.claude/` – dort ohne `/c:`-Namensraum und mit
`${CLAUDE_PROJECT_DIR}/.claude` statt `${CLAUDE_PLUGIN_ROOT}`.
