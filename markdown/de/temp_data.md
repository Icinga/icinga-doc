 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

8.8. Temporäre Daten
--------------------

Verschiedene Dateien werden beim Start von Icinga angelegt und während
der Laufzeit sehr oft verarbeitet. Abhängig von der Größe Ihrer
Konfiguration kann dies zu hoher I/O-Last und damit zu einer
eingeschränkten Bedienbarkeit führen. Um physikalische I/O-Operationen
zu reduzieren kann es sinnvoll sein, temporäre Daten auf einer RAM-Disk
abzulegen. Die folgenden Zeilen zeigen die Schritte zum Anlegen einer
RAM-Disk und die Änderungen an der Hauptkonfigurationsdatei.

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte denken Sie daran, dass die Dateien verloren sind, wenn Sie das
System neu starten. Beachten Sie auch, dass es teilweise schwierig ist,
die Größe der Dateien zu ermitteln, was ggf. zu einer vollen RAM-Disk
führen kann.
















Möglicherweise möchten Sie die RAM-Disk auch für anderen Dateien wie
z.B. die check results benutzen. Bitte erhöhen Sie die Größe der
Hauptkonfigurationsdatei

<pre><code>
 check_result_path=/var/icinga/ramdisk/checkresults
</code></pre>

Stellen Sie sicher, dass auch anderen Addons wie z.B. check\_mk diese
Änderungen bekannt sind.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
