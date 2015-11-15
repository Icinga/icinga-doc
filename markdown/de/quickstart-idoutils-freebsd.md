![Icinga](../images/logofullsize.png "Icinga")

2.7. Icinga-Schnellstart mit IDOUtils auf FreeBSD

[Zurück](quickstart-idoutils.md) 

Kapitel 2. Los geht's

 [Weiter](icinga_packages.md)

* * * * *

2.7. Icinga-Schnellstart mit IDOUtils auf FreeBSD
-------------------------------------------------

**Einführung**

![[Anmerkung]](../images/note.png)

Anmerkung

Anstatt Icinga von Grund auf zu installieren möchten Sie vielleicht ein
Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt. Bitte
werfen Sie einen Blick auf die [Tabelle der
Pakete](https://www.icinga.org/download/packages).

Bitte bedenken Sie, dass die Upstream-Pakete evtl. relativ alt sind, so
dass die Verwendung von Backports-Paketen ein Weg ist, eine aktuelle
Version zu bekommen. Bitte werfen Sie einen Blick auf die
(englischsprachigen) Wiki-Artikel für detaillierte Informationen:

-   [Debian](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Debian)

-   [Ubuntu](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Ubuntu)

-   [RHEL/CentOS](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+RHEL)

Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs.

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem haben,
das in der aktuellen Entwicklerversion ggf. gelöst ist.

Diese Schnellstartanleitung ist dazu gedacht, Ihnen einfache Anweisungen
zu liefern, wie Sie Icinga innerhalb von 30 Minuten aus dem Quellcode
installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für
[FreeBSD](http://www.freebsd.org/) 8.1-RELEASE. Dank an
["ScotchTape"](http://www.monitoring-portal.org/wbb/index.php?page=User&userID=8925)
für die angepassten Anweisungen.

Spätere Distributionen von FreeBSD werden wahrscheinlich auch mit diesen
Anweisungen funktionieren.

![[Anmerkung]](../images/note.png)

Anmerkung

Inzwischen gibt es einen FreeBSD-Port von Icinga (net-mgmt/icinga), so
dass Sie den vielleicht installieren möchten ;-)

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   Icinga und die Plugins werden unterhalb von /usr/local/icinga
    installiert sein

-   Icinga wird so konfiguriert sein, dass es einige Dinge auf Ihrem
    lokalen System überwacht (CPU-Auslastung, Plattenbelegung, usw.)

-   das klassische Icinga-Web-Interface ist erreichbar unter
    `http://localhost/icinga/`{.uri} oder
    `http://yourdomain.com/icinga/`{.uri}

-   eine Datenbank, die von Icinga mit Hilfe der IDOUtils gefüllt wird

**Voraussetzungen**

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

IDOUtils benutzt die [libdbi](http://libdbi.sourceforge.net) und die
libdbi-Treiber für verschiedene Datenbanken. Die Development-Libraries
werden ebenfalls benötigt. Die folgenden Beispiele zeigen, wie die
IDOUtils mit libdbi für MySQL oder PostgreSQL installiert werden.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   [Apache](http://www.apache.org)

-   GCC-compiler

-   [GD](http://www.boutell.com/gd/) development libraries

-   libdbi-Treiber, eine Datenbank wie z.B. MySQL oder PostgreSQL

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    PostgreSQL: Aufgrund von Änderungen an Insert-Statements
    funktioniert PostgreSQL 8.1 nicht länger (und ist auch bereits
    ["End-of-life"](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    seit November 2010), also benutzen Sie bitte 8.2 oder besser noch
    8.4. String escaping mit PostgreSQL 9.x befindet sich noch in einem
    experimentellen Stadium (siehe auch [issue
    \#1974](https://dev.icinga.org/issues/1974)).

**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

**Neue Features für die IDOUtils:**

**SSL-Verschlüsselung zwischen idomod und ido2db**

Wenn Sie **SSL-Verschlüsselung**verwenden möchten: diese ist bereits
installiert.

![[Anmerkung]](../images/note.png)

Anmerkung

SSL muss auch bei allen idomod-Clients aktiviert werden, sonst gehen
Daten verloren!!!

**Oracle-Datenbankunterstützung**

Wenn Sie Oracle als RDBMS einsetzen möchten, dann ist das unter FreeBSD
leider nicht so ohne weiteres möglich.

**Zeitzonenunterstützung**

Alle Zeit-/Datumsinformationen werden als lokale Zeitstempel in der
Datenbank gespeichert. Als Datentypen werden TIMESTAMP für MySQL, LOCAL
TIMESTAMP (0) für Oracle und TIMESTAMP WITH TIME ZONE für PostgreSQL
benutzt. IDO2DB wird die Sitzungszeitzone auf UTC setzen und alle
Unix-Timestamps (die per Definition UTC sind) als UTC-basierte Werte
speichern. Bitte stellen Sie sicher, dass Ihr System Unix-Timestamps als
UTC-basierte Werte ausgibt (wie "date -u '+%s'").

![[Anmerkung]](../images/note.png)

Anmerkung

Stellen Sie sicher, dass Ihre Datenbanksitzung in der gleichen Zeitzone
läuft, in der die existierenden Zeit-/Datumsinformationen gespeichert
wurden (überprüfen Sie Ihre lokale Zeitzone, z.B. Oracle: "select
sessiontimezone from dual;"), wenn Sie das Upgrade-Script laufen lassen.
Zusätzlich für Ihre Bequemlichkeit sollten Sie in Oracle das Format der
Sitzungszeitstempel auf den Wert zu setzen, den Sie wünschen, z.B.
"alter session set nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS'; oder
etwas ähnliches. Nun können Sie Einträge von verschiedenen
Icinga-Installationen in unterschiedlichen Zeitzonen ansehen, die in der
gleichen Datenbank gespeichert wurden, und unabhängig davon, von woher
Sie darauf zugreifen, werden sie in Ihrer lokalen Zeitzone angezeigt.

**Installation der Pakete**

Sie können diese Pakete aus den Ports installieren oder Sie nehmen
fertige und evtl. ältere packages (siehe FreeBSD-Schnellstart):

**Installieren Sie die Ports**

Sie können diese Ports mit den folgenden Befehlen installieren, es
empfiehlt sich aber, portupgrade oder portmaster zu verwenden (als
root):

Bitte aktualisieren Sie Ihre Ports bevor Sie beginnen.

~~~~ {.programlisting}
 #> cd /usr/ports/devel/libtool/ && make all install clean
 #> cd /usr/ports/graphics/jpeg && make all install clean
 #> cd /usr/ports/graphics/png && make all install clean
 #> cd /usr/ports/graphics/gd && make all install clean
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte stellen Sie sicher, dass Apache installiert ist - das Vorgehen
wird hier nicht beschrieben, aber ein Hinweis ist

~~~~ {.programlisting}
#> cd /usr/ports/www/apache22 && make clean && make
~~~~

.

~~~~ {.programlisting}
 #> cd /usr/ports/devel/gmake && make all install clean 
 #> cd /usr/ports/devel/libltdl && make all install clean <-- wenn noch nicht installiert
~~~~

**MySQL**

~~~~ {.programlisting}
 #> cd /usr/ports/databases/mysql51-server && make all install clean 
 #> cd /usr/ports/databases/libdbi-drivers && make all install clean
~~~~

dort den richtigen Treiber für die DB auswählen

**PostgreSQL**

~~~~ {.programlisting}
 #> cd /usr/ports/databases/postgresql84-server && make all install clean 
 #> cd /usr/ports/databases/libdbi-drivers && make all install clean
~~~~

dort den richtigen Treiber für die DB auswählen

**Benutzerinformationen erstellen**

Werden Sie zum root-Benutzer.

~~~~ {.programlisting}
 #> su -l
~~~~

Erstellen Sie ein neues Benutzerkonto *icinga* ohne Passwort und ohne
die Möglichkeit, sich anzumelden (setzen Sie kein Passwort, wenn Sie
danach gefragt werden):

~~~~ {.programlisting}
 #> adduser -D -w no -s nologin
~~~~

Damit Sie über das klassische Webinterface Befehle an Icinga senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Web-Server-Benutzer (www) und den Icinga-Benutzer dieser Gruppe hinzu:

~~~~ {.programlisting}
 #> pw groupadd -n icinga-cmd -M icinga,www 
~~~~

**Icinga und die Plugins herunterladen**

Wechseln Sie in Ihr lokales Source-Verzeichnis, z.B. \~/src

~~~~ {.programlisting}
 #> mkdir ~/src
 #> cd ~/src
~~~~

Laden Sie die Sourcen von der [Icinga Website](http://www.icinga.org/).

Vergessen Sie nicht die [Monitoring
Plugins](https://www.monitoring-plugins.org/).

**Icinga und IDOUtils kompilieren und installieren**

Entpacken Sie das Icinga-Archiv (oder wechseln Sie in den GIT-Snapshot)

~~~~ {.programlisting}
 #> cd ~/src/ 
 #> tar xvzf icinga-1.13.tar.gz 
 #> cd icinga-1.13
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Dieser absolute Pfad ist gemeint, wenn im Nachfolgenden von
'/path/to/icinga-src/' die Rede ist.

Führen Sie das Icinga-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd \
    --enable-idoutils CPPFLAGS=-I/usr/local/include \
    CFLAGS="-I/usr/local/include -L/usr/local/lib" \
    --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include
~~~~

![[Wichtig]](../images/important.png)

Wichtig

Das angehängte *CPPFLAGS=-I/usr/local/include* ist wichtig für die
IDOUtils bzw. das Broker-Modul.

![[Anmerkung]](../images/note.png)

Anmerkung

Sie sollten `CFLAGS=..."`{.literal} wie oben angegeben benutzen.
Anderenfalls finden Sie ggf. später folgende Zeilen in
`icinga.log`{.filename}:

~~~~ {.screen}
 Error: Module ‘/usr/local/icinga/lib/idomod.so’ is using an old or unspecified version of the event broker API. Module will
 be unloaded.
 Event broker module ‘/usr/local/icinga/lib/idomod.so’ deinitialized successfully.
~~~~

Mehr Informationen zu diesem Fehler finden Sie
[hier](http://www.mazej.net/icinga-idomod-o-is-using-an-old-or-unspecified-version-of-the-event-broker-api/).

**Mit SSL-Verschlüsselung:**

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd \
    --enable-idoutils --enable-ssl CPPFLAGS=-I/usr/local/include \
    --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include
~~~~

Kompilieren Sie den Icinga-Source-Code. Es gibt auch eine extra Option
für IDOUtils (*make idoutils*), wenn Sie nur dieses Modul erneut
kompilieren möchten. Um mögliche Optionen zu sehen, rufen Sie lediglich
"make" auf.

~~~~ {.programlisting}
 #> gmake all
~~~~

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

~~~~ {.programlisting}
 #> make install
 #> gmake install-init
 #> gmake install-config
 #> gmake install-eventhandlers
 #> gmake install-commandmode 
 #> gmake install-idoutils
~~~~

oder kürzer

~~~~ {.programlisting}
 #> make fullinstall
 #> gmake install-config
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 ist `make install-config`{.literal} NICHT mehr in
`make fullinstall `{.literal}enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.7.0 werden mit `make install-eventhandlers`{.literal} einige
Beispiel-Eventhandler installiert. Das ist lediglich in
`make fullinstall`{.literal} enthalten, um ein versehentliches
Überschreiben der Dateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Icinga-API diente als eine in PHP geschriebene
Datenbank-Abstraktionsschicht. Seit Icinga ist sie durch eine interne
Datenbank-Abstraktionsschicht ersetzt worden, so dass Icinga-API nicht
mehr installiert werden muss.

Starten Sie Icinga noch nicht - es gibt noch ein paar Dinge zu tun...

**Anpassen der Konfiguration**

Beispiel-Konfigurationsdateien werden durch

~~~~ {.programlisting}
 #> gmake install-config
~~~~

in /usr/local/icinga/etc/ installiert.

Ändern Sie die
*/usr/local/icinga/etc/objects/contacts.cfg*-Konfigurationsdatei mit
Ihrem bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

~~~~ {.programlisting}
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

~~~~ {.programlisting}
 #> cd /usr/local/icinga/etc
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
~~~~

Wenn Sie die IDOUtils mit SSL kompiliert haben, aktivieren Sie SSL in
der idomod.cfg mit

~~~~ {.programlisting}
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
~~~~

(passen Sie die IP-Adresse an, wenn sich Ihre Datenbank nicht auf
localhost befindet!) und in der `ido2db.cfg`{.filename} mit

~~~~ {.programlisting}
 use_ssl=1
 socket_type=tcp 
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Vergessen Sie nicht, alle anderen idomod-Clients auch neu zu kompilieren
und auf ssl umzustellen, **anderenfalls werden Sie Daten verlieren!!!**

**Aktivieren Sie das idomod-Eventbroker-Modul**

![[Wichtig]](../images/important.png)

Wichtig

Unter normalen Umständen gibt es im
`modules`{.filename}-Unterverzeichnis bereits die folgende
module-Definition, so dass Sie keine Änderungen an der
Hauptkonfigurationsdatei vornehmen müssen.

~~~~ {.programlisting}
 define module{
        module_name    ido_mod
        path           /usr/local/icinga/lib/idomod.so
        module_type    neb
        args           config_file=/usr/local/icinga/etc/idomod.cfg
        }
~~~~

Das bedeutet auch, dass ein entsprechender broker\_module-Eintrag nicht
aktiviert werden darf!

**Konfigurieren von Datenbank und IDOUtils**

**MySQL:**

*Anlegen von Datenbank, Benutzer und Berechtigungen*

![[Anmerkung]](../images/note.png)

Anmerkung

Falls Sie gerade ein neues Datenbanksystem installiert haben, dann
müssen Sie den Datenbank-Server-Prozess starten, bevor Sie eine
Datenbank anlegen können. Im Falle von MySQL benutzen Sie
`/usr/local/etc/rc.d/mysql-server start`{.code}.

~~~~ {.screen}
 # mysql -u root -p

 mysql> CREATE DATABASE icinga;

       GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';

        quit
~~~~

~~~~ {.programlisting}
 #> cd /path/to/icinga-src/module/idoutils/db/mysql
 #> mysql -u root -p icinga < mysql.sql
~~~~

~~~~ {.programlisting}
 #> vi /usr/local/icinga/etc/ido2db.cfg

 db_servertype=mysql
 db_port=3306
 db_user=icinga
 db_pass=icinga
~~~~

**PostgreSQL:**

*To Do*

**Installieren und konfigurieren des klassischen Web-Interface**

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

~~~~ {.programlisting}
 #> cd /path/to/icinga-src
 #> gmake cgis
 #> gmake install-cgis
 #> gmake install-html
~~~~

Wenn Sie (zusätzlich) das neue Icinga-Web installieren wollen, lesen Sie
bitte [Installation des
Web-Interface](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend").

Installieren Sie die Icinga-Web-Konfigurationsdatei im
Apache-Includes-Verzeichnis.

~~~~ {.programlisting}
 #> cd /path/to/icinga-src
 #> gmake install-webconf
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.9 installiert der Befehl 'make install-webconf-auth'
zusätzlich die Datei `htpasswd.users`{.filename}, die
Anmeldeinformationen für den Benutzer *icingaadmin* enthält, so dass Sie
den nächsten Schritt überspringen können. Das Passwort lautet
*icingaadmin*.

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie
diesem Konto geben - Sie brauchen es später.

~~~~ {.programlisting}
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

~~~~ {.programlisting}
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

Starten Sie Apache neu, damit die Änderungen wirksam werden.

~~~~ {.programlisting}
 #> service apache22 reload
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Prüfen Sie die Implementierung der verbesserten CGI-Sicherheitsmaßnahmen
wie
[hier](cgisecurity.md "8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung")
beschrieben, um sicherzustellen, dass Ihre
Web-Authentifizierungsinformationen nicht kompromittiert werden.

**Kompilieren und installieren der Plugins**

Entpacken Sie die Plugins-Quellcode-Archivdatei.

~~~~ {.programlisting}
 #> cd ~/src 
 #> tar xvzf nagios-plugins-2.1.tar.gz
 #> cd nagios-plugins-2.1 
~~~~

Kompilieren und installieren Sie die Plugins

~~~~ {.programlisting}
 #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 #> make 
 #> make install 
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Es gibt auch einen port für die Plugins, allerdings installiert dieser
die Plugins in ein anderes Verzeichnis. Man kann dessen make zwar mit
Variablen bestücken, muss aber trotzdem später manches manuell
umkopieren.

Kompilieren und installieren Sie das Perl-Plugin:

~~~~ {.programlisting}
 #> cd /usr/ports/net-mgmt/p5-Nagios-Plugin
 #> make all install clean
~~~~

**IDOUtils und Icinga starten**

IDOUtils muss vor Icinga gestartet werden

**IDOUtils starten**

~~~~ {.programlisting}
 #> /usr/local/etc/rc.d/ido2db start
~~~~

**IDOUtils beenden**

~~~~ {.programlisting}
 #> /usr/local/etc/rc.d/ido2db stop
~~~~

**Icinga starten**

Fügen Sie Icinga zur Liste der System-Services hinzu, damit es
automatisch beim Start des Systems gestartet wird (stellen Sie sicher,
dass Sie das Init-Script vorher installiert haben).

~~~~ {.programlisting}
 #> echo icinga_enable=\"YES\" >> /etc/rc.conf
~~~~

Überprüfen Sie die Icinga-Konfigurationsdateien.

~~~~ {.programlisting}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

Wenn es dabei keine Fehler gibt, starten Sie Icinga.

~~~~ {.programlisting}
 #> /usr/local/etc/rc.d/icinga start
~~~~

**Anmelden am klassischen Web-Interface**

Sie sollten nun auf das klassische Icinga-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*icingaadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

~~~~ {.programlisting}
 http://localhost/icinga/
~~~~

oder

~~~~ {.programlisting}
 http://yourdomain.com/icinga/
~~~~

Klicken Sie auf den "Service Detail"-Verweis in der Navigationsleiste,
um Details darüber zu erhalten, was auf Ihrer lokalen Maschine überwacht
wird. Es wird ein paar Minuten dauern, bis Icinga alle mit Ihrer
Maschine verbundenen Services geprüft hat, weil die Prüfungen über eine
gewisse Zeit verteilt werden.

**Fertig**

Glückwunsch! Sie haben erfolgreich Icinga installiert. Ihre Reise in die
Überwachung hat gerade begonnen.

Sie werden ohne Zweifel mehr als nur Ihre lokale Maschine überwachen
wollen, so dass Sie u.a. das folgende
[Kapitel](ch02.md "Kapitel 2. Los geht's") lesen sollten...

Pakete für Icinga

Compiler-Optionen für Icinga mit IDOUtils

~~~~ {.programlisting}
./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
 --with-gd-lib=/usr/local/lib/ --with-gd-inc=/usr/local/include/ \
 --with-command-group=icinga-cmd --enable-idoutils \
 --with-dbi-inc=/usr/local/include --with-dbu-lib=/usr/local/lib \
 CPPFLAGS=-I/usr/local/include CFLAGS=-fPIC
~~~~

Compiler-Optionen für Monitoring Plugins (ports)

~~~~ {.programlisting}
make install NAGIOSUSER=icinga NAGIOSGROUP=icinga \
 PREFIX=/usr/local/icinga
~~~~

* * * * *

  ---------------------------------------- -------------------------- ----------------------------------------------
  [Zurück](quickstart-idoutils.md)       [Nach oben](ch02.md)      [Weiter](icinga_packages.md)
  2.6. Icinga-Schnellstart mit IDOUtils    [Zum Anfang](index.md)    2.8. Icinga Pakete für Linux-Distributionen
  ---------------------------------------- -------------------------- ----------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
