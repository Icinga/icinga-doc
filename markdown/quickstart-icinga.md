NAME-ICINGA-Schnellstart auf NAME-LINUX
=======================================

Einführung
----------

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

Diese Anleitung enthält momentan Anweisungen für drei verschiedene
Linux-Distributionen: [NAME-FEDORA](http://fedoraproject.org/),
[NAME-UBUNTU](http://www.ubuntu.com/) and
[NAME-OPENSUSE](http://www.opensuse.org/). Ähnliche Distributionen
werden wahrscheinlich auch funktionieren, darunter
[NAME-REDHAT](http://www.redhat.com/),
[NAME-CENTOS](http://www.centos.org/),
[NAME-DEBIAN](http://www.debian.org/) und
[NAME-SLES](http://www.novell.com/products/server/).

> **Important**
>
> Wenn Sie planen, eine Datenbank zusammen mit NAME-IDOUTILS zu nutzen
> oder wenn Sie das neue Web-Interface einsetzen möchten, dann lesen Sie
> statt dessen die [Schnellstartanleitung mit
> IDOUtils](#quickstart-idoutils)!

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   NAME-ICINGA und die Plugins werden unterhalb von URL-ICINGA-BASE
    installiert sein

-   NAME-ICINGA wird so konfiguriert sein, dass es einige Dinge auf
    Ihrem lokalen System überwacht (CPU-Auslastung, Plattenbelegung,
    usw.)

-   das klassische NAME-ICINGA-Web-Interface ist erreichbar unter
    <http://localhost/icinga/> oder <http://yourdomain.com/icinga/>

Voraussetzungen
---------------

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   NAME-APACHE

-   GCC-Compiler

-   C/C++ development libraries

-   [NAME-GD](http://www.boutell.com/gd/)-Development-Libraries

**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

Installation der Pakete
-----------------------

Sie können diese Pakete mit Hilfe der folgenden Befehle installieren
(als root oder mit sudo).

> **Note**
>
> Unglücklicherweise ändern sich manchmal die Paketnamen zwischen
> verschiedenen Ausgaben der gleichen Distribution, so dass Sie die
> Suchoption Ihres Paket-Managers nutzen sollten, falls Sie die
> Fehlermeldung bekommen, dass eins der Pakete nicht gefunden wurde.
>
> -   `yum search <package name>` ( *NAME-FEDORA/NAME-RHEL/NAME-CENTOS*
>     )
>
> -   `apt-cache search <package name>` ( *NAME-DEBIAN/NAME-UBUNTU* )
>
> -   `zypper search <package name>` ( *NAME-OPENSUSE/NAME-SLES* )
>
*NAME-FEDORA / NAME-REDHAT / NAME-CENTOS*

     #> yum install httpd gcc glibc glibc-common gd gd-devel
     #> yum install libjpeg libjpeg-devel libpng libpng-devel
     #> yum install net-snmp net-snmp-devel net-snmp-utils

> **Note**
>
> ggf. sind libjpeg-turbo bzw. libjpeg-turbo-devel zu installieren

*NAME-DEBIAN / NAME-UBUNTU*

     #> apt-get install apache2 build-essential libgd2-xpm-dev
     #> apt-get install libjpeg62 libjpeg62-dev libpng12 libpng12-dev
     #> apt-get install snmp libsnmp5-dev

> **Note**
>
> Die Zahlen \<62/12\> können je nach Distribution abweichen.

> **Note**
>
> Ab NAME-DEBIAN 6.0/NAME-UBUNTU 10.10 heißt das Paket libpng12-0, der
> Name des dev-Pakets ändert sich nicht.

*NAME-OPENSUSE / NAME-SLES*

Bitte nutzen Sie YaST für die Installation der Pakete gd, gd-devel,
libjpeg, libjpeg-devel, libpng, libpng-devel und -optional- net-snmp,
net-snmp-devel und perl-Net-SNMP.

Die Nutzung von zypper sollte ebenfalls funktionieren:

     #> zypper install gd gd-devel libjpeg libjpeg-devel libpng libpng-devel
     #> zypper install net-snmp net-snmp-devel perl-Net-SNMP

> **Note**
>
> Abhängig von der Softwareauswahl bei der Installation des
> Betriebssystems benötigen Sie evtl. weitere Pakete (z.B. apache2,
> gcc). Die devel-Pakete sind ggf. auf den SDK-DVDs zu finden.

Benutzerinformationen erstellen
-------------------------------

Werden Sie zum root-Benutzer.

     $> su -l

Erstellen Sie ein neues Benutzerkonto *icinga* und vergeben Sie ein
Passwort:

     #> /usr/sbin/useradd -m icinga
     #> passwd icinga  

Bei einigen Distributionen müssen Sie die Gruppe in einem gesonderten
Schritt anlegen:

     #> /usr/sbin/groupadd icinga

Damit Sie über das klassische Web-Interface Befehle an NAME-ICINGA
senden können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen
Sie den Webbenutzer und den Icingabenutzer dieser Gruppe hinzu.

     #> /usr/sbin/groupadd icinga-cmd
     #> /usr/sbin/usermod -a -G icinga-cmd icinga
     #> /usr/sbin/usermod -a -G icinga-cmd www-data

(oder www, wwwrun, apache je nach Distribution)

> **Note**
>
> Bei einigen usermod-Versionen (z.B. bei OpenSuSE 11 bzw. SLES 11)
> fehlt die Option -a. In diesen Fällen kann sie entfallen.

> **Note**
>
> Solaris unterstützt nur Gruppennamen bis max. 8 Zeichen, verwenden Sie
> icingcmd anstelle von icinga-cmd.

NAME-ICINGA und die Plugins herunterladen
-----------------------------------------

Wechseln Sie in Ihr lokales Source-Verzeichnis, z.B. /usr/src

     #> cd /usr/src

Laden Sie die Sourcen von der [NAME-ICINGA
Website](http://www.icinga.org/).

Vergessen Sie nicht die [Nagios-Plugins](http://www.nagiosplugins.org/).

NAME-ICINGA kompilieren und installieren
----------------------------------------

Entpacken Sie das NAME-ICINGA-Archiv (oder wechseln Sie in den GIT
Snapshot)

     #> cd /usr/src/
     #> tar xvzf icinga-VER-ICINGA.tar.gz
     #> cd icinga-VER-ICINGA

Führen Sie das NAME-ICINGA-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

> **Note**
>
> Beginnend mit NAME-ICINGA 1.9 hat sich der Default geändert, so dass
> Sie die Kompilation der NAME-IDOUTILS explizit verhindern müssen.

     #> ./configure --with-command-group=icinga-cmd --disable-idoutils

Kompilieren Sie den NAME-ICINGA-Source-Code. Um mögliche Optionen zu
sehen, rufen Sie lediglich "make" auf.

     #> make all

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

     #> make install
     #> make install-init
     #> make install-config
     #> make install-eventhandlers
     #> make install-commandmode 

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

Die Icinga-API ist Voraussetzung für das NAME-ICINGA-Web-Interface
(nicht für die klassische Ansicht!).

Bitte starten Sie NAME-ICINGA noch nicht - es gibt noch ein paar Dinge
zu tun...

Anpassen der Konfiguration
--------------------------

Beispiel-Konfigurationsdateien werden durch

     #> make install-config

in URL-ICINGA-BASE/etc/ installiert. Nun fehlt nur noch eine Änderung,
bevor Sie fortfahren können...

Ändern Sie die
*URL-ICINGA-BASE/etc/objects/contacts.cfg*-Konfigurationsdatei mit Ihrem
bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

     #> vi URL-ICINGA-BASE/etc/objects/contacts.cfg

Installieren und konfigurieren des klassischen Web-Interface
------------------------------------------------------------

Icinga stellt das klassische Webinterface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

     #> make cgis
     #> make install-cgis
     #> make install-html

Wenn Sie (zusätzlich) das neue Icinga Web installieren wollen, lesen Sie
bitte [Installation des Web-Interface](#icinga-web-scratch).

Installieren Sie die NAME-ICINGA-Web-Konfigurationsdatei im NAME-APACHE
conf.d-Verzeichnis.

     #> make install-webconf

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

> **Note**
>
> Abhängig von der Apache-Version müssen Sie ggf. *htpasswd2* verwenden.

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

     #> htpasswd URL-ICINGA-BASE/etc/htpasswd.users <USERNAME>

Starten Sie NAME-APACHE neu, damit die Änderungen wirksam werden.

*NAME-FEDORA/NAME-REDHAT/NAME-CENTOS*

     #> service httpd restart

*NAME-DEBIAN / NAME-UBUNTU / NAME-OPENSUSE*

     #> /etc/init.d/apache2 reload

> **Note**
>
> Prüfen Sie die Implementierung der verbesserten
> CGI-Sicherheitsmaßnahmen wie [hier](#cgisecurity) beschrieben, um
> sicherzustellen, dass Ihre Web-Authentifizierungsinformationen nicht
> kompromittiert werden.

Kompilieren und installieren der NAME-NAGIOS-Plugins
----------------------------------------------------

Entpacken Sie die NAME-NAGIOS-Plugins-Quellcode-Archivdatei.

     #> cd /usr/src
     #> tar xzf nagios-plugins-VER-NAGIOSPLUG.tar.gz
     #> cd nagios-plugins-VER-NAGIOSPLUG

Kompilieren und installieren Sie die Plugins.

     #> ./configure --prefix=/usr/local/icinga \
        --with-cgiurl=/icinga/cgi-bin \
        --with-nagios-user=icinga --with-nagios-group=icinga
     #> make
     #> make install

Anpassen der SENAME-LINUX-Einstellungen
---------------------------------------

NAME-RHEL und ähnliche Distributionen wie NAME-FEDORA oder NAME-CENTOS
werden mit installiertem SENAME-LINUX (Security Enhanced NAME-LINUX)
ausgeliefert und laufen im "Enforcing"-Modus. Dies kann zu "Internal
Server Error"-Fehlern führen, wenn Sie versuchen, die NAME-ICINGA-CGIs
aufzurufen.

Schauen Sie, ob SENAME-LINUX im Enforcing-Modus läuft.

     #> getenforce

Setzen Sie SENAME-LINUX in den "Permissive"-Modus.

     #> setenforce 0

Damit diese Änderung dauerhaft wird, müssen Sie diese Einstellung in
*/etc/selinux/config* anpassen und das System neustarten.

Statt SENAME-LINUX zu deaktivieren oder es in den Permissive-Modus zu
versetzen, können Sie den folgenden Befehl benutzen, um die CGIs im
Enforcing/Targeted-Modus laufen zu lassen:

     #> chcon -R -t httpd_sys_script_exec_t URL-ICINGA-BASE/sbin/
     #> chcon -R -t httpd_sys_content_t URL-ICINGA-BASE/share/
     #> chcon -t httpd_sys_script_rw_t URL-ICINGA-BASE/var/rw/icinga.cmd

Eine alternative Vorgehensweise wird unter
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/)
beschrieben (englisch).

NAME-ICINGA starten
-------------------

Fügen Sie NAME-ICINGA zu der Liste der System-Services hinzu und sorgen
Sie für einen automatischen Start, wenn das System hochfährt (stellen
Sie sicher, dass Sie vorher das Init-Script installiert haben).

*NAME-FEDORA / NAME-REDHAT / NAME-CENTOS / NAME-OPENSUSE*

     #> chkconfig --add icinga 
     #> chkconfig icinga on 

*NAME-DEBIAN / NAME-UBUNTU*

     #> update-rc.d icinga defaults

Überprüfen Sie die NAME-ICINGA-Beispielkonfigurationsdateien.

     #> URL-ICINGA-BIN -v URL-ICINGA-CFG

Anstatt die Pfade für das Binary und die Konfigurationsdatei anzugeben
können Sie auch den folgenden Befehl eingeben:

     #> /etc/init.d/icinga show-errors

Die Ausführung ergibt einen OK-Meldung, wenn alles in Ordnung ist, oder
eine Reihe von Zeilen, die zeigen, wo der/die Fehler zu finden sind.

Wenn es dabei keine Fehler gibt, starten Sie NAME-ICINGA.

*NAME-FEDORA / NAME-OPENSUSE*

     #> service icinga start

*NAME-DEBIAN / NAME-UBUNTU*

     #> /etc/init.d/icinga start

Anmelden am klassischen Web-Interface
-------------------------------------

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

Andere Anpassungen
------------------

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

     #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT

Die Konfiguration von e-Mail-Benachrichtigungen ist nicht Gegenstand
dieser Anleitung. NAME-ICINGA ist konfiguriert, um
e-Mail-Benachrichtigungen zu versenden, aber möglicherweise ist auf
Ihrem System noch kein Mail-Programm installiert bzw. konfiguriert.
Schauen Sie in Ihre Systemdokumentation oder suchen Sie im Web nach
genauen Anweisungen, wie Ihr System konfiguriert werden muss, damit es
e-Mail-Mitteilungen an externe Adressen versendet. Mehr Informationen zu
Benachrichtigungen finden Sie [hier](#notifications).

Fertig
------

Glückwunsch! Sie haben erfolgreich NAME-ICINGA installiert. Ihre Reise
in die Überwachung hat gerade begonnen. Sie werden ohne Zweifel mehr als
nur Ihre lokale Maschine überwachen wollen, so dass Sie u.a. das
folgende [Kapitel](#ch02) lesen sollten...

Schnellstart
NAME-ICINGA auf \$name-linux;
Quickstart
NAME-ICINGA auf Linux
