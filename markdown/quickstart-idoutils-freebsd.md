NAME-ICINGA-Schnellstart mit NAME-IDOUTILS auf FreeBSD
======================================================

**Einführung**

> **Note**
>
> Anstatt NAME-ICINGA von Grund auf zu installieren möchten Sie
> vielleicht ein Paket benutzen, das es möglicherweise für Ihr
> Betriebssystem gibt. Bitte werfen Sie einen Blick auf die [Tabelle der
> Pakete](https://www.icinga.org/download/packages).
>
> Bitte bedenken Sie, dass die Upstream-Pakete evtl. relativ alt sind,
> so dass die Verwendung von Backports-Paketen ein Weg ist, eine
> aktuelle Version zu bekommen. Bitte werfen Sie einen Blick auf die
> (englischsprachigen) Wiki-Artikel für detaillierte Informationen:
>
> -   [Debian](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Debian)
>
> -   [Ubuntu](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Ubuntu)
>
> -   [RHEL/CentOS](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+RHEL)
>
> Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie
> bitte die offiziellen Release-Tarballs.

> **Important**
>
> Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem
> haben, das in der aktuellen Entwicklerversion ggf. gelöst ist.

Diese Schnellstartanleitung ist dazu gedacht, Ihnen einfache Anweisungen
zu liefern, wie Sie NAME-ICINGA innerhalb von 30 Minuten aus dem
Quellcode installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für
[NAME-FREEBSD](http://www.freebsd.org/) 8.1-RELEASE. Dank an
["ScotchTape"](http://www.nagios-portal.org/wbb/index.php?page=User&userID=8925)
für die angepassten Anweisungen.

Spätere Distributionen von NAME-FREEBSD werden wahrscheinlich auch mit
diesen Anweisungen funktionieren.

> **Note**
>
> Inzwischen gibt es einen NAME-FREEBSD-Port von NAME-ICINGA
> (net-mgmt/icinga), so dass Sie den vielleicht installieren möchten ;-)

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   NAME-ICINGA und die Plugins werden unterhalb von URL-ICINGA-BASE
    installiert sein

-   NAME-ICINGA wird so konfiguriert sein, dass es einige Dinge auf
    Ihrem lokalen System überwacht (CPU-Auslastung, Plattenbelegung,
    usw.)

-   das klassische NAME-ICINGA-Web-Interface ist erreichbar unter
    <http://localhost/nagios/> oder <http://yourdomain.com/icinga/>

-   eine Datenbank, die von NAME-ICINGA mit Hilfe der NAME-IDOUTILS
    gefüllt wird

**Voraussetzungen**

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

NAME-IDOUTILS benutzt die [libdbi](http://libdbi.sourceforge.net) und
die libdbi-Treiber für verschiedene Datenbanken. Die
Development-Libraries werden ebenfalls benötigt. Die folgenden Beispiele
zeigen, wie die NAME-IDOUTILS mit libdbi für NAME-MYSQL oder
NAME-POSTGRES installiert werden.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   [NAME-APACHE](http://www.apache.org)

-   GCC-compiler

-   [NAME-GD](http://www.boutell.com/gd/) development libraries

-   libdbi-Treiber, eine Datenbank wie z.B. NAME-MYSQL oder
    NAME-POSTGRES

    > **Note**
    >
    > PostgreSQL: Aufgrund von Änderungen an Insert-Statements
    > funktioniert PostgreSQL 8.1 nicht länger (und ist auch bereits
    > ["End-of-life"](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    > seit November 2010), also benutzen Sie bitte 8.2 oder besser noch
    > 8.4. String escaping mit PostgreSQL 9.x befindet sich noch in
    > einem experimentellen Stadium (siehe auch [issue
    > \#1974](https://dev.icinga.org/issues/1974)).

**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

**Neue Features für die NAME-IDOUTILS:**

**SSL-Verschlüsselung zwischen idomod und ido2db**

Wenn Sie **SSL-Verschlüsselung**verwenden möchten: diese ist bereits
installiert.

> **Note**
>
> SSL muss auch bei allen idomod-Clients aktiviert werden, sonst gehen
> Daten verloren!!!

**Oracle-Datenbankunterstützung**

Wenn Sie Oracle als RDBMS einsetzen möchten, dann ist das unter
NAME-FREEBSD leider nicht so ohne weiteres möglich.

**Zeitzonenunterstützung**

Ab NAME-ICINGA 1.6 werden alle Zeit-/Datumsinformationen als lokale
Zeitstempel in der Datenbank gespeichert. Vorher gab es für jedes
Datenbanksystem unterschiedliche Vorgehensweisen beim Speichern und
Abrufen der Daten, was schwierig für Frontend-Applikationen war. Deshalb
wurden die Datentypen geändert: für NAME-MYSQL von DATETIME in TIMESTAMP
und für NAME-ORACLE von DATE in LOCAL TIMESTAMP (0). NAME-POSTGRES
benutzt bereits TIMESTAMP, es wurde aber in TIMESTAMP WITH TIME ZONE
geändert. IDO2DB wird die Sitzungszeitzone auf UTC setzen und alle
Unix-Timestamps (die per Definition UTC sind) als UTC-basierte Werte
speichern. Bitte stellen Sie sicher, dass Ihr System Unix-Timestamps als
UTC-basierte Werte ausgibt (wie "date -u '+%s'").

> **Note**
>
> Stellen Sie sicher, dass Ihre Datenbanksitzung in der gleichen
> Zeitzone läuft, in der die existierenden Zeit-/Datumsinformationen
> gespeichert wurden (überprüfen Sie Ihre lokale Zeitzone, z.B.
> NAME-ORACLE: "select sessiontimezone from dual;"), wenn Sie das
> Upgrade-Script laufen lassen. Zusätzlich für Ihre Bequemlichkeit
> sollten Sie in NAME-ORACLE das Format der Sitzungszeitstempel auf den
> Wert zu setzen, den Sie wünschen, z.B. "alter session set
> nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS'; oder etwas ähnliches.
> Nun können Sie Einträge von verschiedenen NAME-ICINGA-Installationen
> in unterschiedlichen Zeitzonen ansehen, die in der gleichen Datenbank
> gespeichert wurden, und unabhängig davon, von woher Sie darauf
> zugreifen, werden sie in Ihrer lokalen Zeitzone angezeigt.

**Installation der Pakete**

Sie können diese Pakete aus den ports installieren oder Sie nehmen
fertige und evtl. ältere packages (siehe NAME-FREEBSD-Schnellstart):

**Installieren Sie die Ports**

Sie können diese Ports mit den folgenden Befehlen installieren, es
empfiehlt sich aber, portupgrade oder portmaster zu verwenden (als
root):

Bitte aktualisieren Sie Ihre Ports bevor Sie beginnen.

     #> cd /usr/ports/devel/libtool/ && make all install clean
     #> cd /usr/ports/graphics/jpeg && make all install clean
     #> cd /usr/ports/graphics/png && make all install clean
     #> cd /usr/ports/graphics/gd && make all install clean

> **Note**
>
> Bitte stellen Sie sicher, dass NAME-APACHE installiert ist - das
> Vorgehen wird hier nicht beschrieben, aber ein Hinweis ist
>
>     #> cd /usr/ports/www/apache22 && make clean && make
>
> .

     #> cd /usr/ports/devel/gmake && make all install clean 
     #> cd /usr/ports/devel/libltdl && make all install clean <-- wenn noch nicht installiert

**NAME-MYSQL**

     #> cd /usr/ports/databases/mysql51-server && make all install clean 
     #> cd /usr/ports/databases/libdbi-drivers && make all install clean

dort den richtigen Treiber für die DB auswählen

**NAME-POSTGRES**

     #> cd /usr/ports/databases/postgresql84-server && make all install clean 
     #> cd /usr/ports/databases/libdbi-drivers && make all install clean

dort den richtigen Treiber für die DB auswählen

**Benutzerinformationen erstellen**

Werden Sie zum root-Benutzer.

     #> su -l

Erstellen Sie ein neues Benutzerkonto *icinga* ohne Passwort und ohne
die Möglichkeit, sich anzumelden (setzen Sie kein Passwort, wenn Sie
danach gefragt werden):

     #> adduser -D -w no -s nologin

Damit Sie über das klassische Webinterface Befehle an NAME-ICINGA senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Web-Server-Benutzer (www) und den NAME-ICINGA-Benutzer dieser Gruppe
hinzu:

     #> pw groupadd -n icinga-cmd -M icinga,www 

**NAME-ICINGA und die Plugins herunterladen**

Wechseln Sie in Ihr lokales Source-Verzeichnis, z:b. \~/src

     #> mkdir ~/src
     #> cd ~/src

Laden Sie die Sourcen von der [NAME-ICINGA
Website](http://www.icinga.org/).

Vergessen Sie nicht die
[NAME-NAGIOS-Plugins](http://www.nagiosplugins.org/) .

**NAME-ICINGA und NAME-IDOUTILS kompilieren und installieren**

Entpacken Sie das NAME-ICINGA-Archiv (oder wechseln Sie in den
GIT-Snapshot)

     #> cd ~/src/ 
     #> tar xvzf icinga-VER-ICINGA.tar.gz 
     #> cd icinga-VER-ICINGA

> **Note**
>
> Dieser absolute Pfad ist gemeint, wenn im Nachfolgenden von
> '/path/to/icinga-src/' die Rede ist.

Führen Sie das NAME-ICINGA-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils CPPFLAGS=-I/usr/local/include \
        CFLAGS="-I/usr/local/include -L/usr/local/lib" \
        --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include

> **Important**
>
> Das angehängte *CPPFLAGS=-I/usr/local/include* ist wichtig für die
> NAME-IDOUTILS bzw. das Broker-Modul.

> **Note**
>
> Sie sollten `CFLAGS=..."` wie oben angegeben benutzen. Anderenfalls
> finden Sie ggf. später folgende Zeilen in `icinga.log`:
>
>      Error: Module ‘/usr/local/icinga/lib/idomod.so’ is using an old or unspecified version of the event broker API. Module will
>      be unloaded.
>      Event broker module ‘/usr/local/icinga/lib/idomod.so’ deinitialized successfully.
>
> Mehr Informationen zu diesem Fehler finden Sie
> [hier](http://www.mazej.net/icinga-idomod-o-is-using-an-old-or-unspecified-version-of-the-event-broker-api/).

**Mit SSL-Verschlüsselung:**

     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-ssl CPPFLAGS=-I/usr/local/include \
        --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include

Kompilieren Sie den NAME-ICINGA-Source-Code. Es gibt auch eine extra
Option für NAME-IDOUTILS (*make idoutils*), wenn Sie nur dieses Modul
erneut kompilieren möchten. Um mögliche Optionen zu sehen, rufen Sie
lediglich "make" auf.

     #> gmake all

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

     #> make install
     #> gmake install-init
     #> gmake install-config
     #> gmake install-eventhandlers
     #> gmake install-commandmode 
     #> gmake install-idoutils

oder kürzer

     #> make fullinstall
     #> gmake install-config

> **Note**
>
> Ab NAME-ICINGA 1.5.0 ist `make install-config` NICHT mehr in
> `make fullinstall `enthalten, um ein versehentliches Überschreiben der
> Konfigurationsdateien zu verhindern.

> **Note**
>
> Ab NAME-ICINGA 1.7.0 werden mit `make install-eventhandlers` einige
> Beispiel-Eventhandler installiert. Das ist lediglich in
> `make fullinstall` enthalten, um ein versehentliches Überschreiben der
> Dateien zu verhindern.

> **Note**
>
> Die NAME-ICINGA-API diente als eine in PHP geschriebene
> Datenbank-Abstraktionsschicht. Seit NAME-ICINGA ist sie durch eine
> interne Datenbank-Abstraktionsschicht ersetzt worden, so dass
> NAME-ICINGA-API nicht mehr installiert werden muss.

Starten Sie NAME-ICINGA noch nicht - es gibt noch ein paar Dinge zu
tun...

**Anpassen der Konfiguration**

Beispiel-Konfigurationsdateien werden durch

     #> gmake install-config

in URL-ICINGA-BASE/etc/ installiert.

Ändern Sie die
*URL-ICINGA-BASE/etc/objects/contacts.cfg*-Konfigurationsdatei mit Ihrem
bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

     #> vi URL-ICINGA-BASE/etc/objects/contacts.cfg

     #> cd URL-ICINGA-BASE/etc
     #> mv idomod.cfg-sample idomod.cfg
     #> mv ido2db.cfg-sample ido2db.cfg

Wenn Sie die NAME-IDOUTILS mit SSL kompiliert haben, aktivieren Sie SSL
in der idomod.cfg mit

     use_ssl=1
     output_type=tcpsocket
     output=127.0.0.1

(passen Sie die IP-Adresse an, wenn sich Ihre Datenbank nicht auf
localhost befindet!) und in der `ido2db.cfg` mit

     use_ssl=1
     socket_type=tcp 

> **Note**
>
> Vergessen Sie nicht, alle anderen idomod-Clients auch neu zu
> kompilieren und auf ssl umzustellen, **anderenfalls werden Sie Daten
> verlieren!!!**

**Aktivieren Sie das idomod-Eventbroker-Modul**

> **Important**
>
> Unter normalen Umständen gibt es im `modules`-Unterverzeichnis bereits
> die folgende module-Definition, so dass Sie keine Änderungen an der
> Hauptkonfigurationsdatei vornehmen müssen.
>
>      define module{
>             module_name    ido_mod
>             path           URL-ICINGA-BASE/lib/idomod.so
>             module_type    neb
>             args           config_file=URL-ICINGA-BASE/etc/idomod.cfg
>             }
>
> Das bedeutet auch, dass ein entsprechender broker\_module-Eintrag
> nicht aktiviert werden darf!

**Konfigurieren von Datenbank und NAME-IDOUTILS**

**NAME-MYSQL:**

*Anlegen von Datenbank, Benutzer und Berechtigungen*

> **Note**
>
> Falls Sie gerade ein neues Datenbanksystem installiert haben, dann
> müssen Sie den Datenbank-Server-Prozess starten, bevor Sie eine
> Datenbank anlegen können. Im Falle von NAME-MYSQL benutzen Sie
> `/usr/local/etc/rc.d/mysql-server start`.

     #> mysql -u root -p

     mysql> CREATE DATABASE icinga;

     GRANT USAGE ON icinga.* TO 'icinga'@'localhost'
       IDENTIFIED BY 'icinga'
       WITH MAX_QUERIES_PER_HOUR 0
       MAX_CONNECTIONS_PER_HOUR 0
       MAX_UPDATES_PER_HOUR 0;

     GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE
       ON icinga.* TO 'icinga'@'localhost';

     FLUSH PRIVILEGES ;

     quit

     #> cd /path/to/icinga-src/module/idoutils/db/mysql
     #> mysql -u root -p icinga < mysql.sql

     #> vi URL-ICINGA-BASE/etc/ido2db.cfg

     db_servertype=mysql
     db_port=3306
     db_user=icinga
     db_pass=icinga

**NAME-POSTGRES:**

*To Do*

**Installieren und konfigurieren des klassischen Web-Interface**

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

     #> cd /path/to/icinga-src
     #> gmake cgis
     #> gmake install-cgis
     #> gmake install-html

Wenn Sie (zusätzlich) das neue Icinga-Web installieren wollen, lesen Sie
bitte [Installation des Web-Interface](#icinga-web-scratch).

Installieren Sie die NAME-ICINGA-Web-Konfigurationsdatei im
Apache-Includes-Verzeichnis.

     #> cd /path/to/icinga-src
     #> gmake install-webconf

> **Note**
>
> Ab NAME-ICINGA 1.9 installiert der Befehl 'make install-webconf-auth'
> zusätzlich die Datei `htpasswd.users`, die Anmeldeinformationen für
> den Benutzer *icingaadmin* enthält, so dass Sie den nächsten Schritt
> überspringen können. Das Passwort lautet *icingaadmin*.

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie
diesem Konto geben - Sie brauchen es später.

     #> htpasswd -c URL-ICINGA-BASE/etc/htpasswd.users icingaadmin

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

     #> htpasswd URL-ICINGA-BASE/etc/htpasswd.users <USERNAME>

Starten Sie Apache neu, damit die Änderungen wirksam werden.

     #> service apache22 reload

> **Note**
>
> Prüfen Sie die Implementierung der verbesserten
> CGI-Sicherheitsmaßnahmen wie [hier](#cgisecurity) beschrieben, um
> sicherzustellen, dass Ihre Web-Authentifizierungsinformationen nicht
> kompromittiert werden.

**Kompilieren und installieren der Nagios-/Perl-Plugins**

Entpacken Sie die NAME-NAGIOS-Plugins-Quellcode-Archivdatei.

     #> cd ~/src 
     #> tar xvzf nagios-plugins-VER-NAGIOSPLUG.tar.gz
     #> cd nagios-plugins-VER-NAGIOSPLUG 

Kompilieren und installieren Sie die Plugins

     #> ./configure --prefix=URL-ICINGA-BASE --with-cgiurl=/icinga/cgi-bin \
        --with-nagios-user=icinga --with-nagios-group=icinga
     #> make 
     #> make install 

> **Note**
>
> Es gibt auch einen port für die Plugins, allerdings installiert dieser
> die Plugins in ein anderes Verzeichnis. Man kann dessen make zwar mit
> Variablen bestücken, muss aber trotzdem später manches manuell
> umkopieren.

Kompilieren und installieren Sie das Perl-Plugin:

     #> cd /usr/ports/net-mgmt/p5-Nagios-Plugin
     #> make all install clean

**NAME-IDOUTILS und NAME-ICINGA starten**

NAME-IDOUTILS muss vor NAME-ICINGA gestartet werden

**NAME-IDOUTILS starten**

     #> /usr/local/etc/rc.d/ido2db start

**NAME-IDOUTILS beenden**

     #> /usr/local/etc/rc.d/ido2db stop

**NAME-ICINGA starten**

Fügen Sie NAME-ICINGA zur Liste der System-Services hinzu, damit es
automatisch beim Start des Systems gestartet wird (stellen Sie sicher,
dass Sie das Init-Script vorher installiert haben).

     #> echo icinga_enable=\"YES\" >> /etc/rc.conf

Überprüfen Sie die NAME-ICINGA-Konfigurationsdateien.

     #> URL-ICINGA-BIN -v URL-ICINGA-CFG

Wenn es dabei keine Fehler gibt, starten Sie NAME-ICINGA.

     #> /usr/local/etc/rc.d/icinga start

**Anmelden am klassischen Web-Interface**

Sie sollten nun auf das klassische NAME-ICINGA-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*icingaadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

     http://localhost/icinga/

oder

     http://yourdomain.com/icinga/

Klicken Sie auf den "Service Detail"-Verweis in der Navigationsleiste,
um Details darüber zu erhalten, was auf Ihrer lokalen Maschine überwacht
wird. Es wird ein paar Minuten dauern, bis NAME-ICINGA alle mit Ihrer
Maschine verbundenen Services geprüft hat, weil die Prüfungen über eine
gewisse Zeit verteilt werden.

**Fertig**

Glückwunsch! Sie haben erfolgreich NAME-ICINGA installiert. Ihre Reise
in die Überwachung hat gerade begonnen.

Sie werden ohne Zweifel mehr als nur Ihre lokale Maschine überwachen
wollen, so dass Sie u.a. das folgende [Kapitel](#ch02) lesen sollten...

Pakete für NAME-ICINGA

Compiler-Optionen für NAME-ICINGA mit NAME-IDOUTILS

    ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
     --with-gd-lib=/usr/local/lib/ --with-gd-inc=/usr/local/include/ \
     --with-command-group=icinga-cmd --enable-idoutils \
     --with-dbi-inc=/usr/local/include --with-dbu-lib=/usr/local/lib \
     CPPFLAGS=-I/usr/local/include CFLAGS=-fPIC

Compiler-Optionen für Nagios-Plugins (ports)

    make install NAGIOSUSER=icinga NAGIOSGROUP=icinga \
     PREFIX=/usr/local/icinga

Quickstart
NAME-ICINGA und NAME-IDOUTILS auf NAME-FREEBSD
NAME-IDOUTILS / Zeitzonen-Unterstützung
