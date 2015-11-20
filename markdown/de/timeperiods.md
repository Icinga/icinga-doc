 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.9. Zeitfenster
----------------

5.9.1. [Einführung](timeperiods.md#introduction)

5.9.2. [Vorrang bei Zeitfenstern](timeperiods.md#precedence)

5.9.3. [Wie Zeitfenster mit Host- und Service-Prüfungen
arbeiten](timeperiods.md#hostservicechecks)

5.9.4. [Wie Zeitfenster mit Kontakt-Benachrichtigungen
arbeiten](timeperiods.md#contactnotifications)

5.9.5. [Wie Zeitfenster mit Benachrichtigungs-Eskalationen
arbeiten](timeperiods.md#notificationescalations)

5.9.6. [Wie Zeitfenster mit Abhängigkeiten
arbeiten](timeperiods.md#dependenciestimeperiods)

oder...

### 5.9.1. Einführung

![](../images/objects-timeperiods.png)

[Zeitfenster](objectdefinitions.md#objectdefinitions-timeperiod)-Definitionen
erlauben Ihnen zu kontrollieren, wann verschiedene Aspekte der
Überwachungs- und Alarmierungslogik arbeiten. Zum Beispiel können Sie
einschränken





### 5.9.2. Vorrang bei Zeitfenstern

Zeitfenster-[Definitionen](objectdefinitions.md#objectdefinitions-timeperiod)
können mehrere Typen von Direktiven enthalten, einschließlich
Wochentagen, Monatstagen und Kalenderdaten. Verschiedene Typen von
Direktiven haben unterschiedliche Vorrang-Ebenen und können andere
Direktiven in Ihren Zeitfenster-Definitionen außer Kraft setzen. Die
Rangfolge für verschiedene Typen von Direktiven (in absteigender
Reihenfolge) ist wie folgt:







Beispiele für verschiedene Zeitfenster-Direktiven finden Sie
[hier](objectdefinitions.md#objectdefinitions-timeperiod).

### 5.9.3. Wie Zeitfenster mit Host- und Service-Prüfungen arbeiten

Host- und Service-Definitionen haben eine optionale
*check\_period*-Direktive, die es Ihnen erlaubt, ein Zeitfenster
anzugeben, das zur Einschränkung benutzt werden sollte, wann regelmäßig
geplante aktive Prüfungen des Hosts oder Service stattfinden.

Wenn Sie die *check\_period*-Direktive nicht nutzen, um ein Zeitfenster
anzugeben, wird Icinga in der Lage sein, aktive Prüfungen für den Host
oder Service zu jeder Zeit zu planen, wenn es nötig ist. Dies ist in
Wirklichkeit ein 24x7-Überwachungsszenario.

Ein Zeitfenster in der *check\_period*-Direktive anzugeben erlaubt Ihnen
die Einschränkung der Zeit, wann Icinga regelmäßige aktive Host- oder
Service-Prüfungen plant. Wenn Icinga versucht, einen Host oder Service
neu zu planen, wird es sicherstellen, dass die nächste Prüfung in einen
gültigen Zeitbereich im definierten Zeitfenster fällt. Falls das nicht
zutreffen sollte, wird Icinga die Zeit der nächsten Prüfung so anpassen,
dass sie in die nächste "gültige" Zeit im angegebenen Zeitfenster fällt.
Das bedeutet, dass der Host oder Service vielleicht während der nächsten
Stunde, des nächsten Tages oder der nächsten Woche, etc. nicht geprüft
wird.

![](../images/note.gif) Anmerkung: Prüfungen nach Bedarf und passive
Prüfungen sind nicht durch das Zeitfenster beschränkt, das Sie in der
*check\_period*-Direktive angeben. Nur regelmäßig geplante aktive
Prüfungen werden beschränkt.

Außer Sie haben einen guten Grund das zu tun, würden wir raten, dass Sie
all Ihre Hosts und Services mit einem Zeitfenster überwachen, das einen
24x7-Zeitbereich abdeckt. Falls Sie das nicht tun, können Sie während
der "blackout"-Zeiten in einige Probleme laufen (Zeiten, die nicht
gültig sind in der Zeitfenster-Definition):




### 5.9.4. Wie Zeitfenster mit Kontakt-Benachrichtigungen arbeiten

Durch das Angeben eines Zeitfensters in der
*notification\_period*-Direktive einer Host- oder Service-Definition
kontrollieren Sie, wann Icinga Benachrichtigungen versenden darf, um
über Probleme oder Erholungen für den Host oder Service zu informieren.
Wenn eine Host-Benachrichtigung versandt werden soll, prüft Icinga, ob
die aktuelle Zeit in einem gültigen Bereich der *notification\_period*
liegt. Wenn eine gültige Zeit vorliegt, wird Icinga versuchen, jeden
Kontakt über das Problem oder die Erholung zu informieren.

Sie können Zeitfenster auch nutzen, um zu kontrollieren, wann
Benachrichtigungen an einzelne Kontakte versandt werden. Durch die
Nutzung der *service\_notification\_period*- und der
*host\_notification\_period*-Direktiven in den
[Kontakt-Definitionen](objectdefinitions.md#objectdefinitions-contact)
sind Sie in der Lage, eine tatsächliche Rufbereitschaft für jeden
Kontakt zu definieren. Kontakte werden Host- und
Service-Benachrichtigungen nur während der Zeiten erhalten, die Sie in
den Benachrichtigungs-Direktiven angegeben haben.

Beispiele, wie Zeitfenster-Definitionen für Rufbereitschafts-Wechsel
angelegt werden, finden Sie
[hier](oncallrotation.md "7.11. Bereitschafts-Rotation").

### 5.9.5. Wie Zeitfenster mit Benachrichtigungs-Eskalationen arbeiten

Service- und
Host-[Benachrichtigungs-Eskalationen](escalations.md "7.9. Benachrichtigungseskalationen")
haben eine optionale *escalation\_period*-Direktive, die es Ihnen
erlaubt ein Zeitfenster anzugeben, wann die Eskalation gültig ist und
benutzt werden kann. Wenn Sie die *escalation\_period*-Direktive nicht
in einer Eskalations-Definition benutzen, ist diese Eskalation zu allen
Zeiten gültig. Wenn Sie ein Zeitfenster in der
*escalation\_period*-Direktive angeben, wird Icinga die
Eskalations-Definition nur zu Zeiten nutzen, die aufgrund der
Zeitfenster-Definition gültig sind.

### 5.9.6. Wie Zeitfenster mit Abhängigkeiten arbeiten

Service- und
Host-[Abhängigkeiten](dependencies.md "7.13. Host- und Service-Abhängigkeiten")
haben eine optionale *dependency\_period*-Direktive, die es Ihnen
erlaubt ein Zeitfenster anzugeben, wann die Abhängigkeit gültig ist und
benutzt werden kann. Wenn Sie die *dependency\_period*-Direktive nicht
in einer Abhängigkeits-Definition benutzen, ist diese Abhängigkeit zu
allen Zeiten gültig. Wenn Sie ein Zeitfenster in der
*dependency\_period*-Direktive angeben, wird Icinga die
Abhängigkeits-Definition nur zu Zeiten nutzen, die aufgrund der
Zeitfenster-Definition gültig sind.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
