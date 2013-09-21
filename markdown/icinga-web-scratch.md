Installation des NAME-WEB Frontend
==================================

Einleitung
----------

Das neue NAME-WEB wird aktuell sehr stark weiterentwickelt, sodass sich
diese Dokumentation unter Umständen noch ändern kann/wird. Falls Sie
eine detaillierte Installationsanleitung benötigen, konsultieren Sie
bitte `doc/INSTALL` aus dem Source-Paket. Mehr Informationen über die
gesamte Architektur können Sie auf unserer Webseite nachlesen:
[URL-ICINGAarchitecture/](http://www.icinga.org/architecture/) Falls Sie
mehr über das NAME-WEB-Development und die Modularchitektur wissen
wollen, verfolgen Sie bitte stetig aktualisierte Einträge im
Development-Wiki von NAME-WEB:
[NAME-ICINGAWIKI](https://dev.icinga.org/projects/icinga-development/wiki#24-Icinga-Web)

Diese Installationsanleitung beschreibt die Installation von NAME-WEB
mit NAME-MYSQL bzw. NAME-POSTGRES als verwendeter Datenbank, außerdem
wird NAME-ORACLE unterstützt.

Voraussetzungen
---------------

-   **NAME-MYSQL**

    Die Pakete mysql und php5 sind installiert (mit PEAR und CLI),
    NAME-ICINGA samt IDOUtils läuft, dann ab zu 2., ansonsten bitte:

    -   **Ubuntu / Debian**

             #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php5-pdo php5-ldap php5-soap php5-gd php5-mysql

        > **Note**
        >
        > Für NAME-UBUNTU gibt es kein php5-pdo-Paket, die benötigten
        > PDO-Extensions sind in den Paketen php5 und php5-mysql
        > enthalten!

    -   **Fedora / RHEL / CentOS**

        Stellen Sie sicher, dass Sie ein Repository bzw. Pakete für PHP
        5.2.3 und PCRE 7.6 haben - RHEL/CentOS \<= 5.x enthalten bisher
        lediglich PHP 5.1.6 und PCRE 6.6.

             #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-ldap php-soap php-gd php-mysql

        > **Note**
        >
        > Aktuelle Pakete für PHP und PRCE finden Sie beispielsweise
        > unter: [Les RPM de
        > Remi](http://blog.famillecollet.com/pages/Config-en) oder
        > [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Benutzen Sie yast, um die Pakete "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-mysql", "php5-soap", "php5-gettext", "php5-pdo",
        "php5-ldap", "php5-gd" und "apache2-mod\_php5" zu installieren.
        Die CLI ist im php5-Paket enthalten.

        > **Note**
        >
        > Zumindest bei SLES10 SP2 fehlt die Funktion hash\_hmac.

        Alternativ können Sie auch zypper verwenden

             #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
                php5-mysql php5-soap php5-gettext php5-pdo php5-ldap php5-gd apache2-mod_php5

-   **NAME-POSTGRES**

    Die Pakete pgsql und php5 sind installiert (mit PEAR und CLI),
    NAME-ICINGA samt IDOUtils läuft, dann ab zu 2., ansonsten bitte:

    -   **Ubuntu / Debian**

             #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php5-pdo php5-ldap php5-gd php5-pgsql

        > **Note**
        >
        > Für NAME-UBUNTU gibt es kein php5-pdo-Paket, die benötigten
        > PDO-Extensions sind in den Paketen php5 und php5-pgsql
        > enthalten!

    -   **Fedora / RHEL / CentOS**

        Stellen Sie sicher, dass Sie ein Repository bzw. Pakete für PHP
        5.2.3 und PCRE 7.6 haben - RHEL/CentOS \<= 5.x enthalten bisher
        lediglich PHP 5.1.6 und PCRE 6.6.

             #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-ldap php-gd php-pgsql

        > **Note**
        >
        > Aktuelle Pakete für PHP und PRCE finden Sie beispielsweise
        > unter: [Les RPM de
        > Remi](http://blog.famillecollet.com/pages/Config-en) oder
        > [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Benutzen Sie yast, um die Pakete "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-pgsql", "php5-soap", "php5-gettext", "php5-pdo",
        "php5-ldap", "php5-gd" und "apache2-mod\_php5" zu installieren.
        Die CLI ist im php5-Paket enthalten.

        > **Note**
        >
        > Zumindest bei SLES10 SP2 fehlt die Funktion hash\_hmac.

        Alternativ können Sie auch zypper verwenden

             #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
                php5-mysql php5-soap php5-gettext php5-pdo php5-ldap php5-gd apache2-mod_php5

Die Installation von NAME-ICINGA mit den IDOUtils ist in der
[Icinga-Schnellstartanleitung](#quickstart-idoutils) beschrieben

Die Installation
----------------

-   Laden Sie das Archiv herunter von
    [http://sourceforge.net/projects/icinga/files/](http://sourceforge.net/projects/icinga/files/).
    Falls Sie eine Funktion benötigen, die nur in der aktuellen
    Entwicklerversion vorhanden ist, dann klonen Sie von icinga-web.git:

         #> git clone git://git.icinga.org/icinga-web.git

    Extrahieren Sie das Archiv (tarball) wie folgt:

         #> tar xzvf icinga-web-VER-ICINGAWEB.tar.gz

    Wechseln Sie in das Verzeichnis:

         #> cd icinga-web-VER-ICINGAWEB

    NAME-WEB stellt verschiedene configure-Optionen zur Verfügung z.B.

         #> ./configure
                       --prefix=/usr/local/icinga-web
                       --with-web-user=www-data
                       --with-web-group=www-data
                       --with-web-path=/icinga-web
                       --with-web-apache-path=/etc/apache2/conf.d
                       --with-db-type=mysql
                       --with-db-host=localhost
                       --with-db-port=3306
                       --with-db-name=icinga_web
                       --with-db-user=icinga_web
                       --with-db-pass=icinga_web
                       --with-conf-dir=etc/conf.d
                       --with-log-dir=log
                       --with-api-subtype=TYPE DB driver or network connection
                       --with-api-host=HOST Host to connect (DB or other) (default localhost)
                       --with-api-port=PORT Port for connection (default 3306)
                       --with-api-socket=PATH Path to socket (default none)

    > **Note**
    >
    > Bitte beachten Sie, dass Sie hier die NAME-WEB-Datenbank
    > konfigurieren, und nicht die Icinga-IDOUtils-Datenbank! User- und
    > Gruppenname des Web-Prozesses sind abhängig von der verwendeten
    > Distribution.

    Alle Konfigurationsmöglichkeiten sehen Sie mit:

         #> ./configure --help

    Um NAME-WEB für NAME-POSTGRES zu konfigurieren, führen Sie folgenden
    Befehl aus:

         #> ./configure --with-db-type=pgsql --with-db-port=5432

    Falls auch NAME-ICINGA mit pgsql läuft, sind die api-Optionen mit
    anzugeben:

         #> ./configure --with-db-type=pgsql --with-db-port=5432 \
         --with-api-subtype=pgsql --with-api-port=5432

    Ohne weitere Optionen wird das NAME-ICINGAWEB mit:

         #> ./configure
         #> make install

    unter `/usr/local/icinga-web` installiert. Das kann eine Weile
    dauern, also bitte nicht ungeduldig werden ;-)

    Installation der neuen Apache-Konfiguration

         #> make install-apache-config

    Wenn Sie das nicht möchten, können Sie das bisherige Verfahren
    nutzen, durch die Eingabe von:

         #> make install-javascript

    Dies installiert die bisherigen Symlinks.

    Erzeugen des Installationsberichtes:

         #> make install-done

         Installation of icinga-web succeeded.
         Please check the new Apache2 configuration (etc/apache2/icinga-web.conf).

    Passwort zurücksetzen:

         #> make icinga-reset-password

    Setzt das Passwort für jeden Account auf icinga-web zurück.

-   **PHP-Abhängigkeiten**

    Bitte prüfen Sie die PHP-Abhängigkeiten mit:

         #> make testdeps

    Alle "require"-Tests sollten erfolgreich sein. Eventuell müssen Sie
    die `php.ini` anpassen:

    Die "magic\_quote\_gpc" in der Apache- und der CLI-`php.ini` auf
    "Off" setzen! Evtl. müssen Sie auch "safe\_mode" auf "off" setzen
    (PHP \< 5.3.0). Bitte beachten Sie, dass die Pfade von der
    Distribution abhängig sind.

         #> vi /etc/php5/apache/php.ini

           magic_quotes_gpc = off
           safe_mode = off

         #> vi /etc/php5/cli/php.ini

           magic_quotes_gpc = off

    > **Note**
    >
    > Beide Dateien müssen vorhanden sein, sonst erhalten Sie eine
    > Agavi-Meldung, weil der Default von magic\_quotes\_gpc "ON" ist.

-   **Datenbank-Installation**

    NAME-WEB benötigt eine eigene Datenbank, z.B. icinga\_web. Sie
    können die Datenbank von NAME-IDOUTILS mitverwenden, dies wird
    allerdings nicht empfohlen, um bei Upgrades keine Probleme zu haben.

    **Anlegen des Datenbankbenutzers:**

    Der Benutzer muss mindestens diese Privilegien haben: SELECT,
    UPDATE, INSERT, DELETE.

         SQL> GRANT USAGE ON *.* TO 'icinga_web'@'localhost' IDENTIFIED BY 'icinga_web';

         SQL> GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX
             ON icinga_web.* TO 'icinga_web'@'localhost';

    -   **NAME-MYSQL**

             #> mysql -u root -p

             mysql> GRANT USAGE ON icinga_web.* TO 'icinga_web'@'localhost'
                    IDENTIFIED BY 'icinga_web'
                    WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0;

                    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX
                    ON icinga_web.* TO 'icinga_web'@'localhost';

                    FLUSH PRIVILEGES;

                    quit

    -   **NAME-POSTGRES**

             #> su - postgres

             $ psql

             postgres=# CREATE USER icinga_web;

             postgres=# ALTER USER icinga_web WITH PASSWORD 'icinga_web' CREATEDB;

             <Ctrl>+<D>

    **Anlegen der Datenbank**

    NAME-WEB bringt Doctrine mit, womit in Zukunft die Datenbank
    verwaltet wird. Mittels 'make' kann diese initialisiert oder
    gelöscht werden.

         #> make db-initialize      - legt eine Icinga Web Datenbank an
                                    - und füllt diese mit initialen Werten

         #> make db-drop            - löscht die komplette Datenbank, inklusive
                                    - Security-Abfrage, um ungewolltes Löschen zu verhindern

    Um die Datenbankanlege-Befehle nutzen zu können, müssen Sie dem
    Benutzer, der diese DB-Befehle ausführen soll, auch die
    entsprechenden Privilegien zuordnen. Falls derjenige Benutzer, der
    für das Icinga-Web in `configure` vorgesehen wurde, zu wenig
    Berechtigungen hat, gibt es in 'make' eine Abfrage, ob Sie einen
    anderen Benutzer mit mehr Privilegien verwenden wollen. Falls dies
    nicht funktioniert, sollten Sie `etc/build.properties` editieren und
    einen root-Benutzer einfügen.

    Das Installieren der Datenbank funktioniert mittels:

         #> make db-initialize

    **Manuelles Anlegen der Datenbank**

    Sofern Sie die Datenbank manuell installieren wollen, z.B. für
    Package building, so finden Sie unter
    \</path/to/icinga-web/etc/schema/\> das zu importierende SQL-Script.

    -   **MySQL**

             $ mysql -u root -p icinga_web  < /path/to/icinga-web/etc/schema/mysql.sql

    -   **Oracle**

             #> su - oracle
             $ sqlplus dbuser/dbpass
             SQL> @oracle.sql

    -   **Postgresql**

             #> su - postgres
             $ psql -U icinga_web -d icinga_web < /path/to/icinga-web/etc/schema/pgsql.sql

        Bitte editieren Sie außerdem die Datei `pg_hba.conf` und tragen
        Sie die folgenden Zeilen ein:

             #> vi /etc/postgresql/9.x/main/pg_hba.conf

             # database administrative login by UNIX sockets
             local all postgres ident

             # TYPE DATABASE USER CIDR-ADDRESS METHOD
             #icinga_web
             local icinga_web icinga_web trust

             # "local" is for Unix domain socket connections only
             local all all trust

             # IPv4 local connections
             host all all 127.0.0.1/32 trust

             # IPV6 local connections
             host all all ::1/128 trust

        Denken Sie anschließend daran, NAME-POSTGRES neu zu laden:

             #> /etc/init.d/postgresql reload

Einstellungen
-------------

-   **Icinga-Web-Konfiguration**

    Im Normalfall können Sie die Datenbankeinstellungen während
    `configure` vornehmen. Sollten Sie diese allerdings anpassen oder im
    Fehlerfall kontrollieren wollen, öffnen Sie folgende Datei mit einem
    Editor Ihrer Wahl.

    > **Note**
    >
    > Möglicherweise finden Sie es einfacher, beim Editieren von
    > XML-Strukturen Syntax-Hightlighting zu benutzen, um zwischen
    > Kommentaren und XML-Tags zu unterscheiden.
    >
    > Editieren Sie `/etc/vim/vimrc`
    >
    >      " Vim5 and later versions support syntax highlighting. Uncommenting the next
    >      " line enables syntax highlighting by default.
    >      syntax on
    >
    > oder `/etc/nanorc`
    >
    >      ## HTML
    >      include "/usr/share/nano/html.nanorc"

         #> vi app/config/databases.xml

    > **Note**
    >
    > Optional: Ihre spezifischen NAME-ICINGA Datenbankeinstellungen
    > können Sie vornehmen in `etc/conf.d/database.xml` (oder dem
    > web-conf-folder Ziel). Es gibt zwei Datenbanken: icinga\_web
    > (welche für die interne Verwaltung von icinga\_web verwendet wird)
    > und icinga, welche auf die Datenbank zeigt, in die ido2db
    > schreibt. Diese Informationen bleiben während eines
    > Update-Prozesses erhalten.

           <databases default="icinga_web">
              <database name="icinga_web" class="AgaviDoctrineDatabase">

                 <!--
                    Doctrine dsn strings:

                    http://www.doctrine-project.org/documentation/manual/1_1/en/introduction-to-connections
                 -->
                 <!-- ##### NAME-MYSQL ##### -->
                 <ae:parameter name="dsn">mysql://icinga_web:icinga_web@127.0.0.1:3306/icinga_web</ae:parameter>
                 <!-- ##### NAME-POSTGRES ##### -->
                 <ae:parameter name="dsn">pgsql://icinga_web:icinga_web@localhost:5432/icinga_web</ae:parameter>

                 <!-- Generic credentials  -->
                 <!-- <ae:parameter name="username">icinga_web</ae:parameter> -->
                 <!-- <ae:parameter name="password">icinga_web</ae:parameter> -->

                 <!-- DB encoding type -->
                 <ae:parameter name="charset">utf8</ae:parameter>

                 <!--
                    Doctrine_Manager configuration
                 -->
                 <ae:parameter name="manager_attributes">
                    <!-- This allows lazy loading of the models -->
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                 </ae:parameter>

                 <!-- The path to our models -->
                 <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
                 <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>

              </database>

              <-- Die Icinga Datenbank für ido2db -->
              <database name="icinga" class="AgaviDoctrineDatabase">

                 <!--
                    Doctrine dsn strings:

                    http://www.doctrine-project.org/documentation/manual/1_1/en/introduction-to-connections
                 -->
                 <!-- ##### NAME-MYSQL ##### -->
                 <ae:parameter name="dsn">mysql://icinga:icinga@127.0.0.1:3306/icinga</ae:parameter>
                 <!-- ##### NAME-POSTGRES ##### -->
                 <ae:parameter name="dsn">pgsql://icinga:icinga@localhost:5432/icinga</ae:parameter>

                 <!-- Generic credentials  -->
                 <!-- <ae:parameter name="username">icinga</ae:parameter> -->
                 <!-- <ae:parameter name="password">icinga</ae:parameter> -->

                 <!-- DB encoding type -->
                 <ae:parameter name="charset">utf8</ae:parameter>

                 <!--
                    Doctrine_Manager configuration
                 -->
                 <ae:parameter name="manager_attributes">
                    <!-- This allows lazy loading of the models -->
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                 </ae:parameter>

                 <!-- The path to our models -->
                 <ae:parameter name="load_models">%core.module_dir%/Api/lib/database/models/generated</ae:parameter>
                 <ae:parameter name="models_directory">%core.module_dir%/Api/lib/database/models</ae:parameter>

              </database>
           </databases>
              

    In der `access.xml` können Sie die Informationen zu Ihrer
    command-pipe, den Zugangsdaten und der Zugriffmethode (ssh oder via
    local console) angeben. Außerdem legen Sie fest, welche
    Icinga-Instanz welchem Host zugeordnet ist.

                <!-- Map your instances to hosts here -->
                <instances>
                    <instance name="default">localhost</instance>
                </instances>
                <!-- default location of the icinga pipe -->
                <defaults>
                    <access>
                        <write>
                            <files>
                                <resource name="icinga_pipe">/usr/local/icinga/var/rw/icinga.cmd</resource>
                            </files>
                        </write>
                    </access>
                </defaults>

                <!-- Hosts that can be accessed via the console interface -->
                <hosts>
                    <host name="localhost">
                        <type>local</type>
                        <access useDefaults="true">

                        </access>
                    </host>

                    <!--  Example for ssh connection with user/password auth -->
                    <host name="remot_host">
                        <type>ssh</type>
                        <ssh-config>
                            <host>localhost</host>
                            <port>22</port>
                            <auth>
                                <type>password</type>
                                <user>john</user>
                                <password>doe</password>
                            </auth>
                        </ssh-config>

                        <access useDefaults="true" />

                    </host>
              </hosts>
              

    > **Note**
    >
    > Nachdem Sie Änderungen an diesen Konfigurationen vorgenommen
    > haben, müssen Sie den Cache leeren!

         #> rm -rf app/cache/config/*.php

    oder /path/to/clearcache.sh

         #> /usr/local/icinga-web/bin/clearcache.sh

-   **Apache-Konfiguration**

    Voraussetzungen:

    -   mod\_rewrite, vielleicht müssen Sie einen Verweis erstellen:

             #> ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

        Bei OpenSuSE und SLES können Sie das Modul mit "a2enmod rewrite"
        aktivieren. Falls das nicht funktioniert, gibt es in der Datei
        `/etc/sysconfig/apache2` die Zeile "APACHE\_MODULES=...", der
        das Modul "rewrite" hinzugefügt werden muss.

        Bei Debian und Ubuntu können Sie das Modul ebenfalls mit
        "a2enmod rewrite" aktivieren.

        Bei RHEL/Fedora/CentOS ist die Unterstützung bereits im httpd
        enthalten.

    Bitte wechseln Sie in das Konfigurationsverzeichnis Ihres
    Webservers. Überprüfen Sie, ob die mit **make
    install-apache-config** erstellte Konfiguration Ihren Anforderungen
    entspricht, oder erstellen Sie noch einen neuen Alias im
    Konfigurationsverzeichnis des Webservers (hier in der
    `icinga-web.conf`):

        #> vi /etc/apache2/conf.d/icinga-web.conf

        #
        # icinga-web apache configuration
        # - Enable all options .htaccess
        # - Add extjs library to alias
        #

        Alias /icinga-web/js/ext3 /usr/local/icinga-web/lib/ext3
        Alias /icinga-web /usr/local/icinga-web/pub
        <Directory /usr/local/icinga-web/lib/ext3>
            Order allow,deny
            Allow from all
        </Directory>
           Alias /icinga-web /usr/local/icinga-web/pub
          <Directory /usr/local/icinga-web/pub>
                AllowOverride All
          </Directory>

    Leeren Sie den Cache:

         #> rm /usr/local/icinga-web/app/cache/config/*.php

    oder /path/to/clearcache.sh

         #> /usr/local/icinga-web/bin/clearcache.sh

    und starten Sie den Webserver neu:

         #> service apache2 restart

    bzw.

         #> /etc/init.d/apache2 restart

    oder

         #> /etc/init.d/httpd restart

Testen
------

> **Note**
>
> Bitte achten Sie darauf, dass Ihre Datenbank, Apache, NAME-IDOUTILS
> und NAME-ICINGA gestartet sind!

Öffnen Sie im Webbrowser http://localhost/icinga-web. Überprüfen Sie, ob
das Webinterface ohne Fehler ("exceptions") startet, und loggen Sie sich
mit dem User 'root' und dem Passwort 'password' ein.

Viel Spaß :-)

Test & Fehler?
--------------

> **Note**
>
> Der folgende Abschnitt versucht, einige Hinweise zu üblichen Problemen
> zu geben, aber aufgrund der Natur von "geschriebenem" Material wird
> die
> [Wiki-Seite](https://wiki.icinga.org/display/testing/Icinga+Web+Testing)
> höchstwahrscheinlich aktueller sein, so dass es dort ggf. eine Lösung
> gibt, die Sie hier nicht finden.

Diese Sammlung enthält einige nützliche Informationen, wie Sie Fehler
finden und lösen können. Ebenso wird darauf hingewiesen, welche
Informationen Sie im Fehlerfall angeben sollten, wenn Sie eine Frage auf
den Mailinglisten oder auf
[http://www.icinga-portal.org](http://www.icinga-portal.org) stellen.

-   Geben Sie immer die verwendete Version an - Paket, tar.gz oder GIT?

-   Browser, Version

-   Falls das Problem mit der Datenquelle besteht: Ausführliche
    Informationen zu API, IDOUtils, Core (Version, Debug Logs).

Wo können Sie nachsehen?

-   Apache Error Logs, PHP Errors, PHP Dateien können nicht gefunden
    werden

-   `/var/log/messages`, /path/to/icinga/var/icinga.log

Änderungen an der NAME-WEB-Konfiguration (z.B.
API/IDOUtils-Einstellungen geändert) werden nicht aktualisiert?

-   Löschen Sie den Konfigurationscache in app/cache/config/\*.php

<!-- -->

     /usr/local/icinga-web/bin/clearcache.sh

Icinga-Web zeigt eine leere Seite?

-   Apache Errors Logs =\> mod\_rewrite enabled, PHP-Abhängigkeiten ok?
    'make testdeps'. Bei Debian gibt es u.a. die folgende Fehlermeldung:
    ".htaccess: Invalid command 'RewriteEngine', perhaps misspelled or
    defined by a module not included in the server configuration"

-   .htaccess/VHost-Konfiguration =\> Pfade nicht korrekt? Icinga-Web
    zeigt keine Daten?

-   "Ich kann meinen neu installierten Cronk nicht sehen" oder "nach
    einem Update kann ich nicht auf das Reporting-Cronk zugreifen"

    Beginnend mit 1.8.2 gibt es einen neuen Session-Cache, der beim
    Update von NAME-WEB bzw. der Installation eines neuen Cronks oder
    Moduls ggf. zu Irritationen führen kann. Die Lösung ist recht
    einfach

    -   Löschen Sie den xml-Cache

    -   Zurücksetzen des Applikationszustands des Benutzers (rechte
        obere Ecke -\> Preferences)

    -   Abmelden und neu anmelden (rechte obere Ecke)

        ![](../images/icinga-web-user-prefs-logout.png)

Icinga Web - Login erfolgt- aber die Seite lädt und lädt...

-   Request failed, Ressource /icinga-web/appkit/ext/application State
    could not be loaded - is the url correct? =\> mod\_rewrite enabled ?

-   Datenbankzugriff verweigert =\> Überprüfen Sie, ob die
    Datenbankeinstellungen für NAME-WEB korrekt sind.

IDOUtils-Datenbank wird nicht gefüllt?

-   "Error writing to data sink" =\> Überprüfen Sie die IDOUtils (ido2db
    läuft 2x - ok?), ido2db.cfg debug\_level=-1, debug\_verbosity=2,
    restarten Sie IDOUtils und suchen Sie Fehler in `ido2db.debug`

-   Keine Daten vorhanden =\> Überprüfen Sie `icinga.log`, ob IDOMOD zu
    Beginn geladen wird. Falls nicht, aktivieren Sie das Event Broker
    Modul in `icinga.cfg` so wie im Icinga Core im [IDOUtils Quickstart
    Guide](#quickstart-idoutils) beschrieben.

-   IDOUtils DB-Schema ist die aktuellste Version? =\> Falls nicht,
    überprüfen Sie mögliche Upgrades anhand der Docs dafür.

-   Sockets sind korrekt definiert? =\> Unix oder TCP Socket, TCP
    wahlweise mit oder ohne SSL

**Testing the Web (stellen Sie sicher, dass PHPUnit installiert ist):**

     $> make test

> **Note**
>
> Falls Sie Ihren root-Benutzer zum Testen benutzen, dann stellen Sie
> vorher sicher, dass für den angegebenen Web-Benutzer in der
> `/etc/passwd` eine gültige Shell eingetragen ist. Anderenfalls werden
> verschiedene Tests fehlschlagen. Abhängig von der verwendeten
> Icinga-Web-Version kann es sein, dass die Berechtigungen für die
> Dateien in `/usr/local/icinga-web/log` falsch gesetzt sind, so dass
> Icinga-Web mit der Meldung "Loading" stehenbleibt.

> **Note**
>
> Nicht vergessen - Ändern von PHP-Einstellungen in der `php.ini`
> erfordert einen Apache reload/restart!

-   PHP Fatal error: Allowed memory size of ... bytes exhausted (tried
    to allocate ... bytes) =\> Überprüfen Sie Ihre `php.ini` (apache2
    und cli) und setzen Sie den Wert memory\_limit auf 128M oder höher

-   PHP Fatal error: Uncaught exception 'AgaviCacheException' with
    message 'Failed to write cache file
    /usr/local/icinga-web/app/cache/config/config\_handlers.xml\_development\_\_xxxx.php"
    generated from configuration file
    /usr/local/icinga-web/app/config/config\_handlers.xml". Please make
    sure you have set correct write permissions for directory
    /usr/local/icinga-web/app/cache.... =\> Setzen von safe\_mode = off
    in /etc/php5/apache/php.ini.

    > **Note**
    >
    > Das kann auch ein Hinweis auf ein aktiviertes SELinux sein.

-   [PHP Error] strtotime(): It is not safe to rely on the system's
    timezone settings. You are \*required\* to use the date.timezone
    setting or the date\_default\_timezone\_set() function. In case you
    used any of those methods and you are still getting this warning,
    you most likely misspelled the timezone identifier. We selected
    'Europe/Berlin' for 'CEST/2.0/DST' instead [line 1548 of
    /home/xxx/icinga/icinga-web/lib/doctrine/lib/Doctrine/Record.php]
    =\> Sie müssen date.timezone in der `php.ini` definieren.

-   -\> 500 internal server error! Uncaught exception AgaviException
    thrown! Your default timezone is 'System/Localtime', ... = \> Sie
    müssen date.timezone in der `php.ini` definieren.

-   Keine Verbindung zur API. The API Connector returned the following
    message: getConnection failed: Database connection failed:
    SQLSTATE[28000] [1045] Access denied for user 'icinga'@'localhost'
    (using password: YES)) =\> Überprüfen Sie Ihre IDOUtils
    DB-Referenzen in der `ido2db.cfg` und fügen Sie diese in Ihre
    NAME-WEB-Konfiguration als bevorzugte DB-Referenzen für Ihre IDO
    hinzu (siehe Konfiguration der NAME-API). Ab NAME-WEB1.0.3 können
    die Werte direkt während des configure gesetzt werden.

-   touch: cannot touch \`/usr/local/icinga-web/.../cache/testfile.txt':
    Permission denied =\> Die Konfiguration in den xml-Dateien wird vom
    Framework ge-'pre-cached'. Daher müssen spezielle Berechtigungen für
    die Caching-Verzeichnisse gesetzt werden. Durch die Ausführung von
    icingaWebTesting.php in etc/tests können die richtigen
    Berechtigungen automatisch gesetzt werden.

-   PHP Fatal error: Uncaught exception '...' with message 'Couldn't
    locate driver named mysql' =\> Stellen Sie sicher, dass php pdo
    installiert und geladen ist, auch wenn testdeps sagt, dass alles in
    Ordnung ist.

-   Das Login wird nicht angezeigt =\> Aktivieren Sie short\_open\_tag
    in Ihrer `php.ini`. =\> Editieren Sie open\_basedir in Ihrer
    `php.ini` und fügen Sie die Installationsverzeichnisse von NAME-WEB
    und von NAME-API (z.B. `/usr/local/icinga/share/`) hinzu.

-   Leeres NAME-WEB? =\> Wenn mod\_rewrite aktiviert ist und 'index.php'
    erscheint in der angefragten URL, dann funktioniert das Portal
    nicht. Entfernen Sie index.php aus Ihrer URL und alles sollte
    funktionieren

-   Die Ergebnisse in den Status Cronks passen nicht zu Ihrer
    Konfiguration? =\> Überprüfen Sie in Ihrem Backend, d.h. IDOUtils
    DB, welche Werte für die Status-Tabellen selektiert werden.

-   Keine Daten in den Cronks ? =\> Überprüfen Sie ob alle
    Berechtigungen korrekt gesetzt sind, insbesondere von log/.
    Weiterhin können Sie die angezeigten Daten in Ihrem Browser
    debuggen. Ausführliche Informationen dazu finden Sie im Icinga-Wiki
    <https://wiki.icinga.org/display/Dev/Icinga+Web+Testing>

Sofern Sie Fragen oder Updates haben, zögern Sie bitte nicht, uns diese
mitzuteilen! :-)

Webinterface
Installation des Webinterfaces
