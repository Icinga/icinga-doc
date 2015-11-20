 ![Icinga](../images/logofullsize.png "Icinga") 

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
Version hinzugefügt wurden, in `sample-config/updates/` sowie
`module/idoutils/config/updates`, z.B.
`cgi.cfg_added_1.7_to_1.8.cfg`.

Der Core wird unbekannte Macros nicht mehr "as is" belassen, sondern
diese entfernen und eine Warnung ins Log schreiben. Entweder korrigieren
Sie die Konfiguration (falsche Macros, Dollarzeichen mit einem weiteren
absichern) oder Sie setzen keep\_unknown\_macros=1 in der
`icinga.cfg`-Datei, um zum alten Verhalten zurückzukehren.

Die klassische GUI (Classic UI) liefert kein WAP Interface
(statuswml.cgi) sowie keine 3D Statusmap (statuswrl.cgi) mehr mit, weil
diese nicht mehr aktiv weiterentwickelt und verwendet werden. Aus diesem
Grund wurden auch die Hostkonfigurationsattribute "vrml\_image" und
"3dcoords" als veraltet markiert.

Bitte werfen Sie auch einen Blick in den Abschnitt "CHANGES" in der
Datei `changelog`.

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

Seit 1.9 ist die Direktive `event_profiling_enabled` in
`icinga.cfg` veraltet.

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
`sudo -s icinga` benutzen.

<pre><code>
 $> su -l icinga
</code></pre>

