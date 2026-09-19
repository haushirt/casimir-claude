---
name: neu
description: Neues Repo fuer Casimirs Arbeitsweise einrichten - Plugin-Einbindung, CLAUDE.md, STAND.md, LEARNINGS.md.
argument-hint: "[optional: worum geht das Projekt]"
disable-model-invocation: true
---

# /c:neu - Repo einrichten

Projekt: $ARGUMENTS

Stelle zuerst **hoechstens 3 Fragen** zum Projekt, gebuendelt in einer Nachricht,
am besten als Auswahl mit Vorschlag. Sinnvolle Fragen sind:
- Worum geht es, in einem Satz?
- Was ist die Technik (z. B. Cloudflare Worker, Webseite, Skript)?
- Gibt es etwas, das Claude niemals tun darf (z. B. Deploy, Push auf main)?

Danach lege diese vier Dateien an. Nichts anderes anfassen.

## 1. `.claude/settings.json`
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
Gibt es die Datei schon, ergaenze nur diese beiden Schluessel.

## 2. `CLAUDE.md`
Nur **projektspezifisches** Wissen, unter 80 Zeilen. Die Arbeitsweise steht
schon im Plugin und gehoert hier NICHT hinein. Geruest:

```markdown
# <Projektname>

## Worum es geht
<ein bis drei Saetze>

## Technik
<Stack, wichtigste Dateien>

## Harte Regeln
1. <was nie passieren darf>

## Sprache
UI-Texte Deutsch. Commits: kurze Beschreibung auf Deutsch.
```

## 3. `STAND.md`
```markdown
# Stand

**Letzte Aktualisierung:** <Datum>

## Wo wir stehen
- <Stichpunkte>

## Was als Naechstes ansteht
- <Stichpunkte>

## Bekannte Baustellen
- <Stichpunkte>
```

## 4. `LEARNINGS.md`
```markdown
# Learnings

<!-- Kurz und datiert. Neueste oben. -->
```

Zum Schluss: 1 Zeile, dass das Repo eingerichtet ist, plus der Hinweis, dass
das Plugin erst nach einem Neustart der Session geladen wird.
