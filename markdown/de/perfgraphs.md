 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios
-----------------------------------------------------------------------

8.7.1. [Einführung](perfgraphs.md#introduction)

8.7.2. [Voraussetzungen](perfgraphs.md#prerequisites)

8.7.3. [Durchschnittliche
Host-/Service-Prüfungslatenz](perfgraphs.md#avghostsvcchecklatency)

8.7.4. [Service-Statistiken](perfgraphs.md#servicestatistics)

8.7.5. [Host-Statistiken](perfgraphs.md#hoststatistics)

8.7.6. [Durchschnittliche
Ausführungszeiten](perfgraphs.md#avgexecutiontimes)

8.7.7. [Externe Befehle (external
commands)](perfgraphs.md#externalcommands)

8.7.8. [Puffer für externe Befehle (external command
buffers)](perfgraphs.md#externalcommandbuffers)

8.7.9. [Zwischengespeicherte Host- und Service-Prüfungen (cached host
and service checks)](perfgraphs.md#avgstatechanges)

8.7.10. [Durchschnittliche Zustandswechsel](perfgraphs.md#idp15945472)

### 8.7.1. Einführung

Das [icingastats](icingastats.md)-Utility erlaubt Ihnen zusammen mit
[PNP4Nagios](http://docs.pnp4nagios.org/pnp-0.6/start), verschiedene
Icinga-Performance-Statistiken über eine bestimmten Zeitraum grafisch
darzustellen. Das ist wichtig, weil es Ihnen helfen kann




### 8.7.2. Voraussetzungen

PNP4Nagios ist eines der populärsten Addons wegen der einfachen
Installation und geringem Wartungsaufwand während des Betriebs. Die
Dokumentation zusammen mit weiteren Links zum Download der Software
finden Sie unter
[http://docs.pnp4nagios.org/de/pnp-0.6/start](http://docs.pnp4nagios.org/de/pnp-0.6/start).

[check\_nagiostats](https://www.monitoringexchange.org/inventory/Check-Plugins/Software/Nagios/check_nagiostats)
wurde von [Jochen
Bern](http://www.monitoring-portal.org/wbb/index.php?page=User&userID=7773)
erstellt. Es kann als aktive Service-Prüfung aufgerufen werden oder über
die crontab und liefert die Daten dann als passive Prüfergebnisse. Trotz
des Namens funktioniert das Plugin auch mit Icinga.
























**Beispiel-Graphen**

Wir werden beschreiben, was die durch `check_nagiostats`
erzeugten Graphen bedeuten und wofür sie benutzt werden können...

### 8.7.3. Durchschnittliche Host-/Service-Prüfungslatenz

**Abbildung 8.1. Durchschnittliche Host-/Service-Prüfungslatenz**

![Durchschnittliche
Host-/Service-Prüfungslatenz](../images/perfdata_lat.png)

\

Dieser Graph zeigt die durchschnittlichen Latenzzeiten von Hosts und
Services über die Zeit gesehen, getrennt nach aktiven und passiven
Prüfungen. Das ist nützlich zum Verständnis von:






Durchgehend hohe Latenzen können ein Hinweis darauf sein, dass eine oder
mehrere der folgenden Variablen angepasst werden sollten:




### 8.7.4. Service-Statistiken

**Abbildung 8.2. Service-Statistiken**

![Service-Statistiken](../images/perfdata_svc.png)

\

Dieser Graph zeigt die Werte für die einzelnen Service-Zustände zusammen
mit der durchschnittlichen Zahl von geprüften Services an, die aktiv
bzw. passiv in der von Ihnen angegebenen Zeitperiode geprüft wurden. Das
ist nützlich zum Verständnis von:





### 8.7.5. Host-Statistiken

**Abbildung 8.3. Host-Statistiken**

![Host-Statistiken](../images/perfdata_host.png)

\

Dieser Graph zeigt die Werte für die einzelnen Host-Zustände zusammen
mit der durchschnittlichen Zahl von geprüften Hosts an, die aktiv bzw.
passiv in der von Ihnen angegebenen Zeitperiode geprüft wurden. Das ist
nützlich zum Verständnis von:





### 8.7.6. Durchschnittliche Ausführungszeiten

**Abbildung 8.4. Durchschnittliche Ausführungszeiten**

![Durchschnittliche Ausführungszeiten](../images/perfdata_exec.png)

\

Dieser Graph zeigt die durchschnittlichen Ausführungszeit von Host- und
Service-Prüfungen über die Zeit gesehen. Das ist nützlich zum
Verständnis von:




![[Anmerkung]](../images/note.png)

Anmerkung

Um ehrlich zu sein: Wir haben die Graphen ein wenig verändert, bezogen
auf die Farben. Gelb ist teilweise schwierig vom Hintergrund zu
unterscheiden so dass wir einige Zeilen in der PNP4Nagios-Template-Datei
`template.dist/nagiostats.php` von `$i=0;` in
`$i=1;` geändert haben.

**Zusätzliche Graphen**

Nun ja, wir haben das Template noch ein bisschen mehr verändert, weil
das Plugin zwar die Daten liefert, aber keine dazugehörigen Graphen.
(Beim Blick in das Template ist es aber sehr schnell anzupassen, falls
Sie die folgenden Graphen wirklich benötigen.

### 8.7.7. Externe Befehle (external commands)

**Abbildung 8.5. Externe Befehle**

![Externe Befehle](../images/perfdata_extcmd.png)

\

Dieser Graph zeigt, wie viele externe Befehle vom Icinga-Daemon über die
Zeit gesehen verarbeitet wurden. Solange Sie keine große Anzahl von
externen Befehlen verarbeiten (wie z.B. im Falle einer verteilten
Überwachungsumgebung), dann kann dieser Graph fast leer sein. Die
Überwachung von externen Befehlen kann nützlich sein für das Verständnis
der Auswirkung von:




### 8.7.8. Puffer für externe Befehle (external command buffers)

**Abbildung 8.6. Puffer für externe Befehle**

![Puffer für externe Befehle](../images/perfdata_cmdbuf.png)

\

Der Graph zeigt, wie viele Puffer für externe Befehle über die Zeit
gesehen benutzt wurden. Wenn die Zahl von benutzten Puffern regelmäßig
fast die Zahl von verfügbaren Puffern erreicht, dann ist es
wahrscheinlich, dass Sie die Anzahl von verfügbaren Puffern mit Hilfe
der Direktive [external command buffer
slots](configmain.md#configmain-external_command_buffer_slots) erhöhen
sollten. Jeder Puffer kann genau einen externen Befehl aufnehmen. Puffer
werden für die vorübergehende Aufbewahrung von externen Befehlen
genutzt, und zwar vom Lesen aus dem [external command
file](configmain.md#configmain-command_file) bis zur Verarbeitung
durch den IcingaDaemon.

Wie Sie sehen wird nur ein Puffer genutzt und das ist genau der für die
Ergebnisse des check\_nagiostats-Plugins.

### 8.7.9. Zwischengespeicherte Host- und Service-Prüfungen (cached host and service checks)

**Abbildung 8.7. Zwischengespeicherte Host- und Service-Prüfungen**

![Zwischengespeicherte Host- und
Service-Prüfungen](../images/perfdata_cached.png)

\

Dieser Graph zeigt, wie viele zwischengespeicherte Host- und
Service-Prüfungen über die Zeit aufgetreten sind. Das ist nützlich zum
Verständnis von:



### 8.7.10. Durchschnittliche Zustandswechsel

**Abbildung 8.8. Durchschnittliche Zustandswechsel**

![Durchschnittliche Zustandswechsel](../images/perfdata_state_chg.png)

\

Dieser Graph zeigt den durchschnittlichen prozentualen Zustandswechsel
(ein Maß für die Sprunghaftigkeit) über die Zeit gesehen, unterschieden
nach Hosts und Service, die zuletzt aktiv oder passiv geprüft wurden.
Das ist nützlich zum Verständnis von:


* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
