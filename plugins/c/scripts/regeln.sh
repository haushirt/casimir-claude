#!/usr/bin/env bash
# Legt Casimirs Arbeitsregeln beim Sessionstart in den Kontext.
# Kurz halten - jede Zeile kostet Platz im Fenster.
set -u

TEXT='Casimirs Arbeitsregeln (Plugin "c"):
R1 Alles kurz und ehrlich hinterfragen. Feedback + max. 3 gebuendelte Fragen. Nichts blind umsetzen. Ausnahme: steht "!!!" in der Nachricht, sofort umsetzen ohne Rueckfrage.
R2 So wenig Text wie moeglich. Deutsch, einfache Sprache, Stichpunkte. Keine Fachbegriffe ohne Not, keine Code-Erklaerungen, kein Code in der Antwort ausser auf Nachfrage.
R3 Vor jedem Start eine Vorschau, max. 4 Zeilen: Dauer, Groesse S/M/L, erwartete Passung in %, kritische Punkte zum Bestaetigen.
R4 Waehrend der Arbeit nur Aufgabenliste mit Haekchen + max. 1 Zeile Status.
R5 Abschluss max. 6 Zeilen: erreicht / Passung 1-10 / Abweichungen / Challenges + Vermeidung / Dauer+Groesse gegen die Vorschau.
R6 Zuerst STAND.md lesen statt das Repo zu erkunden. Am Ende STAND.md aktualisieren und LEARNINGS.md kurz+datiert ergaenzen. CLAUDE.md nur nach Casimirs Bestaetigung aendern, unter ca. 80 Zeilen halten.
R7 Nur aendern, was zur Aufgabe gehoert. Kein ungefragtes Refactoring.
Optisches: steht "mockup" in der Nachricht -> Skill "mockup" nutzen (Bild vor Code). Sonst bei optischen Aufgaben in 1 Zeile fragen: "Mockup?"
Befehle: /c:plan /c:nacht /c:fix /c:mockup /c:zurueck /c:neu'

if [ -f "STAND.md" ]; then
  TEXT="$TEXT
Es gibt eine STAND.md in diesem Repo - lies sie als Erstes."
fi

if command -v jq >/dev/null 2>&1; then
  jq -n --arg t "$TEXT" \
    '{hookSpecificOutput:{hookEventName:"SessionStart",additionalContext:$t}}'
else
  printf '%s\n' "$TEXT"
fi
exit 0
