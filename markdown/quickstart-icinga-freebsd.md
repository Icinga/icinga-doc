NAME-ICINGA-Schnellstart auf FreeBSD
====================================

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
zu liefern, wie Sie NAME-ICINGA innerhalb von 20 Minuten aus dem
Quellcode installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für [NAME-FREEBSD]() 7.2.

Spätere Distributionen von NAME-FREEBSD werden wahrscheinlich auch mit
diesen Anweisungen funktionieren.

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   NAME-ICINGA und die Plugins werden unterhalb von URL-ICINGA-BASE

-   NAME-ICINGA wird so konfiguriert sein, dass es einige Dinge auf
    Ihrem lokalen System überwacht (CPU-Auslastung, Plattenbelegung,
    usw.)

-   das klassische NAME-ICINGA-Web-Interface ist erreichbar unter
    <http://localhost/nagios/> oder <http://yourdomain.com/icinga/>

**Voraussetzungen**

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   [NAME-APACHE](http://www.apache.org)

-   GCC compiler

-   C/C++ development libraries

-   [NAME-GD](http://www.boutell.com/gd/) development libraries

**Installieren Sie die Ports**

Sie können diese Ports mit den folgenden Befehlen installieren (als
root):

Bitte aktualisieren Sie Ihre Ports bevor Sie beginnen.

     # cd /usr/ports/devel/libtool22/ && make deinstall && make clean && make && make install 
     # cd /usr/ports/graphics/jpeg && make deinstall && make clean && make && make install
     # cd /usr/ports/graphics/png && make deinstall && make clean && make && make install
     # cd /usr/ports/graphics/gd && make deinstall && make clean && make && make install

> **Note**
>
> Bitte stellen Sie sicher, dass NAME-APACHE installiert ist - das
> Vorgehen wird hier nicht beschrieben, aber ein Hinweis ist *\#\> cd
> /usr/ports/www/apache22 && make clean && make*.

**Benutzerinformationen erstellen**

Werden Sie zum root-Benutzer.

     # su -l

Erstellen Sie ein neues Benutzerkonto *icinga* ohne Passwort und ohne
die Möglichkeit, sich anzumelden (setzen Sie kein Passwort, wenn Sie
danach gefragt werden):

     # adduser -D -w no -s nologin

Damit Sie über das klassische Webinterface Befehle an NAME-ICINGA senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Web-Server-Benutzer (www) und den NAME-ICINGA-Benutzer dieser Gruppe
hinzu:

     # pw groupadd -n icinga-cmd -M icinga,www 

**NAME-ICINGA und die Plugins herunterladen**

Wechseln Sie in Ihr lokales Source-Verzeichnis, z:b. \~/src

     # mkdir ~/src
     # cd ~/src

Laden Sie die Sourcen von der [NAME-ICINGA
Website](http://www.icinga.org/).

Vergessen Sie nicht die
[NAME-NAGIOS-Plugins](http://www.nagiosplugins.org/) .

**NAME-ICINGA kompilieren und installieren**

Entpacken Sie das NAME-ICINGA-Archiv (oder wechseln Sie in den
GIT-Snapshot)

     # cd ~/src/ 
     # tar xvzf icinga-VER-ICINGA.tar.gz 
     # cd icinga-VER-ICINGA

Führen Sie das NAME-ICINGA-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

     # ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
        --with-gd-lib=/usr/local/lib/ \
        --with-gd-inc=/usr/local/include/ \
        --with-command-group=icinga-cmd

Kompilieren Sie den NAME-ICINGA-Source-Code. Um mögliche Optionen zu
sehen, rufen Sie lediglich "make" auf.

     # make all

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

     #> make install
     #> make install-init
     #> make install-config
     #> make install-eventhandlers
     #> make install-commandmode
     #> make install-idoutils 

oder kürzer

     #> make fullinstall
     #> make install-config

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

Die Icinga-API wird beim Aufruf von "make install" installiert, wenn Sie
nur die Icinga-API (nach)installieren möchten, nutzen Sie:

     # make install-api

Die Icinga-API ist Voraussetzung für das Icinga Web-Interface (nicht für
die klassische Ansicht!).

Starten Sie NAME-ICINGA noch nicht - es gibt noch ein paar Dinge zu
tun...

**Anpassen der Konfiguration**

Beispiel-Konfigurationsdateien werden durch

     # make install-config

in URL-ICINGA-BASE/etc/ installiert. Nun fehlt nur noch eine Änderung,
bevor Sie fortfahren können...

Ändern Sie die
*URL-ICINGA-BASE/etc/objects/contacts.cfg*-Konfigurationsdatei mit Ihrem
bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

     # vi URL-ICINGA-BASE/etc/objects/contacts.cfg

**Installieren und konfigurieren des klassischen Web-Interface**

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

     #> make cgis
     #> make install-cgis
     #> make install-html

Wenn Sie (zuätzlich) das neue Icinga Web installieren wollen, lesen Sie
bitte [Installation des Web-Interface](#icinga-web-scratch).

Installieren Sie die NAME-ICINGA-Web-Konfigurationsdatei im
Apache-Konfigurationsverzeichnis.

> **Note**
>
> Es gibt momentan einen Bug im NAME-ICINGA-Makefile, der die Ausführung
> dieses *make*-Befehls unter FreeBSD verhindert, daher editieren Sie
> die Makefile-Datei im NAME-ICINGA-Source-Verzeichnis und ändern Sie
> die Zeile
>
>      $(INSTALL) -D -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
>
> in
>
>      $(INSTALL) -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf

     # make install-webconf

> **Note**
>
> Ab NAME-ICINGA 1.9 installiert der Befehl 'make install-webconf-auth'
> zusätzlich die Datei `htpasswd.users`, die Anmeldeinformationen für
> den Benutzer *icingaadmin* enthält, so dass Sie den nächsten Schritt
> überspringen können. Das Passwort lautet *icingaadmin*.

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie
diesem Konto geben - Sie brauchen es später.

     # htpasswd -c URL-ICINGA-BASE/etc/htpasswd.users icingaadmin

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

     # htpasswd URL-ICINGA-BASE/etc/htpasswd.users <USERNAME>

Starten Sie Apache neu, damit die Änderungen wirksam werden.

     # /usr/local/etc/rc.d/apache2 reload

**Kompilieren und installieren der Nagios-Plugins**

Entpacken Sie die NAME-NAGIOS-Plugins-Quellcode-Archivdatei.

     # cd ~/src 
     # tar xvzf nagios-plugins-VER-NAGIOSPLUG.tar.gz
     # cd nagios-plugins-VER-NAGIOSPLUG 

Kompilieren und installieren Sie die Plugins, indem Sie das
Installationverzeichnis auf URL-ICINGA-BASE

     # ./configure --prefix=URL-ICINGA-BASE \
        --with-cgiurl=/icinga/cgi-bin \
        --with-nagios-user=icinga --with-nagios-group=icinga
     # make 
     # make install 

**NAME-ICINGA starten**

Fügen Sie NAME-ICINGA zur Liste der System-Services hinzu, damit es
automatisch beim Start des Systems gestartet wird (stellen Sie sicher,
dass Sie das Init-Script vorher installiert haben).

     # echo icinga_enable=\"YES\" >> /etc/rc.conf

Überprüfen Sie die NAME-ICINGA-Konfigurationsdateien.

     # URL-ICINGA-BIN -v URL-ICINGA-CFG

Wenn es dabei keine Fehler gibt, starten Sie NAME-ICINGA.

     # /usr/local/etc/rc.d/icinga start

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

**Andere Modifikationen**

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

     # TCP port 80

Die Installation eines Mail Transfer Agent (MTA) wie exim, sendmail oder
postfix ist nicht Gegenstand dieser Anleitung. NAME-ICINGA ist
konfiguriert, um e-Mail-Benachrichtigungen zu versenden, aber
möglicherweise ist auf Ihrem System noch kein Mail-Programm installiert
bzw. konfiguriert. Schauen Sie in Ihre Systemdokumentation oder suchen
Sie im Web nach weiteren Informationen.

**Fertig**

Glückwunsch! Sie haben erfolgreich NAME-ICINGA installiert. Ihre Reise
in die Überwachung hat gerade begonnen.

Sie werden ohne Zweifel mehr als nur Ihre lokale Maschine überwachen
wollen, so dass Sie u.a. das folgende [Kapitel](#ch02) lesen sollten...

Quickstart
NAME-ICINGA auf NAME-FREEBSD
