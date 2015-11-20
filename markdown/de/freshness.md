 ![Icinga](../images/logofullsize.png "Icinga") 

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





![](../images/tip.gif) Hinweis: Eine aktive Prüfung wird ausgeführt,
selbst wenn aktive Prüfungen programmweit oder auf Host- bzw.
Service-spezifischer Basis deaktiviert sind.

Wenn Sie beispielsweise einen Frische-Schwellwert von 60 für einen Ihrer
Services haben, wird Icinga diesen Service als abgestanden ansehen, wenn
das letzte Prüfergebnis älter als 60 Sekunden ist.

### 7.5.3. Frische-Prüfungen aktivieren

Was Sie tun müssen, um Frische-Prüfungen zu aktivieren...







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

 define service{
</code></pre>

Beachten Sie, dass aktive Prüfungen für den Service deaktiviert sind.
Das ist so, weil die Ergebnisse für den Service nur durch eine externe
Applikation geliefert werden. Die Frische-Prüfung ist aktiviert und der
Frische-Schwellwert ist auf 26 Stunden gesetzt. Das ist ein bisschen
mehr als 24 Stunden, weil Backup-Jobs ab und zu länger dauern (abhängig
davon, wie viele Daten zu sichern sind, wie viel Netzwerkverkehr
herrscht, usw.). Das *no-backup-report*-Kommando wird nur ausgeführt,
wenn die Ergebnisse des Service als abgestanden angesehen werden. Die
Definition des *no-backup-report*-Kommandos könnte wie folgt aussehen...

 define command{
</code></pre>

Falls Icinga erkennt, dass das Service-Ergebnis abgestanden ist, wird es
das *no-backup-report*-Kommando als eine aktive Service-Prüfung
ausführen. Das führt dazu, dass das *check\_dummy*-Plugin ausgeführt
wird, das einen kritischen Status an Icinga meldet. Der Service wird
dann in einen kritischen Zustand gehen (falls das nicht bereits der Fall
ist) und wahrscheinlich wird jemand über das Problem informiert.

### 7.5.5. "Check results ... are stale. Forcing an immediate check ...

Manchmal finden Sie vielleicht Meldungen wie die folgende in icinga.log:

 Check results for service x on host y are stale by 0d 0h 0m 10s (threshold=0d 0h 10m 0s).
 Forcing an immediate check of the service...
</code></pre>

Das bedeutet, dass der Service in der Vergangenheit geprüft wurde und
die als Schwellwert definierte Zeit (z.B. 10min) vergangen ist, ohne
dass ein neues Prüfergebnis geliefert wurde, so dass eine Prüfung durch
den Core erzwungen wird.

Die Meldung kommt aus dem Code-Fragment in base/checks.c (Zeilen wurden
umgebrochen, um die Lesbarkeit zu verbessern)

<pre><code>
 /* the results for the last check of this service are stale */




</code></pre>

Normalerweise trifft folgendes zu




Falls der Service nicht jetzt, aber bereits in der Vergangenheit geprüft
wurde (event\_start \> last\_check) und der Schwellwert 0 ist, wird
max\_service\_check\_spread multipliziert mit dem Intervall als
zusätzlicher Offset addiert (das passiert während der Startphase, um
festzustellen, wann die erste Prüfung (und Status + Ausgabe) erfolgen
muss).

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
