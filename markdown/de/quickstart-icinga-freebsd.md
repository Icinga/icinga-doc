![Icinga](../images/logofullsize.png "Icinga")

2.5. Icinga-Schnellstart auf FreeBSD

[Zurück](quickstart-icinga.md) 

Kapitel 2. Los geht's

 [Weiter](quickstart-idoutils.md)

* * * * *

2.5. Icinga-Schnellstart auf FreeBSD
------------------------------------

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
zu liefern, wie Sie Icinga innerhalb von 20 Minuten aus dem Quellcode
installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für [FreeBSD]() 7.2.

Spätere Distributionen von FreeBSD werden wahrscheinlich auch mit diesen
Anweisungen funktionieren.

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   Icinga und die Plugins werden unterhalb von /usr/local/icinga

-   Icinga wird so konfiguriert sein, dass es einige Dinge auf Ihrem
    lokalen System überwacht (CPU-Auslastung, Plattenbelegung, usw.)

-   das klassische Icinga-Web-Interface ist erreichbar unter
    `http://localhost/icinga/`{.uri} oder
    `http://yourdomain.com/icinga/`{.uri}

**Voraussetzungen**

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   [Apache](http://www.apache.org)

-   GCC compiler

-   C/C++ development libraries

-   [GD](http://www.boutell.com/gd/) development libraries

**Installieren Sie die Ports**

Sie können diese Ports mit den folgenden Befehlen installieren (als
root):

Bitte aktualisieren Sie Ihre Ports bevor Sie beginnen.

~~~~ {.programlisting}
 # cd /usr/ports/devel/libtool22/ && make deinstall && make clean && make && make install 
 # cd /usr/ports/graphics/jpeg && make deinstall && make clean && make && make install
 # cd /usr/ports/graphics/png && make deinstall && make clean && make && make install
 # cd /usr/ports/graphics/gd && make deinstall && make clean && make && make install
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte stellen Sie sicher, dass Apache installiert ist - das Vorgehen
wird hier nicht beschrieben, aber ein Hinweis ist *\#\> cd
/usr/ports/www/apache22 && make clean && make*.

**Benutzerinformationen erstellen**

Werden Sie zum root-Benutzer.

~~~~ {.programlisting}
 # su -l
~~~~

Erstellen Sie ein neues Benutzerkonto *icinga* ohne Passwort und ohne
die Möglichkeit, sich anzumelden (setzen Sie kein Passwort, wenn Sie
danach gefragt werden):

~~~~ {.programlisting}
 # adduser -D -w no -s nologin
~~~~

Damit Sie über das klassische Webinterface Befehle an Icinga senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Web-Server-Benutzer (www) und den Icinga-Benutzer dieser Gruppe hinzu:

~~~~ {.programlisting}
 # pw groupadd -n icinga-cmd -M icinga,www 
~~~~

**Icinga und die Plugins herunterladen**

Wechseln Sie in Ihr lokales Source-Verzeichnis, z:b. \~/src

~~~~ {.programlisting}
 # mkdir ~/src
 # cd ~/src
~~~~

Laden Sie die Sourcen von der [Icinga Website](http://www.icinga.org/).

Vergessen Sie nicht die [Monitoring
Plugins](https://www.monitoring-plugins.org) .

**Icinga kompilieren und installieren**

Entpacken Sie das Icinga-Archiv (oder wechseln Sie in den GIT-Snapshot)

~~~~ {.programlisting}
 # cd ~/src/ 
 # tar xvzf icinga-1.13.tar.gz 
 # cd icinga-1.13
~~~~

Führen Sie das Icinga-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

~~~~ {.programlisting}
 # ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
    --with-gd-lib=/usr/local/lib/ \
    --with-gd-inc=/usr/local/include/ \
    --with-command-group=icinga-cmd
~~~~

Kompilieren Sie den Icinga-Source-Code. Um mögliche Optionen zu sehen,
rufen Sie lediglich "make" auf.

~~~~ {.programlisting}
 # make all
~~~~

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

~~~~ {.programlisting}
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode
 #> make install-idoutils 
~~~~

oder kürzer

~~~~ {.programlisting}
 #> make fullinstall
 #> make install-config
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

`make install-config`{.literal} ist NICHT mehr in
`make fullinstall `{.literal}enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Mit `make install-eventhandlers`{.literal} werden einige
Beispiel-Eventhandler installiert. Das ist lediglich in
`make fullinstall`{.literal} enthalten, um ein versehentliches
Überschreiben der Dateien zu verhindern.

Die Icinga-API wird beim Aufruf von "make install" installiert, wenn Sie
nur die Icinga-API (nach)installieren möchten, nutzen Sie:

~~~~ {.programlisting}
 # make install-api
~~~~

Die Icinga-API ist Voraussetzung für das Icinga Web-Interface (nicht für
die klassische Ansicht!).

Starten Sie Icinga noch nicht - es gibt noch ein paar Dinge zu tun...

**Anpassen der Konfiguration**

Beispiel-Konfigurationsdateien werden durch

~~~~ {.programlisting}
 # make install-config
~~~~

in /usr/local/icinga/etc/ installiert. Nun fehlt nur noch eine Änderung,
bevor Sie fortfahren können...

Ändern Sie die
*/usr/local/icinga/etc/objects/contacts.cfg*-Konfigurationsdatei mit
Ihrem bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

~~~~ {.programlisting}
 # vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

**Installieren und konfigurieren des klassischen Web-Interface**

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

~~~~ {.programlisting}
 #> make cgis
 #> make install-cgis
 #> make install-html
~~~~

Wenn Sie (zusätzlich) das neue Icinga Web installieren wollen, lesen Sie
bitte [Installation des
Web-Interface](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend").

Installieren Sie die Icinga-Web-Konfigurationsdatei im
Apache-Konfigurationsverzeichnis.

![[Anmerkung]](../images/note.png)

Anmerkung

Es gibt momentan einen Bug im Icinga-Makefile, der die Ausführung dieses
*make*-Befehls unter FreeBSD verhindert, daher editieren Sie die
Makefile-Datei im Icinga-Source-Verzeichnis und ändern Sie die Zeile

~~~~ {.programlisting}
 $(INSTALL) -D -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
~~~~

in

~~~~ {.programlisting}
 $(INSTALL) -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
~~~~

~~~~ {.programlisting}
 # make install-webconf
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
 # htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

~~~~ {.programlisting}
 # htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

Starten Sie Apache neu, damit die Änderungen wirksam werden.

~~~~ {.programlisting}
 # /usr/local/etc/rc.d/apache2 reload
~~~~

**Kompilieren und installieren der Monitoring Plugins**

Entpacken Sie die Monitoring Plugins-Plugins-Quellcode-Archivdatei.

~~~~ {.programlisting}
 # cd ~/src 
 # tar xvzf nagios-plugins-2.1.tar.gz
 # cd nagios-plugins-2.1 
~~~~

Kompilieren und installieren Sie die Plugins, indem Sie das
Installationverzeichnis auf /usr/local/icinga

~~~~ {.programlisting}
 # ./configure --prefix=/usr/local/icinga \
    --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 # make 
 # make install 
~~~~

**Icinga starten**

Fügen Sie Icinga zur Liste der System-Services hinzu, damit es
automatisch beim Start des Systems gestartet wird (stellen Sie sicher,
dass Sie das Init-Script vorher installiert haben).

~~~~ {.programlisting}
 # echo icinga_enable=\"YES\" >> /etc/rc.conf
~~~~

Überprüfen Sie die Icinga-Konfigurationsdateien.

~~~~ {.programlisting}
 # /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

Wenn es dabei keine Fehler gibt, starten Sie Icinga.

~~~~ {.programlisting}
 # /usr/local/etc/rc.d/icinga start
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

**Andere Modifikationen**

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

~~~~ {.programlisting}
 # TCP port 80
~~~~

Die Installation eines Mail Transfer Agent (MTA) wie exim, sendmail oder
postfix ist nicht Gegenstand dieser Anleitung. Icinga ist konfiguriert,
um e-Mail-Benachrichtigungen zu versenden, aber möglicherweise ist auf
Ihrem System noch kein Mail-Programm installiert bzw. konfiguriert.
Schauen Sie in Ihre Systemdokumentation oder suchen Sie im Web nach
weiteren Informationen.

**Fertig**

Glückwunsch! Sie haben erfolgreich Icinga installiert. Ihre Reise in die
Überwachung hat gerade begonnen.

Sie werden ohne Zweifel mehr als nur Ihre lokale Maschine überwachen
wollen, so dass Sie u.a. das folgende
[Kapitel](ch02.md "Kapitel 2. Los geht's") lesen sollten...

* * * * *

  ------------------------------------- -------------------------- ----------------------------------------
  [Zurück](quickstart-icinga.md)      [Nach oben](ch02.md)      [Weiter](quickstart-idoutils.md)
  2.4. Icinga-Schnellstart auf Linux    [Zum Anfang](index.md)    2.6. Icinga-Schnellstart mit IDOUtils
  ------------------------------------- -------------------------- ----------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
