![Icinga](../images/logofullsize.png "Icinga")

9.4. MKLiveStatus-Integration

[Zurück](int-tcpwrappers.md) 

Kapitel 9. Integration mit anderer Software

 [Weiter](reporting.md)

* * * * *

9.4. MKLiveStatus-Integration
-----------------------------

9.4.1. [Einführung](int-mklivestatus.md#introduction)

9.4.2. [Installation /
Konfiguration](int-mklivestatus.md#installconfig)

### 9.4.1. Einführung

MKLiveStatus ist ein Modul von Mathias Kettner zur Anbindung von
verschiedene Addons wie z.B. NagVis oder Thruk an Icinga (oder Nagios).
Solange Sie keine Datenbank zur Speicherung von historischen Werten
benötigen, könnte dies eine gute Wahl sein, weil es relativ klein und
einfach zu installieren ist. Auf der [offiziellen
Website](http://mathias-kettner.de/checkmk_livestatus.md) finden Sie
die komplette Dokumenation, denn hier beschreiben wir nur in sehr kurzer
Form die Installation und Konfiguration von MKLiveStatus für Icinga. Wir
nehmen an, dass Sie Icinga in */usr/local/icinga* installiert haben.

### 9.4.2. Installation / Konfiguration

1.  Laden Sie die Software und kompilieren Sie das Modul (bitte schauen
    Sie auf der Website nach der aktuellsten Version)

    ~~~~ {.programlisting}
     wget http://mathias-kettner.de/download/mk-livestatus-1.2.4.tar.gz
     tar xzvf mk-livestatus-1.2.4.tar.gz
     cd mk-livestatus-1.2.4
     ./configure --prefix=/usr/local/icinga --exec-prefix=/usr/local/icinga
     make
     cp src/livestatus.o /usr/local/icinga/bin
    ~~~~

2.  Editieren Sie *icinga.cfg*, um das Modul zu integrieren. Stellen Sie
    sicher, dass das Verzeichnis */usr/local/icinga/var/rw* existiert
    und dass der Icinga-Benutzer dort Schreibrechte hat. Es sollte das
    gleiche Verzeichnis sein, das auch für das Command File (meistens
    icinga.cmd) benutzt wird. "live" ist ein Socket, der nur während der
    Laufzeit des Moduls vorhanden ist.

    ` broker_module=/usr/local/icinga/bin/livestatus.o /usr/local/icinga/var/rw/live`{.code}

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Ab Icinga 1.4 können Sie **anstatt** des broker\_module-Eintrags die
    neue module-Definition in einer Ihrer Objektkonfigurationsdateien
    benutzen:

    ~~~~ {.programlisting}
     define module{
            module_name    mklivestatus
            path           /usr/local/icinga/bin/livestatus.o
            module_type    neb
            args           /usr/local/icinga/var/rw/live
            }
    ~~~~

3.  Restarten Sie Icinga

    ~~~~ {.programlisting}
     service icinga restart
    ~~~~

    oder

    ~~~~ {.programlisting}
     /etc/init.d/icinga restart
    ~~~~

4.  Prüfen Sie, ob das Modul läuft

    ~~~~ {.programlisting}
     ps -ef | grep livestatus
     ls -la /usr/local/icinga/var/rw/live
    ~~~~

    Falls es keinen Prozess und/oder keinen Socket gibt, dann prüfen Sie
    das Icinga-Log und bereinigen Sie vorhandene Fehler.

* * * * *

  --------------------------------- -------------------------- ------------------------------------------------------------------
  [Zurück](int-tcpwrappers.md)    [Nach oben](ch09.md)      [Weiter](reporting.md)
  9.3. TCP-Wrapper-Integration      [Zum Anfang](index.md)    9.5. Installation von Icinga Reporting mit JasperReports Server
  --------------------------------- -------------------------- ------------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
