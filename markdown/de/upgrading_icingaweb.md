 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

6.7. Aktualisierung von Icinga Web und Icinga Web Datenbank
-----------------------------------------------------------

6.7.1. [Aktualisieren von Icinga
Web](upgrading_icingaweb.md#upgradingicingaweb)

6.7.2. [Die Aktualisierung von Icinga
Web](upgrading_icingaweb.md#upgrade)

6.7.3. [Aktualisieren der Icinga Web
Datenbank](upgrading_icingaweb.md#upgradedatabase)

### 6.7.1. Aktualisieren von Icinga Web

Sobald neuere Versionen von Icinga Web herauskommen, sollten Sie
dringend über eine Aktualisierung nachdenken. Neuere Ausgaben enthalten
Behebungen von kritischen Fehlern, so dass es wichtig ist, aktuell zu
sein. Wenn Sie bereits Icinga Web, wie in den Schnellstartanleitungen
beschrieben, aus dem Quellcode installiert haben, dann können Sie
einfach neuere Versionen installieren.

Stellen Sie sicher, dass Sie eine vollständige Datensicherung Ihrer
bestehenden Icinga Web-Installation und der Konfigurationsdateien haben
(wenn Sie Ihre benutzerdefinierte Konfiguration in \*.site.xml- Dateien
erstellt haben, so werden diese während der Aktualisierung nicht
überschrieben!). Wenn irgendetwas schief geht oder nicht funktioniert,
dann können Sie auf diese Weise schnell Ihre alte Icinga Web-Version
wiederherstellen.

Bitte denken Sie daran, dass `configure` mit den gleichen
Optionen wie bei der vorherigen Installation aufzurufen ist! Die
verwendeten Optionen sehen Sie im `config.log.`

![[Anmerkung]](../images/note.png)

Anmerkung

Seit 1.9 ist der Tackle-Cronk in Icinga Web veraltet.

![[Anmerkung]](../images/note.png)

Anmerkung

Mit 1.9 wurde die Datei `.htaccess` enfernt und alle Rewrite
Regeln in die Apacheconfiguration übernommen.

Bitte aktualisieren Sie ihre Apache Konfiguration
`icinga-web.conf` (`etc/conf.d/icinga-web.conf` im Quell
Tarball) oder führen Sie `make install-apache-config` aus.

Beim Update einer vorhandenen Installation sollten die
`.htaccess` Dateien in `/usr/local/icinga-web/pub/` und
`/usr/local/icinga-web/pub/soap/` (oder wo Sie Icinga Web
installiert haben) entfernt werden.

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit 1.8.2 gibt es einen neuen Session-Cache, der beim Update
von Icinga Web bzw. der Installation eines neuen Cronks oder Moduls ggf.
zu Irritationen führen kann. Wenn Sie ein Verhalten feststellen wie "Ich
kann meinen neu installierten Cronk nicht sehen" oder "nach einem Update
kann ich nicht auf das Reporting-Cronk zugreifen", dann ist die Lösung
recht einfach





![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass es einige wesentliche Änderungen mit Icinga 1.5
gab, die ggf. zusätzliche Aktionen erfordern könnten:





Falls Sie Icinga-Web \<= 1.4x benutzen, dann empfehlen wir eine
Neuinstallation anstatt einer Aktualisierung. Es ist besser, Ihre alten
Konfigurationsdateien in die neue Struktur zu kopieren, weil es viele
geänderte und gelöschte Dateien gibt, um die wir uns bei einer
Aktualisierung ggf. nicht kümmern.

![[Anmerkung]](../images/note.png)

Anmerkung

Falls Sie die PNP Template Extensions für Icinga Web installiert haben,
müssen Sie diese ebenfalls aktualisieren (sowie den Cache leeren!).

### 6.7.2. Die Aktualisierung von Icinga Web

Bitte laden Sie das Archiv von
[http://www.icinga.org/download/](http://www.icinga.org/download/)
herunter. Falls Sie ein Problem haben, das in der aktuellen
Entwicklerversion behoben ist, dann klonen Sie den aktuellsten git-
Branch mit :

<pre><code>
 #> git clone git://git.icinga.org/icinga-web.git
</code></pre>

Entpacken Sie das Archiv (tarball):

<pre><code>
 #> tar xzvf icinga-web-1.13.tar.gz
</code></pre>

Wechseln Sie in das Verzeichnis

<pre><code>
 #> cd icinga-web-1.13
</code></pre>

Icinga Web bietet diverse Konfigurationsoptionen an:

<pre><code>
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass Sie hier die Icinga Web-Datenbank
konfigurieren, und nicht die Icinga-IDOUtils-Datenbank! User- und
Gruppenname des Web-Prozesses sind abhängig von der verwendeten
Distribution.

Alle configure- Optionen sehen Sie mit:

<pre><code>
 #> ./configure --help
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie configure ohne weitere Optionen ausführen, erwartet der
Installer die Icinga API unter /usr/local/icinga/share/icinga-api.

Die Aktualisierung von Icinga Web unter /usr/local/icinga-web erfolgt
mit:

<pre><code>
 #> ./configure
 #> make upgrade
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte denken Sie daran den Cache zu leeren!

<pre><code>
 #> rm -rf app/cache/config/*.php
</code></pre>

oder /path/to/clearcache.sh

<pre><code>
 #> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

Das war's, Sie können sich nun an Ihrem aktualisierten Icinga Web
anmelden.

Bekannte Fehler sind
[hier](icinga-web-scratch.md#webtroubleshooting "6.5.6. Test & Fehler?")
beschrieben.

### 6.7.3. Aktualisieren der Icinga Web Datenbank

Die Aktualisierung Ihrer Icinga Web Datenbank ist zwingend erforderlich
sofern es Änderungen am Schema gegeben hat. Sollten Sie kein Update SQL
Script auf das aktuelle Release vorfinden, müssen Sie nichts tun. Wenn
Sie eine ältere Icinga Web Datenbank-Version aktualisieren, dann müssen
Sie außerdem diese Anpassungen manuell ausführen. Wenn Sie
rpm/deb-Pakete benutzen, lesen Sie bitte die Hinweise und/oder fragen
Sie den Maintainer, der diese Anpassungen in der Installationsroutine
hinzugefügt hat.

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von den Änderungen und der Größe Ihrer Datenbank kann es eine
Weile dauern, die Anpassungen durchzuführen. Bitte haben Sie ein wenig
Geduld und brechen Sie das Script nicht ab, weil sonst ggf. Ihre Daten
unbrauchbar sind.

Die Update-Dateien finden Sie zusammen mit den
Datenbank-Installationsdateien in
`/path/to/icinga-web/etc/schema/updates`

Die Syntax ist wie folgt

`<rdbm>_<alteVersion>_to_<neueVersion>.sql`

wobei \<rdbm\> mysql, pgsql oder oracle sein kann und \<neueVersion\>
zeigt auf die Version, auf die Sie aktualisieren wollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie eine ältere Version aktualisieren wollen und zwischen dieser
und der aktuellen noch andere Versionen liegen, dann sollten Sie
beachten, dass Sie auch die dazwischen liegenden Updates inkrementell
installieren müssen!










* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
