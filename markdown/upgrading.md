NAME-ICINGA aktualisieren
=========================

> **Note**
>
> Seit 1.8 finden Sie neue Konfigurationsoptionen, die in einer neuen
> Version hinzugefügt wurden, in `sample-config/updates/` sowie
> `module/idoutils/config/updates`, z.B. `cgi.cfg_added_1.7_to_1.8.cfg`.
>
> *Der Core wird unbekannte Macros nicht mehr "as is" belassen, sondern
> diese entfernen und eine Warnung ins Log schreiben.* Entweder
> korrigieren Sie die Konfiguration (falsche Macros, Dollarzeichen mit
> einem weiteren absichern) oder Sie setzen keep\_unknown\_macros=1 in
> der `icinga.cfg`-Datei, um zum alten Verhalten zurückzukehren.
>
> Die klassische GUI (Classic UI) liefert kein WAP Interface
> (statuswml.cgi) sowie keine 3D Statusmap (statuswrl.cgi) mehr mit,
> weil diese nicht mehr aktiv weiterentwickelt und verwendet werden. Aus
> diesem Grund wurden auch die Hostkonfigurationsattribute "vrml\_image"
> und "3dcoords" als veraltet markiert.
>
> Bitte werfen Sie auch einen Blick in den Abschnitt "CHANGES" in der
> Datei `changelog`.

