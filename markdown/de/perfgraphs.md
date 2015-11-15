![Icinga](../images/logofullsize.png "Icinga")

8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios

[Zurück](icingastats.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](temp_data.md)

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

-   dass Icinga effizient arbeitet

-   um Problembereiche im Überwachungsprozess zu lokalisieren

-   um die Einflüsse von Änderungen in Ihrer Icinga-Konfiguration zu
    beobachten

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

-   Nach dem Herunterladen des Plugins und Ablegen im Plugin-Verzeichnis
    (z.B. `/usr/local/icinga/libexec`{.filename}, falls Sie die
    Schnellstartanleitung benutzt haben) müssen Sie die Werte im
    Konfigurationsabschnitt des Scripts anpassen.

    -   Am **wichtig**sten ist
        "`EXEC=`{.literal}`/path/to/icingastats`{.filename}" (z.B.
        `/usr/local/icinga/bin/icingastats`{.filename}), das auf das
        `icingastats`{.filename}-Binary zeigen muss.

    -   Abhängig von Ihren Bedürfnissen möchten Sie ggf. den Wert für
        `CUMULATE`{.literal} von "AVG" auf "MIN" oder "MAX" ändern: Die
        Einstellung von `TIMEFRAME`{.literal} beeinflusst die
        Zeitperiode, die für die Ausgabe von kumulierten Werten benutzt
        wird

    -   Das Ändern der Werte von `PASSIVE_EMERGENCY_HOST`{.literal} und
        `PASSIVE_EMERGENCY_SERVICE`{.literal} sollte nicht notwendig
        sein, weil diese Werte als Parameter an das Script übergeben
        werden.

-   Sie können das Plugin mit aktiven oder passiven Prüfungen aufrufen

    -   Aktiv

        Stellen Sie sicher, dass Ihre Objektkonfigurationsdateien eine
        passende Service-Definition enthalten, wie z.B.

        ~~~~ {.programlisting}
         define service{
            host_name               <the Icinga server>
            service_description     icingastats # (oder etwas Passendes)
            check_command           check_stats
            check_interval          1
            retry_interval          1
            ...
         }
        ~~~~

        und eine Command-Definition

        ~~~~ {.programlisting}
         define command{
            command_name            check_stats
            command_line            $USER1$/check_nagiostats
          }
        ~~~~

        Vergessen Sie nicht den Neustart von Icinga nach diesen
        Änderungen.

    -   Passiv

        Stellen Sie sicher, dass Ihre Objektkonfigurationsdateien eine
        passende Service-Definition enthalten, wie z.B.

        ~~~~ {.programlisting}
         define service{
            host_name               <the Icinga server>
            service_description     icingastats # (oder etwas Passendes)
            active_checks_enabled   0
            check_command           check_stats!3!Frische-Schwellwert ueberschritten
            check_freshness         1
            freshness_threshold     180         # Pruefintervall + x Sekunden
            ...
         }
        ~~~~

        und eine Command-Definition

        ~~~~ {.programlisting}
         define command{
            command_name            check_stats
            command_line            $USER1$/check_dummy $ARG1$ $ARG2$
         }
        ~~~~

        Vergessen Sie nicht den Neustart von Icinga nach dieser
        Änderung.

        Fügen Sie eine Zeile zur crontab des Icinga-Benutzers hinzu, die
        das `icingastats`{.filename}-Binary aufruft und die Ergebnisse
        an die Command-Pipe weiterleitet

        ~~~~ {.programlisting}
         * * * * * /usr/local/icinga/libexec/check_nagiostats --passive <host> icingastats >> /usr/local/icinga/var/rw/icinga.cmd
        ~~~~

        Auf diese Weise werden die Werte in regelmäßigen Intervallen
        aktualisiert.

-   Legen Sie einen logischen Link im (Benutzer) templates-Verzeichnis
    von PNP4Nagios an

    ~~~~ {.programlisting}
     $> ln -s ../templates.dist/nagiostats.php check_stats.php
    ~~~~

    Stellen Sie sicher, dass *check\_stats* (ohne die Endung .php) zu
    dem Wert passt, den Sie als ersten Parameter im check\_command
    angegeben haben

**Beispiel-Graphen**

Wir werden beschreiben, was die durch `check_nagiostats`{.filename}
erzeugten Graphen bedeuten und wofür sie benutzt werden können...

### 8.7.3. Durchschnittliche Host-/Service-Prüfungslatenz

**Abbildung 8.1. Durchschnittliche Host-/Service-Prüfungslatenz**

![Durchschnittliche
Host-/Service-Prüfungslatenz](../images/perfdata_lat.png)

\

Dieser Graph zeigt die durchschnittlichen Latenzzeiten von Hosts und
Services über die Zeit gesehen, getrennt nach aktiven und passiven
Prüfungen. Das ist nützlich zum Verständnis von:

-   [Host-Prüfungen](hostchecks.md "5.4. Host-Prüfungen (Host checks)")

