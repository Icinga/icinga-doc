![Icinga](../images/logofullsize.png "Icinga")

6.5. Installation des Icinga Web Frontend

[Zurück](cgicmd.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](icinga-web-config.md)

* * * * *

6.5. Installation des Icinga Web Frontend
-----------------------------------------

6.5.1. [Einleitung](icinga-web-scratch.md#introduction)

6.5.2. [Voraussetzungen](icinga-web-scratch.md#prerequisites)

6.5.3. [Die Installation](icinga-web-scratch.md#install)

6.5.4. [Einstellungen](icinga-web-scratch.md#settings)

6.5.5. [Testen](icinga-web-scratch.md#useit)

6.5.6. [Test & Fehler?](icinga-web-scratch.md#webtroubleshooting)

### 6.5.1. Einleitung

Das neue Icinga Web wird aktuell sehr stark weiterentwickelt, sodass
sich diese Dokumentation unter Umständen noch ändern kann/wird. Falls
Sie eine detaillierte Installationsanleitung benötigen, konsultieren Sie
bitte `doc/INSTALL`{.filename} aus dem Source-Paket. Mehr Informationen
über die gesamte Architektur können Sie auf unserer Webseite nachlesen:
[https://www.icinga.org/architecture/](http://www.icinga.org/architecture/)
Falls Sie mehr über das Icinga Web-Development und die Modularchitektur
wissen wollen, verfolgen Sie bitte stetig aktualisierte Einträge im
Development-Wiki von Icinga Web: [Icinga
Wiki](https://dev.icinga.org/projects/icinga-development/wiki#24-Icinga-Web)

Diese Installationsanleitung beschreibt die Installation von Icinga Web
mit MySQL bzw. PostgreSQL als verwendeter Datenbank, außerdem wird
Oracle unterstützt.

### 6.5.2. Voraussetzungen

-   **MySQL**

    Die Pakete mysql und php5 sind installiert (mit PEAR und CLI),
    Icinga samt IDOUtils läuft, dann ab zu 2., ansonsten bitte:

    -   **Ubuntu / Debian**

        ~~~~ {.screen}
         #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php5-mysql php5-ldap php-soap php5-gd php5-mysql
        ~~~~

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Neuere PHP-Versionen (\>= 5.5) werden (aus Lizenzgründen) mit
        einem separaten JSON-Paket ausgeliefert, so dass Sie das Paket
        separat installieren müssen.

        Prüfen Sie, ob das Modul bereits vorhanden ist:

        ~~~~ {.programlisting}
         #> php -m | grep -i json
        ~~~~

        Falls dort kein Modul ausgegeben wird, installieren Sie das
        Modul:

        ~~~~ {.programlisting}
         #> apt-get install php5-json
        ~~~~

    -   **Fedora / RHEL / CentOS**

        Stellen Sie sicher, dass Sie ein Repository bzw. Pakete für PHP
        5.2.3 und PCRE 7.6 haben - RHEL/CentOS \<= 5.x enthalten bisher
        lediglich PHP 5.1.6 und PCRE 6.6.

        ~~~~ {.screen}
         #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-ldap php-soap php-gd php-mysql
        ~~~~

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Aktuelle Pakete für PHP und PRCE finden Sie beispielsweise
        unter: [Les RPM de
        Remi](http://blog.famillecollet.com/pages/Config-en) oder
        [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Benutzen Sie yast, um die Pakete "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-mysql", "php5-soap", "php5-gettext", "php5-pdo",
        "php5-ldap", "php5-gd" und "apache2-mod\_php5" zu installieren.
        Die CLI ist im php5-Paket enthalten.

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Zumindest bei SLES10 SP2 fehlt die Funktion hash\_hmac.

        Alternativ können Sie auch zypper verwenden

        ~~~~ {.screen}
         #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
            php5-mysql php5-soap php5-gettext php5-pdo php5-ldap php5-gd apache2-mod_php5
        ~~~~

-   **PostgreSQL**

    Die Pakete pgsql und php5 sind installiert (mit PEAR und CLI),
    Icinga samt IDOUtils läuft, dann ab zu 2., ansonsten bitte:

    -   **Ubuntu / Debian**

        ~~~~ {.screen}
         #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php5-ldap php5-soap php5-gd php5-pgsql
        ~~~~

    -   **Fedora / RHEL / CentOS**

        Stellen Sie sicher, dass Sie ein Repository bzw. Pakete für PHP
        5.2.3 und PCRE 7.6 haben - RHEL/CentOS \<= 5.x enthalten bisher
        lediglich PHP 5.1.6 und PCRE 6.6.

        ~~~~ {.screen}
         #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-ldap php-gd php-pgsql
        ~~~~

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Aktuelle Pakete für PHP und PRCE finden Sie beispielsweise
        unter: [Les RPM de
        Remi](http://blog.famillecollet.com/pages/Config-en) oder
        [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Benutzen Sie yast, um die Pakete "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-pgsql", "php5-soap", "php5-gettext", "php5-pdo",
        "php5-ldap", "php5-gd" und "apache2-mod\_php5" zu installieren.
        Die CLI ist im php5-Paket enthalten.

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Zumindest bei SLES10 SP2 fehlt die Funktion hash\_hmac.

        Alternativ können Sie auch zypper verwenden

        ~~~~ {.screen}
         #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
            php5-mysql php5-soap php5-gettext php5-pdo php5-ldap php5-gd apache2-mod_php5
        ~~~~

Die Installation von Icinga mit den IDOUtils ist in der
[Icinga-Schnellstartanleitung](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
beschrieben

### 6.5.3. Die Installation

-   Laden Sie das Archiv herunter von
    [http://www.icinga.org/download/](http://www.icinga.org/download/).
    Falls Sie eine Funktion benötigen, die nur in der aktuellen
    Entwicklerversion vorhanden ist, dann klonen Sie von icinga-web.git:

    ~~~~ {.screen}
     #> git clone git://git.icinga.org/icinga-web.git
    ~~~~

    Extrahieren Sie das Archiv (tarball) wie folgt:

    ~~~~ {.screen}
     #> tar xzvf icinga-web-1.13.tar.gz
    ~~~~

    Wechseln Sie in das Verzeichnis:

    ~~~~ {.screen}
     #> cd icinga-web-1.13
    ~~~~

    Icinga Web stellt verschiedene configure-Optionen zur Verfügung z.B.

    ~~~~ {.screen}
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
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Bitte beachten Sie, dass Sie hier die Icinga Web-Datenbank
    konfigurieren, und nicht die Icinga-IDOUtils-Datenbank! User- und
    Gruppenname des Web-Prozesses sind abhängig von der verwendeten
    Distribution.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Beginnend mit Apache 2.4 hat sich der Standard-Konfigurationsordner
    von `/etc/apache2/conf.d`{.filename} in
    `/etc/apache2/conf-available`{.filename} geändert, so dass Sie
    abhängig von Ihrer Distribution (testing-Versionen von Debian /
    Ubuntu) dem Aufruf von configure diese Option hinzufügen müssen

    ~~~~ {.screen}
    #> ./configure --with-web-apache-path=/etc/apache2/conf-available
    ~~~~

    Alle Konfigurationsmöglichkeiten sehen Sie mit:

    ~~~~ {.screen}
     #> ./configure --help
    ~~~~

    Um Icinga Web für PostgreSQL zu konfigurieren, führen Sie folgenden
    Befehl aus:

    ~~~~ {.screen}
     #> ./configure --with-db-type=pgsql --with-db-port=5432
    ~~~~

    Falls auch Icinga mit pgsql läuft, sind die api-Optionen mit
    anzugeben:

    ~~~~ {.screen}
     #> ./configure --with-db-type=pgsql --with-db-port=5432 \
     --with-api-subtype=pgsql --with-api-port=5432
    ~~~~

    Ohne weitere Optionen wird das Icinga Webinterface mit:

    ~~~~ {.screen}
     #> ./configure
     #> make install
    ~~~~

    unter `/usr/local/icinga-web`{.filename} installiert. Das kann eine
    Weile dauern, also bitte nicht ungeduldig werden ;-)

    Installation der neuen Apache-Konfiguration

    ~~~~ {.screen}
     #> make install-apache-config
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Beginnend mit Apache 2.4 (testing-Versionen von Debian / Ubuntu)
    müssen Sie die Konfiguration aktivieren

    ~~~~ {.screen}
    #> a2enconf icinga-web
    ~~~~

    Wenn Sie das nicht möchten, können Sie das bisherige Verfahren
    nutzen, durch die Eingabe von:

    ~~~~ {.screen}
     #> make install-javascript
    ~~~~

    Dies installiert die bisherigen Symlinks.

    Erzeugen des Installationsberichtes:

    ~~~~ {.screen}
     #> make install-done

     Installation of icinga-web succeeded.
     Please check the new Apache2 configuration (etc/apache2/icinga-web.conf).
    ~~~~

    Passwort zurücksetzen:

    ~~~~ {.screen}
     #> make icinga-reset-password
    ~~~~

    Setzt das Passwort für jeden Account auf icinga-web zurück.

-   **Anpassen der SELinux-Einstellungen**

    RHEL und ähnliche Distributionen wie Fedora oder CentOS werden mit
    installiertem SELinux (Security Enhanced Linux) ausgeliefert und
    laufen im "Enforcing"-Modus. Dies kann zu "Internal Server
    Error"-Fehlern führen, wenn Sie versuchen, die Icinga-CGIs
    aufzurufen.

    Schauen Sie, ob SELinux im Enforcing-Modus läuft.

    ~~~~ {.screen}
     #> getenforce
    ~~~~

    Setzen Sie SELinux in den "Permissive"-Modus.

    ~~~~ {.screen}
     #> setenforce 0
    ~~~~

    Damit diese Änderung dauerhaft wird, müssen Sie diese Einstellung in
    */etc/selinux/config* anpassen und das System neustarten.

    Statt SELinux zu deaktivieren oder es in den Permissive-Modus zu
    versetzen, können Sie den folgenden Befehl benutzen, um die CGIs im
    Enforcing/Targeted-Modus laufen zu lassen. Der *semanage*-Befehl
    wird automatisch Einträge in die Datei
    `/etc/selinux/targeted/contexts/files/file_contexts.local`{.filename}
    einfügen:

    ~~~~ {.programlisting}
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/app(/.*)?'
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/lib(/.*)?'
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/pub(/.*)?'
     #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga-web/app/cache(/.*)?'
     #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga-web/log(/.*)?'
    ~~~~

    Sobald Sie die notwendigen Kontexte definiert haben, müssen die
    Einträge aktiviert werden.

    ~~~~ {.programlisting}
     #> chcon -R /usr/local/icinga-web
    ~~~~

    Einzelheiten finden Sie unter
    [http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/)
    (englisch).

-   **PHP-Abhängigkeiten**

    Bitte prüfen Sie die PHP-Abhängigkeiten mit:

    ~~~~ {.screen}
     #> make testdeps
    ~~~~

    Alle "require"-Tests sollten erfolgreich sein. Eventuell müssen Sie
    die `php.ini`{.filename} anpassen:

    Die "magic\_quote\_gpc" in der Apache- und der
    CLI-`php.ini`{.filename} auf "Off" setzen! Evtl. müssen Sie auch
    "safe\_mode" auf "off" setzen (PHP \< 5.3.0). Bitte beachten Sie,
    dass die Pfade von der Distribution abhängig sind.

    ~~~~ {.screen}
     #> vi /etc/php5/apache/php.ini
    ~~~~

    ~~~~ {.programlisting}
       magic_quotes_gpc = off
       safe_mode = off
    ~~~~

    ~~~~ {.screen}
     #> vi /etc/php5/cli/php.ini
    ~~~~

    ~~~~ {.programlisting}
       magic_quotes_gpc = off
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Beide Dateien müssen vorhanden sein, sonst erhalten Sie eine
    Agavi-Meldung, weil der Default von magic\_quotes\_gpc "ON" ist.

-   **Datenbank-Installation**

    Icinga Web benötigt eine eigene Datenbank, z.B. icinga\_web. Sie
    können die Datenbank von IDOUtils mitverwenden, dies wird allerdings
    nicht empfohlen, um bei Upgrades keine Probleme zu haben.

    **Anlegen des Datenbankbenutzers:**

    Der Benutzer muss mindestens diese Privilegien haben: SELECT,
    UPDATE, INSERT, DELETE.

    -   **MySQL**

        ~~~~ {.screen}
         # mysql -u root -p

         mysql> CREATE DATABASE icinga_web;

               GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga_web.* TO 'icinga_web'@'localhost' IDENTIFIED BY 'icinga_web';

                quit
        ~~~~

    -   **PostgreSQL**

        ~~~~ {.screen}
         #> su - postgres

         $ psql

         postgres=# CREATE USER icinga_web;

         postgres=# ALTER USER icinga_web WITH PASSWORD 'icinga_web' CREATEDB;

         <Ctrl>+<D>
        ~~~~

    **Anlegen der Datenbank**

    Icinga Web bringt Doctrine mit, womit in Zukunft die Datenbank
    verwaltet wird. Mittels 'make' kann diese initialisiert oder
    gelöscht werden.

    ~~~~ {.screen}
     #> make db-initialize      - legt eine Icinga Web Datenbank an
                                - und füllt diese mit initialen Werten
    ~~~~

    ~~~~ {.screen}
     #> make db-drop            - löscht die komplette Datenbank, inklusive
                                - Security-Abfrage, um ungewolltes Löschen zu verhindern
    ~~~~

    Um die Datenbankanlege-Befehle nutzen zu können, müssen Sie dem
    Benutzer, der diese DB-Befehle ausführen soll, auch die
    entsprechenden Privilegien zuordnen. Falls derjenige Benutzer, der
    für das Icinga-Web in `configure`{.filename} vorgesehen wurde, zu
    wenig Berechtigungen hat, gibt es in 'make' eine Abfrage, ob Sie
    einen anderen Benutzer mit mehr Privilegien verwenden wollen. Falls
    dies nicht funktioniert, sollten Sie
    `etc/build.properties`{.filename} editieren und einen root-Benutzer
    einfügen.

    Das Installieren der Datenbank funktioniert mittels:

    ~~~~ {.screen}
     #> make db-initialize
    ~~~~

    **Manuelles Anlegen der Datenbank**

    Sofern Sie die Datenbank manuell installieren wollen, z.B. für
    Package building, so finden Sie unter
    \</path/to/icinga-web/etc/schema/\> das zu importierende SQL-Script.

    -   **MySQL**

        ~~~~ {.screen}
         $ mysql -u root -p icinga_web  < /path/to/icinga-web/etc/schema/mysql.sql
        ~~~~

    -   **Oracle**

        ~~~~ {.screen}
         #> su - oracle
         $ sqlplus dbuser/dbpass
         SQL> @oracle.sql
        ~~~~

    -   **Postgresql**

        ~~~~ {.screen}
         #> su - postgres
         $ psql -U icinga_web -d icinga_web < /path/to/icinga-web/etc/schema/pgsql.sql
        ~~~~

        Bitte editieren Sie außerdem die Datei `pg_hba.conf`{.filename}
        und tragen Sie die folgenden Zeilen ein:

        ~~~~ {.screen}
         #> vi /etc/postgresql/9.x/main/pg_hba.conf
        ~~~~

        ~~~~ {.programlisting}
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
        ~~~~

        Denken Sie anschließend daran, PostgreSQL neu zu laden:

        ~~~~ {.screen}
         #> /etc/init.d/postgresql reload
        ~~~~

### 6.5.4. Einstellungen

-   **Icinga-Web-Konfiguration**

    Im Normalfall können Sie die Datenbankeinstellungen während
    `configure`{.filename} vornehmen. Sollten Sie diese allerdings
    anpassen oder im Fehlerfall kontrollieren wollen, öffnen Sie
    folgende Datei mit einem Editor Ihrer Wahl.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Möglicherweise finden Sie es einfacher, beim Editieren von
    XML-Strukturen Syntax-Hightlighting zu benutzen, um zwischen
    Kommentaren und XML-Tags zu unterscheiden.

    Editieren Sie `/etc/vim/vimrc`{.filename}

    ~~~~ {.screen}
     " Vim5 and later versions support syntax highlighting. Uncommenting the next
     " line enables syntax highlighting by default.
     syntax on
    ~~~~

    oder `/etc/nanorc`{.filename}

    ~~~~ {.screen}
     ## HTML
     include "/usr/share/nano/html.nanorc"
    ~~~~

    ~~~~ {.screen}
     #> vi app/config/databases.xml
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Optional: Ihre spezifischen Icinga Datenbankeinstellungen können Sie
    vornehmen in `etc/conf.d/database.xml`{.filename} (oder dem
    web\_conf\_path-Ziel). Es gibt zwei Datenbanken: icinga\_web (welche
    für die interne Verwaltung von icinga\_web verwendet wird) und
    icinga, welche auf die Datenbank zeigt, in die ido2db schreibt.
    Diese Informationen bleiben während eines Update-Prozesses erhalten.

    ~~~~ {.programlisting}
       <databases default="icinga_web">
          <database name="icinga_web" class="AgaviDoctrineDatabase">

             <!--
                Doctrine dsn strings:

                http://www.doctrine-project.org/documentation/manual/1_1/en/introduction-to-connections
             -->
             <!-- ##### MySQL ##### -->
             <ae:parameter name="dsn">mysql://icinga_web:icinga_web@127.0.0.1:3306/icinga_web</ae:parameter>
             <!-- ##### PostgreSQL ##### -->
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
             <!-- ##### MySQL ##### -->
             <ae:parameter name="dsn">mysql://icinga:icinga@127.0.0.1:3306/icinga</ae:parameter>
             <!-- ##### PostgreSQL ##### -->
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
          
    ~~~~

    In der `access.xml`{.filename} können Sie die Informationen zu Ihrer
    command-pipe, den Zugangsdaten und der Zugriffmethode (ssh oder via
    local console) angeben. Außerdem legen Sie fest, welche
    Icinga-Instanz welchem Host zugeordnet ist.

    ~~~~ {.programlisting}
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
          
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Nachdem Sie Änderungen an diesen Konfigurationen vorgenommen haben,
    müssen Sie den Cache leeren!

    ~~~~ {.screen}
     #> rm -rf app/cache/config/*.php
    ~~~~

    oder /path/to/clearcache.sh

    ~~~~ {.screen}
     #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

-   **Apache-Konfiguration**

    Voraussetzungen:

    -   mod\_rewrite, vielleicht müssen Sie einen Verweis erstellen:

        ~~~~ {.screen}
         #> ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
        ~~~~

        Bei OpenSuSE und SLES können Sie das Modul mit "a2enmod rewrite"
        aktivieren. Falls das nicht funktioniert, gibt es in der Datei
        `/etc/sysconfig/apache2`{.filename} die Zeile
        "APACHE\_MODULES=...", der das Modul "rewrite" hinzugefügt
        werden muss.

        Bei Debian und Ubuntu können Sie das Modul ebenfalls mit
        "a2enmod rewrite" aktivieren.

        Bei RHEL/Fedora/CentOS ist die Unterstützung bereits im httpd
        enthalten.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    In 1.9 wurde die Datei `.htaccess`{.filename} entfernt und die
    Optionen sind nun in der Apache-Konfiguration zu finden.

    Bitte wechseln Sie in das Konfigurationsverzeichnis Ihres
    Webservers. Überprüfen Sie, ob die mit **make
    install-apache-config** erstellte Konfiguration Ihren Anforderungen
    entspricht, oder erstellen Sie noch einen neuen Alias im
    Konfigurationsverzeichnis des Webservers (hier in der
    `icinga-web.conf`{.filename}):

    ~~~~ {.screen}
    #> vi /etc/apache2/conf.d/icinga-web.conf
    ~~~~

    ~~~~ {.programlisting}
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
    ~~~~

    Leeren Sie den Cache:

    ~~~~ {.screen}
     #> rm /usr/local/icinga-web/app/cache/config/*.php
    ~~~~

    oder /path/to/clearcache.sh

    ~~~~ {.screen}
     #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

    und starten Sie den Webserver neu:

    ~~~~ {.screen}
     #> service apache2 restart
    ~~~~

    bzw.

    ~~~~ {.screen}
     #> /etc/init.d/apache2 restart
    ~~~~

    oder

    ~~~~ {.screen}
     #> /etc/init.d/httpd restart
    ~~~~

### 6.5.5. Testen

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte achten Sie darauf, dass Ihre Datenbank, Apache, IDOUtils und
Icinga gestartet sind!

Öffnen Sie im Webbrowser http://localhost/icinga-web. Überprüfen Sie, ob
das Webinterface ohne Fehler ("exceptions") startet, und loggen Sie sich
mit dem User 'root' und dem Passwort 'password' ein.

Viel Spaß :-)

### 6.5.6. Test & Fehler?

![[Anmerkung]](../images/note.png)

Anmerkung

Der folgende Abschnitt versucht, einige Hinweise zu üblichen Problemen
zu geben, aber aufgrund der Natur von "geschriebenem" Material wird die
[Wiki-Seite](https://wiki.icinga.org/display/testing/Icinga+Web+Testing)
höchstwahrscheinlich aktueller sein, so dass es dort ggf. eine Lösung
gibt, die Sie hier nicht finden.

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

-   `/var/log/messages`{.filename}, /path/to/icinga/var/icinga.log

Änderungen an der Icinga Web-Konfiguration (z.B.
API/IDOUtils-Einstellungen geändert) werden nicht aktualisiert?

-   Löschen Sie den Konfigurationscache in app/cache/config/\*.php

~~~~ {.screen}
 /usr/local/icinga-web/bin/clearcache.sh
~~~~

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
    Update von Icinga Web bzw. der Installation eines neuen Cronks oder
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
    Datenbankeinstellungen für Icinga Web korrekt sind.

IDOUtils-Datenbank wird nicht gefüllt?

-   "Error writing to data sink" =\> Überprüfen Sie die IDOUtils (ido2db
    läuft 2x - ok?), ido2db.cfg debug\_level=-1, debug\_verbosity=2,
    restarten Sie IDOUtils und suchen Sie Fehler in
    `ido2db.debug`{.filename}

-   Keine Daten vorhanden =\> Überprüfen Sie `icinga.log`{.filename}, ob
    IDOMOD zu Beginn geladen wird. Falls nicht, aktivieren Sie das Event
    Broker Modul in `icinga.cfg`{.filename} so wie im Icinga Core im
    [IDOUtils Quickstart
    Guide](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
    beschrieben.

-   IDOUtils DB-Schema ist die aktuellste Version? =\> Falls nicht,
    überprüfen Sie mögliche Upgrades anhand der Docs dafür.

-   Sockets sind korrekt definiert? =\> Unix oder TCP Socket, TCP
    wahlweise mit oder ohne SSL

**Testing the Web (stellen Sie sicher, dass PHPUnit installiert ist):**

~~~~ {.screen}
 $> make test
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Falls Sie Ihren root-Benutzer zum Testen benutzen, dann stellen Sie
vorher sicher, dass für den angegebenen Web-Benutzer in der
`/etc/passwd`{.filename} eine gültige Shell eingetragen ist.
Anderenfalls werden verschiedene Tests fehlschlagen. Abhängig von der
verwendeten Icinga-Web-Version kann es sein, dass die Berechtigungen für
die Dateien in `/usr/local/icinga-web/log`{.filename} falsch gesetzt
sind, so dass Icinga-Web mit der Meldung "Loading" stehenbleibt.

![[Anmerkung]](../images/note.png)

Anmerkung

Nicht vergessen - Ändern von PHP-Einstellungen in der
`php.ini`{.filename} erfordert einen Apache reload/restart!

-   PHP Fatal error: Allowed memory size of ... bytes exhausted (tried
    to allocate ... bytes) =\> Überprüfen Sie Ihre `php.ini`{.filename}
    (apache2 und cli) und setzen Sie den Wert memory\_limit auf 128M
    oder höher

-   PHP Fatal error: Uncaught exception 'AgaviCacheException' with
    message 'Failed to write cache file
    /usr/local/icinga-web/app/cache/config/config\_handlers.xml\_development\_\_xxxx.php"
    generated from configuration file
    /usr/local/icinga-web/app/config/config\_handlers.xml". Please make
    sure you have set correct write permissions for directory
    /usr/local/icinga-web/app/cache.... =\> Setzen von safe\_mode = off
    in /etc/php5/apache/php.ini.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Das kann auch ein Hinweis auf ein aktiviertes SELinux sein.

-   [PHP Error] strtotime(): It is not safe to rely on the system's
    timezone settings. You are \*required\* to use the date.timezone
    setting or the date\_default\_timezone\_set() function. In case you
    used any of those methods and you are still getting this warning,
    you most likely misspelled the timezone identifier. We selected
    'Europe/Berlin' for 'CEST/2.0/DST' instead [line 1548 of
    /home/xxx/icinga/icinga-web/lib/doctrine/lib/Doctrine/Record.php]
    =\> Sie müssen date.timezone in der `php.ini`{.filename} definieren.

-   -\> 500 internal server error! Uncaught exception AgaviException
    thrown! Your default timezone is 'System/Localtime', ... = \> Sie
    müssen date.timezone in der `php.ini`{.filename} definieren.

-   Keine Verbindung zur API. The API Connector returned the following
    message: getConnection failed: Database connection failed:
    SQLSTATE[28000] [1045] Access denied for user 'icinga'@'localhost'
    (using password: YES)) =\> Überprüfen Sie Ihre IDOUtils
    DB-Referenzen in der `ido2db.cfg`{.filename} und fügen Sie diese in
    Ihre Icinga Web-Konfiguration als bevorzugte DB-Referenzen für Ihre
    IDO hinzu (siehe Konfiguration der Icinga API). Ab Icinga Web1.0.3
    können die Werte direkt während des configure gesetzt werden.

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
    in Ihrer `php.ini`{.filename}. =\> Editieren Sie open\_basedir in
    Ihrer `php.ini`{.filename} und fügen Sie die
    Installationsverzeichnisse von Icinga Web und von Icinga API (z.B.
    `/usr/local/icinga/share/`{.filename}) hinzu.

-   Leeres Icinga Web? =\> Wenn mod\_rewrite aktiviert ist und
    'index.php' erscheint in der angefragten URL, dann funktioniert das
    Portal nicht. Entfernen Sie index.php aus Ihrer URL und alles sollte
    funktionieren

-   Die Ergebnisse in den Status Cronks passen nicht zu Ihrer
    Konfiguration? =\> Überprüfen Sie in Ihrem Backend, d.h. IDOUtils
    DB, welche Werte für die Status-Tabellen selektiert werden.

-   Keine Daten in den Cronks ? =\> Überprüfen Sie ob alle
    Berechtigungen korrekt gesetzt sind, insbesondere von log/.
    Weiterhin können Sie die angezeigten Daten in Ihrem Browser
    debuggen. Ausführliche Informationen dazu finden Sie im Icinga-Wiki
    `https://wiki.icinga.org/display/Dev/Icinga+Web+Testing`{.uri}

Sofern Sie Fragen oder Updates haben, zögern Sie bitte nicht, uns diese
mitzuteilen! :-)

* * * * *

  --------------------------------------------------------------------- -------------------------- ------------------------------------------
  [Zurück](cgicmd.md)                                                 [Nach oben](ch06.md)      [Weiter](icinga-web-config.md)
  6.4. Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile    [Zum Anfang](index.md)    6.6. Konfigurationsübersicht Icinga Web
  --------------------------------------------------------------------- -------------------------- ------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
