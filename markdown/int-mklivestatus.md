MKLiveStatus-Integration
========================

Einführung
----------

MKLiveStatus ist ein Modul von Mathias Kettner zur Anbindung von
verschiedene Addons wie z.B. NAME-NAGVIS oder NAME-THRUK an NAME-ICINGA
(oder NAME-NAGIOS). Solange Sie keine Datenbank zur Speicherung von
historischen Werten benötigen, könnte dies eine gute Wahl sein, weil es
relativ klein und einfach zu installieren ist. Auf der [offiziellen
Website](http://mathias-kettner.de/checkmk_livestatus.html) finden Sie
die komplette Dokumenation, denn hier beschreiben wir nur in sehr kurzer
Form die Installation und Konfiguration von NAME-MKLIVE für NAME-ICINGA.
Wir nehmen an, dass Sie NAME-ICINGA in */usr/local/icinga* installiert
haben.

Installation / Konfiguration
----------------------------

1.  Laden Sie die Software und kompilieren Sie das Modul (bitte schauen
    Sie auf der Website nach der aktuellsten Version)

         wget http://mathias-kettner.de/download/mk-livestatus-VER-MKLIVE.tar.gz
         tar xzvf mk-livestatus-VER-MKLIVE.tar.gz
         cd mk-livestatus-VER-MKLIVE
         ./configure --prefix=/usr/local/icinga --exec-prefix=/usr/local/icinga
         make
         cp src/livestatus.o /usr/local/icinga/bin

2.  Editieren Sie *icinga.cfg*, um das Modul zu integrieren. Stellen Sie
    sicher, dass das Verzeichnis */usr/local/icinga/var/rw* existiert
    und dass der Icinga-Benutzer dort Schreibrechte hat. Es sollte das
    gleiche Verzeichnis sein, das auch für das Command File (meistens
    icinga.cmd) benutzt wird. "live" ist ein Socket, der nur während der
    Laufzeit des Moduls vorhanden ist.

    ` broker_module=/usr/local/icinga/bin/livestatus.o /usr/local/icinga/var/rw/live`

    > **Note**
    >
    > Ab NAME-ICINGA 1.4 können Sie **anstatt** des
    > broker\_module-Eintrags die neue module-Definition in einer Ihrer
    > Objektkonfigurationsdateien benutzen:
    >
    >      define module{
    >             module_name    mklivestatus
    >             path           URL-ICINGA-BASE/bin/livestatus.o
    >             module_type    neb
    >             args           URL-ICINGA-BASE/var/rw/live
    >             }

3.  Restarten Sie NAME-ICINGA

         service icinga restart

    oder

         /etc/init.d/icinga restart

4.  Prüfen Sie, ob das Modul läuft

         ps -ef | grep livestatus
         ls -la /usr/local/icinga/var/rw/live

    Falls es keinen Prozess und/oder keinen Socket gibt, dann prüfen Sie
    das NAME-ICINGA-Log und bereinigen Sie vorhandene Fehler.

MKLiveStatus-Integration
Addons
MKLiveStatus-Integration
