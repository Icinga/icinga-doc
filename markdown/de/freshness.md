![Icinga](../images/logofullsize.png "Icinga")

7.5. Service- und Host-Frische-Prüfungen

[Zurück](volatileservices.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](distributed.md)

* * * * *

7.5. Service- und Host-Frische-Prüfungen
----------------------------------------

7.5.1. [Einführung](freshness.md#introduction)

7.5.2. [Wie funktioniert die
Frische-Prüfung?](freshness.md#howitworks)

7.5.3. [Frische-Prüfungen aktivieren](freshness.md#enable)

7.5.4. [Beispiel](freshness.md#example)

7.5.5. ["Check results ... are stale. Forcing an immediate check
...](freshness.md#stale)

### 7.5.1. Einführung

Icinga unterstützt ein Feature, das die "Frische" (Freshness) der Host-
und Service-Prüfungen überprüft. Der Zweck der Frische-Prüfung ist es,
bei passiven Host- und Service-Prüfungen sicherzustellen, dass diese
regelmäßig von externen Applikationen zur Verfügung gestellt werden.

Frische-Prüfungen sind sinnvoll, wenn Sie sicherstellen wollen, dass
[passive
Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
so regelmäßig empfangen werden wie Sie das erwarten. Das kann in
[verteilten](distributed.md "7.6. Verteilte Überwachung") und
[Failover](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")
Überwachungsumgebungen sehr sinnvoll sein.

![](../images/freshness.png)

### 7.5.2. Wie funktioniert die Frische-Prüfung?

Icinga prüft periodisch die Frische der Ergebnisse für alle Hosts und
Services, bei denen Frische-Prüfungen aktiviert sind.

-   ein Frische-Schwellwert wird für jeden Host oder Service berechnet.

-   für jeden Host/Service wird das Alter des letzten
    Prüfungsergebnisses mit dem Frische-Schwellwert verglichen.

-   wenn das Alter des letzten Prüfungsergebnisses größer als der
    Frisch-Schwellwert ist, wird das Prüfergebnis als "abgestanden"
    (stale) betrachtet.

-   wenn das Prüfergebnis als abgestanden angesehen wird, wird Icinga
    eine [aktive
    Prüfung](activechecks.md "5.6. Aktive Prüfungen (Active Checks)")
    für den Host oder Service mit dem Kommando ausführen, das in der
    Host- oder Service-Definition angegeben ist.

![](../images/tip.gif) Hinweis: Eine aktive Prüfung wird ausgeführt,
selbst wenn aktive Prüfungen programmweit oder auf Host- bzw.
Service-spezifischer Basis deaktiviert sind.

Wenn Sie beispielsweise einen Frische-Schwellwert von 60 für einen Ihrer
Services haben, wird Icinga diesen Service als abgestanden ansehen, wenn
das letzte Prüfergebnis älter als 60 Sekunden ist.

### 7.5.3. Frische-Prüfungen aktivieren

Was Sie tun müssen, um Frische-Prüfungen zu aktivieren...

-   aktivieren Sie Frische-Prüfungen auf programmweiter Basis mit den
    [check\_service\_freshness](configmain.md#configmain-check_service_freshness)
    und
    [check\_host\_freshness](configmain.md#configmain-check_host_freshness)-Direktiven.

-   benutzen Sie die
    [service\_freshness\_check\_interval](configmain.md#configmain-service_freshness_check_interval)-
    und
    [host\_freshness\_check\_interval](configmain.md#configmain-host_freshness_check_interval)-Optionen,
    um Icinga mitzuteilen, wie oft es die Frische von Host- und
    Service-Ergebnissen prüfen soll.

-   aktivieren Sie Frische-Prüfungen auf Host- und Service-spezifischer
    Basis, indem Sie die *check\_freshness*-Option in Ihrer Host- und
    Service-Definitionen auf 1 setzen.

-   konfigurieren Sie Frische-Schwellwerte, indem Sie die
    *freshness\_threshold*-Option in Ihren Host- und
    Service-Definitionen setzen.

-   konfigurieren Sie die *check\_command*-Option in Ihren Host- oder
    Service-Definitionen, so dass sie ein gültiges Script enthalten, das
    benutzt werden kann, um den Host oder Service aktiv zu prüfen, wenn
    er als abgestanden angesehen wird.

-   Die *check\_period*-Option in Ihren Host- und Service-Definitionen
    wird benutzt, wenn Icinga festlegt, wann ein Host oder Service auf
    Frische geprüft werden soll, um sicherzustellen, dass es sich um ein
    gültiges Zeitfenster handelt.

![](../images/tip.gif) Hinweis: Wenn Sie keinen Host- oder
Service-spezifischen *freshness\_threshold*-Wert angeben (oder ihn auf
Null setzen), wird Icinga automatisch einen Schwellwert berechnen, der
darauf basiert, wie oft Sie den jeweiligen Host- oder Service
überwachen. Wir würden empfehlen, dass Sie explizit einen
Frische-Schwellwert angeben, statt dass Icinga einen für Sie auswählt.

### 7.5.4. Beispiel

Ein Beispiel für einen Service, der eine Frische-Prüfung benötigen
könnte, wäre einer, der den Status Ihrer nächtlichen Backups meldet.
Vielleicht haben Sie ein externes Script, welches das Ergebnis des
Backup-Jobs an Icinga meldet, sobald das Backup beendet ist. In diesem
Fall werden alle Prüfungen/Ergebnisse für diesen Service durch eine
externe Applikation mit Hilfe von passiven Prüfungen zur Verfügung
gestellt. Um sicherzustellen, dass der Status des Backup-Jobs täglich
gemeldet wird, können Sie die Frische-Prüfung für diesen Service
aktivieren. Falls das externe Script das Ergebnis des Backup-Jobs nicht
meldet, kann Icinga ein kritisches Ergebnis imitieren, indem man
folgendes tut...

Nachfolgend, wie die Definition für den Service aussehen könnte (einige
benötigte Optionen fehlen...)

~~~~ {.screen}
 define service{
        host_name               backup-server
        service_description     ArcServe Backup Job
        active_checks_enabled   0               ; aktive Prüfungen sind NICHT aktiviert
        passive_checks_enabled  1               ; passive Prüfungen sind aktiviert (dadurch werden Ergebnisse gemeldet)
        check_freshness         1
        freshness_threshold     93600           ; 26 Stunden Schwellwert, nachdem Backups nicht immer zur gleichen Zeit beendet sind
        check_command           no-backup-report        ; dieses Kommando wird nur ausgeführt, wenn der Service als "abgestanden" angesehen wird
        ...andere Optionen...
        }
~~~~

Beachten Sie, dass aktive Prüfungen für den Service deaktiviert sind.
Das ist so, weil die Ergebnisse für den Service nur durch eine externe
Applikation geliefert werden. Die Frische-Prüfung ist aktiviert und der
Frische-Schwellwert ist auf 26 Stunden gesetzt. Das ist ein bisschen
mehr als 24 Stunden, weil Backup-Jobs ab und zu länger dauern (abhängig
davon, wie viele Daten zu sichern sind, wie viel Netzwerkverkehr
herrscht, usw.). Das *no-backup-report*-Kommando wird nur ausgeführt,
wenn die Ergebnisse des Service als abgestanden angesehen werden. Die
Definition des *no-backup-report*-Kommandos könnte wie folgt aussehen...

~~~~ {.screen}
 define command{
        command_name    no-backup-report
        command_line    /usr/local/icinga/libexec/check_dummy 2 "CRITICAL: Results of backup job were not reported!"
        }
~~~~

Falls Icinga erkennt, dass das Service-Ergebnis abgestanden ist, wird es
das *no-backup-report*-Kommando als eine aktive Service-Prüfung
ausführen. Das führt dazu, dass das *check\_dummy*-Plugin ausgeführt
wird, das einen kritischen Status an Icinga meldet. Der Service wird
dann in einen kritischen Zustand gehen (falls das nicht bereits der Fall
ist) und wahrscheinlich wird jemand über das Problem informiert.

### 7.5.5. "Check results ... are stale. Forcing an immediate check ...

Manchmal finden Sie vielleicht Meldungen wie die folgende in icinga.log:

~~~~ {.screen}
 Check results for service x on host y are stale by 0d 0h 0m 10s (threshold=0d 0h 10m 0s).
 Forcing an immediate check of the service...
~~~~

Das bedeutet, dass der Service in der Vergangenheit geprüft wurde und
die als Schwellwert definierte Zeit (z.B. 10min) vergangen ist, ohne
dass ein neues Prüfergebnis geliefert wurde, so dass eine Prüfung durch
den Core erzwungen wird.

Die Meldung kommt aus dem Code-Fragment in base/checks.c (Zeilen wurden
umgebrochen, um die Lesbarkeit zu verbessern)

~~~~ {.programlisting}
 /* the results for the last check of this service are stale */
    if (expiration_time < current_time) {

       get_time_breakdown((current_time - expiration_time), &days, &hours, &minutes, &seconds);
       get_time_breakdown(freshness_threshold, &tdays, &thours, &tminutes, &tseconds);

       /* log a warning */ 
       if (log_this == TRUE)
          logit(NSLOG_RUNTIME_WARNING, TRUE,
             "Warning: The results of service '%s' on host '%s' are stale by %dd %dh %dm %ds (threshold=%dd %dh %dm %ds).
             I'm forcing an immediate check of the service.\n",
             temp_service->description, temp_service->host_name,
             days, hours, minutes, seconds, tdays, thours, tminutes, tseconds
          );

       log_debug_info(DEBUGL_CHECKS, 1,
          "Check results for service '%s' on host '%s' are stale by %dd %dh %dm %ds (threshold=%dd %dh %dm %ds).
          Forcing an immediate check of the service...\n",
          temp_service->description, temp_service->host_name,
          days, hours, minutes, seconds, tdays, thours, tminutes, tseconds
       );

       return FALSE;
    }
~~~~

Normalerweise trifft folgendes zu

-   `expiration_time`{.literal} = last\_check + freshness threshold
    (z.B. 10 Min.)

-   expiration\_time ist in der Vergangenheit
    (`< current_time`{.literal}) == stale

-   der Unterschied zwischen jetzt und expiration\_time wird im
    Protokoll angezeigt (z.B. 10 Sek.)

Falls der Service nicht jetzt, aber bereits in der Vergangenheit geprüft
wurde (event\_start \> last\_check) und der Schwellwert 0 ist, wird
max\_service\_check\_spread multipliziert mit dem Intervall als
zusätzlicher Offset addiert (das passiert während der Startphase, um
festzustellen, wann die erste Prüfung (und Status + Ausgabe) erfolgen
muss).

* * * * *

  ---------------------------------- -------------------------- -----------------------------
  [Zurück](volatileservices.md)    [Nach oben](ch07.md)      [Weiter](distributed.md)
  7.4. sprunghafte Services          [Zum Anfang](index.md)    7.6. Verteilte Überwachung
  ---------------------------------- -------------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
