![Icinga](../images/logofullsize.png "Icinga")

8.8. Temporäre Daten

[Zurück](perfgraphs.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](ch09.md)

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

1.  Werfen Sie einen Blick auf den aktuellen Standort des [status
    file](configmain.md#configmain-status_file) (z.B.
    `/usr/local/icinga/var/status.dat`{.filename}) und des [object cache
    file](configmain.md#configmain-object_cache_file) (z.B.
    `/usr/local/icnga/var/objects.cache`{.filename}) und ermitteln Sie
    die Größe der beiden Dateien. Addieren Sie die Größe der Statusdatei
    (status\_file) für temporäre Daten
    ([temp\_file](configmain.md#configmain-temp_file)).

    ~~~~ {.programlisting}
     #> ls -la /usr/local/icinga/var/
     -rw-rw-r--   1 icinga icinga 8.2M Jun 10 11:57 status.dat
     -rw-r--r--   1 icinga icinga 5.9M Jun 10 11:58 objects.cache
    ~~~~

2.  Erhöhen Sie die Zahl um einen nennenswerten Betrag, um auch
    zukünftiges Wachstum zu ermöglichen (100 MB sollten in diesem Fall
    ausreichen) und legen Sie die RAM-Disk an.

    ![[Achtung]](../images/caution.png)

    Achtung

    Wenn der Wert zu groß gewählt ist, wird dies Ihr System drosseln,
    weil es dann anfängt zu "swappen", was wieder zu physikalischem I/O
    führt.

    ~~~~ {.programlisting}
     #> mkdir /var/icinga/ramdisk
     #> mount -t tmpfs tmpfs /var/icinga/ramdisk -o size=100m
     #> chown icinga:icinga /var/icinga/ramdisk
    ~~~~

    Passen Sie die Angaben von Benutzer und Gruppe auf die Werte an, die
    in Ihrer Konfiguration benutzt werden (falls notwendig).

3.  Fügen Sie einen Eintrag zur Datei `/etc/fstab`{.filename} hinzu, um
    die Änderungen permanent zu machen, damit die RAM-Disk beim nächsten
    Systemneustart automatisch angelegt wird.

    ~~~~ {.programlisting}
    tmpfs                /var/icinga/ramdisk     tmpfs   size=100m        0 0
    ~~~~

4.  Editieren Sie die Icinga Hauptkonfigurationsdatei und ändern Sie die
    Einstellungen der betreffenden Direktiven

    ~~~~ {.programlisting}
     #object_cache_file=/usr/local/icinga/var/objects.cache
     object_cache_file=/var/icinga/ramdisk/objects.cache

     #status_file=/usr/local/icinga/var/status.dat
     status_file=/var/icinga/ramdisk/status.dat
     
     #temp_file=/usr/local/icinga/var/icinga.tmp
     temp_file=/var/icinga/ramdisk/icinga.tmp
    ~~~~

5.  Starten Sie Icinga neu, damit die Änderungen aktiv werden

    ~~~~ {.programlisting}
     #> /etc/init.d/icinga restart
    ~~~~

Möglicherweise möchten Sie die RAM-Disk auch für anderen Dateien wie
z.B. die check results benutzen. Bitte erhöhen Sie die Größe der
RAM-Disk - falls notwendig - und ändern Sie die Direktive in der
Hauptkonfigurationsdatei

~~~~ {.programlisting}
 check_result_path=/var/icinga/ramdisk/checkresults
~~~~

Stellen Sie sicher, dass auch anderen Addons wie z.B. check\_mk diese
Änderungen bekannt sind.

* * * * *

  -------------------------------------------------------------------------- -------------------------- ----------------------------------------------
  [Zurück](perfgraphs.md)                                                  [Nach oben](ch08.md)      [Weiter](ch09.md)
  8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios    [Zum Anfang](index.md)    Kapitel 9. Integration mit anderer Software
  -------------------------------------------------------------------------- -------------------------- ----------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
