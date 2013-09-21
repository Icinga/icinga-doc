Service- und Host-Frische-Prüfungen
===================================

Einführung
----------

NAME-ICINGA unterstützt ein Feature, das die "Frische" (Freshness) der
Host- und Service-Prüfungen überprüft. Der Zweck der Frische-Prüfung ist
es, bei passiven Host- und Service-Prüfungen sicherzustellen, dass diese
regelmäßig von externen Applikationen zur Verfügung gestellt werden.

Frische-Prüfungen sind sinnvoll, wenn Sie sicherstellen wollen, dass
[passive Prüfungen](#passivechecks) so regelmäßig empfangen werden wie
Sie das erwarten. Das kann in [verteilten](#distributed) und
[Failover](#redundancy) Überwachungsumgebungen sehr sinnvoll sein.

![](../images/freshness.png)

Wie funktioniert die Frische-Prüfung?
-------------------------------------

NAME-ICINGA prüft periodisch die Frische der Ergebnisse für alle Hosts
und Services, bei denen Frische-Prüfungen aktiviert sind.

-   ein Frische-Schwellwert wird für jeden Host oder Service berechnet.

-   für jeden Host/Service wird das Alter des letzten
    Prüfungsergebnisses mit dem Frische-Schwellwert verglichen.

-   wenn das Alter des letzten Prüfungsergebnisses größer als der
    Frisch-Schwellwert ist, wird das Prüfergebnis als "abgestanden"
    (stale) betrachtet.

-   wenn das Prüfergebnis als abgestanden angesehen wird, wird
    NAME-ICINGA eine [aktive Prüfung](#activechecks) für den Host oder
    Service mit dem Kommando ausführen, das in der Host- oder
    Service-Definition angegeben ist.

![](../images/tip.gif) Hinweis: Eine aktive Prüfung wird ausgeführt,
selbst wenn aktive Prüfungen programmweit oder auf Host- bzw.
Service-spezifischer Basis deaktiviert sind.

Wenn Sie beispielsweise einen Frische-Schwellwert von 60 für einen Ihrer
Services haben, wird NAME-ICINGA diesen Service als abgestanden ansehen,
wenn das letzte Prüfergebnis älter als 60 Sekunden ist.

Frische-Prüfungen aktivieren
----------------------------

Was Sie tun müssen, um Frische-Prüfungen zu aktivieren...

-   aktivieren Sie Frische-Prüfungen auf programmweiter Basis mit den
    [check\_service\_freshness](#configmain-check_service_freshness) und
    [check\_host\_freshness](#configmain-check_host_freshness)-Direktiven.

-   benutzen Sie die
    [service\_freshness\_check\_interval](#configmain-service_freshness_check_interval)-
    und
    [host\_freshness\_check\_interval](#configmain-host_freshness_check_interval)-Optionen,
    um NAME-ICINGA mitzuteilen, wie oft es die Frische von Host- und
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
    wird benutzt, wenn NAME-ICINGA festlegt, wann ein Host oder Service
    auf Frische geprüft werden soll, um sicherzustellen, dass es sich um
    ein gültiges Zeitfenster handelt.

![](../images/tip.gif) Hinweis: Wenn Sie keinen Host- oder
Service-spezifischen *freshness\_threshold*-Wert angeben (oder ihn auf
Null setzen), wird NAME-ICINGA automatisch einen Schwellwert berechnen,
der darauf basiert, wie oft Sie den jeweiligen Host- oder Service
überwachen. Wir würden empfehlen, dass Sie explizit einen
Frische-Schwellwert angeben, statt dass NAME-ICINGA einen für Sie
auswählt.

Beispiel
--------

Ein Beispiel für einen Service, der eine Frische-Prüfung benötigen
könnte, wäre einer, der den Status Ihrer nächtlichen Backups meldet.
Vielleicht haben Sie ein externes Script, welches das Ergebnis des
Backup-Jobs an NAME-ICINGA meldet, sobald das Backup beendet ist. In
diesem Fall werden alle Prüfungen/Ergebnisse für diesen Service durch
eine externe Applikation mit Hilfe von passiven Prüfungen zur Verfügung
gestellt. Um sicherzustellen, dass der Status des Backup-Jobs täglich
gemeldet wird, können Sie die Frische-Prüfung für diesen Service
aktivieren. Falls das externe Script das Ergebnis des Backup-Jobs nicht
meldet, kann NAME-ICINGA ein kritisches Ergebnis imitieren, indem man
folgendes tut...

Nachfolgend, wie die Definition für den Service aussehen könnte (einige
benötigte Optionen fehlen...)

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

Beachten Sie, dass aktive Prüfungen für den Service deaktiviert sind.
Das ist so, weil die Ergebnisse für den Service nur durch eine externe
Applikation geliefert werden. Die Frische-Prüfung ist aktiviert und der
Frische-Schwellwert ist auf 26 Stunden gesetzt. Das ist ein bisschen
mehr als 24 Stunden, weil Backup-Jobs ab und zu länger dauern (abhängig
davon, wie viele Daten zu sichern sind, wie viel Netzwerkverkehr
herrscht, usw.). Das *no-backup-report*-Kommando wird nur ausgeführt,
wenn die Ergebnissse des Service als abgestanden angesehen werden. Die
Definition des *no-backup-report*-Kommandos könnte wie folgt aussehen...

     define command{
            command_name    no-backup-report
            command_line    URL-ICINGA-LIBEXEC/check_dummy 2 "CRITICAL: Results of backup job were not reported!"
            }

Falls NAME-ICINGA erkennt, dass das Service-Ergebnis abgestanden ist,
wird es das *no-backup-report*-Kommando als eine aktive Service-Prüfung
ausführen. Das führt dazu, dass das *check\_dummy*-Plugin ausgeführt
wird, das einen kritischen Status an NAME-ICINGA meldet. Der Service
wird dann in einen kritischen Zustand gehen (falls das nicht bereits der
Fall ist) und wahrscheinlich wird jemand über das Problem informiert.

Frische (freshness)
Service- und Host-Frischeprüfungen
