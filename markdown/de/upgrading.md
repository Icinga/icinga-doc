![Icinga](../images/logofullsize.png "Icinga")

2.10. Icinga aktualisieren

[Zurück](howtos.md) 

Kapitel 2. Los geht's

 [Weiter](upgrading_idoutils.md)

* * * * *

2.10. Icinga aktualisieren
--------------------------

2.10.1. [Aktualisierung von
Icinga](upgrading.md#upgradepreviousrelease)

2.10.2. [Upgrade von Nagios 3.x](upgrading.md#upgradenagios3x)

2.10.3. [Upgrade von Nagios 2.x](upgrading.md#upgradenagios2x)

2.10.4. [Aktualisierung einer
RPM-Installation](upgrading.md#upgradefromrpm)

![[Anmerkung]](../images/note.png)

Anmerkung

Seit 1.8 finden Sie neue Konfigurationsoptionen, die in einer neuen
Version hinzugefügt wurden, in `sample-config/updates/`{.filename} sowie
`module/idoutils/config/updates`{.filename}, z.B.
`cgi.cfg_added_1.7_to_1.8.cfg`{.filename}.

Der Core wird unbekannte Macros nicht mehr "as is" belassen, sondern
diese entfernen und eine Warnung ins Log schreiben. Entweder korrigieren
Sie die Konfiguration (falsche Macros, Dollarzeichen mit einem weiteren
absichern) oder Sie setzen keep\_unknown\_macros=1 in der
`icinga.cfg`{.filename}-Datei, um zum alten Verhalten zurückzukehren.

Die klassische GUI (Classic UI) liefert kein WAP Interface
(statuswml.cgi) sowie keine 3D Statusmap (statuswrl.cgi) mehr mit, weil
diese nicht mehr aktiv weiterentwickelt und verwendet werden. Aus diesem
Grund wurden auch die Hostkonfigurationsattribute "vrml\_image" und
"3dcoords" als veraltet markiert.

Bitte werfen Sie auch einen Blick in den Abschnitt "CHANGES" in der
Datei `changelog`{.filename}.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie die IDOUtils benutzen, dann müssen Sie auch diese
aktualisieren. Weitere Informationen finden Sie im Abschnitt
[IDOUtils-Datenbank
aktualisieren](upgrading_idoutils.md "2.11. IDOUtils-Datenbank aktualisieren").

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie Icinga Web benutzen, dann müssen Sie auch diese aktualisieren.
Weitere Informationen finden Sie im Abschnitt [Aktualisierung von
Icinga-Web und
Icinga-Web-Datenbank](upgrading_icingaweb.md "6.7. Aktualisierung von Icinga Web und Icinga Web Datenbank").

![[Anmerkung]](../images/note.png)

Anmerkung

Seit 1.9 ist die Direktive `event_profiling_enabled`{.literal} in
`icinga.cfg`{.filename} veraltet.

### 2.10.1. Aktualisierung von Icinga

Sobald neuere Versionen von Icinga herauskommen, sollten Sie dringend
über eine Aktualisierung nachdenken. Neuere Ausgaben enthalten
Behebungen kritischer Fehler, so dass es wichtig ist, aktuell zu sein.
Wenn Sie bereits Icinga, wie in den Schnellstartanleitungen beschrieben,
aus dem Quellcode installiert haben, dann können Sie einfach neuere
Versionen installieren. Sie müssen dazu noch nicht einmal
root-Berechtigungen haben, weil bereits alles passiert ist, was als
root-Benutzer getan werden muss. Das ist allerdings abhängig davon,
welche Präferenzen Sie diesbezüglich haben.

Stellen Sie sicher, dass Sie eine gute Datensicherung Ihrer bestehenden
Icinga-Installation und der Konfigurationsdateien haben. Wenn
irgendetwas schief geht oder nicht funktioniert, dann können Sie auf
diese Weise schnell Ihre alte Icinga-Version wiederherstellen.

Werden Sie der icinga-Benutzer. Debian/Ubuntu-Benutzer sollten
`sudo -s icinga`{.code} benutzen.

~~~~ {.programlisting}
 $> su -l icinga
~~~~

Holen Sie sich das Quellcode-Archiv der letzten Icinga-Version (besuchen
Sie [https://www.icinga.org/](http://www.icinga.org/) für den Verweis
auf die letzte Version) und entpacken Sie das Quellcode-Archiv.

Starten Sie das Icinga-configure-Script mit den gleichen Optionen wie
bei der letzten Installation, z.B. so:

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Icinga 1.9 hat sich der Default geändert, so dass Sie die
Kompilation der IDOUtils ggf. explizit verhindern müssen.

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd --disable-idoutils
~~~~

Kompilieren Sie den Icinga-Quellcode.

~~~~ {.programlisting}
 #> make all
~~~~

Installieren Sie aktualisierte Programme, Dokumentation und
Web-Interface. Ihre vorhandenen Konfigurationsdaten werden in diesem
Schritt nicht überschrieben.

~~~~ {.programlisting}
 #> make install install-base install-cgis install-html install-init install-commandmode install-idoutils
~~~~

Überprüfen Sie Ihre Konfigurationsdateien und starten Sie Icinga erneut.

~~~~ {.programlisting}
 #> /etc/init.d/icinga checkconfig
 #> /etc/init.d/icinga restart
~~~~

**Aktualisieren auf Apache 2.4**

Beginnend mit Apache 2.4 hat sich der Standard-Konfigurationsordner von
`/etc/apache2/conf.d`{.filename} in
`/etc/apache2/conf-available`{.filename} geändert. Wenn Sie migrieren
wollen, dann verschieben Sie einfach die Datei(en), aktivieren die
Konfiguration(en) und starten den Web-Server neu

~~~~ {.screen}
#> mv /etc/apache2/conf.d/icinga*.conf /etc/apache2/conf-available
#> a2enconf icinga icinga-web
#> service apache2 reload
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Hinter `a2enconf`{.literal} geben Sie die Konfiguration(en) an. Das
Beispiel nimmt an, dass Sie Icinga Classic UI und Icinga Web installiert
haben.

Außerdem ist das CGI-Modul zu aktivieren

~~~~ {.screen}
#> a2enmod cgi
~~~~

Das war's - Sie sind fertig!

### 2.10.2. Upgrade von Nagios 3.x

Icinga ist aus Nagios 3.x hervorgegangen, so dass die Aktualisierung
problemlos sein sollte.

Falls Sie einen Upgrade von Nagios-Version 3.0.x durchführen, dann fehlt
Ihnen ggf. PHP.

*Debian / Ubuntu*

~~~~ {.programlisting}
 #> apt-get install php5 libapache2-mod-php5
~~~~

*Fedora / RedHat*

~~~~ {.programlisting}
 #> yum install php mod_php
~~~~

*openSuSE / SLES:* Nutzen Sie yast zur Installation der Pakete *php5*
und *apache2-mod\_php5* oder benutzen Sie zypper

~~~~ {.programlisting}
 #> zypper install php5 apache2-mod_php5
~~~~

Stellen Sie sicher, dass Sie eine gute Datensicherung Ihrer bestehenden
Nagios-Installation und der Konfigurationsdateien haben. Wenn
irgendetwas schief geht oder nicht funktioniert, dann können Sie auf
diese Weise schnell Ihre alte Nagios-Version wiederherstellen.

Bitte installieren Sie Icinga anhand der
[Schnellstart-Anleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen").
Bitte beachten Sie, dass

-   der Default-Präfix nun "`/usr/local/icinga`{.filename}" heißt

-   die Umgebungs-Makros nun mit ICINGA\_ beginnen

    PNP4Nagios berücksichtigt das seit 0.6rc1 (2009.09.20), aber Sie
    benötigen die Makros lediglich im "sync"-Modus.

    check\_multi bietet Unterstützung seit 0.21 (2010.06.03), aber Sie
    müssen dazu die Installation mit beginnend mit dem Schritt
    '`configure --with-nagios_name=icinga`{.code}' erneut durchführen,
    damit die check\_multi-Prozedur mit geänderten Werten erstellt wird.
    Stattdessen können Sie auch die Option "-s" zur Übergabe von Werten
    benutzen.

-   die Konfigurationsdateien der (verbesserten) IDOUtils heißen nun
    `idomod.cfg/ido2db.cfg`{.filename} anstatt
    `ndomod.cfg/ndo2db.cfg`{.filename}

Werden Sie der nagios-Benutzer. Debian/Ubuntu-Benutzer sollten *sudo -s
nagios* benutzen.

~~~~ {.programlisting}
 $ su -l nagios
~~~~

Holen Sie sich das Quellcode-Archiv der letzten Icinga-Version (besuchen
Sie [https://www.icinga.org/](http://www.icinga.org//) für den Verweis
auf die letzte Version).

~~~~ {.programlisting}
 #> wget https://github.com/Icinga/icinga-core/releases/download/v1.13/icinga-1.13.tar.gz
~~~~

Entpacken Sie das Quellcode-Archiv.

~~~~ {.programlisting}
 #> tar xzf icinga-1.13.tar.gz
 #> cd icinga-1.13 
~~~~

Starten Sie das Icinga-configure-Script mit den Optionen, die Sie beim
`./configure`{.code} von Nagios benutzt haben. Den Aufruf finden Sie in
der Datei `config.log`{.filename}. Beispiel:

~~~~ {.programlisting}
 #> ./configure --with-command-group=nagcmd
~~~~

Kompilieren Sie den Icinga-Quellcode.

~~~~ {.programlisting}
 #> make all
~~~~

Installieren Sie aktualisierte Programme, Dokumentation, Web-Interface
und das Init-Script. Ihre vorhandenen Konfigurationsdaten werden in
diesem Schritt nicht überschrieben.

~~~~ {.programlisting}
 #> make cgis
 #> make install
 #> make install-cgis
 #> make install-init
~~~~

oder einfach

~~~~ {.programlisting}
 #> make fullinstall
~~~~

![[Wichtig]](../images/important.png)

Wichtig

Erst ab Icinga 1.5.0 ist `make install-config`{.literal} NICHT mehr in
`make fullinstall `{.literal} enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

Kopieren Sie Ihre Konfigurationsdateien nach
`/usr/local/icinga/etc`{.filename} bzw.
`/usr/local/icinga/etc/object`{.filename}. Vor dem Start von Icinga
müssen Sie noch ein paar Dinge anpassen:

-   Benennen Sie die Hauptkonfigurationsdatei `nagios.cfg`{.filename} in
    `icinga.cfg`{.filename} um und ändern Sie in
    `/usr/local/icinga/etc/icinga.cfg`{.filename} die Namen der
    Direktiven "nagios\_user" in "icinga\_user" und "nagios\_group" in
    "icinga\_group". Das betrifft ggf. auch die Pfade in der Datei.

    ~~~~ {.programlisting}
     #> sed -i 's/nagios/icinga/g' ./icinga.cfg/
    ~~~~

-   Ändern Sie in der CGI-Konfigurationsdatei `cgi.cfg`{.filename} die
    Pfad-Angaben.

    ~~~~ {.programlisting}
     #> sed -i 's/nagios/icinga/g' ./cgi.cfg/
    ~~~~

Kopieren Sie andere relevante Dateien von Ihrer Nagios-Installation zum
neuen Standort. Falls Sie unsicher bezüglich der Pfade sind, dann werfen
Sie einen Blick in die Konfigurationsdateien `nagios.cfg`{.filename}
und/oder `icinga.cfg`{.filename}.

-   `retention.dat`{.filename} (sie enthält bestimmte
    Statusinformationen, Kommentare und andere "bleibende" Dinge)

-   `nagios.log`{.filename} (bitte umbenennen in
    `icinga.log`{.filename})

-   `archives/nagios-<date>.log`{.filename}-Dateien (Icinga ist in der
    Lage, sowohl nagios-\<date\>.log als auch
    icinga-\<date\>.log-Dateien zu verarbeiten, so dass Sie die Dateien
    nicht umbenennen müssen)

-   Sie müssen die Dateien `status.dat`{.filename} und/oder
    `objects.cache`{.filename} nicht kopieren, weil sie jeweils beim
    Neustart erstellt werden. Bitte erstellen Sie
    `objects.precache`{.filename} vor dem Neustart [(falls
    nötig)](configmain.md#configmain-precached_object_file) anstatt
    die Datei zu kopieren

Überprüfen Sie Ihre Konfigurationsdateien und starten Sie Icinga.

~~~~ {.programlisting}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
 #> /etc/init.d/icinga start
~~~~

Das war's - Sie sind fertig!

Bitte beachten Sie, dass

-   der Aufruf im Browser nun http://localhost/icinga/ lautet (für das
    klassische UI)

-   der Name des Admin-Benutzers nun icingaadmin lautet

### 2.10.3. Upgrade von Nagios 2.x

Es sollte nicht allzu schwierig sein, von Nagios 2.x auf Icinga 1.13 zu
aktualisieren. Die Aktualisierung ist im Wesentlichen die gleiche wie
die von bestehenden Nagios 3.x-Versionen. Allerdings müssen Sie Ihre
Konfigurationsdateien ein wenig ändern, damit sie mit Icinga 1.13
funktionieren:

-   Die alte *service\_reaper\_frequency*-Variable in der
    Hauptkonfigurationsdatei wurde umbenannt in
    [check\_result\_reaper\_frequency](configmain.md#configmain-check_result_reaper_frequency).

-   Das alte *\$NOTIFICATIONNUMBER\$*-Makro entfällt zugunsten der
    [\$HOSTNOTIFICATIONNUMBER\$](macrolist.md#macrolist-hostnotificationnumber)-
    und
    [\$SERVICENOTIFICATIONNUMBER\$](macrolist.md#macrolist-servicenotificationnumber)-Makros.

-   Die alte *parallelize*-Direktive in Service-Definitionen ist
    veraltet und wird nicht länger benutzt, weil alle Service-Prüfungen
    parallel ablaufen.

-   Die alte *aggregate\_status\_updates*-Option wurde entfernt. Alle
    Statusdatei-Aktualisierungen werden nun mit einem minimalen
    Intervall von einer Sekunde zusammengefasst.

-   Erweiterte Host- und erweiterte Service-Definitionen sind veraltet.
    Sie werden noch von Icinga gelesen und verarbeitet, aber es wird
    empfohlen, dass Sie diese Direktiven in die entsprechenden Host- und
    Service-Definitionen verschieben.

-   Die alte *downtime\_file*-Dateivariable in der
    Hauptkonfigurationsdatei wird nicht länger unterstützt, weil
    Einträge von geplanten Ausfallzeiten (downtimes) nun in der
    [Aufbewahrungsdatei](configmain.md#configmain-state_retention_file)
    (retention file) gespeichert werden. Um bestehende Einträge zu
    erhalten, stoppen Sie Nagios 2.x und hängen Sie den Inhalt Ihrer
    alten Downtime-Datei an das "retention file".

-   Die alte *comment\_file*-Dateivariable in der
    Hauptkonfigurationsdatei wird nicht länger unterstützt, weil
    Kommentare nun in der
    [Aufbewahrungsdatei](configmain.md#configmain-state_retention_file)
    (retention file) gespeichert werden. Um bestehende Einträge zu
    erhalten, stoppen Sie Nagios 2.x und hängen Sie den Inhalt Ihrer
    alten Kommentar-Datei an die "Aufbewahrungsdatei" (retention file).

-   Die Hauptkonfigurationsdatei heißt nun icinga.cfg. Innerhalb der
    Datei ist "nagios\_user" gegen "icinga\_user" und nagios\_group"
    gegen "icinga\_group" auszutauschen.

Stellen Sie außerdem sicher, dass Sie den "[Was gibt's
Neues](whatsnew.md "1.2. What's New in Icinga 1.13")"-Abschnitt in der
Dokumentation lesen. Er beschreibt all die Änderungen am Icinga-Code.

### 2.10.4. Aktualisierung einer RPM-Installation

Wenn Sie momentan eine RPM- oder Debian/Ubuntu-APT-paketbasierte
Nagios-Installation haben und nun den Übergang zu einer Installation aus
dem offiziellen Quellcode machen wollen, dann sind hier die
grundlegenden Schritte:

1.  Sichern Sie Ihre existierende Nagios-Installation

2.  Konfigurationsdateien

    -   -   Hauptkonfigurationsdatei (normalerweise
            `nagios.cfg`{.filename})

        -   Ressource-Konfigurationsdatei (normalerweise
            `resource.cfg`{.filename})

        -   CGI-Konfigurationsdatei (normalerweise `cgi.cfg`{.filename})

        -   all Ihre Objektdefinitionsdateien

    -   Aufbewahrungsdatei (normalerweise `retention.dat`{.filename})

    -   die aktuelle Nagios-Protokolldatei (normalerweise
        `nagios.log`{.filename})

    -   archivierte Nagios-Protokolldateien

3.  Deinstallieren Sie die originalen RPM- oder APT-Pakete

4.  Installieren Sie Icinga aus dem Quellcode, indem Sie der
    [Schnellstartanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
    folgen

5.  Sichern Sie Ihre Original-Nagios-Konfigurationsdateien,
    Aufbewahrungs- und Protokolldateien wieder zurück

6.  Benennen Sie die Hauptkonfigurationsdatei `nagios.conf`{.filename}
    in `icinga.conf`{.filename} um und ändern Sie in
    /usr/local/icinga/etc/icinga.cfg die Namen der Direktiven
    "nagios\_user" in "icinga\_user" und "nagios\_group" in
    "icinga\_group".

7.  [Überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration")
    Sie Ihre Konfiguration und
    [starten](startstop.md "4.2. Icinga starten und stoppen") Sie
    Icinga

Beachten Sie, dass verschiedene RPM- oder APT-Pakete Nagios auf
verschiedene Weisen oder an verschiedenen Orten installieren. Stellen
Sie sicher, dass Sie all Ihre kritischen Nagios-Dateien gesichert haben,
bevor Sie das Original-RPM- oder APT-Paket entfernen, so dass Sie darauf
zurückgreifen können, wenn Sie auf Probleme stoßen.

* * * * *

  -------------------------------- -------------------------- -----------------------------------------
  [Zurück](howtos.md)            [Nach oben](ch02.md)      [Weiter](upgrading_idoutils.md)
  2.9. Links zu weiteren Howtos    [Zum Anfang](index.md)    2.11. IDOUtils-Datenbank aktualisieren
  -------------------------------- -------------------------- -----------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
