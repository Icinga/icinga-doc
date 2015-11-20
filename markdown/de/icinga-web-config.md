 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

6.6. Konfigurationsübersicht Icinga Web
---------------------------------------

6.6.1. [Wo sind meine
Konfigurationsdateien?](icinga-web-config.md#configfilelocation)

6.6.2. [Index](icinga-web-config.md#configfileindex)

6.6.3. [Globale Konfiguration](icinga-web-config.md#globalconfig)

6.6.4. [Fehlersuche](icinga-web-config.md#troubleshooting)

6.6.5. [Modul-Konfiguration:](icinga-web-config.md#moduleconfig)

6.6.6. [Benutzerdefinierte
Konfiguration](icinga-web-config.md#customconfig)

### 6.6.1. Wo sind meine Konfigurationsdateien?

Die von Icinga Web bereitgestellten Konfigurationsdateien stehen unter
`app/config`, aber Site-spezifische stehen im
Web-Konfigurationsordner (per Default `etc/conf.d`), der bei
Aktualisierungen nicht überschrieben wird. Der Ordner kann während der
Installation mit Hilfe von --with-conf-dir geändert werden. Die Namen
der Dateien sind identisch zu denen in `app/config`.

Icinga Web arbeitet mit Modulen und jedes Modul hat seine eigene
Konfiguration. Das gilt ebenfalls für die Libraries. Wenn Sie weitere
Informationen zu den Cronk-Libraries benötigen, schauen Sie in
`app/modules/Cronks/lib` (für js in
`app/modules/Cronks/lib/js`).

Ein Modul von Icinga Web ist wie folgt aufgebaut:

<pre><code>
 tree -d -L 1 app/modules/AppKit/
 app/modules/AppKit/
 |-- actions
 |-- config
 |-- lib
 |-- models
 |-- templates
 |-- validate
 |-- views
</code></pre>

### 6.6.2. Index

















### 6.6.3. Globale Konfiguration

**app/config**

Hier finden Sie die globalen Konfigurationsdateien für z.B. die
Web-Session, den Icinga-Web-Pfad und die Datenbankinformationen.

Die wichtigsten Dateien:























































































































































### 6.6.4. Fehlersuche



**Icinga Web-Zeitzone**

Wenn die Zeitzone von Icinga Web von Ihrer lokalen Zeitzone abweicht,
überprüfen Sie bitte den Parameter "date.timezone" in Ihrer
`php.ini`. Alternativ überprüfen Sie den Eintrag in
`app/modules/AppKit/config/module.xml` (z.B. 'Europe/Berlin')

<pre><code>
#> vi app/modules/AppKit/config/module.xml
<ae:parameter name="date.timezone">Europe/Berlin</ae:parameter>
</code></pre>

**Benutzervorgaben ändern**

Die Datei `module.xml` enthält verschiedene Einstellungen,
die durch eigene Werte überschrieben werden können, die in der Datei
`userpreferences.xml` (im Ordner `etc/config`
einzutragen sind).

### 6.6.5. Modul-Konfiguration:






















### 6.6.6. Benutzerdefinierte Konfiguration

**Bitte beachten:**

Wenn Sie Konfigurationsdateien ändern oder erstellen, denken Sie bitte
an folgendes:



![[Anmerkung]](../images/note.png)

Anmerkung

Nach dem Ändern von Konfigurationsdateien leeren Sie bitte den Cache!

<pre><code>
 #> rm -rf app/cache/config/*.php
</code></pre>

oder

<pre><code>
 #> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

Benötigen Sie weitere Informationen? Schauen Sie bitte in
unserem[Development
Wiki.](https://dev.icinga.org/projects/icinga-development/wiki/)

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
