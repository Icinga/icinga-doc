 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.6. Icinga-Schnellstart mit IDOUtils
-------------------------------------

2.6.1. [Einführung](quickstart-idoutils.md#introduction)

2.6.2. [Voraussetzungen](quickstart-idoutils.md#prerequisites)

2.6.3. [Neue Features für die
IDOUtils:](quickstart-idoutils.md#newfeatures)

2.6.4. [Installation der
Pakete](quickstart-idoutils.md#installpackages)

2.6.5. [Benutzerinformationen
erstellen](quickstart-idoutils.md#createaccount)

2.6.6. [Icinga und die Plugins
herunterladen](quickstart-idoutils.md#downloadicingaandplugins)

2.6.7. [Icinga und die IDOUtils kompilieren und
installieren](quickstart-idoutils.md#compileinstallidoutils)

2.6.8. [Kompilieren und
Installieren](quickstart-idoutils.md#compileinstall)

2.6.9. [Anpassen der
Konfiguration](quickstart-idoutils.md#customiseconfig)

2.6.10. [Aktivieren des
idomod-Eventbroker-Moduls](quickstart-idoutils.md#enableidomod)

2.6.11. [Anlegen und konfigurieren von Datenbank, Benutzer und
Berechtigungen](quickstart-idoutils.md#createidoutilsdatabase)

2.6.12. [Installieren und konfigurieren des klassischen
Web-Interface](quickstart-idoutils.md#configclassicui)

2.6.13. [Kompilieren und installieren der
Plugins](quickstart-idoutils.md#compileinstallplugins)

2.6.14. [Anpassen der
SELinux-Einstellungen](quickstart-idoutils.md#selinuxsettings)

2.6.15. [IDOUtils und Icinga
starten](quickstart-idoutils.md#startiido2dbandicinga)

2.6.16. [Automatischer Start von
IDOUtils](quickstart-idoutils.md#configstartup)

2.6.17. [Anmelden am klassischen
Web-Interface](quickstart-idoutils.md#loginclassicui)

2.6.18. [Andere Anpassungen](quickstart-idoutils.md#othermods)

2.6.19. [Fertig](quickstart-idoutils.md#done)

### 2.6.1. Einführung

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
zu liefern, wie Sie Icinga innerhalb von 30 Minuten aus dem Quellcode
installieren und Ihren lokalen Rechner damit überwachen.

lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für drei verschiedene
Linux-Distributionen: [Fedora](http://fedoraproject.org/),
[Ubuntu](http://www.ubuntu.com/) und
[openSuSE](http://www.opensuse.org/). Ähnliche Distributionen werden
wahrscheinlich auch funktionieren, darunter
[RedHat](http://www.redhat.com/), [CentOS](http://www.centos.org/),
[Debian](http://www.debian.org/) und
[SLES](http://www.novell.com/products/server/).

![[Wichtig]](../images/important.png)

Wichtig

Wenn Sie planen, Icinga OHNE IDOUtils zu nutzen, dann lesen Sie statt
dessen [Abschnitt 2.4, „Icinga-Schnellstart auf
Linux“](quickstart-icinga.md "2.4. Icinga-Schnellstart auf Linux")!

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:





### 2.6.2. Voraussetzungen

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

IDOUtils benutzt die [libdbi](http://libdbi.sourceforge.net) und die
libdbi-Treiber für verschiedene Datenbanken. Die Development-Libraries
werden ebenfalls benötigt. Die folgenden Beispiele zeigen, wie die
IDOUtils mit libdbi für MySQL oder PostgreSQL installiert werden.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.









**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

### 2.6.3. Neue Features für die IDOUtils:























### 2.6.4. Installation der Pakete

Sie können diese Pakete mit Hilfe der folgenden Befehle installieren
(als root oder mit sudo).

![[Anmerkung]](../images/note.png)

Anmerkung

Unglücklicherweise ändern sich manchmal die Paketnamen zwischen
verschiedenen Ausgaben der gleichen Distribution, so dass Sie die
Suchoption Ihres Paket-Managers nutzen sollten, falls Sie die
Fehlermeldung bekommen, dass eins der Pakete nicht gefunden wurde.




















































### 2.6.5. Benutzerinformationen erstellen

Werden Sie zum root-Benutzer.

<pre><code>
 $> su -l
</code></pre>

Erstellen Sie ein neues Benutzerkonto *icinga* und vergeben Sie ein
Passwort:

<pre><code>
</code></pre>

Bei einigen Distributionen müssen Sie die Gruppe in einem gesonderten
Schritt anlegen:

<pre><code>
 #> /usr/sbin/groupadd icinga
</code></pre>

Damit Sie über das klassische Web-Interface Befehle an Icinga senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Webbenutzer und den Icingabenutzer dieser Gruppe hinzu.

<pre><code>
 #> /usr/sbin/groupadd icinga-cmd
 #> /usr/sbin/usermod -a -G icinga-cmd icinga
 #> /usr/sbin/usermod -a -G icinga-cmd www-data
</code></pre>

(oder www, wwwrun, apache je nach Distribution)

![[Anmerkung]](../images/note.png)

Anmerkung

Bei einigen usermod-Versionen (z.B. OpenSuSE 11 bzw. SLES 11) fehlt die
Option -a. In diesen Fällen kann sie entfallen.

![[Wichtig]](../images/important.png)

Wichtig

Solaris unterstützt nur Gruppennamen bis max. 8 Zeichen, verwenden Sie
icingcmd anstelle von icinga-cmd.

### 2.6.6. Icinga und die Plugins herunterladen

Wechseln Sie in Ihr lokales Source-Verzeichnis, z.B. /usr/src

<pre><code>
 #> cd /usr/src
</code></pre>

Laden Sie die Sourcen von der [Icinga Website](http://www.icinga.org/).

Vergessen Sie nicht die [Monitoring
Plugins](https://www.monitoring-plugins.org).

### 2.6.7. Icinga und die IDOUtils kompilieren und installieren

Entpacken Sie das Icinga-Archiv

<pre><code>
 #> cd icinga-1.13
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Dieser absolute Pfad ist gemeint, wenn im Nachfolgenden von
'/path/to/icinga-src/' die Rede ist.

Führen Sie das Icinga-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Icinga 1.9 hat sich der Default geändert, so dass die
IDOUtils automatisch kompiliert werden, wenn Sie dies nicht explizit
verhindern.

<pre><code>
 #> ./configure --with-command-group=icinga-cmd
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Apache 2.4 hat sich der Standard-Konfigurationsordner von
`/etc/apache2/conf.d` in
`/etc/apache2/conf-available` geändert, so dass Sie abhängig
von Ihrer Distribution (testing-Versionen von Debian / Ubuntu) dem
Aufruf von configure diese Option hinzufügen müssen

</code></pre> 
#> ./configure --with-httpd-conf=/etc/apache2/conf-available
</code></pre>

![[Wichtig]](../images/important.png)

Wichtig

Das Kompilieren auf Solaris kann wegen unerfüllten
Bibliotheksabhängigkeiten von gethostbyname fehlschlagen. Wenn dies der
Fall ist, führen Sie folgenden Befehl vor configure aus:

<pre><code>
 #> export LIBS=-lsocket -lnsl
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Auch mit **PostgreSQL** sollten Sie nicht den Parameter
`--enable-pgsq` verwenden, denn dieser wird noch nicht
unterstützt.













### 2.6.8. Kompilieren und Installieren

Kompilieren Sie den Icinga-Source-Code. Es gibt auch eine extra Option
für IDOUtils (*make idoutils*), wenn Sie nur dieses Module erneut
kompilieren möchten. Um mögliche Optionen zu sehen, rufen Sie lediglich
"make" auf.

<pre><code>
 #> make all
</code></pre>

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien und setzen Sie die Berechtigungen für das
External-Command-Verzeichnis.

<pre><code>
 #> make install-eventhandlers
 #> make install-idoutils
</code></pre>

oder kürzer

<pre><code>
 #> make fullinstall
 #> make install-config
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 ist `make install-config` NICHT mehr in
`make fullinstall `enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.7.0 werden mit `make install-eventhandlers` einige
Beispiel-Eventhandler installiert. Das ist lediglich in
`make fullinstall` enthalten, um ein versehentliches
Überschreiben der Dateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Installieren Sie die IDOUtils und andere Ereignis-Broker-Module nur mit
dem primären Ziel **make instal****l**. Manuelles Kopieren und
Überschreiben des vorhandenen Moduls erzeugt einen Segfault des
Icinga-Kerns mit Hilfe von idomod.so, da eine Verwendung einer
temporären Kopie explizit verhindert werden soll. Dies ist nützlich für
[OMD](http://omdistro.org/)

tun...

### 2.6.9. Anpassen der Konfiguration

Beispiel-Konfigurationsdateien werden durch

<pre><code>
 #> make install-config
</code></pre>

in /usr/local/icinga/etc/ installiert.

Ändern Sie die
*/usr/local/icinga/etc/objects/contacts.cfg*-Konfigurationsdatei mit
Ihrem bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

<pre><code>
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
</code></pre>

<pre><code>
 #> cd /usr/local/icinga/etc
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
</code></pre>

Wenn Sie die IDOUtils mit ssl kompiliert haben, aktivieren Sie ssl in
der `idomod.cfg` mit

<pre><code>
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
</code></pre>

(Passen Sie die IP-Adresse an, wenn sich Ihre Datenbank nicht auf
localhost befindet!) und der `ido2db.cfg` mit

<pre><code>
 use_ssl=1
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Vergessen Sie nicht, alle anderen idomod-Clients auch neu zu kompilieren
und auf ssl umzustellen, **anderenfalls werden Sie Daten verlieren**!!!

### 2.6.10. Aktivieren des idomod-Eventbroker-Moduls

![[Wichtig]](../images/important.png)

Wichtig

Unter normalen Umständen gibt es im
`modules`-Unterverzeichnis bereits die folgende
module-Definition, so dass Sie keine Änderungen an der
Hauptkonfigurationsdatei vornehmen müssen.

</code></pre> 
 define module{
</code></pre>

Das bedeutet auch, dass ein entsprechender broker\_module-Eintrag nicht
aktiviert werden darf!

### 2.6.11. Anlegen und konfigurieren von Datenbank, Benutzer und Berechtigungen

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie wie weiter oben beschrieben das Datenbanksystem neu installiert
haben, dann müssen Sie den Datenbank-Server starten, bevor Sie eine
Datenbank anlegen können. Im Falle von MySQL erfolgt der Start z.B. mit
`/etc/init.d/mysqld start` (oder `/etc/init.d/mysql`,
abhängig von Ihrer Distribution).





































### 2.6.12. Installieren und konfigurieren des klassischen Web-Interface

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

<pre><code>
 #> cd /path/to/icinga-src
 #> make cgis
 #> make install-cgis
 #> make install-html
</code></pre>

Wenn Sie (zusätzlich) das neue Icinga-Web installieren wollen, lesen Sie
bitte [Installation des
Web-Interface](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend").

Installieren Sie die Icinga-Web-Konfigurationsdatei im Apache
conf.d-Verzeichnis.

<pre><code>
 #> cd /path/to/icinga-src
 #> make install-webconf
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.9 installiert der Befehl 'make install-webconf-auth'
zusätzlich die Datei `htpasswd.users`, die
Anmeldeinformationen für den Benutzer *icingaadmin* enthält, so dass Sie
den nächsten Schritt überspringen können. Das Passwort lautet
*icingaadmin*.

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Apache 2.4 (testing-Versionen von Debian / Ubuntu) müssen
Sie die Konfiguration aktivieren

</code></pre> 
#> a2enconf icinga
</code></pre>

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie

</code></pre> 
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von der Apache-Version müssen Sie ggf. *htpasswd2 verwenden.*

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

<pre><code>
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
</code></pre>

Starten Sie Apache neu, damit die Änderungen wirksam werden.







![[Anmerkung]](../images/note.png)

Anmerkung

Prüfen Sie die Implementierung der verbesserten CGI-Sicherheitsmaßnahmen
wie
[hier](cgisecurity.md "8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung")
beschrieben, um sicherzustellen, dass Ihre
Web-Authentifizierungsinformationen nicht kompromittiert werden.

### 2.6.13. Kompilieren und installieren der Plugins

Entpacken Sie die Plugins-Quellcode-Archivdatei.

</code></pre> 
 #> cd /usr/src
 #> tar xzf nagios-plugins-2.1.tar.gz
 #> cd nagios-plugins-2.1
</code></pre>

Kompilieren und installieren Sie die Plugins.

</code></pre> 
 #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
 #> make
 #> make install
</code></pre>

### 2.6.14. Anpassen der SELinux-Einstellungen

RHEL und ähnliche Distributionen wie Fedora oder CentOS werden mit
installiertem SELinux (Security Enhanced Linux) ausgeliefert und laufen
im "Enforcing"-Modus. Dies kann zu "Internal Server Error"-Fehlern
führen, wenn Sie versuchen, die Icinga-CGIs aufzurufen.

Schauen Sie, ob SELinux im Enforcing-Modus läuft.

</code></pre> 
 #> getenforce
</code></pre>

Setzen Sie SELinux in den "Permissive"-Modus.

</code></pre> 
 #> setenforce 0
</code></pre>

Damit diese Änderung dauerhaft wird, müssen Sie diese Einstellung in
*/etc/selinux/config* anpassen und das System neustarten.

Statt SELinux zu deaktivieren oder es in den Permissive-Modus zu
versetzen, können Sie den folgenden Befehl benutzen, um die CGIs im
Enforcing/Targeted-Modus laufen zu lassen. Der *semanage*-Befehl wird
automatisch Einträge in die Datei
`/etc/selinux/targeted/contexts/files/file_contexts.local`
einfügen:

<pre><code>
 #> semanage fcontext -a -t httpd_sys_script_exec_t '/usr/local/icinga/sbin(/.*)?'
 #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga/share(/.*)?'
 #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga/var(/.*)?'
</code></pre>

Sobald Sie die notwendigen Kontexte definiert haben, müssen die Einträge
aktiviert werden.

<pre><code>
 #> chcon -R /usr/local/icinga/sbin
 #> chcon -R /usr/local/icinga/share
 #> chcon -R /usr/local/icinga/var
</code></pre>

Einzelheiten finden Sie unter
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/)
(englisch).

### 2.6.15. IDOUtils und Icinga starten

IDOUtils muss vor Icinga gestartet werden

**IDOUtils starten**





**IDOUtils beenden**





### 2.6.16. Automatischer Start von IDOUtils

Fügen Sie IDOUtils zu der Liste der System-Services hinzu und sorgen Sie
für einen automatischen Start, wenn das System hochfährt (stellen Sie
sicher, dass Sie vorher das Init-Script installiert haben).

**Fedora / openSuSE:**

<pre><code>
 #> chkconfig --add ido2db
</code></pre>

**Debian / Ubuntu:**

<pre><code>
 #> update-rc.d ido2db defaults
</code></pre>

**Icinga starten:**

**Start von Icinga**

Überprüfen Sie die Icinga-Beispielkonfigurationsdateien.

<pre><code>
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
</code></pre>

Wenn es dabei keine Fehler gibt, starten Sie Icinga.

**Fedora / openSuSE/Ubuntu:**

<pre><code>
 #> service icinga start
</code></pre>

**Debian:**

<pre><code>
 #> /etc/init.d/icinga start
</code></pre>

**Automatischer Start von Icinga**

Fügen Sie Icinga zu der Liste der System-Services hinzu und sorgen Sie
für einen automatischen Start, wenn das System hochfährt (stellen Sie
sicher, dass Sie vorher das Init-Script installiert haben).

**Fedora / openSuSE:**

<pre><code>
</code></pre>

**Debian / Ubuntu:**

<pre><code>
 #> update-rc.d icinga defaults
</code></pre>

### 2.6.17. Anmelden am klassischen Web-Interface

Sie sollten nun auf das klassische Icinga-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*icingaadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

</code></pre> 
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

### 2.6.18. Andere Anpassungen

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

<pre><code>
 #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
</code></pre>

Die Konfiguration von e-Mail-Benachrichtigungen ist nicht Gegenstand
dieser Anleitung. Icinga ist konfiguriert, um e-Mail-Benachrichtigungen
zu versenden, aber möglicherweise ist auf Ihrem System noch kein
Mail-Programm installiert bzw. konfiguriert. Schauen Sie in Ihre
Systemdokumentation oder suchen Sie im Web nach genauen Anweisungen, wie
Ihr System konfiguriert werden muss, damit es e-Mail-Mitteilungen an
externe Adressen versendet. Mehr Informationen zu Benachrichtigungen
finden Sie [hier](notifications.md "5.11. Benachrichtigungen")

### 2.6.19. Fertig

Glückwunsch! Sie haben erfolgreich Icinga installiert. Ihre Reise in die
Überwachung hat gerade begonnen. Sie werden ohne Zweifel mehr als nur
Ihre lokale Maschine überwachen wollen, so dass Sie u.a. das folgende
[Kapitel](ch02.md "Kapitel 2. Los geht's") lesen sollten...

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