Holen Sie sich das Quellcode-Archiv der letzten Icinga-Version (besuchen
Sie [https://www.icinga.org/](http://www.icinga.org/) für den Verweis
auf die letzte Version) und entpacken Sie das Quellcode-Archiv.

Starten Sie das Icinga-configure-Script mit den gleichen Optionen wie
bei der letzten Installation, z.B. so:

<pre><code>
 #> ./configure --with-command-group=icinga-cmd
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Icinga 1.9 hat sich der Default geändert, so dass Sie die
Kompilation der IDOUtils ggf. explizit verhindern müssen.

<pre><code>
 #> ./configure --with-command-group=icinga-cmd --disable-idoutils
</code></pre>

Kompilieren Sie den Icinga-Quellcode.

<pre><code>
 #> make all
</code></pre>

Installieren Sie aktualisierte Programme, Dokumentation und
Web-Interface. Ihre vorhandenen Konfigurationsdaten werden in diesem
Schritt nicht überschrieben.

<pre><code>
 #> make install install-base install-cgis install-html install-init install-commandmode install-idoutils
</code></pre>

Überprüfen Sie Ihre Konfigurationsdateien und starten Sie Icinga erneut.

<pre><code>
 #> /etc/init.d/icinga checkconfig
 #> /etc/init.d/icinga restart
</code></pre>

**Aktualisieren auf Apache 2.4**

Beginnend mit Apache 2.4 hat sich der Standard-Konfigurationsordner von
`/etc/apache2/conf.d` in
`/etc/apache2/conf-available` geändert. Wenn Sie migrieren
wollen, dann verschieben Sie einfach die Datei(en), aktivieren die
Konfiguration(en) und starten den Web-Server neu

</code></pre> 
#> mv /etc/apache2/conf.d/icinga*.conf /etc/apache2/conf-available
#> a2enconf icinga icinga-web
#> service apache2 reload
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Hinter `a2enconf` geben Sie die Konfiguration(en) an. Das
Beispiel nimmt an, dass Sie Icinga Classic UI und Icinga Web installiert
haben.

Außerdem ist das CGI-Modul zu aktivieren

</code></pre> 
#> a2enmod cgi
</code></pre>


### 2.10.2. Upgrade von Nagios 3.x

Icinga ist aus Nagios 3.x hervorgegangen, so dass die Aktualisierung
problemlos sein sollte.

Falls Sie einen Upgrade von Nagios-Version 3.0.x durchführen, dann fehlt
Ihnen ggf. PHP.

*Debian / Ubuntu*

<pre><code>
 #> apt-get install php5 libapache2-mod-php5
</code></pre>

*Fedora / RedHat*

<pre><code>
 #> yum install php mod_php
</code></pre>

*openSuSE / SLES:* Nutzen Sie yast zur Installation der Pakete *php5*
und *apache2-mod\_php5* oder benutzen Sie zypper

<pre><code>
 #> zypper install php5 apache2-mod_php5
</code></pre>

Stellen Sie sicher, dass Sie eine gute Datensicherung Ihrer bestehenden
Nagios-Installation und der Konfigurationsdateien haben. Wenn
irgendetwas schief geht oder nicht funktioniert, dann können Sie auf
diese Weise schnell Ihre alte Nagios-Version wiederherstellen.

Bitte installieren Sie Icinga anhand der
[Schnellstart-Anleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen").
Bitte beachten Sie, dass






Werden Sie der nagios-Benutzer. Debian/Ubuntu-Benutzer sollten *sudo -s
nagios* benutzen.

<pre><code>
 $ su -l nagios
</code></pre>

Holen Sie sich das Quellcode-Archiv der letzten Icinga-Version (besuchen
Sie [https://www.icinga.org/](http://www.icinga.org//) für den Verweis
auf die letzte Version).

<pre><code>
 #> wget https://github.com/Icinga/icinga-core/releases/download/v1.13/icinga-1.13.tar.gz
</code></pre>

Entpacken Sie das Quellcode-Archiv.

<pre><code>
 #> tar xzf icinga-1.13.tar.gz
</code></pre>

Starten Sie das Icinga-configure-Script mit den Optionen, die Sie beim
`./configure` von Nagios benutzt haben. Den Aufruf finden Sie in
der Datei `config.log`. Beispiel:

<pre><code>
 #> ./configure --with-command-group=nagcmd
</code></pre>

Kompilieren Sie den Icinga-Quellcode.

<pre><code>
 #> make all
</code></pre>

Installieren Sie aktualisierte Programme, Dokumentation, Web-Interface
und das Init-Script. Ihre vorhandenen Konfigurationsdaten werden in
diesem Schritt nicht überschrieben.

<pre><code>
 #> make cgis
 #> make install
 #> make install-cgis
 #> make install-init
</code></pre>

oder einfach

<pre><code>
 #> make fullinstall
</code></pre>

![[Wichtig]](../images/important.png)

Wichtig

Erst ab Icinga 1.5.0 ist `make install-config` NICHT mehr in
`make fullinstall ` enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

Kopieren Sie Ihre Konfigurationsdateien nach
`/usr/local/icinga/etc` bzw.
`/usr/local/icinga/etc/object`. Vor dem Start von Icinga
müssen Sie noch ein paar Dinge anpassen:





Kopieren Sie andere relevante Dateien von Ihrer Nagios-Installation zum
neuen Standort. Falls Sie unsicher bezüglich der Pfade sind, dann werfen
Sie einen Blick in die Konfigurationsdateien `nagios.cfg`
und/oder `icinga.cfg`.





Überprüfen Sie Ihre Konfigurationsdateien und starten Sie Icinga.

<pre><code>
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
 #> /etc/init.d/icinga start
</code></pre>


Bitte beachten Sie, dass



### 2.10.3. Upgrade von Nagios 2.x

Es sollte nicht allzu schwierig sein, von Nagios 2.x auf Icinga 1.13 zu
aktualisieren. Die Aktualisierung ist im Wesentlichen die gleiche wie
die von bestehenden Nagios 3.x-Versionen. Allerdings müssen Sie Ihre
Konfigurationsdateien ein wenig ändern, damit sie mit Icinga 1.13
funktionieren:









Stellen Sie außerdem sicher, dass Sie den "[Was gibt's
Neues](whatsnew.md "1.2. What's New in Icinga 1.13")"-Abschnitt in der
Dokumentation lesen. Er beschreibt all die Änderungen am Icinga-Code.

### 2.10.4. Aktualisierung einer RPM-Installation

Wenn Sie momentan eine RPM- oder Debian/Ubuntu-APT-paketbasierte
Nagios-Installation haben und nun den Übergang zu einer Installation aus
dem offiziellen Quellcode machen wollen, dann sind hier die
grundlegenden Schritte:















Beachten Sie, dass verschiedene RPM- oder APT-Pakete Nagios auf
verschiedene Weisen oder an verschiedenen Orten installieren. Stellen
Sie sicher, dass Sie all Ihre kritischen Nagios-Dateien gesichert haben,
bevor Sie das Original-RPM- oder APT-Paket entfernen, so dass Sie darauf
zurückgreifen können, wenn Sie auf Probleme stoßen.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
