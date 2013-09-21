Temporäre Daten
===============

Verschiedene Dateien werden beim Start von NAME-ICINGA angelegt und
während der Laufzeit sehr oft verarbeitet. Abhängig von der Größe Ihrer
Konfiguration kann dies zu hoher I/O-Last und damit zu einer
eingeschränkten Bedienbarkeit führen. Um physikalische I/O-Operationen
zu reduzieren kann es sinnvoll sein, temporäre Daten auf einer RAM-Disk
abzulegen. Die folgenden Zeilen zeigen die Schritte zum Anlegen einer
RAM-Disk und die Änderungen an der Hauptkonfigurationsdatei.

> **Note**
>
> Bitte denken Sie daran, dass die Dateien verloren sind, wenn Sie das
> System neu starten. Beachten Sie auch, dass es teilweise schwierig
> ist, die Größe der Dateien zu ermitteln, was ggf. zu einer vollen
> RAM-Disk führen kann.

1.  Werfen Sie einen Blick auf den aktuellen Standort des [status
    file](#configmain-status_file) (z.B.
    `/usr/local/icinga/var/status.dat`) und des [object cache
    file](#configmain-object_cache_file) (z.B.
    `/usr/local/icnga/var/objects.cache`) und ermitteln Sie die Größe
    der beiden Dateien. Addieren Sie die Größe der Statusdatei
    (status\_file) für temporäre Daten
    ([temp\_file](#configmain-temp_file)).

         #> ls -la /usr/local/icinga/var/
         -rw-rw-r--   1 icinga icinga 8.2M Jun 10 11:57 status.dat
         -rw-r--r--   1 icinga icinga 5.9M Jun 10 11:58 objects.cache

2.  Erhöhen Sie die Zahl um einen nennenswerten Betrag, um auch
    zukünftiges Wachstum zu ermöglichen (100 MB sollten in diesem Fall
    ausreichen) und legen Sie die RAM-Disk an.

    > **Caution**
    >
    > Wenn der Wert zu groß gewählt ist, wird dies Ihr System drosseln,
    > weil es dann anfängt zu "swappen", was wieder zu physikalischem
    > I/O führt.

         #> mkdir /var/icinga/ramdisk
         #> mount -t tmpfs tmpfs /var/icinga/ramdisk -o size=100m
         #> chown icinga:icinga /var/icinga/ramdisk

    Passen Sie die Angaben von Benutzer und Gruppe auf die Werte an, die
    in Ihrer Konfiguration benutzt werden (falls notwendig).

3.  Fügen Sie einen Eintrag zur Datei `/etc/fstab` hinzu, um die
    Änderungen permanent zu machen, damit die RAM-Disk beim nächsten
    Systemneustart automatisch angelegt wird.

        tmpfs                /var/icinga/ramdisk     tmpfs   size=100m        0 0

4.  Editieren Sie die NAME-ICINGA Hauptkonfigurationsdatei und ändern
    Sie die Einstellungen der betreffenden Direktiven

         #object_cache_file=/usr/local/icinga/var/objects.cache
         object_cache_file=/var/icinga/ramdisk/objects.cache

         #status_file=/usr/local/icinga/var/status.dat
         status_file=/var/icinga/ramdisk/status.dat
         
         #temp_file=/usr/local/icinga/var/icinga.tmp
         temp_file=/var/icinga/ramdisk/icinga.tmp

5.  Starten Sie NAME-ICINGA neu, damit die Änderungen aktiv werden

         #> /etc/init.d/icinga restart

Möglicherweise möchten Sie die RAM-Disk auch für anderen Dateien wie
z.B. die check results benutzen. Bitte erhöhen Sie die Größe der
RAM-Disk - falls notwendig - und ändern Sie die Direktive in der
Hauptkonfigurationsdatei

     check_result_path=/var/icinga/ramdisk/checkresults

Stellen Sie sicher, dass auch anderen Addons wie z.B. check\_mk diese
Änderungen bekannt sind.

Temporary Data
RAM-Disk
Status file
Object cache file