Aktualisieren (upgrading)
> **Note**
>
> Wenn Sie die NAME-IDOUTILS benutzen, dann müssen Sie auch diese
> aktualisieren. Weitere Informationen finden Sie im Abschnitt
> [IDOUtils-Datenbank aktualisieren](#upgrading_idoutils).

> **Note**
>
> Wenn Sie NAME-WEB benutzen, dann müssen Sie auch diese aktualisieren.
> Weitere Informationen finden Sie im Abschnitt [Aktualisierung von
> Icinga-Web und Icinga-Web-Datenbank](#upgrading_icingaweb).

> **Note**
>
> Seit 1.9 ist die Direktive `event_profiling_enabled` in `icinga.cfg`
> veraltet.

Aktualisierung von NAME-ICINGA
------------------------------

Sobald neuere Versionen von NAME-ICINGA herauskommen, sollten Sie
dringend über eine Aktualisierung nachdenken. Neuere Ausgaben enthalten
Behebungen kritischer Fehler, so dass es wichtig ist, aktuell zu sein.
Wenn Sie bereits NAME-ICINGA, wie in den Schnellstartanleitungen
beschrieben, aus dem Quellcode installiert haben, dann können Sie
einfach neuere Versionen installieren. Sie müssen dazu noch nicht einmal
root-Berechtigungen haben, weil bereits alles passiert ist, was als
root-Benutzer getan werden muss. Das ist allerdings abhängig davon,
welche Präferenzen Sie diesbezüglich haben.

Stellen Sie sicher, dass Sie eine gute Datensicherung Ihrer bestehenden
NAME-ICINGA-Installation und der Konfigurationsdateien haben. Wenn
irgendetwas schief geht oder nicht funktioniert, dann können Sie auf
diese Weise schnell Ihre alte NAME-ICINGA-Version wiederherstellen.

Werden Sie der icinga-Benutzer. Debian/Ubuntu-Benutzer sollten
`sudo -s icinga` benutzen.

     $> su -l icinga

Holen Sie sich das Quellcode-Archiv der letzten NAME-ICINGA-Version
(besuchen Sie [URL-ICINGA](http://www.icinga.org/) für den Verweis auf
die letzte Version) und entpacken Sie das Quellcode-Archiv.

Starten Sie das NAME-ICINGA-configure-Script mit den gleichen Optionen
wie bei der letzten Installation, z.B. so:

     #> ./configure --with-command-group=icinga-cmd --enable-idoutils

Kompilieren Sie den NAME-ICINGA-Quellcode.

     #> make all

Installieren Sie aktualisierte Programme, Dokumentation und
Web-Interface. Ihre vorhandenen Konfigurationsdaten werden in diesem
Schritt nicht überschrieben.

     #> make install install-base install-cgis install-html install-init install-commandmode install-idoutils

Überprüfen Sie Ihre Konfigurationsdateien und starten Sie NAME-ICINGA
erneut.

     #> /etc/init.d/icinga checkconfig
     #> /etc/init.d/icinga restart

Das war's - Sie sind fertig!

Aktualisieren (upgrading)
einer früheren NAME-ICINGA-Version
Upgrade von NAME-NAGIOS 3.x
---------------------------

NAME-ICINGA ist aus NAME-NAGIOS 3.x hervorgegangen, so dass die
Aktualisierung problemlos sein sollte.

Falls Sie einen Upgrade von NAME-NAGIOS-Version 3.0.x durchführen, dann
fehlt Ihnen ggf. PHP.

*Debian / Ubuntu*

     #> apt-get install php5 libapache2-mod-php5

*Fedora / RedHat*

     #> yum install php mod_php

*openSuSE / SLES:* Nutzen Sie yast zur Installation der Pakete *php5*
und *apache2-mod\_php5* oder benutzen Sie zypper

     #> zypper install php5 apache2-mod_php5

Stellen Sie sicher, dass Sie eine gute Datensicherung Ihrer bestehenden
NAME-NAGIOS-Installation und der Konfigurationsdateien haben. Wenn
irgendetwas schief geht oder nicht funktioniert, dann können Sie auf
diese Weise schnell Ihre alte NAME-NAGIOS-Version wiederherstellen.

Bitte installieren Sie NAME-ICINGA anhand der
[Schnellstart-Anleitung](#quickstart). Bitte beachten Sie, dass

-   der Default-Präfix nun "`/usr/local/icinga`" heißt

-   die Umgebungs-Makros nun mit ICINGA\_ beginnen

    PNP4Nagios berücksichtigt das seit 0.6rc1 (2009.09.20), aber Sie
    benötigen die Makros lediglich im "sync"-Modus.

    check\_multi bietet Unterstützung seit 0.21 (2010.06.03), aber Sie
    müssen dazu die Installation mit beginnend mit dem Schritt
    '`configure --with-nagios_name=icinga`' erneut durchführen, damit
    die check\_multi-Prozedur mit geänderten Werten erstellt wird.
    Stattdessen können Sie auch die Option "-s" zur Übergabe von Werten
    benutzen.

-   die Konfigurationsdateien der (verbesserten) IDOUtils heißen nun
    `idomod.cfg/ido2db.cfg` anstatt `ndomod.cfg/ndo2db.cfg`

Werden Sie der nagios-Benutzer. NAME-DEBIAN/NAME-UBUNTU-Benutzer sollten
*sudo -s nagios* benutzen.

     $ su -l nagios

Holen Sie sich das Quellcode-Archiv der letzten NAME-ICINGA-Version
(besuchen Sie [URL-ICINGA](http://www.icinga.org//) für den Verweis auf
die letzte Version).

     #> wget http://osdn.dl.sourceforge.net/sourceforge/icinga/icinga-.tar.gz

Entpacken Sie das Quellcode-Archiv.

     #> tar xzf icinga-.tar.gz
     #> cd icinga- 

Starten Sie das NAME-ICINGA-configure-Script mit den Optionen, die Sie
beim `./configure` von NAME-NAGIOS benutzt haben. Den Aufruf finden Sie
in der Datei `config.log`. Beispiel:

     #> ./configure --with-command-group=nagcmd

Kompilieren Sie den NAME-ICINGA-Quellcode.

     #> make all

Installieren Sie aktualisierte Programme, Dokumentation, Web-Interface
und das Init-Script. Ihre vorhandenen Konfigurationsdaten werden in
diesem Schritt nicht überschrieben.

     #> make cgis
     #> make install
     #> make install-cgis
     #> make install-init

oder einfach

     #> make fullinstall

> **Important**
>
> Erst ab NAME-ICINGA 1.5.0 ist `make install-config` NICHT mehr in
> `make fullinstall ` enthalten, um ein versehentliches Überschreiben
> der Konfigurationsdateien zu verhindern.

Kopieren Sie Ihre Konfigurationsdateien nach `URL-ICINGA-BASE/etc` bzw.
`URL-ICINGA-BASE/etc/object`. Vor dem Start von NAME-ICINGA müssen Sie
noch ein paar Dinge anpassen:

-   Benennen Sie die Hauptkonfigurationsdatei `nagios.cfg` in
    `icinga.cfg` um und ändern Sie in `` die Namen der Direktiven
    "nagios\_user" in "icinga\_user" und "nagios\_group" in
    "icinga\_group". Das betrifft ggf. auch die Pfade in der Datei.

         #> sed -i 's/nagios/icinga/g' ./icinga.cfg/

-   Ändern Sie in der CGI-Konfigurationsdatei `cgi.cfg` die
    Pfad-Angaben.

         #> sed -i 's/nagios/icinga/g' ./cgi.cfg/

Kopieren Sie andere relevante Dateien von Ihrer NAME-NAGIOS-Installation
zum neuen Standort. Falls Sie unsicher bezüglich der Pfade sind, dann
werfen Sie einen Blick in die Konfigurationsdateien `nagios.cfg`
und/oder `icinga.cfg`.

-   `retention.dat` (sie enthält bestimmte Statusinformationen,
    Kommentare und andere "bleibende" Dinge)

-   `nagios.log` (bitte umbenennen in `icinga.log`)

-   `archives/nagios-<date>.log`-Dateien (NAME-ICINGA ist in der Lage,
    sowohl nagios-\<date\>.log als auch icinga-\<date\>.log-Dateien zu
    verarbeiten, so dass Sie die Dateien nicht umbenennen müssen)

-   Sie müssen die Dateien `status.dat` und/oder `objects.cache` nicht
    kopieren, weil sie jeweils beim Neustart erstellt werden. Bitte
    erstellen Sie `objects.precache` vor dem Neustart [(falls
    nötig)](#configmain-precached_object_file) anstatt die Datei zu
    kopieren

Überprüfen Sie Ihre Konfigurationsdateien und starten Sie NAME-ICINGA.

     #> URL-ICINGA-BIN -v URL-ICINGA-CFG
     #> /etc/init.d/icinga start

Das war's - Sie sind fertig!

Bitte beachten Sie, dass

-   der Aufruf im Browser nun http://localhost/icinga/ lautet (für das
    klassische UI)

-   der Name des Admin-Benutzers nun icingaadmin lautet

Aktualisieren (upgrading)
von NAME-NAGIOS Version 3.x
Nagios
von NAME-NAGIOS nach NAME-ICINGA migrieren
Migration
von NAME-NAGIOS nach NAME-ICINGA
Upgrade von NAME-NAGIOS 2.x
---------------------------

Es sollte nicht allzu schwierig sein, von NAME-NAGIOS 2.x auf
NAME-ICINGA VER-ICINGA zu aktualisieren. Die Aktualisierung ist im
Wesentlichen die gleiche wie die von bestehenden NAME-NAGIOS
3.x-Versionen. Allerdings müssen Sie Ihre Konfigurationsdateien ein
wenig ändern, damit sie mit NAME-ICINGA VER-ICINGA funktionieren:

-   Die alte *service\_reaper\_frequency*-Variable in der
    Hauptkonfigurationsdatei wurde umbenannt in
    [check\_result\_reaper\_frequency](#configmain-check_result_reaper_frequency).

-   Das alte *\$NOTIFICATIONNUMBER\$*-Makro entfällt zugunsten der
    [\$HOSTNOTIFICATIONNUMBER\$](#macrolist-hostnotificationnumber)- und
    [\$SERVICENOTIFICATIONNUMBER\$](#macrolist-servicenotificationnumber)-Makros.

-   Die alte *parallelize*-Direktive in Service-Definitionen ist
    veraltet und wird nicht länger benutzt, weil alle Service-Prüfungen
    parallel ablaufen.

-   Die alte *aggregate\_status\_updates*-Option wurde entfernt. Alle
    Statusdatei-Aktualisierungen werden nun mit einem minimalen
    Intervall von einer Sekunde zusammengefasst.

-   Erweiterte Host- und erweiterte Service-Definitionen sind veraltet.
    Sie werden noch von NAME-ICINGA gelesen und verarbeitet, aber es
    wird empfohlen, dass Sie diese Direktiven in die entsprechenden
    Host- und Service-Definitionen verschieben.

-   Die alte *downtime\_file*-Dateivariable in der
    Hauptkonfigurationsdatei wird nicht länger unterstützt, weil
    Einträge von geplanten Ausfallzeiten (downtimes) nun in der
    [Aufbewahrungsdatei](#configmain-state_retention_file) (retention
    file) gespeichert werden. Um bestehende Einträge zu erhalten,
    stoppen Sie NAME-NAGIOS 2.x und hängen Sie den Inhalt Ihrer alten
    Downtime-Datei an das "retention file".

-   Die alte *comment\_file*-Dateivariable in der
    Hauptkonfigurationsdatei wird nicht länger unterstützt, weil
    Kommentare nun in der
    [Aufbewahrungsdatei](#configmain-state_retention_file) (retention
    file) gespeichert werden. Um bestehende Einträge zu erhalten,
    stoppen Sie NAME-NAGIOS 2.x und hängen Sie den Inhalt Ihrer alten
    Kommentar-Datei an die "Aufbewahrungsdatei" (retention file).

-   Die Hauptkonfigurationsdatei heißt nun icinga.cfg. Innerhalb der
    Datei ist "nagios\_user" gegen "icinga\_user" und nagios\_group"
    gegen "icinga\_group" auszutauschen.

Stellen Sie außerdem sicher, dass Sie den "[Was gibt's
Neues](#whatsnew)"-Abschnitt in der Dokumentation lesen. Er beschreibt
all die Änderungen am NAME-ICINGA-Code.

Aktualisierung einer RPM-Installation
-------------------------------------

Wenn Sie momentan eine RPM- oder
NAME-DEBIAN/NAME-UBUNTU-APT-paketbasierte NAME-NAGIOS-Installation haben
und nun den Übergang zu einer Installation aus dem offiziellen Quellcode
machen wollen, dann sind hier die grundlegenden Schritte:

1.  Sichern Sie Ihre existierende NAME-NAGIOS-Installation

2.  Konfigurationsdateien

    -   -   Hauptkonfigurationsdatei (normalerweise `nagios.cfg`)

        -   Ressource-Konfigurationsdatei (normalerweise `resource.cfg`)

        -   CGI-Konfigurationsdatei (normalerweise `cgi.cfg`)

        -   all Ihre Objektdefinitionsdateien

    -   Aufbewahrungsdatei (normalerweise `retention.dat`)

    -   die aktuelle NAME-NAGIOS-Protokolldatei (normalerweise
        `nagios.log`)

    -   archivierte NAME-NAGIOS-Protokolldateien

3.  Deinstallieren Sie die originalen RPM- oder APT-Pakete

4.  Installieren Sie NAME-ICINGA aus dem Quellcode, indem Sie der
    [Schnellstartanleitung](#quickstart) folgen

5.  Sichern Sie Ihre Original-NAME-NAGIOS-Konfigurationsdateien,
    Aufbewahrungs- und Protokolldateien wieder zurück

6.  Benennen Sie die Hauptkonfigurationsdatei `nagios.conf` in
    `icinga.conf` um und ändern Sie in URL-ICINGA-CFG die Namen der
    Direktiven "nagios\_user" in "icinga\_user" und "nagios\_group" in
    "icinga\_group".

7.  [Überprüfen](#verifyconfig) Sie Ihre Konfiguration und
    [starten](#startstop) Sie NAME-ICINGA

Beachten Sie, dass verschiedene RPM- oder APT-Pakete NAME-NAGIOS auf
verschiedene Weisen oder an verschiedenen Orten installieren. Stellen
Sie sicher, dass Sie all Ihre kritischen NAME-NAGIOS-Dateien gesichert
haben, bevor Sie das Original-RPM- oder APT-Paket entfernen, so dass Sie
darauf zurückgreifen können, wenn Sie auf Probleme stoßen.

Aktualisieren (upgrading)
von NAME-NAGIOS Version 2.x
