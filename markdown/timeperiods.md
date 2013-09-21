Zeitfenster
===========

oder...

Einführung
----------

![](../images/objects-timeperiods.png)

[Zeitfenster](#objectdefinitions-timeperiod)-Definitionen erlauben Ihnen
zu kontrollieren, wann verschiedene Aspekte der Überwachungs- und
Alarmierungslogik arbeiten. Zum Beispiel können Sie einschränken

-   wann regelmäßig geplante Host- und Service-Prüfungen ausgeführt
    werden

-   wann Benachrichtigungen versandt werden

-   wann Benachrichtigungs-Eskalationen benutzt werden können

-   wann Abhängigkeiten gültig sind

Vorrang bei Zeitfenstern
------------------------

Zeitfenster-[Definitionen](#objectdefinitions-timeperiod) können mehrere
Typen von Direktiven enthalten, einschließlich Wochentagen, Monatstagen
und Kalenderdaten. Verschiedene Typen von Direktiven haben
unterschiedliche Vorrang-Ebenen und können andere Direktiven in Ihren
Zeitfenster-Definitionen außer Kraft setzen. Die Rangfolge für
verschiedene Typen von Direktiven (in absteigender Reihenfolge) ist wie
folgt:

-   Kalenderdaten (2008-01-01)

-   angegebener Tag des Monats (January 1st)

-   generischer Tag des Monats (Day 15)

-   Offset Wochentag eines bestimmten Monats (2nd Tuesday in December)

-   Offset Wochentag (3rd Monday)

-   normaler Wochentag (Tuesday)

Beispiele für verschiedene Zeitfenster-Direktiven finden Sie
[hier](#objectdefinitions-timeperiod).

Wie Zeitfenster mit Host- und Service-Prüfungen arbeiten
--------------------------------------------------------

Host- und Service-Definitionen haben eine optionale
*check\_period*-Direktive, die es Ihnen erlaubt, ein Zeitfenster
anzugeben, das zur Einschränkung benutzt werden sollte, wann regelmäßig
geplante aktive Prüfungen des Hosts oder Service stattfinden.

Wenn Sie die *check\_period*-Direktive nicht nutzen, um ein Zeitfenster
anzugeben, wird NAME-ICINGA in der Lage sein, aktive Prüfungen für den
Host oder Service zu jeder Zeit zu planen, wenn es nötig ist. Dies ist
in Wirklichkeit ein 24x7-Überwachungsszenario.

Ein Zeitfenster in der *check\_period*-Direktive anzugeben erlaubt Ihnen
die Einschränkung der Zeit, wann NAME-ICINGA regelmäßige aktive Host-
oder Service-Prüfungen plant. Wenn NAME-ICINGA versucht, einen Host oder
Service neu zu planen, wird es sicherstellen, dass die nächste Prüfung
in einen gültigen Zeitbereich im definierten Zeitfenster fällt. Falls
das nicht zutreffen sollte, wird NAME-ICINGA die Zeit der nächsten
Prüfung so anpassen, dass sie in die nächste "gültige" Zeit im
angegebenen Zeitfenster fällt. Das bedeutet, dass der Host oder Service
vielleicht während der nächsten Stunde, des nächsten Tages oder der
nächsten Woche, etc. nicht geprüft wird.

![](../images/note.gif) Anmerkung: Prüfungen nach Bedarf und passive
Prüfungen sind nicht durch das Zeitfenster beschränkt, das Sie in der
*check\_period*-Direktive angeben. Nur regelmäßig geplante aktive
Prüfungen werden beschränkt.

Außer Sie haben einen guten Grund das zu tun, würden wir raten, dass Sie
all Ihre Hosts und Services mit einem Zeitfenster überwachen, das einen
24x7-Zeitbereich abdeckt. Falls Sie das nicht tun, können Sie während
der "blackout"-Zeiten in einige Probleme laufen (Zeiten, die nicht
gültig sind in der Zeitfenster-Definition):

1.  der Status des Hosts oder Service wird in der blackout-Zeit
    unverändert erscheinen.

2.  Kontakte werden während der blackout-Zeit wahrscheinlich nicht
    erneut über Host- oder Service-Probleme informiert werden.

3.  falls sich ein Host oder Service während einer blackout-Zeit erholt,
    werden Kontakte nicht umgehend über die Erholung informiert.

Wie Zeitfenster mit Kontakt-Benachrichtigungen arbeiten
-------------------------------------------------------

Durch das Angeben eines Zeitfensters in der
*notification\_period*-Direktive einer Host- oder Service-Definition
kontrollieren Sie, wann NAME-ICINGA Benachrichtigungen versenden darf,
um über Probleme oder Erholungen für den Host oder Service zu
informieren. Wenn eine Host-Benachrichtigung versandt werden soll, prüft
NAME-ICINGA, ob die aktuelle Zeit in einem gültigen Bereich der
*notification\_period* liegt. Wenn eine gültige Zeit vorliegt, wird
NAME-ICINGA versuchen, jeden Kontakt über das Problem oder die Erholung
zu informieren.

Sie können Zeitfenster auch nutzen, um zu kontrollieren, wann
Benachrichtigungen an einzelne Kontakte versandt werden. Durch die
Nutzung der *service\_notification\_period*- und der
*host\_notification\_period*-Direktiven in den
[Kontakt-Definitionen](#objectdefinitions-contact) sind Sie in der Lage,
eine tatsächliche Rufbereitschaft für jeden Kontakt zu definieren.
Kontakte werden Host- und Service-Benachrichtigungen nur während der
Zeiten erhalten, die Sie in den Benachrichtigungs-Direktiven angegeben
haben.

Beispiele, wie Zeitfenster-Definitionen für Rufbereitschafts-Wechsel
angelegt werden, finden Sie [hier](#oncallrotation).

Wie Zeitfenster mit Benachrichtigungs-Eskalationen arbeiten
-----------------------------------------------------------

Service- und Host-[Benachrichtigungs-Eskalationen](#escalations) haben
eine optionale *escalation\_period*-Direktive, die es Ihnen erlaubt ein
Zeitfenster anzugeben, wann die Eskalation gültig ist und benutzt werden
kann. Wenn Sie die *escalation\_period*-Direktive nicht in einer
Eskalations-Definition benutzen, ist diese Eskalation zu allen Zeiten
gültig. Wenn Sie ein Zeitfenster in der *escalation\_period*-Direktive
angeben, wird NAME-ICINGA die Eskalations-Definition nur zu Zeiten
nutzen, die aufgrund der Zeitfenster-Definition gültig sind.

Wie Zeitfenster mit Abhängigkeiten arbeiten
-------------------------------------------

Service- und Host-[Abhängigkeiten](#dependencies) haben eine optionale
*dependency\_period*-Direktive, die es Ihnen erlaubt ein Zeitfenster
anzugeben, wann die Abhängigkeit gültig ist und benutzt werden kann.
Wenn Sie die *dependency\_period*-Direktive nicht in einer
Abhängigkeits-Definition benutzen, ist diese Abhängigkeit zu allen
Zeiten gültig. Wenn Sie ein Zeitfenster in der
*dependency\_period*-Direktive angeben, wird NAME-ICINGA die
Abhängigkeits-Definition nur zu Zeiten nutzen, die aufgrund der
Zeitfenster-Definition gültig sind.

Zeitfenster (time periods)
