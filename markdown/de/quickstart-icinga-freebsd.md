 ![Icinga](../images/logofullsize.png "Icinga") 

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




Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs.

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem haben,
das in der aktuellen Entwicklerversion ggf. gelöst ist.

Diese Schnellstartanleitung ist dazu gedacht, Ihnen einfache Anweisungen
zu liefern, wie Sie Icinga innerhalb von 20 Minuten aus dem Quellcode
installieren und Ihren lokalen Rechner damit überwachen.

lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für [FreeBSD]() 7.2.

Spätere Distributionen von FreeBSD werden wahrscheinlich auch mit diesen
Anweisungen funktionieren.

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:




**Voraussetzungen**

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.





**Installieren Sie die Ports**

Sie können diese Ports mit den folgenden Befehlen installieren (als
root):

Bitte aktualisieren Sie Ihre Ports bevor Sie beginnen.

<pre><code>
 # cd /usr/ports/graphics/jpeg && make deinstall && make clean && make && make install
 # cd /usr/ports/graphics/png && make deinstall && make clean && make && make install
 # cd /usr/ports/graphics/gd && make deinstall && make clean && make && make install
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

wird hier nicht beschrieben, aber ein Hinweis ist *\#\> cd
/usr/ports/www/apache22 && make clean && make*.

**Benutzerinformationen erstellen**

Werden Sie zum root-Benutzer.

<pre><code>
 # su -l
</code></pre>

Erstellen Sie ein neues Benutzerkonto *icinga* ohne Passwort und ohne
die Möglichkeit, sich anzumelden (setzen Sie kein Passwort, wenn Sie
danach gefragt werden):

<pre><code>
 # adduser -D -w no -s nologin
</code></pre>

Damit Sie über das klassische Webinterface Befehle an Icinga senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Web-Server-Benutzer (www) und den Icinga-Benutzer dieser Gruppe hinzu:

<pre><code>
</code></pre>

**Icinga und die Plugins herunterladen**

Wechseln Sie in Ihr lokales Source-Verzeichnis, z:b. \~/src

<pre><code>
 # mkdir ~/src
 # cd ~/src
</code></pre>

Laden Sie die Sourcen von der [Icinga Website](http://www.icinga.org/).

Vergessen Sie nicht die [Monitoring
Plugins](https://www.monitoring-plugins.org) .

**Icinga kompilieren und installieren**

Entpacken Sie das Icinga-Archiv (oder wechseln Sie in den GIT-Snapshot)

<pre><code>
 # cd icinga-1.13
</code></pre>

Führen Sie das Icinga-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

<pre><code>
 # ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
</code></pre>

Kompilieren Sie den Icinga-Source-Code. Um mögliche Optionen zu sehen,
rufen Sie lediglich "make" auf.

<pre><code>
 # make all
</code></pre>

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien, Beispiel-Eventhandler und setzen Sie die
Berechtigungen für das External-Command-Verzeichnis.

<pre><code>
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode
</code></pre>

oder kürzer

<pre><code>
 #> make fullinstall
 #> make install-config
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

`make install-config` ist NICHT mehr in
`make fullinstall `enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Mit `make install-eventhandlers` werden einige
Beispiel-Eventhandler installiert. Das ist lediglich in
`make fullinstall` enthalten, um ein versehentliches
Überschreiben der Dateien zu verhindern.

Die Icinga-API wird beim Aufruf von "make install" installiert, wenn Sie
nur die Icinga-API (nach)installieren möchten, nutzen Sie:

<pre><code>
 # make install-api
</code></pre>

Die Icinga-API ist Voraussetzung für das Icinga Web-Interface (nicht für
die klassische Ansicht!).


**Anpassen der Konfiguration**

Beispiel-Konfigurationsdateien werden durch

<pre><code>
 # make install-config
</code></pre>

in /usr/local/icinga/etc/ installiert. Nun fehlt nur noch eine Änderung,
bevor Sie fortfahren können...

Ändern Sie die
*/usr/local/icinga/etc/objects/contacts.cfg*-Konfigurationsdatei mit
Ihrem bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

<pre><code>
 # vi /usr/local/icinga/etc/objects/contacts.cfg
</code></pre>

**Installieren und konfigurieren des klassischen Web-Interface**

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

<pre><code>
 #> make cgis
 #> make install-cgis
 #> make install-html
</code></pre>

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

<pre><code>
 $(INSTALL) -D -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
</code></pre>

in

<pre><code>
 $(INSTALL) -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
</code></pre>

<pre><code>
 # make install-webconf
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.9 installiert der Befehl 'make install-webconf-auth'
zusätzlich die Datei `htpasswd.users`, die
Anmeldeinformationen für den Benutzer *icingaadmin* enthält, so dass Sie
den nächsten Schritt überspringen können. Das Passwort lautet
*icingaadmin*.

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie

<pre><code>
 # htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
</code></pre>

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

<pre><code>
 # htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
</code></pre>

Starten Sie Apache neu, damit die Änderungen wirksam werden.

<pre><code>
 # /usr/local/etc/rc.d/apache2 reload
</code></pre>

**Kompilieren und installieren der Monitoring Plugins**

Entpacken Sie die Monitoring Plugins-Plugins-Quellcode-Archivdatei.

<pre><code>
 # tar xvzf nagios-plugins-2.1.tar.gz
</code></pre>

Kompilieren und installieren Sie die Plugins, indem Sie das
Installationverzeichnis auf /usr/local/icinga

<pre><code>
 # ./configure --prefix=/usr/local/icinga \
</code></pre>

**Icinga starten**

Fügen Sie Icinga zur Liste der System-Services hinzu, damit es
automatisch beim Start des Systems gestartet wird (stellen Sie sicher,
dass Sie das Init-Script vorher installiert haben).

<pre><code>
 # echo icinga_enable=\"YES\" >> /etc/rc.conf
</code></pre>

Überprüfen Sie die Icinga-Konfigurationsdateien.

<pre><code>
 # /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
</code></pre>

Wenn es dabei keine Fehler gibt, starten Sie Icinga.

<pre><code>
 # /usr/local/etc/rc.d/icinga start
</code></pre>

**Anmelden am klassischen Web-Interface**

Sie sollten nun auf das klassische Icinga-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*icingaadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

<pre><code>
 http://localhost/icinga/
</code></pre>

oder

<pre><code>
 http://yourdomain.com/icinga/
</code></pre>

Klicken Sie auf den "Service Detail"-Verweis in der Navigationsleiste,
um Details darüber zu erhalten, was auf Ihrer lokalen Maschine überwacht
wird. Es wird ein paar Minuten dauern, bis Icinga alle mit Ihrer
Maschine verbundenen Services geprüft hat, weil die Prüfungen über eine
gewisse Zeit verteilt werden.

**Andere Modifikationen**

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

<pre><code>
 # TCP port 80
</code></pre>

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


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