-   [Service-Prüfungen](servicechecks.md "5.5. Service-Prüfungen (Service Checks)")

-   [Aktiven
    Prüfungen](activechecks.md "5.6. Aktive Prüfungen (Active Checks)")

-   [Passiven
    Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")

-   [Performance-Tuning](tuning.md "8.3. Icinga für maximale Leistung optimieren")

Durchgehend hohe Latenzen können ein Hinweis darauf sein, dass eine oder
mehrere der folgenden Variablen angepasst werden sollten:

-   [max\_concurrent\_checks](configmain.md#configmain-max_concurrent_checks)

-   [check\_result\_reaper\_frequency](configmain.md#configmain-check_result_reaper_frequency)

-   [max\_check\_result\_reaper\_time](configmain.md#configmain-max_check_result_reaper_time)

### 8.7.4. Service-Statistiken

**Abbildung 8.2. Service-Statistiken**

![Service-Statistiken](../images/perfdata_svc.png)

\

Dieser Graph zeigt die Werte für die einzelnen Service-Zustände zusammen
mit der durchschnittlichen Zahl von geprüften Services an, die aktiv
bzw. passiv in der von Ihnen angegebenen Zeitperiode geprüft wurden. Das
ist nützlich zum Verständnis von:

-   [Service-Prüfungen](servicechecks.md "5.5. Service-Prüfungen (Service Checks)")

-   [Vorausschauenden Service-Abhängigkeitsprüfungen (predictive service
    dependency
    checks)](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")

-   [Zwischengespeicherten Prüfungen (cached
    checks)](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen")

-   [Flattererkennung (flap
    detection)](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")

### 8.7.5. Host-Statistiken

**Abbildung 8.3. Host-Statistiken**

![Host-Statistiken](../images/perfdata_host.png)

\

Dieser Graph zeigt die Werte für die einzelnen Host-Zustände zusammen
mit der durchschnittlichen Zahl von geprüften Hosts an, die aktiv bzw.
passiv in der von Ihnen angegebenen Zeitperiode geprüft wurden. Das ist
nützlich zum Verständnis von:

-   [Host-Prüfungen](hostchecks.md "5.4. Host-Prüfungen (Host checks)")

-   [Vorausschauenden Host-Abhängigkeitsprüfungen (predictive host
    dependency
    checks)](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")

-   [Zwischengespeicherten Prüfungen (cached
    checks)](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen")

-   [Flattererkennung (flap
    detection)](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")

### 8.7.6. Durchschnittliche Ausführungszeiten

**Abbildung 8.4. Durchschnittliche Ausführungszeiten**

![Durchschnittliche Ausführungszeiten](../images/perfdata_exec.png)

\

Dieser Graph zeigt die durchschnittlichen Ausführungszeit von Host- und
Service-Prüfungen über die Zeit gesehen. Das ist nützlich zum
Verständnis von:

-   [Host-Prüfungen](hostchecks.md "5.4. Host-Prüfungen (Host checks)")

-   [Service-Prüfungen](servicechecks.md "5.5. Service-Prüfungen (Service Checks)")

-   [Performance-Tuning](tuning.md "8.3. Icinga für maximale Leistung optimieren")

![[Anmerkung]](../images/note.png)

Anmerkung

Um ehrlich zu sein: Wir haben die Graphen ein wenig verändert, bezogen
auf die Farben. Gelb ist teilweise schwierig vom Hintergrund zu
unterscheiden so dass wir einige Zeilen in der PNP4Nagios-Template-Datei
`template.dist/nagiostats.php`{.filename} von `$i=0;`{.code} in
`$i=1;`{.code} geändert haben.

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

-   [Passiven
    Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")

-   [Verteilter
    Überwachung](distributed.md "7.6. Verteilte Überwachung")

-   [Redundante/Failover-Überwachung](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")

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

-   [Zwischengespeicherten Prüfungen (cached
    checks)](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen")

-   [Vorausschauenden Host- und Service-Abhängigkeitsprüfungen
    (predictive host and service dependency
    checks)](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")

### 8.7.10. Durchschnittliche Zustandswechsel

**Abbildung 8.8. Durchschnittliche Zustandswechsel**

![Durchschnittliche Zustandswechsel](../images/perfdata_state_chg.png)

\

Dieser Graph zeigt den durchschnittlichen prozentualen Zustandswechsel
(ein Maß für die Sprunghaftigkeit) über die Zeit gesehen, unterschieden
nach Hosts und Service, die zuletzt aktiv oder passiv geprüft wurden.
Das ist nützlich zum Verständnis von:

-   [Flattererkennung (flap
    detection)](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")

* * * * *

  ---------------------------------------- -------------------------- ---------------------------
  [Zurück](icingastats.md)               [Nach oben](ch08.md)      [Weiter](temp_data.md)
  8.6. Nutzung des Icingastats-Utilitys    [Zum Anfang](index.md)    8.8. Temporäre Daten
  ---------------------------------------- -------------------------- ---------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
