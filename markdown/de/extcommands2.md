![Icinga](../images/logofullsize.png "Icinga")

7.2. Liste der externen Befehle

[Zurück](extcommands.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](eventhandlers.md)

* * * * *

7.2. Liste der externen Befehle
-------------------------------

Nachfolgend finden Sie Beschreibungen für jeden externen Befehl. Es ist
ziemlich einfach, externe Befehle an Icinga zu senden und Sie müssen
jeweils nur die letzte Zeile des Beispiel-Scripts anpassen, um einen
anderen Befehl zu nutzen (so dass wir auf Beispiele in den
Beschreibungen verzichtet haben).

Eine [Liste der verfügbaren Befehle](cgiparams.md#cgiparams-commands)
gibt es auch in der Beschreibung der CGI-Parameter.

*Beispiel:*

~~~~ {.programlisting}
 #!/bin/sh
 # Passen Sie ggf. die Variablen auf Ihre Umgebung an.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] ACKNOWLEDGE_HOST_PROBLEM;Host1;1;1;1;Max Mustermann;ein Kommentar\n" $now > $commandfile
~~~~

**ACKNOWLEDGE\_HOST\_PROBLEM**

`ACKNOWLEDGE_HOST_PROBLEM;`{.code}\<host\_name\>;\<sticky\>;\<notify\>;\<persistent\>;\<author\>;\<comment\>

Erlaubt Ihnen, das aktuelle Problem für den angegebenen Host zu
bestätigen. Durch Bestätigung des aktuellen Problems werden weitere
Benachrichtigungen (für den gleichen Host-Status) deaktiviert.

Wenn die "sticky"-Option auf zwei (2) gesetzt wird, bleibt die
Bestätigung bestehen, bis der Host sich erholt (in einen UP-Status
zurückkehrt). Anderenfalls wird die Bestätigung automatisch entfernt,
wenn sich der Host-Status ändert.

Wenn die "notify"-Option auf eins (1) gesetzt wird, werden die Kontakte
über die Bestätigung informiert, bei Null (0) wird keine
Benachrichtigung versandt.

Wenn die "persistent"-Option auf eins (1) gesetzt wird, bleibt der
Kommentar der Bestätigung auch nach der Erholung des Hosts bestehen.

**ACKNOWLEDGE\_HOST\_PROBLEM\_EXPIRE**

`ACKNOWLEDGE_HOST_PROBLEM_EXPIRE;`{.code}\<host\_name\>;\<sticky\>;\<notify\>;\<persistent\>;\<timestamp\>;\<author\>;\<comment\>

Erlaubt Ihnen, die Verfallszeit (in Sekunden seit der UNIX-Epoche) der
Bestätigung (acknowledgement) zu setzen.

**ACKNOWLEDGE\_SVC\_PROBLEM**

`ACKNOWLEDGE_SVC_PROBLEM;`{.code}\<host\_name\>;\<service\_description\>;\<sticky\>;\<notify\>;\<persistent\>;\<author\>;\<comment\>

Erlaubt Ihnen, das aktuelle Problem für den angegebenen Service zu
bestätigen. Durch Bestätigung des aktuellen Problems werden weitere
Benachrichtigungen (für den gleichen Service-Status) deaktiviert.

Wenn die "sticky"-Option auf zwei (2) gesetzt wird, bleibt die
Bestätigung bestehen, bis der Service sich erholt (in einen OK-Status
zurückkehrt). Anderenfalls wird die Bestätigung automatisch entfernt,
wenn sich der Service-Status ändert.

Wenn die "notify"-Option auf eins (1) gesetzt wird, werden die Kontakte
über die Bestätigung informiert, bei Null (0) wird keine
Benachrichtigung versandt.

Wenn die "persistent"-Option auf eins (1) gesetzt wird, bleibt der
Kommentar der Bestätigung auch nach der Erholung des Service bestehen.

**ACKNOWLEDGE\_SVC\_PROBLEM\_EXPIRE**

`ACKNOWLEDGE_SVC_PROBLEM_EXPIRE;`{.code}\<host\_name\>;\<service\_description\>;\<sticky\>;\<notify\>;\<persistent\>;\<timestamp\>;\<author\>;\<comment\>

Erlaubt Ihnen, die Verfallszeit (in Sekunden seit der UNIX-Epoche) der
Bestätigung (acknowledgement) zu setzen.

**ADD\_HOST\_COMMENT**

`ADD_HOST_COMMENT;`{.code}\<host\_name\>;\<persistent\>;\<author\>;\<comment\>

Fügt einen Kommentar zu einem bestimmten Host hinzu. Wenn die
"persistent"-Option auf eins (1) gesetzt wird, wird der Kommentar zu
diesem Host auch über Neustarts des Icinga-Prozesses hinweg aufbewahrt.
Anderenfalls wird der Kommentar beim nächsten Neustart des
Icinga-Prozesses gelöscht.

**ADD\_SVC\_COMMENT**

`ADD_SVC_COMMENT;`{.code}\<host\_name\>;\<service\_description\>;\<persistent\>;\<author\>;\<comment\>

Fügt einen Kommentar zu einem bestimmten Service hinzu. Wenn die
"persistent"-Option auf eins (1) gesetzt wird, wird der Kommentar zu
diesem Service auch über Neustarts des Icinga-Prozesses hinweg
aufbewahrt. Anderenfalls wird der Kommentar beim nächsten Neustart des
Icinga-Prozesses gelöscht.

**CHANGE\_CONTACT\_HOST\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_CONTACT_HOST_NOTIFICATION_TIMEPERIOD;`{.code}\<contact\_name\>;\<notification\_timeperiod\>

Ändert das Host-Benachrichtigungs-Zeitfenster (timeperiod) für einen
bestimmten Host auf das, was durch die "notification\_timeperiod"-Option
angegeben wird. Diese Option gibt den Kurznamen des Zeitfensters an, das
als Host-Benachrichtigungs-Zeitfenster für den Kontakt benutzt werden
soll. Das Zeitfenster muss bereits existieren, also beim letzten
(Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_CONTACT\_MODATTR**

`CHANGE_CONTACT_MODATTR;`{.code}\<contact\_name\>;\<value\>

Dieser Befehl ändert den Wert für "modified attributes" für den
angegebenen Kontakt. "Modified attributes"-Werte werden von Icinga
benutzt, um festzulegen, welche Objekteigenschaften über
Programmneustarts hinweg aufbewahrt werden sollen. Das bedeutet, dass
die Änderung des Wertes die Datenaufbewahrung beeinflussen kann. Dies
ist eine fortgeschrittene Option und sollte nur von Personen benutzt
werden, die fundierte Kenntnisse von der Aufbewahrungslogik in Icinga
besitzen.

**CHANGE\_CONTACT\_MODHATTR**

`CHANGE_CONTACT_MODHATTR;`{.code}\<contact\_name\>;\<value\>

Dieser Befehl ändert den Wert für "modified host attributes" für den
angegebenen Kontakt. "Modified attributes"-Werte werden von Icinga
benutzt, um festzulegen, welche Objekteigenschaften über
Programmneustarts hinweg aufbewahrt werden sollen. Das bedeutet, dass
die Änderung des Wertes die Datenaufbewahrung beeinflussen kann. Dies
ist eine fortgeschrittene Option und sollte nur von Personen benutzt
werden, die fundierte Kenntnisse von der Aufbewahrungslogik in Icinga
besitzen.

**CHANGE\_CONTACT\_MODSATTR**

`CHANGE_CONTACT_MODSATTR;`{.code}\<contact\_name\>;\<value\>

Dieser Befehl ändert den Wert für "modified service attributes" für den
angegebenen Kontakt. "Modified attributes"-Werte werden von Icinga
benutzt, um festzulegen, welche Objekteigenschaften über
Programmneustarts hinweg aufbewahrt werden sollen. Das bedeutet, dass
die Änderung des Wertes die Datenaufbewahrung beeinflussen kann. Dies
ist eine fortgeschrittene Option und sollte nur von Personen benutzt
werden, die fundierte Kenntnisse von der Aufbewahrungslogik in Icinga
besitzen.

**CHANGE\_CONTACT\_SVC\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_CONTACT_SVC_NOTIFICATION_TIMEPERIOD;`{.code}\<contact\_name\>;\<notification\_timeperiod\>

Ändert das Service-Benachrichtigungs-Zeitfenster (timeperiod) für einen
bestimmten Service auf das, was durch die
"notification\_timeperiod"-Option angegeben wird. Diese Option gibt den
Kurznamen des Zeitfensters an, das als
Service-Benachrichtigungs-Zeitfenster für den Kontakt benutzt werden
soll. Das Zeitfenster muss bereits existieren, also beim letzten
(Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_CUSTOM\_CONTACT\_VAR**

`CHANGE_CUSTOM_CONTACT_VAR;`{.code}\<contact\_name\>;\<varname\>;\<varvalue\>

Ändert den Wert einer benutzerdefinierten Kontakt-Variable.

**CHANGE\_CUSTOM\_HOST\_VAR**

`CHANGE_CUSTOM_HOST_VAR;`{.code}\<host\_name\>;\<varname\>;\<varvalue\>

Ändert den Wert einer benutzerdefinierten Host-Variable.

**CHANGE\_CUSTOM\_SVC\_VAR**

`CHANGE_CUSTOM_SVC_VAR;`{.code}\<host\_name\>;\<service\_description\>;\<varname\>;\<varvalue\>

Ändert den Wert einer benutzerdefinierten Service-Variable.

**CHANGE\_GLOBAL\_HOST\_EVENT\_HANDLER**

`CHANGE_GLOBAL_HOST_EVENT_HANDLER;`{.code}\<event\_handler\_command\>

Ändert den globalen Host-Eventhandler-Befehl auf den Befehl, der über
"event\_handler\_command" angegeben wird. Diese Option gibt den
Kurznamen des Befehls an, der als globaler Host-Eventhandler-Befehl
benutzt werden soll. Der Befehl muss bereits existieren, also beim
letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_GLOBAL\_SVC\_EVENT\_HANDLER**

`CHANGE_GLOBAL_SVC_EVENT_HANDLER;`{.code}\<event\_handler\_command\>

Ändert den globalen Service-Eventhandler-Befehl auf den Befehl, der über
"event\_handler\_command" angegeben wird. Diese Option gibt den
Kurznamen des Befehls an, der als globaler Service-Eventhandler-Befehl
benutzt werden soll. Der Befehl muss bereits existieren, also beim
letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_HOST\_CHECK\_COMMAND**

`CHANGE_HOST_CHECK_COMMAND;`{.code}\<host\_name\>;\<check\_command\>

Ändert den Prüfbefehl für einen bestimmten Host auf das, was durch die
"check\_command"-Option angegeben wird. Diese Option gibt den Kurznamen
des Befehls enthalten, der als Prüfbefehl für den Host benutzt werden
soll. Der Befehl muss bereits existieren, also beim letzten (Neu-)Start
des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_HOST\_CHECK\_TIMEPERIOD**

`CHANGE_HOST_CHECK_TIMEPERIOD;`{.code}\<host\_name\>;\<timeperiod\>

Ändert das Host-Prüf-Zeitfenster (timeperiod) für einen bestimmten Host
auf das, was durch die "timeperiod"-Option angegeben wird. Diese Option
gibt den Kurznamen des Zeitfensters an, das als Prüf-Zeitfenster für den
Host benutzt werden soll. Das Zeitfenster muss bereits existieren, also
beim letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_HOST\_EVENT\_HANDLER**

`CHANGE_HOST_EVENT_HANDLER;`{.code}\<host\_name\>;\<event\_handler\_command\>

Ändert den Eventhandler-Befehl für einen bestimmten Host auf den Befehl,
der über "event\_handler\_command" angegeben wird. Diese Option gibt den
Kurznamen des Befehls an, der als neuer Eventhandler-Befehl für diesen
Host benutzt werden soll. Der Befehl muss bereits existieren, also beim
letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_HOST\_MODATTR**

`CHANGE_HOST_MODATTR;`{.code}\<host\_name\>;\<value\>

Dieser Befehl ändert den Wert für "modified attributes" für den
angegebenen Host. "Modified attributes"-Werte werden von Icinga benutzt,
um festzulegen, welche Objekteigenschaften über Programmneustarts hinweg
aufbewahrt werden sollen. Das bedeutet, dass die Änderung des Wertes die
Datenaufbewahrung beeinflussen kann. Dies ist eine fortgeschrittene
Option und sollte nur von Personen benutzt werden, die fundierte
Kenntnisse von der Aufbewahrungslogik in Icinga besitzen

**CHANGE\_HOST\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_HOST_NOTIFICATION_TIMEPERIOD;`{.code}\<host\_name\>;\<notification\_timeperiod\>

Ändert das Host-Benachrichtigungs-Zeitfenster (timeperiod) für einen
bestimmten Host auf das, was durch die "notification\_timeperiod"-Option
angegeben wird. Diese Option gibt den Kurznamen des Zeitfensters an, das
als Benachrichtigungs-Zeitfenster für den Host benutzt werden soll. Das
Zeitfenster muss bereits existieren, also beim letzten (Neu-)Start des
Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_MAX\_HOST\_CHECK\_ATTEMPTS**

`CHANGE_MAX_HOST_CHECK_ATTEMPTS;`{.code}\<host\_name\>;\<check\_attempts\>

Ändert die maximale Anzahl von erneuten Prüf-Versuchen (Wiederholungen)
für einen bestimmten Host.

**CHANGE\_MAX\_SVC\_CHECK\_ATTEMPTS**

`CHANGE_MAX_SVC_CHECK_ATTEMPTS;`{.code}\<host\_name\>;\<service\_description\>;\<check\_attempts\>

Ändert die maximale Anzahl von erneuten Prüf-Versuchen (Wiederholungen)
für einen bestimmten Service.

**CHANGE\_NORMAL\_HOST\_CHECK\_INTERVAL**

`CHANGE_NORMAL_HOST_CHECK_INTERVAL;`{.code}\<host\_name\>;\<check\_interval\>

Ändert das normale Prüfintervall (für regelmäßige Prüfungen) für einen
bestimmten Host.

**CHANGE\_NORMAL\_SVC\_CHECK\_INTERVAL**

`CHANGE_NORMAL_SVC_CHECK_INTERVAL;`{.code}\<host\_name\>;\<service\_description\>;\<check\_interval\>

Ändert das normale Prüfintervall (für regelmäßige Prüfungen) für einen
bestimmten Service

**CHANGE\_RETRY\_HOST\_CHECK\_INTERVAL**

`CHANGE_RETRY_HOST_CHECK_INTERVAL;`{.code}\<host\_name\>;\<check\_interval\>

Ändert das Prüfintervall (für Wiederholungsprüfungen) für einen
bestimmten Host.

**CHANGE\_RETRY\_SVC\_CHECK\_INTERVAL**

`CHANGE_RETRY_SVC_CHECK_INTERVAL;`{.code}\<host\_name\>;\<service\_description\>;\<check\_interval\>

Ändert das Prüfintervall (für Wiederholungsprüfungen) für einen
bestimmten Service.

**CHANGE\_SVC\_CHECK\_COMMAND**

`CHANGE_SVC_CHECK_COMMAND;`{.code}\<host\_name\>;\<service\_description\>;\<check\_command\>

Ändert den Prüfbefehl für einen bestimmten Service auf das, was durch
die "check\_command"-Option angegeben wird. Diese Option gibt den
Kurznamen des Befehls enthalten, der als Prüfbefehl für den Service
benutzt werden soll. Der Befehl muss bereits existieren, also beim
letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen sein.

**CHANGE\_SVC\_CHECK\_TIMEPERIOD**

`CHANGE_SVC_CHECK_TIMEPERIOD;`{.code}\<host\_name\>;\<service\_description\>;\<check\_timeperiod\>

Ändert das Service-Prüf-Zeitfenster (timeperiod) für einen bestimmten
Service auf das, was durch die "timeperiod"-Option angegeben wird. Diese
Option gibt den Kurznamen des Zeitfensters an, das als Prüf-Zeitfenster
für den Service benutzt werden soll. Das Zeitfenster muss bereits
existieren, also beim letzten (Neu-)Start des Icinga-Prozesses
konfiguriert gewesen sein.

**CHANGE\_SVC\_EVENT\_HANDLER**

`CHANGE_SVC_EVENT_HANDLER;`{.code}\<host\_name\>;\<service\_description\>;\<event\_handler\_command\>

Ändert den Eventhandler-Befehl für einen bestimmten Service auf den
Befehl, der über "event\_handler\_command" angegeben wird. Diese Option
gibt den Kurznamen des Befehls an, der als neuer Eventhandler-Befehl für
diesen Service benutzt werden soll. Der Befehl muss bereits existieren,
also beim letzten (Neu-)Start des Icinga-Prozesses konfiguriert gewesen
sein.

**CHANGE\_SVC\_MODATTR**

`CHANGE_SVC_MODATTR;`{.code}\<host\_name\>;\<service\_description\>;\<value\>

Dieser Befehl ändert den Wert für "modified attributes" für den
angegebenen Service. "Modified attributes"-Werte werden von Icinga
benutzt, um festzulegen, welche Objekteigenschaften über
Programmneustarts hinweg aufbewahrt werden sollen. Das bedeutet, dass
die Änderung des Wertes die Datenaufbewahrung beeinflussen kann. Dies
ist eine fortgeschrittene Option und sollte nur von Personen benutzt
werden, die fundierte Kenntnisse von der Aufbewahrungslogik in Icinga
besitzen.

**CHANGE\_SVC\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_SVC_NOTIFICATION_TIMEPERIOD;`{.code}\<host\_name\>;\<service\_description\>;\<notification\_timeperiod\>

Ändert das Service-Benachrichtigungs-Zeitfenster (timeperiod) für einen
bestimmten Host auf das, was durch die "notification\_timeperiod"-Option
angegeben wird. Diese Option gibt den Kurznamen des Zeitfensters an, das
als Benachrichtigungs-Zeitfenster für den Host benutzt werden soll. Das
Zeitfenster muss bereits existieren, also beim letzten (Neu-)Start des
Icinga-Prozesses konfiguriert gewesen sein.

**DEL\_ALL\_HOST\_COMMENTS**

`DEL_ALL_HOST_COMMENTS;`{.code}\<host\_name\>

Löscht alle Kommentare, die mit einem bestimmten Host verbunden sind.

**DEL\_ALL\_SVC\_COMMENTS**

`DEL_ALL_SVC_COMMENTS;`{.code}\<host\_name\>;\<service\_description\>

Löscht alle Kommentare, die mit einem bestimmten Service verbunden sind.

**DEL\_HOST\_COMMENT**

`DEL_HOST_COMMENT;`{.code}\<comment\_id\>

Löscht einen Host-Kommentar. Die ID-Nummer des zu löschenden Kommentars
muss angegeben werden.

**DEL\_DOWNTIME\_BY\_HOST\_NAME**

`DEL_DOWNTIME_BY_HOST_NAME;`{.code}\<host\_name\>[;\<servicedesc\>[;\<starttime\>[;\<commentstring\>]]]

Löscht die Ausfallzeiten des Hosts, der über "host\_name" angegeben
wurde, sowie dessen verbundene Services. Bitte beachten Sie, dass Sie
den Bereich mit optionalen "Filtern" weiter einschränken können.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Änderungen stammen vom [Opsview](http://www.opsview.com/)-Team.

**DEL\_DOWNTIME\_BY\_HOSTGROUP\_NAME**

`DEL_DOWNTIME_BY_HOSTGROUP_NAME;`{.code}\<hostgroup\_name\>[host\_name\>[;\<servicedesc\>[;\<starttime\>[;\<commentstring\>]]]]

Löscht die Ausfallzeiten aller Hosts der Hostgruppe, die über
"hostgroup\_name" angegeben wurde, sowie deren verbundene Services.
Bitte beachten Sie, dass Sie den Bereich mit optionalen "Filtern" weiter
einschränken können.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Änderungen stammen vom [Opsview](http://www.opsview.com/)-Team.

**DEL\_DOWNTIME\_BY\_START\_TIME\_COMMENT**

`DEL_DOWNTIME_BY_START_TIME_COMMENT;`{.code}\<start
time[;commentstring]\>

Löscht die Ausfallzeiten mit Startzeiten, die dem Zeitstempel
entsprechen, der über "start time" angegeben wurde. Optional wird
zusätzlich auch der Kommentar überprüft.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Änderungen stammen vom [Opsview](http://www.opsview.com/)-Team.

**DEL\_HOST\_DOWNTIME**

`DEL_HOST_DOWNTIME;`{.code}\<downtime\_id\>

Löscht den Host-Ausfallzeit-Eintrag mit der durch "downtime\_id"
angegebenen Nummer. Falls die Ausfallzeit gerade aktiv ist, wird die
Ausfallzeit des Hosts damit beendet (solange es keine weiteren aktiven
überlappenden Ausfallzeiteinträge für diesen Host gibt).

**DEL\_SVC\_COMMENT**

`DEL_SVC_COMMENT;`{.code}\<comment\_id\>

Löscht einen Service-Kommentar. Die ID-Nummer des zu löschenden
Kommentars muss angegeben werden.

**DEL\_SVC\_DOWNTIME**

`DEL_SVC_DOWNTIME;`{.code}\<downtime\_id\>

Löscht den Service-Ausfallzeit-Eintrag mit der durch "downtime\_id"
angegebenen Nummer. Falls die Ausfallzeit gerade aktiv ist, wird die
Ausfallzeit des Service damit beendet (solange es keine weiteren aktiven
überlappenden Ausfallzeiteinträge für diesen Service gibt).

**DELAY\_HOST\_NOTIFICATION**

`DELAY_HOST_NOTIFICATION;`{.code}\<host\_name\>;\<notification\_time\>

Verzögert die nächste Benachrichtigung für einen bestimmten Host bis zur
Erreichung des Wertes, der durch "notification\_time" angegeben wird.
Der "notification\_time"-Parameter wird im time\_t-Format angegeben
(Sekunden seit der UNIX-Epoche). Beachten Sie, dass dies nur dann
zutrifft, wenn der Host im gleichen Problemzustand wie momentan bleibt.
Wenn der Host-Zustand in einen anderen Status wechselt, wird ggf. eine
neue Benachrichtigung versandt, bevor die Zeit erreicht ist, die Sie als
"notification\_time"-Argument angegeben haben.

**DELAY\_SVC\_NOTIFICATION**

`DELAY_SVC_NOTIFICATION;`{.code}\<host\_name\>;\<service\_description\>;\<notification\_time\>

Verzögert die nächste Benachrichtigung für einen bestimmten Service bis
zur Erreichung des Wertes, der durch "notification\_time" angegeben
wird. Der "notification\_time"-Parameter wird im time\_t-Format
angegeben (Sekunden seit der UNIX-Epoche). Beachten Sie, dass dies nur
dann zutrifft, wenn der Service im gleichen Problemzustand wie momentan
bleibt. Wenn der Service-Zustand in einen anderen Status wechselt, wird
ggf. eine neue Benachrichtigung versandt, bevor die Zeit erreicht ist,
die Sie als "notification\_time"-Argument angegeben haben.

**DISABLE\_ALL\_NOTIFICATIONS\_BEYOND\_HOST**

`DISABLE_ALL_NOTIFICATIONS_BEYOND_HOST;`{.code}\<host\_name\>

Deaktiviert die Benachrichtigungen für alle Host und Services "jenseits"
(d.h. auf alles "Child-"Hosts) des angegebenen Hosts. Die aktuelle
Benachrichtigungseinstellung auf dem angegebenen Host ist davon nicht
betroffen.

**DISABLE\_CONTACT\_HOST\_NOTIFICATIONS**

`DISABLE_CONTACT_HOST_NOTIFICATIONS;`{.code}\<contact\_name\>

Deaktiviert Host-Benachrichtigungen für einen bestimmten Kontakt.

**DISABLE\_CONTACT\_SVC\_NOTIFICATIONS**

`DISABLE_CONTACT_SVC_NOTIFICATIONS;`{.code}\<contact\_name\>

Deaktiviert Service-Benachrichtigungen für einen bestimmten Kontakt.

**DISABLE\_CONTACTGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_CONTACTGROUP_HOST_NOTIFICATIONS;`{.code}\<contactgroup\_name\>

Deaktiviert Host-Benachrichtigungen für alle Kontakte einer bestimmten
Kontaktgruppe.

**DISABLE\_CONTACTGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_CONTACTGROUP_SVC_NOTIFICATIONS;`{.code}\<contactgroup\_name\>

Deaktiviert Service-Benachrichtigungen für alle Kontakte einer
bestimmten Kontaktgruppe.

**DISABLE\_EVENT\_HANDLERS**

`DISABLE_EVENT_HANDLERS`{.code}

Deaktiviert Host- und Service-Eventhandler auf programmweiter Ebene.

**DISABLE\_FAILURE\_PREDICTION**

`DISABLE_FAILURE_PREDICTION`{.code}

Deaktiviert Fehlervorhersage auf programmweiter Ebene.

**DISABLE\_FLAP\_DETECTION**

`DISABLE_FLAP_DETECTION`{.code}

Deaktiviert Host- und Service-Flattererkennung auf programmweiter Ebene.

**DISABLE\_HOST\_AND\_CHILD\_NOTIFICATIONS**

`DISABLE_HOST_AND_CHILD_NOTIFICATIONS;`{.code}\<host\_name\>

Deaktiviert Benachrichtigungen für den angegebenen Host sowie die
"Child"-Hosts des angegebenen Hosts.

**DISABLE\_HOST\_CHECK**

`DISABLE_HOST_CHECK;`{.code}\<host\_name\>

Deaktiviert (regelmäßig geplante) aktive Prüfungen des angegebenen
Hosts. "On-demand"-Prüfungen finden weiterhin statt (?).

**DISABLE\_HOST\_EVENT\_HANDLER**

`DISABLE_HOST_EVENT_HANDLER;`{.code}\<host\_name\>

Deaktiviert den Eventhandler für den angegebenen Host.

**DISABLE\_HOST\_FLAP\_DETECTION**

`DISABLE_HOST_FLAP_DETECTION;`{.code}\<host\_name\>

Deaktiviert die Flattererkennung für den angegebenen Host.

**DISABLE\_HOST\_FRESHNESS\_CHECKS**

`DISABLE_HOST_FRESHNESS_CHECKS`{.code}

Deaktiviert Frische-Prüfungen für alle Hosts auf programmweiter Ebene.

**DISABLE\_HOST\_NOTIFICATIONS**

`DISABLE_HOST_NOTIFICATIONS;`{.code}\<host\_name\>

Deaktiviert Benachrichtigungen für den angegebenen Host.

**DISABLE\_HOST\_SVC\_CHECKS**

`DISABLE_HOST_SVC_CHECKS;`{.code}\<host\_name\>

Deaktiviert aktive Prüfungen für alle Services des angegebenen Hosts.

**DISABLE\_HOST\_SVC\_NOTIFICATIONS**

`DISABLE_HOST_SVC_NOTIFICATIONS;`{.code}\<host\_name\>

Deaktiviert Benachrichtigungen für alle Services des angegebenen Hosts.

**DISABLE\_HOSTGROUP\_HOST\_CHECKS**

`DISABLE_HOSTGROUP_HOST_CHECKS;`{.code}\<hostgroup\_name\>

Deaktiviert aktive Prüfungen für alle Hosts der angegebenen Hostgruppe.

**DISABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_HOSTGROUP_HOST_NOTIFICATIONS;`{.code}\<hostgroup\_name\>

Deaktiviert Benachrichtigungen für alle Hosts der angegebenen
Hostgruppe. Dies deaktiviert NICHT die Benachrichtigungen für die
Services der betroffenen Hosts - siehe
DISABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS.

**DISABLE\_HOSTGROUP\_PASSIVE\_HOST\_CHECKS**

`DISABLE_HOSTGROUP_PASSIVE_HOST_CHECKS;`{.code}\<hostgroup\_name\>

Deaktiviert passive Prüfungen für alle Hosts der angegebenen Hostgruppe.

**DISABLE\_HOSTGROUP\_PASSIVE\_SVC\_CHECKS**

`DISABLE_HOSTGROUP_PASSIVE_SVC_CHECKS;`{.code}\<hostgroup\_name\>

Deaktiviert passive Prüfungen für alle Services, die mit den Hosts der
angegebenen Hostgruppe verbunden sind.

**DISABLE\_HOSTGROUP\_SVC\_CHECKS**

`DISABLE_HOSTGROUP_SVC_CHECKS;`{.code}\<hostgroup\_name\>

Deaktiviert aktive Prüfungen für alle Services, die mit den Hosts der
angegebenen Hostgruppe verbunden sind.

**DISABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_HOSTGROUP_SVC_NOTIFICATIONS;`{.code}\<hostgroup\_name\>

Deaktiviert Benachrichtigungen für alle Services, die mit den Hosts der
angegebenen Hostgruppe verbunden sind. Dies deaktiviert NICHT die
Benachrichtigungen für die Hosts der angegebenen Hostgruppe - siehe
DISABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS.

**DISABLE\_NOTIFICATIONS**

`DISABLE_NOTIFICATIONS`{.code}

Deaktiviert Host- und Service-Benachrichtigungen auf programmweiter
Ebene.

**DISABLE\_NOTIFICATIONS\_EXPIRE\_TIME**

`DISABLE_NOTIFICATIONS_EXPIRE_TIME;<schedule_time>;<expire_time>`{.code}

Die \<schedule\_time\> hat derzeit noch keine Funktion, setzen Sie sie
auf die aktuelle Zeit.

Deaktiviert Host- und Service-Benachrichtigungen auf programmweiter
Ebene bis zur angegbenen Verfallszeit.

**DISABLE\_PASSIVE\_HOST\_CHECKS**

`DISABLE_PASSIVE_HOST_CHECKS;`{.code}\<host\_name\>

Deaktiviert Annahme und Verarbeitung von passiven Host-Prüfungen für den
angegebenen Host.

**DISABLE\_PASSIVE\_SVC\_CHECKS**

`DISABLE_PASSIVE_SVC_CHECKS;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert Annahme und Verarbeitung von passiven Service-Prüfungen für
den angegebenen Service.

**DISABLE\_PERFORMANCE\_DATA**

`DISABLE_PERFORMANCE_DATA`{.code}

Deaktiviert die Verarbeitung von Host- und Service-Performance-Daten auf
programmweiter Ebene.

**DISABLE\_SERVICE\_FRESHNESS\_CHECKS**

`DISABLE_SERVICE_FRESHNESS_CHECKS`{.code}

Deaktiviert Frische-Prüfungen auf programmweiter Ebene.

**DISABLE\_SERVICEGROUP\_HOST\_CHECKS**

`DISABLE_SERVICEGROUP_HOST_CHECKS;`{.code}\<servicegroup\_name\>

Deaktiviert aktive Prüfungen für alle Hosts, die mit Services aus der
angegebenen Servicegruppe verbunden sind.

**DISABLE\_SERVICEGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_SERVICEGROUP_HOST_NOTIFICATIONS;`{.code}\<servicegroup\_name\>

Deaktiviert Benachrichtigungen für alle Hosts, die mit Services aus der
angegebenen Servicegruppe verbunden sind.

**DISABLE\_SERVICEGROUP\_PASSIVE\_HOST\_CHECKS**

`DISABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS;`{.code}\<servicegroup\_name\>

Deaktiviert Annahme und Verarbeitung von passiven Prüfungen für alle
Hosts, die mit Services aus der angegebenen Servicegruppe verbunden
sind.

**DISABLE\_SERVICEGROUP\_PASSIVE\_SVC\_CHECKS**

`DISABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS;`{.code}\<servicegroup\_name\>

Deaktiviert Annahme und Verarbeitung von passiven Prüfungen für alle
Services aus der angegebenen Servicegruppe.

**DISABLE\_SERVICEGROUP\_SVC\_CHECKS**

`DISABLE_SERVICEGROUP_SVC_CHECKS;`{.code}\<servicegroup\_name\>

Deaktiviert aktive Prüfungen für alle Services aus der angegebenen
Servicegruppe.

**DISABLE\_SERVICEGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_SERVICEGROUP_SVC_NOTIFICATIONS;`{.code}\<servicegroup\_name\>

Deaktiviert Benachrichtigungen für alle Services aus der angegebenen
Servicegruppe.

**DISABLE\_SVC\_CHECK**

`DISABLE_SVC_CHECK;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert aktive Prüfungen für den angegebenen Service.

**DISABLE\_SVC\_EVENT\_HANDLER**

`DISABLE_SVC_EVENT_HANDLER;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert den Eventhandler für den angegebenen Service.

**DISABLE\_SVC\_FLAP\_DETECTION**

`DISABLE_SVC_FLAP_DETECTION;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert die Flattererkennung für den angegebenen Service.

**DISABLE\_SVC\_NOTIFICATIONS**

`DISABLE_SVC_NOTIFICATIONS;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert Benachrichtigungen für den angegebenen Service.

**ENABLE\_ALL\_NOTIFICATIONS\_BEYOND\_HOST**

`ENABLE_ALL_NOTIFICATIONS_BEYOND_HOST;`{.code}\<host\_name\>

Aktiviert die Benachrichtigungen für alle Host und Services "jenseits"
(d.h. auf alles "Child-"Hosts) des angegebenen Hosts. Die aktuelle
Benachrichtigungseinstellung auf dem angegebenen Host ist davon nicht
betroffen. Benachrichtigungen für diese Hosts und Services werden nur
versandt, wenn Benachrichtigungen auch auf programmweiter Ebene
aktiviert sind.

**ENABLE\_CONTACT\_HOST\_NOTIFICATIONS**

`ENABLE_CONTACT_HOST_NOTIFICATIONS;`{.code}\<contact\_name\>

Aktiviert Host-Benachrichtigungen für einen bestimmten Kontakt..

**ENABLE\_CONTACT\_SVC\_NOTIFICATIONS**

`ENABLE_CONTACT_SVC_NOTIFICATIONS;`{.code}\<contact\_name\>

Aktiviert Service-Benachrichtigungen für einen bestimmten Kontakt.

**ENABLE\_CONTACTGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_CONTACTGROUP_HOST_NOTIFICATIONS;`{.code}\<contactgroup\_name\>

Aktiviert Host-Benachrichtigungen für alle Kontakte der angegebenen
Kontaktgruppe.

**ENABLE\_CONTACTGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_CONTACTGROUP_SVC_NOTIFICATIONS;`{.code}\<contactgroup\_name\>

Aktiviert Service-Benachrichtigungen für alle Kontakte der angegebenen
Kontaktgruppe.

**ENABLE\_EVENT\_HANDLERS**

`ENABLE_EVENT_HANDLERS`{.code}

Aktiviert Host- und Service-Eventhandler auf programmweiter Ebene.

**ENABLE\_FAILURE\_PREDICTION**

`ENABLE_FAILURE_PREDICTION`{.code}

Aktiviert Fehlervorhersage auf programmweiter Ebene.

**ENABLE\_FLAP\_DETECTION**

`ENABLE_FLAP_DETECTION`{.code}

Aktiviert Host- und Service-Flattererkennung auf programmweiter Ebene.

**ENABLE\_HOST\_AND\_CHILD\_NOTIFICATIONS**

`ENABLE_HOST_AND_CHILD_NOTIFICATIONS;`{.code}\<host\_name\>

Aktiviert Benachrichtigungen für den angegebenen Host sowie die
"Child"-Hosts des angegebenen Hosts. Benachrichtigungen für diese Hosts
werden nur versandt, wenn Benachrichtigungen auch auf programmweiter
Ebene aktiviert sind.

**ENABLE\_HOST\_CHECK**

`ENABLE_HOST_CHECK;`{.code}\<host\_name\>

Aktiviert (regelmäßig geplante) aktive Prüfungen des angegebenen Hosts.

**ENABLE\_HOST\_EVENT\_HANDLER**

`ENABLE_HOST_EVENT_HANDLER;`{.code}\<host\_name\>

Aktiviert den Eventhandler für den angegebenen Host.

**ENABLE\_HOST\_FLAP\_DETECTION**

`ENABLE_HOST_FLAP_DETECTION;`{.code}\<host\_name\>

Aktiviert die Flattererkennung für den angegebenen Host. Die
Flattererkennung muss auch auf programmweiter Ebene aktiviert sind.

**ENABLE\_HOST\_FRESHNESS\_CHECKS**

`ENABLE_HOST_FRESHNESS_CHECKS`{.code}

Aktiviert Frische-Prüfungen für alle Hosts auf programmweiter Ebene.
Einzelne Hosts, bei denen die Frische-Prüfung deaktivert ist, sind davon
nicht betroffen. Sie werden weiterhin nicht auf Frische geprüft.

**ENABLE\_HOST\_NOTIFICATIONS**

`ENABLE_HOST_NOTIFICATIONS;`{.code}\<host\_name\>

Aktiviert Benachrichtigungen für den angegebenen Host.
Benachrichtigungen für diesen Host werden nur versandt, wenn
Benachrichtigungen auch auf programmweiter Ebene aktiviert sind.

**ENABLE\_HOST\_SVC\_CHECKS**

`ENABLE_HOST_SVC_CHECKS;`{.code}\<host\_name\>

Aktiviert aktive Prüfungen für alles Services des angegebenen Hosts.

**ENABLE\_HOST\_SVC\_NOTIFICATIONS**

`ENABLE_HOST_SVC_NOTIFICATIONS;`{.code}\<host\_name\>

Aktiviert Benachrichtigungen für alle Services des angegebenen Hosts.
Benachrichtigungen werden nur versandt, wenn Benachrichtigungen auch auf
programmweiter Ebene aktiviert sind.

**ENABLE\_HOSTGROUP\_HOST\_CHECKS**

`ENABLE_HOSTGROUP_HOST_CHECKS;`{.code}\<hostgroup\_name\>

Aktiviert aktive Prüfungen für alle Host der angegebenen Hostgruppe.

**ENABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_HOSTGROUP_HOST_NOTIFICATIONS;`{.code}\<hostgroup\_name\>

Aktiviert Benachrichtigungen für alle Hosts der angegebenen Hostgruppe.
Dies aktiviert nicht die Benachrichtigungen für die Services, die mit
den Hosts der angegebenen Hostgruppe verbunden sind. - siehe
ENABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS. Benachrichtigungen für diese
Hosts werden nur versandt, wenn Benachrichtigungen auch auf
programmweiter Ebene aktiviert sind.

**ENABLE\_HOSTGROUP\_PASSIVE\_HOST\_CHECKS**

`ENABLE_HOSTGROUP_PASSIVE_HOST_CHECKS;`{.code}\<hostgroup\_name\>

Aktiviert passive Prüfungen für alle Hosts der angegebenen Hostgruppe.

**ENABLE\_HOSTGROUP\_PASSIVE\_SVC\_CHECKS**

`ENABLE_HOSTGROUP_PASSIVE_SVC_CHECKS;`{.code}\<hostgroup\_name\>

Aktiviert passive Prüfungen für alle Host der angegebenen Hostgruppe.

**ENABLE\_HOSTGROUP\_SVC\_CHECKS**

`ENABLE_HOSTGROUP_SVC_CHECKS;`{.code}\<hostgroup\_name\>

Aktiviert aktive Prüfungen für alle Services, die mit den Hosts der
angegebenen Hostgruppe verbunden sind.

**ENABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_HOSTGROUP_SVC_NOTIFICATIONS;`{.code}\<hostgroup\_name\>

Aktiviert Benachrichtigungen für alle Services, die mit den Hosts der
angebenen Hostgruppe verbunden sind. Dies aktiviert nicht die
Benachrichtigungen für die Hosts der angegebenen Hostgruppe. - siehe
ENABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS. Benachrichtigungen für diese
Services werden nur versandt, wenn Benachrichtigungen auch auf
programmweiter Ebene aktiviert sind

**ENABLE\_NOTIFICATIONS**

`ENABLE_NOTIFICATIONS`{.code}

Aktiviert Host- und Service-Benachrichtigungen auf programmweiter Ebene.

**ENABLE\_PASSIVE\_HOST\_CHECKS**

`ENABLE_PASSIVE_HOST_CHECKS;`{.code}\<host\_name\>

Aktiviert Annahme und Verarbeitung von passiven Host-Prüfungen für den
angegebenen Hosts.

**ENABLE\_PASSIVE\_SVC\_CHECKS**

`ENABLE_PASSIVE_SVC_CHECKS;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert passive Prüfungen für den angegebenen Service.

**ENABLE\_PERFORMANCE\_DATA**

`ENABLE_PERFORMANCE_DATA`{.code}

Aktiviert die Verarbeitung von Host- und Service-Performance-Daten auf
programmweiter Ebene.

**ENABLE\_SERVICE\_FRESHNESS\_CHECKS**

`ENABLE_SERVICE_FRESHNESS_CHECKS`{.code}

Aktiviert Frische-Prüfungen für alle Services auf programmweiter Ebene.
Einzelne Services, bei denen die Frische-Prüfung deaktivert ist, sind
davon nicht betroffen. Sie werden weiterhin nicht auf Frische geprüft.

**ENABLE\_SERVICEGROUP\_HOST\_CHECKS**

`ENABLE_SERVICEGROUP_HOST_CHECKS;`{.code}\<servicegroup\_name\>

Aktiviert aktive Prüfungen für alle Hosts, die mit Services aus der
angegebenen Servicegruppe verbunden sind.

**ENABLE\_SERVICEGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_SERVICEGROUP_HOST_NOTIFICATIONS;`{.code}\<servicegroup\_name\>

Aktiviert Benachrichtigungen für alle Hosts, die mit Services aus der
angegebenen Servicegruppe verbunden sind. Benachrichtigungen für diese
Hosts werden nur versandt, wenn Benachrichtigungen auch auf
programmweiter Ebene aktiviert sind.

**ENABLE\_SERVICEGROUP\_PASSIVE\_HOST\_CHECKS**

`ENABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS;`{.code}\<servicegroup\_name\>

Aktiviert Annahme und Verarbeitung von passiven Prüfungen für alle
Hosts, die mit Services aus der angegebenen Servicegruppe verbunden
sind.

**ENABLE\_SERVICEGROUP\_PASSIVE\_SVC\_CHECKS**

`ENABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS;`{.code}\<servicegroup\_name\>

Aktiviert Annahme und Verarbeitung von passiven Prüfungen für alle
Services aus der angegebenen Servicegruppe.

**ENABLE\_SERVICEGROUP\_SVC\_CHECKS**

`ENABLE_SERVICEGROUP_SVC_CHECKS;`{.code}\<servicegroup\_name\>

Aktiviert aktive Prüfungen für alle Services aus der angegebenen
Servicegruppe.

**ENABLE\_SERVICEGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_SERVICEGROUP_SVC_NOTIFICATIONS;`{.code}\<servicegroup\_name\>

Aktiviert Benachrichtigungen für alle Services aus der angegebenen
Servicegruppe. Benachrichtigungen für diese Service werden nur versandt,
wenn Benachrichtigungen auch auf programmweiter Ebene aktiviert sind.

**ENABLE\_SVC\_CHECK**

`ENABLE_SVC_CHECK;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert aktive Prüfungen für den angegebenen Service.

**ENABLE\_SVC\_EVENT\_HANDLER**

`ENABLE_SVC_EVENT_HANDLER;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert den Eventhandler für den angegebenen Service.

**ENABLE\_SVC\_FLAP\_DETECTION**

`ENABLE_SVC_FLAP_DETECTION;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert die Flattererkennung für den angegebenen Service. Die
Flattererkennung muss auch auf programmweiter Ebene aktiviert sind.

**ENABLE\_SVC\_NOTIFICATIONS**

`ENABLE_SVC_NOTIFICATIONS;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert Benachrichtigungen für den angegebenen Service.
Benachrichtigungen für diesen Service werden nur versandt, wenn
Benachrichtigungen auch auf programmweiter Ebene aktiviert sind.

**PROCESS\_FILE**

`PROCESS_FILE;`{.code}\<file\_name\>;\<delete\>

Weist Icinga an, alle externen Befehle zu verarbeiten, die in der Datei
zu finden sind, die mit dem \<file\_name\>-Argument angegeben wird.
Falls die \<delete\>-Option nicht-Null ist, wird die Datei nach der
Verarbeitung gelöscht. Falls die \<delete\>-Option Null (0) ist, bleibt
die Datei erhalten.

**PROCESS\_HOST\_CHECK\_RESULT**

`PROCESS_HOST_CHECK_RESULT;`{.code}\<host\_name\>;\<status\_code\>;\<plugin\_output\>

Dies wird benutzt, um ein passives Prüfergebnis für einen bestimmten
Host einzuliefern. Der "status\_code" gibt den Status der Host-Prüfung
an und sollte einen der folgenden Werte haben: 0=UP, 1=DOWN,
2=UNREACHABLE. Das "plugin\_output"-Argument enthält den Text der
Host-Prüfung, zusammen mit optionalen Performance-Daten.

**PROCESS\_SERVICE\_CHECK\_RESULT**

`PROCESS_SERVICE_CHECK_RESULT;`{.code}\<host\_name\>;\<service\_description\>;\<return\_code\>;\<plugin\_output\>

Dies wird benutzt, um ein passives Prüfergebnis für einen bestimmten
Service einzuliefern. Der "status\_code" gibt den Status der
Service-Prüfung an und sollte einen der folgenden Werte haben: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN. Das "plugin\_output"-Argument enthält
den Text der Service-Prüfungen, zusammen mit optionalen
Performance-Daten.

**READ\_STATE\_INFORMATION**

`READ_STATE_INFORMATION`{.code}

Bewirkt, dass Icinga alle aktuellen Überwachungs-Statusinformationen aus
der Statusaufbewahrungsdatei (state retention file) liest. Normalerweise
werden diese Informationen beim Start des Icinga-Prozesses vor dem Start
der eigentlichen Überwachung geladen. Dieser Befehl bewirkt, dass Icinga
die aktuellen Überwachungs-Statusinformationen verwirft und stattdessen
die Informatonen aus der Statusaufbewahrungsdatei liest. *Vorsicht!*

**REMOVE\_HOST\_ACKNOWLEDGEMENT**

`REMOVE_HOST_ACKNOWLEDGEMENT;`{.code}\<host\_name\>

Dies entfernt die Problem-Bestätigung für den angegebenen Host. Sobald
die Bestätigung entfernt ist, können wieder Benachrichtigungen für den
Host versandt werden.

**REMOVE\_SVC\_ACKNOWLEDGEMENT**

`REMOVE_SVC_ACKNOWLEDGEMENT;`{.code}\<host\_name\>;\<service\_description\>

Dies entfernt die Problem-Bestätigung für den angegebenen Service.
Sobald die Bestätigung entfernt ist, können wieder Benachrichtigungen
für den Service versandt werden.

**RESTART\_PROCESS**

`RESTART_PROCESS`{.code}

Veranlasst einen Restart des Icinga-Prozesses.

**SAVE\_STATE\_INFORMATION**

`SAVE_STATE_INFORMATION`{.code}

Bewirkt, dass Icinga alle aktuellen Überwachungs-Statusinformationen in
die Statusaufbewahrungsdatei (state retention file) schreibt.
Normalerweise werden diese Informationen vor Beendigung des
Icinga-Prozesses (und möglicherweise in bestimmten regelmäßig geplanten
Intervallen) geschrieben. Dieser Befehl erlaubt Ihnen, dass Icinga diese
Informationen sofort in die Datei schreibt. Dies beeinflusst nicht die
aktuellen Statusinformationen des Icinga-Prozesses.

**SCHEDULE\_AND\_PROPAGATE\_HOST\_DOWNTIME**

`SCHEDULE_AND_PROPAGATE_HOST_DOWNTIME;`{.code}\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für den angegebenen Host und seine
"Kinder"(-Hosts). Wenn das "fixed"-Argument auf eins (1) gesetzt ist,
wird die Ausfallzeit zu den durch die "start"- und "end"-Argumente
angegebenen Zeiten starten bzw. enden. Andernfalls wird die Ausfallzeit
zwischen den Start- und Endzeiten beginnen und die Anzahl von Sekunden
dauern, die durch das "duration"-Argument angegeben wird. Die "start"-
und "end"-Argumente werden im time\_t-Format (Sekunden seit der
UNIX-Epoche) angegeben. Die Ausfallzeit des angegebenen (Eltern-) Hosts
kann durch einen anderen Ausfallzeiteintrag ausgelöst werden, wenn die
"trigger\_id" den Wert der ID eines anderen Ausfallzeiteintrag hat.
Setzen Sie den Wert von "trigger\_id" auf Null (0), wenn die Ausfallzeit
des angegebenen (Eltern-) Hosts nicht von einem anderen
Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_AND\_PROPAGATE\_TRIGGERED\_HOST\_DOWNTIME**

`SCHEDULE_AND_PROPAGATE_TRIGGERED_HOST_DOWNTIME;`{.code}\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für den angegebenen Host und seine
"Kinder"(-Hosts). Wenn das "fixed"-Argument auf eins (1) gesetzt ist,
wird die Ausfallzeit zu den durch die "start"- und "end"-Argumente
angegebenen Zeiten starten bzw. enden. Andernfalls wird die Ausfallzeit
zwischen den Start- und Endzeiten beginnen und die Anzahl von Sekunden
dauern, die durch das "duration"-Argument angegeben wird. Die "start"-
und "end"-Argumente werden im time\_t-Format (Sekunden seit der
UNIX-Epoche) angegeben. Die Ausfallzeit der "Kinder"-Hosts wird durch
die Ausfallzeit des "Eltern"-Hosts ausgelöst. Die Ausfallzeit des
angegebenen (Eltern-) Hosts kann durch einen anderen Ausfallzeiteintrag
ausgelöst werden, wenn die "trigger\_id" den Wert der ID eines anderen
Ausfallzeiteintrag hat. Setzen Sie den Wert von "trigger\_id" auf Null
(0), wenn die Ausfallzeit des angegebenen (Eltern-) Hosts nicht von
einem anderen Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_FORCED\_HOST\_CHECK**

`SCHEDULE_FORCED_HOST_CHECK;`{.code}\<host\_name\>;\<check\_time\>

Plant eine erzwungene aktive Prüfung des angegebenen Hosts zur
"check\_time". Das "check\_time"-Argument gibt dem Wert im
time\_t-Format (Sekunden seit der UNIX-Epoche) an. Erzwungene Prüfungen
in jedem Fall ausgeführt, also unabhängig von der Zeit (z.B. werden
Zeitfenster-Einschränkungen ignoriert) und davon, ob aktive Prüfungen
für bestimmte Hosts oder auf programmweiter Ebene aktiviert sind oder
nicht.

**SCHEDULE\_FORCED\_HOST\_SVC\_CHECKS**

`SCHEDULE_FORCED_HOST_SVC_CHECKS;`{.code}\<host\_name\>;\<check\_time\>

Plant eine erzwungene aktive Prüfung von allen Services des angegebenen
Hosts zur "check\_time". Das "check\_time"-Argument gibt dem Wert im
time\_t-Format (Sekunden seit der UNIX-Epoche) an. Erzwungene Prüfungen
in jedem Fall ausgeführt, also unabhängig von der Zeit (z.B. werden
Zeitfenster-Einschränkungen ignoriert) und davon, ob aktive Prüfungen
für bestimmte Hosts oder auf programmweiter Ebene aktiviert sind oder
nicht.

**SCHEDULE\_FORCED\_SVC\_CHECK**

`SCHEDULE_FORCED_SVC_CHECK;`{.code}\<host\_name\>;\<service\_description\>;\<check\_time\>

Plant eine erzwungene aktive Prüfung eines bestimmten Service des
angegebenen Hosts zur "check\_time". Das "check\_time"-Argument gibt dem
Wert im time\_t-Format (Sekunden seit der UNIX-Epoche) an. Erzwungene
Prüfungen in jedem Fall ausgeführt, also unabhängig von der Zeit (z.B.
werden Zeitfenster-Einschränkungen ignoriert) und davon, ob aktive
Prüfungen für bestimmte Hosts oder auf programmweiter Ebene aktiviert
sind oder nicht.

**SCHEDULE\_HOST\_CHECK**

`SCHEDULE_HOST_CHECK;`{.code}\<host\_name\>;\<check\_time\>

Plant die nächste aktive Prüfung des angegebenen Hosts zur
"check\_time". Das "check\_time"-Argument gibt dem Wert im
time\_t-Format (Sekunden seit der UNIX-Epoche) an. Beachten Sie, dass
der Host ggf. nicht zu der Zeit geprüft wird, die Sie angegeben haben.
Das kann eine Reihe von Gründen haben: Aktive Prüfungen sind auf Host-
oder programmweiter Ebene deaktiviert, die Host-Prüfung ist bereits für
einen früheren Zeitpunkt geplant, usw. Wenn Sie die Host-Prüfung
erzwingen wollen, dann schauen Sie beim
SCHEDULE\_FORCED\_HOST\_CHECK-Befehl.

**SCHEDULE\_HOST\_DOWNTIME**

`SCHEDULE_HOST_DOWNTIME;`{.code}\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für den angegebenen Host. Wenn das
"fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit zu den
durch die "start"- und "end"-Argumente angegebenen Zeiten starten bzw.
enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit des angegebenen Hosts kann durch einen anderen
Ausfallzeiteintrag ausgelöst werden, wenn die "trigger\_id" den Wert der
ID eines anderen Ausfallzeiteintrag hat. Setzen Sie den Wert von
"trigger\_id" auf Null (0), wenn die Ausfallzeit des angegebenen Hosts
nicht von einem anderen Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_HOST\_SVC\_CHECKS**

`SCHEDULE_HOST_SVC_CHECKS;`{.code}\<host\_name\>;\<check\_time\>

Plant die nächste aktive Prüfung aller Services des angegebenen Hosts
zur "check\_time". Das "check\_time"-Argument gibt dem Wert im
time\_t-Format (Sekunden seit der UNIX-Epoche) an. Beachten Sie, dass
die Services ggf. nicht zu der Zeit geprüft wird, die Sie angegeben
haben. Das kann eine Reihe von Gründen haben: Aktive Prüfungen sind auf
Service- oder programmweiter Ebene deaktiviert, die Service-Prüfungen
sind bereits für einen früheren Zeitpunkt geplant, usw. Wenn Sie die
Service-Prüfungen erzwingen wollen, dann schauen Sie beim
SCHEDULE\_FORCED\_HOST\_SVC\_CHECKS-Befehl.

**SCHEDULE\_HOST\_SVC\_DOWNTIME**

`SCHEDULE_HOST_SVC_DOWNTIME;`{.code}\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für alle Services des angegebenen Hosts. Wenn das
"fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit zu den
durch die "start"- und "end"-Argumente angegebenen Zeiten starten bzw.
enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit der Services kann durch einen anderen Ausfallzeiteintrag
ausgelöst werden, wenn die "trigger\_id" den Wert der ID eines anderen
Ausfallzeiteintrag hat. Setzen Sie den Wert von "trigger\_id" auf Null
(0), wenn die Ausfallzeit der Services nicht von einem anderen
Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_HOSTGROUP\_HOST\_DOWNTIME**

`SCHEDULE_HOSTGROUP_HOST_DOWNTIME;`{.code}\<hostgroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für alle Hosts der angegebenen Hostgruppe. Wenn
das "fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit zu
den durch die "start"- und "end"-Argumente angegebenen Zeiten starten
bzw. enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit der Hosts kann durch einen anderen Ausfallzeiteintrag
ausgelöst werden, wenn die "trigger\_id" den Wert der ID eines anderen
Ausfallzeiteintrag hat. Setzen Sie den Wert von "trigger\_id" auf Null
(0), wenn die Ausfallzeit der Hosts nicht von einem anderen
Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_HOSTGROUP\_SVC\_DOWNTIME**

`SCHEDULE_HOSTGROUP_SVC_DOWNTIME;`{.code}\<hostgroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für alle Services der angegebenen Hostgruppe.
Wenn das "fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit
zu den durch die "start"- und "end"-Argumente angegebenen Zeiten starten
bzw. enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit der Services kann durch einen anderen Ausfallzeiteintrag
ausgelöst werden, wenn die "trigger\_id" den Wert der ID eines anderen
Ausfallzeiteintrag hat. Setzen Sie den Wert von "trigger\_id" auf Null
(0), wenn die Ausfallzeit der Services nicht von einem anderen
Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_SERVICEGROUP\_HOST\_DOWNTIME**

`SCHEDULE_SERVICEGROUP_HOST_DOWNTIME;`{.code}\<servicegroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für alle Hosts, die Services in der angegebenen
Servicegruppe haben. Wenn das "fixed"-Argument auf eins (1) gesetzt ist,
wird die Ausfallzeit zu den durch die "start"- und "end"-Argumente
angegebenen Zeiten starten bzw. enden. Andernfalls wird die Ausfallzeit
zwischen den Start- und Endzeiten beginnen und die Anzahl von Sekunden
dauern, die durch das "duration"-Argument angegeben wird. Die "start"-
und "end"-Argumente werden im time\_t-Format (Sekunden seit der
UNIX-Epoche) angegeben. Die Ausfallzeit der Hosts kann durch einen
anderen Ausfallzeiteintrag ausgelöst werden, wenn die "trigger\_id" den
Wert der ID eines anderen Ausfallzeiteintrag hat. Setzen Sie den Wert
von "trigger\_id" auf Null (0), wenn die Ausfallzeit der Hosts nicht von
einem anderen Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_SERVICEGROUP\_SVC\_DOWNTIME**

`SCHEDULE_SERVICEGROUP_SVC_DOWNTIME;`{.code}\<servicegroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für alle Services der angegebenen Servicegruppe.
Wenn das "fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit
zu den durch die "start"- und "end"-Argumente angegebenen Zeiten starten
bzw. enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit der Services kann durch einen anderen Ausfallzeiteintrag
ausgelöst werden, wenn die "trigger\_id" den Wert der ID eines anderen
Ausfallzeiteintrag hat. Setzen Sie den Wert von "trigger\_id" auf Null
(0), wenn die Ausfallzeit der Services nicht von einem anderen
Ausfallzeiteintrag ausgelöst werden soll.

**SCHEDULE\_SVC\_CHECK**

`SCHEDULE_SVC_CHECK;`{.code}\<host\_name\>;\<service\_description\>;\<check\_time\>

Plant die nächste aktive Prüfung des angegebenen Service zur
"check\_time". Das "check\_time"-Argument gibt dem Wert im
time\_t-Format (Sekunden seit der UNIX-Epoche) an. Beachten Sie, dass
der Service ggf. nicht zu der Zeit geprüft wird, die Sie angegeben
haben. Das kann eine Reihe von Gründen haben: Aktive Prüfungen sind auf
Service- oder programmweiter Ebene deaktiviert, die Service-Prüfung ist
bereits für einen früheren Zeitpunkt geplant, usw. Wenn Sie die
Service-Prüfung erzwingen wollen, dann schauen Sie beim
SCHEDULE\_FORCED\_SVC\_CHECK-Befehl.

**SCHEDULE\_SVC\_DOWNTIME**

`SCHEDULE_SVC_DOWNTIME;`{.code}\<host\_name\>;\<service\_description\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Plant eine Ausfallzeit für den angegebenen Service. Wenn das
"fixed"-Argument auf eins (1) gesetzt ist, wird die Ausfallzeit zu den
durch die "start"- und "end"-Argumente angegebenen Zeiten starten bzw.
enden. Andernfalls wird die Ausfallzeit zwischen den Start- und
Endzeiten beginnen und die Anzahl von Sekunden dauern, die durch das
"duration"-Argument angegeben wird. Die "start"- und "end"-Argumente
werden im time\_t-Format (Sekunden seit der UNIX-Epoche) angegeben. Die
Ausfallzeit des angegebenen Service kann durch einen anderen
Ausfallzeiteintrag ausgelöst werden, wenn die "trigger\_id" den Wert der
ID eines anderen Ausfallzeiteintrag hat. Setzen Sie den Wert von
"trigger\_id" auf Null (0), wenn die Ausfallzeit des angegebenen Service
nicht von einem anderen Ausfallzeiteintrag ausgelöst werden soll.

**SEND\_CUSTOM\_HOST\_NOTIFICATION**

`SEND_CUSTOM_HOST_NOTIFICATION;`{.code}\<host\_name\>;\<options\>;\<author\>;\<comment\>

Erlaubt Ihnen den Versand einer angepassten Host-Benachrichtigung. Das
ist sehr nützlich in schlimmen Situationen, Notfällen oder um mit allen
Admins zu kommunizieren, die für einen bestimmten Host zuständig sind.
Beim Versand der Host-Benachrichtigung wird das
\$NOTIFICATIONTYPE\$-Makro auf "CUSTOM" gesetzt. Das \<options-\>-Feld
ist ein logisches ODER der folgenden Ganzzahl-Werte, die beeinflussen,
wie die Benachrichtigung versandt wird: 0 = keine Option (Default), 1 =
Broadcast (Benachrichtigungen an alle normalen und alle
Eskalationskontakte des Hosts versenden), 2 = erzwungen
(Benachrichtigung wird versandt, unabhängig von der aktuellen Zeit, ob
Benachrichtigungen aktiviert sind oder nicht, etc.), 4 = inkrementieren
der Benachrichtigungsnummer für den Host (dies wird nicht automatisch
bei angepassten Benachrichtigungen gemacht). Das Kommentarfeld kann über
das \$NOTIFICATIONCOMMENT\$-Makro in Benachrichtigungsbefehlen benutzt
werden.

**SEND\_CUSTOM\_SVC\_NOTIFICATION**

`SEND_CUSTOM_SVC_NOTIFICATION;`{.code}\<host\_name\>;\<service\_description\>;\<options\>;\<author\>;\<comment\>

Erlaubt Ihnen den Versand einer angepassten Service-Benachrichtigung.
Das ist sehr nützlich in schlimmen Situationen, Notfällen oder um mit
allen Admins zu kommunizieren, die für einen bestimmten Service
zuständig sind. Beim Versand der Service-Benachrichtigung wird das
\$NOTIFICATIONTYPE\$-Makro auf "CUSTOM" gesetzt. Das \<options-\>-Feld
ist ein logisches ODER der folgenden Ganzzahl-Werte, die beeinflussen,
wie die Benachrichtigung versandt wird: 0 = keine Option (Default), 1 =
Broadcast (Benachrichtigungen an alle normalen und alle
Eskalationskontakte des Service versenden), 2 = erzwungen
(Benachrichtigung wird versandt, unabhängig von der aktuellen Zeit, ob
Benachrichtigungen aktiviert sind oder nicht, etc.), 4 = inkrementieren
der Benachrichtigungsnummer für den Service (dies wird nicht automatisch
bei angepassten Benachrichtigungen gemacht). Das Kommentarfeld kann über
das \$NOTIFICATIONCOMMENT\$-Makro in Benachrichtigungsbefehlen benutzt
werden.

**SET\_HOST\_NOTIFICATION\_NUMBER**

`SET_HOST_NOTIFICATION_NUMBER;`{.code}\<host\_name\>;\<notification\_number\>

Setzt die aktuellen Benachrichtigungsnummer für den angegebenen Host.
Ein Wert von Null (0) zeigt an, dass bisher keine Benachrichtigung für
das aktuelle Host-Problem versandt wurde. Das ist nützlich zum Erzwingen
einer Eskalation (basierend auf der Benachrichtigungsnummer) oder zur
Replizierung von Benachrichtigungsinformationen in redundanten
Überwachungsumgebungen. Benachrichtigungsnummern größer Null haben
keinen spürbaren Einfluss auf den Benachrichtigungsprozess, falls sich
der Host gerade in einem UP-Zustand befindet.

**SET\_SVC\_NOTIFICATION\_NUMBER**

`SET_SVC_NOTIFICATION_NUMBER;`{.code}\<host\_name\>;\<service\_description\>;\<notification\_number\>

Setzt die aktuellen Benachrichtigungsnummer für den angegebenen Service.
Ein Wert von Null (0) zeigt an, dass bisher keine Benachrichtigung für
das aktuelle Service-Problem versandt wurde. Das ist nützlich zum
Erzwingen einer Eskalation (basierend auf der Benachrichtigungsnummer)
oder zur Replizierung von Benachrichtigungsinformationen in redundanten
Überwachungsumgebungen. Benachrichtigungsnummern größer Null haben
keinen spürbaren Einfluss auf den Benachrichtigungsprozess, falls sich
der Service gerade in einem OK-Zustand befindet.

**SHUTDOWN\_PROCESS**

`SHUTDOWN_PROCESS`{.code}

Stoppt den Icinga-Prozess.

**START\_ACCEPTING\_PASSIVE\_HOST\_CHECKS**

`START_ACCEPTING_PASSIVE_HOST_CHECKS`{.code}

Aktiviert Annahme und Verarbeitung von passiven Host-Prüfungen auf
programmweiter Ebene.

**START\_ACCEPTING\_PASSIVE\_SVC\_CHECKS**

`START_ACCEPTING_PASSIVE_SVC_CHECKS`{.code}

Aktiviert Annahme und Verarbeitung von passiven Service-Prüfungen auf
programmweiter Ebene.

**START\_EXECUTING\_HOST\_CHECKS**

`START_EXECUTING_HOST_CHECKS`{.code}

Aktiviert aktive Host-Prüfungen auf programmweiter Ebene.

**START\_EXECUTING\_SVC\_CHECKS**

`START_EXECUTING_SVC_CHECKS`{.code}

Aktiviert aktive Service-Prüfungen auf programmweiter Ebene.

**START\_OBSESSING\_OVER\_HOST**

`START_OBSESSING_OVER_HOST;`{.code}\<host\_name\>

Aktiviert die Verarbeitung von Host-Prüfungen mit Hilfe des OCHP-Befehls
für den angegebenen Host.

**START\_OBSESSING\_OVER\_HOST\_CHECKS**

`START_OBSESSING_OVER_HOST_CHECKS`{.code}

Aktiviert die Verarbeitung von Host-Prüfungen mit Hilfe des OCHP-Befehls
auf programmweiter Ebene.

**START\_OBSESSING\_OVER\_SVC**

`START_OBSESSING_OVER_SVC;`{.code}\<host\_name\>;\<service\_description\>

Aktiviert die Verarbeitung von Service-Prüfungen mit Hilfe des
OCSP-Befehls für den angegebenen Service.

**START\_OBSESSING\_OVER\_SVC\_CHECKS**

`START_OBSESSING_OVER_SVC_CHECKS`{.code}

Aktiviert die Verarbeitung von Service-Prüfungen mit Hilfe des
OCSP-Befehls auf programmweiter Ebene.

**STOP\_ACCEPTING\_PASSIVE\_HOST\_CHECKS**

`STOP_ACCEPTING_PASSIVE_HOST_CHECKS`{.code}

Deaktiviert Annahme und Verarbeitung von passiven Host-Prüfungen auf
programmweiter Ebene.

**STOP\_ACCEPTING\_PASSIVE\_SVC\_CHECKS**

`STOP_ACCEPTING_PASSIVE_SVC_CHECKS`{.code}

Deaktiviert Annahme und Verarbeitung von passiven Service-Prüfungen auf
programmweiter Ebene.

**STOP\_EXECUTING\_HOST\_CHECKS**

`STOP_EXECUTING_HOST_CHECKS`{.code}

Deaktiviert aktive Host-Prüfungen auf programmweiter Ebene.

**STOP\_EXECUTING\_SVC\_CHECKS**

`STOP_EXECUTING_SVC_CHECKS`{.code}

Deaktiviert aktive Service-Prüfungen auf programmweiter Ebene.

**STOP\_OBSESSING\_OVER\_HOST**

`STOP_OBSESSING_OVER_HOST;`{.code}\<host\_name\>

Deaktiviert die Verarbeitung von Host-Prüfungen mit Hilfe des
OCHP-Befehls für den angegebenen Host.

**STOP\_OBSESSING\_OVER\_HOST\_CHECKS**

`STOP_OBSESSING_OVER_HOST_CHECKS`{.code}

Deaktiviert die Verarbeitung von Host-Prüfungen mit Hilfe des
OCHP-Befehls auf programmweiter Ebene.

**STOP\_OBSESSING\_OVER\_SVC**

`STOP_OBSESSING_OVER_SVC;`{.code}\<host\_name\>;\<service\_description\>

Deaktiviert die Verarbeitung von Service-Prüfungen mit Hilfe des
OCSP-Befehls für den angegebenen Service.

**STOP\_OBSESSING\_OVER\_SVC\_CHECKS**

`STOP_OBSESSING_OVER_SVC_CHECKS`{.code}

Deaktiviert die Verarbeitung von Service-Prüfungen mit Hilfe des
OCSP-Befehls auf programmweiter Ebene.

* * * * *

  ----------------------------- -------------------------- -------------------------------
  [Zurück](extcommands.md)    [Nach oben](ch07.md)      [Weiter](eventhandlers.md)
  7.1. Externe Befehle          [Zum Anfang](index.md)    7.3. Eventhandler
  ----------------------------- -------------------------- -------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
