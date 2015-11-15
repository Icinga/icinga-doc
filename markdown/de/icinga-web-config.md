![Icinga](../images/logofullsize.png "Icinga")

6.6. Konfigurationsübersicht Icinga Web

[Zurück](icinga-web-scratch.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](upgrading_icingaweb.md)

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
`app/config`{.filename}, aber Site-spezifische stehen im
Web-Konfigurationsordner (per Default `etc/conf.d`{.filename}), der bei
Aktualisierungen nicht überschrieben wird. Der Ordner kann während der
Installation mit Hilfe von --with-conf-dir geändert werden. Die Namen
der Dateien sind identisch zu denen in `app/config`{.filename}.

Icinga Web arbeitet mit Modulen und jedes Modul hat seine eigene
Konfiguration. Das gilt ebenfalls für die Libraries. Wenn Sie weitere
Informationen zu den Cronk-Libraries benötigen, schauen Sie in
`app/modules/Cronks/lib`{.filename} (für js in
`app/modules/Cronks/lib/js`{.filename}).

Ein Modul von Icinga Web ist wie folgt aufgebaut:

~~~~ {.programlisting}
 tree -d -L 1 app/modules/AppKit/
 app/modules/AppKit/
 |-- actions
 |-- config
 |-- lib
 |-- models
 |-- templates
 |-- validate
 |-- views
~~~~

### 6.6.2. Index

  ------------------------------------------------------------- ------------------------------- ------------------------------------------------------------------------
  **Dateiname**                                                 **Ablageort**                   **Bemerkung**
  [access.xml](icinga-web-config.md#configweb-access)         app/modules/Api/config/         Controls commands and where Icinga commands goes to
  [auth.xml](icinga-web-config.md#configweb-auth)             app/modules/AppKit/config/      Authentication configuration
  cronks.xml                                                    app/modules/Cronks/config/      System cronk and categories which are not changeable by users
  [databases.xml](icinga-web-config.md#configweb-databases)   app/config/                     Upgrade safe database connections
  [factories.xml](icinga-web-config.md#configweb-factories)   app/config/                     Agavi system config, storage and session configuration
  icinga.xml                                                    app/config/                     Icinga settings, e.g. version and prefixes / version name
  [logging.xml](icinga-web-config.md#configweb-logging)       app/config/                     Disable log levels or write new logfiles
  module\_appkit.xml                                            app/modules/AppKit/config/      Overwrite settings for AppKit module (ajax timeout, SQL query logging)
  module\_cronks.xml                                            app/modules/Cronks/config/      Overwrite settings for Cronks module
  module\_reporting.xml                                         app/modules/Reporting/config/   Overwrite settings for Reporting (multiple JasperServer ...)
  module\_web.xml                                               app/modules/Web/config/         Overwrite setting for Web module
  [settings.xml](icinga-web-config.md#configweb-settings)     app/config/                     Change agavi core settings (Title, availability, debug-mode, ...)
  sla.xml                                                       app/modules/Api/config/         SLA settings for the provider (Only used by tackle view)
  exclude\_customvars.xml                                       app/modules/Api/config/         Exclude sensitive customvars from API queries
  translation.xml                                               app/config/                     Default language, date and time formats and settings
  module.xml                                                    app/modules/Appkit/config/      Overwrite user preferences using userpreferences.xml (in etc/conf.d)
  ------------------------------------------------------------- ------------------------------- ------------------------------------------------------------------------

  : Tabelle 6.1. Konfigurationsdateien

-   [Globale
    Konfiguration](icinga-web-config.md#globalconfig "6.6.3. Globale Konfiguration")

    -   [access.xml](icinga-web-config.md#configweb-access)

    -   [databases.xml](icinga-web-config.md#configweb-databases)

    -   [factories.xml](icinga-web-config.md#configweb-factories)

        -   [Session Cookie
            Lifetime](icinga-web-config.md#configweb-session-lifetime)

    -   [logging.xml](icinga-web-config.md#configweb-logging)

    -   [settings.xml](icinga-web-config.md#configweb-settings)

    -   [translation.xml](icinga-web-config.md#configweb-translation)

    -   [views.xml](icinga-web-config.md#configweb-views)

-   [Default-Zeitzone ändern](icinga-web-config.md#configweb-timezone)

-   [Benutzervorgaben
    ändern](icinga-web-config.md#configweb-userprefs)

-   [Module-Konfiguration](icinga-web-config.md#configweb-module)

-   [Authentifizierung](icinga-web-config.md#configweb-auth)

-   [Benutzerdefinierte
    Konfiguration](icinga-web-config.md#customconfig "6.6.6. Benutzerdefinierte Konfiguration")

### 6.6.3. Globale Konfiguration

**app/config**

Hier finden Sie die globalen Konfigurationsdateien für z.B. die
Web-Session, den Icinga-Web-Pfad und die Datenbankinformationen.

Die wichtigsten Dateien:

-   access.xml

    Die Konfigurationsdatei `access.xml`{.filename} hat zwei
    Hauptzwecke:

    -   definieren von Hosts, auf die von Icinga-Web (via System oder
        ssh) zugegriffen werden kann und definieren von Dateien, auf die
        lesend/schreibend zugegriffen werden kann bzw. auszuführenden
        Programmen

    -   zuordnen von Icinga-Instanzen zu diesen Hosts

    Die `access.xml`{.filename}-Konfiguration wird von Icinga-Webs
    Console-Handler-Implementation genutzt und bietet zusätzliche
    Sicherheit, weil sie willkürliche Ausführung/Manipulation von
    Dateien in letzter Instanz verhindert.

    **Abschnitte**

    -   *Instanzen*

        Das Einrichten von Instanzen erfolgt im \<instances\>-Abschnitt:

        Beispiel: Zuordnen der Instanz 'default' zum Host 'localhost'

        ~~~~ {.screen}
        <!-- Map your instances to hosts here -->
         <instances>
            <instance name="default">localhost</instance>
         </instances>
        ~~~~

        Zulässige Unterelemente

        -   instance: Nur "instance" ist als Unterelement zulässig.
            Dieser Knoten ordnet einem Host (s.u.) einen Instanznamen
            zu, der durch den Wert des Attributs "name" festgelegt ist:

            ~~~~ {.screen}
             <instance name="%icinga instance name%">%host name%</instance>
            ~~~~

    -   *Standardwerte*

        Der "default"-Abschnitt definiert Standardwerte für
        Host-Einstellungen, z.B. auf welche Dateien schreibend/lesend
        zugegriffen werden bzw. welche ausgeführt werden können. Auch
        der Standard-Host, der von Icinga-Web benutzt werden soll, wird
        hier definiert.

        Zulässige Unterelemente

        -   defaultHost: definiert den Host, der für Aktionen benutzt
            wird, wenn kein Host angegeben ist. Dies nur für einige
            Module wichtig und es betrifft nicht Icinga-Webs
            Standardleistungsumfang.

            ~~~~ {.screen}
             <defaultHost>localhost</defaultHost>
            ~~~~

            Der Host muss im hosts-Abschnitt definiert werden.

        -   access: Icinga-Web (und Module, wenn sie korrekt geschrieben
            sind) greifen nicht direkt auf System-Ressourcen zu, sondern
            über ein Console-Interface, das sich um die Sicherheit
            kümmert. Im Zugriffsabschnitt definieren Sie, welche
            System-Ressources von dieser Behandlungsroutine aufgerufen
            werden dürfen und wo sie sich befinden. Außerdem geben Sie
            System-Ressourcen einen Ressourcen-Namen. Der
            Console-Handler bspw. greift auf die Icinga-Pipe nur über
            den Ressource-Namen "icinga\_pipe" zu.

            Der Zugriffsabschnitt hat vier zulässige Unterelemente:
            'readwrite', 'read', 'write' und 'execute', die die
            Zugriffsebene für darunterliegende Ressourcen definieren.
            Ressourcen selbst werden unter den Tags 'folders' oder
            'files' definiert und mit 'resource' eingeschlossen: Das
            folgende Beispiel erlaubt Schreib-/Lesezugriff auf Icingas
            `objects`{.filename}-Ordner. Schreiben, Lesen und Ausführen
            funktionieren analog, das 'readwrite'-Tag wird jeweils durch
            das entsprechende Tag ausgetauscht.

        ~~~~ {.screen}
         <readwrite>
            <folders>
               <resource name="icinga_objects">/usr/local/icinga/etc/objects</resource>
            </folders>
            <files>
               <resource name="icinga_cfg">/usr/local/icinga/etc/icinga.cfg</resource>
            </files>
         </readwrite>
        ~~~~

        Wie oben erwähnt ordnet jede Ressource ein Ressourcen-Symbol
        (Name) einem Pfad zu. Dies ist optional, wird aber empfohlen.
        Wenn ein Symbol mehrfach existiert, dann wird das letzte
        benutzt.

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        *Eigene Default-Definitionen in Ihrem Konfigurationsordner*

        If you override a custom section, like readwrite, all previously
        set definitions will be ignored and must be redefined if you
        want to use them. Das betrifft nicht Modul-KonfigurationenThis
        doesn't affect module configurations.

    -   *Hosts*

        Im host-Abschnitt werden Zugriffsmethoden und
        Anmeldeinformation, aber auch spezifische Rechte für Hosts
        definiert.

        Zulässige Unterelemente:

        -   host: definiert einen einzelnen Host und gibt ihm einen
            Namen, der benutzt werden kann, um auf diesen Host zu
            referenzieren (wie z.B. im "instance"-Abschnitt).

            ~~~~ {.screen}
             <!-- Example for ssh connection with user/password auth -->
             <host name="vm_host1">
                <type>ssh</type>
                <ssh-config>
                   <host>localhost</host>
                   <port>22</port>
                   <auth>
                      <type>password</type>
                      <user>john_doe</user>
                      <password>foobar</password>
                   </auth>
                </ssh-config>

                <access useDefaults="true" />
             </host>
            ~~~~

            Das 'host'-Tag hat eine Reihe von Unterelementen:

        -   type: Entweder "local" oder "ssh". Definiert, ob Befehl
            direkt auf der Maschine ausgeführt werden, auf der
            Icinga-Web läuft, oder via ssh.

        -   access: sh. den "access"-Abschnitt weiter oben. Zusätzlich
            kann 'useDefaults' gesetzt werden, um dem Command-Interface
            mitzuteilen, dass alle Standardzugriffsdefinitionen benutzt
            werden sollen (wenn sie nicht in diesem Abschnitt
            überschrieben werden).

        -   ssh-config: (nur falls type:ssh) Dies legt fest, wie auf den
            Host per ssh zugegriffen werden soll. Es gibt drei
            Authentifizierungsmethoden für ssh: 'none', 'password' oder
            'key', die im folgenden Abschnitt erläutert werden.
            Unabhängig davon, welche Methode Sie wählen, müssen die
            'host'- und 'port'-Einträge für jeden Host gesetzt werden.

    -   *SSH-Config auth*

        Dieser Abschnitt erklärt den Authentifizierungsblock der
        ssh-Konfigurationseinstellungen, die wir im vorigen Anschnitt
        angesprochen haben. Die Elemente unterhalb des 'auth'-Tags sind
        abhängig vom ausgewählten Authentifizierungstyp.

        -   Auth type: none

            Dies teilt der Console-Verbindung mit, dass nur ein
            Benutzername für die Authentifizierung verwendet wird:

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>none</type>
                   <user>john_doe</user>
                </auth>
             </ssh-config>
            ~~~~

            In diesem Beispiel wird nur der Benutzername 'john\_doe' für
            die Authentifizierung geliefert. Dies kann sinnvoll sein,
            wenn Ihre Maschinen automatische Schlüssel-Authentifizierung
            benutzen.

        -   Auth type: password

            Dies teilt der Console-Verbindung mit, dass Benutzername und
            Passwort für die Authentifizierung verwendet werden:

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>password</type>
                   <user>john_doe</user>
                   <password>foobar</password>
                </auth>
             </ssh-config>
            ~~~~

            In diesem Beispiel werden nur der Benutzername 'john\_doe'
            und das Passwort 'foobar' für die Authentifizierung
            verwendet.

        -   Auth type: key

            ![[Wichtig]](../images/important.png)

            Wichtig

            Experimentell! Probieren Sie es aus und öffnen Sie ein
            Ticket, wenn Sie Probleme haben!

            Dies teilt der Console-Verbindung mit, eine Schlüsseldatei
            für die Authentifizierung zu benutzen, die optional mit
            einem Password geschützt ist

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>key</type>
                   <user>testuser</user>
                   <private-key>/usr/local/icinga-web/app/modules/Api/lib/.ssh/host1_rsa</private-key>
                   <password>secret123</password>
                </auth>
             </ssh-config>
            ~~~~

            Hier wird der private Schlüssel benutzt, der im
            'private-key'-Tag definiert wird. Sie sollten und müssen
            diesen Pfad *nicht* im host-Zugriffsabschnitt definieren!

-   `databases.xml`{.filename} - enthält die Verbindungseinstellungen
    für Ihre Icinga Web-Datenbank

    -   *Allgemeine Einstellungen*

        Die folgenden Einstellungen gelten für jede in Icinga Web
        definierte Datenbank.

        Wenn Sie sich die Standarddefinition der icinga\_web-Datenbank
        ansehen, dann finden Sie dort die meisten Einstellungen einer
        generischen Datenbankverbindung:

        ~~~~ {.screen}
        <db:database name="icinga_web" class="AppKitDoctrineDatabase">
            <ae:parameter name="dsn">mysql://icinga_web:icinga_web@localhost:3306/icinga_web</ae:parameter>
            <ae:parameter name="charset">utf8</ae:parameter>
            <ae:parameter name="manager_attributes">
                <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
            </ae:parameter>

            <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
            <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>
            <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>


            <ae:parameter name="caching">
                <ae:parameter name="enabled">false</ae:parameter>
                <ae:parameter name="driver">apc</ae:parameter>
                <ae:parameter name="use_query_cache">true</ae:parameter>
                <ae:parameter name="use_result_cache">true</ae:parameter>
                <ae:parameter name="result_cache_lifespan">60</ae:parameter>
            </ae:parameter>

        </db:database>
        ~~~~

        -   Datenbank-Identifier

            ~~~~ {.screen}
            <db:database name="%Database name%" class="%Handler%">
               ...
            </db:database>
            ~~~~

            Mit dem db:database-Tag informieren Sie Icinga Web, dass es
            sich um eine Datenbankdefinition handelt. Dieses Tag muss
            zwei Attribute haben:

            -   name: Der Name für Ihre Datenbank. Zu dieser Zeit (\>=
                v1.5) ist 'icinga-web' für die interne
                Icinga-Web-Datenbank reserviert, die Benutzer- und
                Anmeldeinformationen, Persistenz-Einstellungen usw.
                enthält, und 'icinga' für die Datenbank, die von ido2db
                genutzt wird, um die Informationen von Icinga zu
                speichern.

            -   class: Benutzen Sie immer "AppKitDoctrineDatabase", nur
                die 'icinga'-Datenbank erfordert
                'IcingaDoctrineDatabase' (siehe unten)

        -   dsn (Data Source Name):

            Definiert die Anmeldeinformationen, den Typ und Standort der
            Datenbank:

            Für MySQL, PostgreSQL und Oracle:

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="dsn">%driver%://%username%:%password%@%host%:%port%/%database name%</ae:parameter>
                ...
            </db:database>
            ~~~~

            Für sqlite3:

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="dsn">sqlite:///%path to your db file%</ae:parameter>
                ...
            </db:database>
            ~~~~

            ![[Anmerkung]](../images/note.png)

            Anmerkung

            SQLite-Datenbanken müssen für den Webserver-Benutzern les-
            und beschreibbar sein, außerdem das Verzeichnis, in dem sich
            die Datei befindet.

            -   %driver%: Das zu benutzende Datenbank-Backend

                -   mysql: Eine MySQL-Datenbank

                -   pgsql: Eine PostgreSQL-Datenbank

                -   oracle: Eine Oracle-Datenbank, auf die über den
                    [oci8](http://www.php.net/manual/de/book.oci8.php)-Treiber
                    zugegriffen wird

                    Benutzen Sie nicht den PDO-Treiber, denn dieser ist
                    weit von produktiver Nutzung entfernt.

                -   icingaOracle: Eine spezielle Implementation, die
                    genutzt werden muss, wenn eine Icinga-Datenbank
                    verwendet wird (einige Tabellennamen sind
                    unterschiedlich und die Längen von Bezeichnern muss
                    automatisch berücksichtigt werden, um
                    sicherzustellen, dass sich kein Entwickler während
                    der Entwicklung umbringt).

            -   %username%: Der Benutzername zur DB-Authentifizierung

            -   %password%: Das Passwort zur DB-Authentifizierung

            -   %host%: Der Host Ihres DB-Servers

            -   %port%: Der Port Ihres DB-Servers

                -   mysql-default: 3306

                -   postgresql-default: 5432

                -   oracle-default: 1521

            -   %database name%: Der Name Ihrer Datenbank

        -   charset

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="charset">utf8</ae:parameter>
                ...
            </db:database>
            ~~~~

            Im Allgemeinen sollte Ihr Datenbank-Zeichensatz utf8 sein.

        -   manager\_attributes, load\_models, models\_directory

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>
                ...
            </db:database>
            ~~~~

            Sie können beruhigt diesen Abschnitt ignorieren und ihn
            einfach kopieren. Er enthält lediglich Doctrine-spezifische
            Einstellungen (insbesondere wie Datenbankmodelle geladen
            werden und wo sie zu finden sind. Wenn Sie mehr wissen
            möchten, dann schauen Sie in die [doctrine
            documentation](http://www.doctrine-project.org/projects/orm/1.2/docs/manual/introduction-to-models/en#autoloading-models)).

        -   date\_formate

            Dies ist erforderlich, um sauber auf Oracle-Datenbanken
            zuzugreifen. Es setzt das für die Datenbank zu benutzende
            Datumsformat.

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>
                ...
            </db:database>
            ~~~~

        -   Caching

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                    <ae:parameter name="use_result_cache">true</ae:parameter>
                    <ae:parameter name="result_cache_lifespan">60</ae:parameter>
                </ae:parameter>
            <db:database>
            ~~~~

            Wenn Sie apc oder memcache benutzen, dann können Sie
            entweder Datenbankabfragen oder -ergebnisse
            zwischenspeichern. Während das Zwischenspeichern von
            Abfragen eigentlich nie eine schlechte Sache ist (solange
            Sie nicht entwickeln), ist das Zwischenspeichern von
            Ergebnissen ein ziemlich spezieller Fall - denn Sie könnten
            veraltete Daten aus Ihrer Datenbank bekommen. **Also
            benutzen Sie es bitte nie für Ihre Icinga-Datenbank!**

            -   enabled: Caching für diese Datenbank ein- oder
                ausschalten

            -   driver: apc oder memcache, wobei memcache experimentell
                ist (also probieren Sie es aus !)

            -   use\_query\_cache: Abfragen zwischenspeichern (nur die
                SQL-Abfragen, nicht die Ergebnisse)

            -   use\_result\_cache: Datenbankergebnisse
                zwischenspeichern (**Gefahr!**)

            -   result\_cache\_lifespan: Wie lange Ergebnisse
                zwischengespeichert werden sollen (in Sekunden), wenn
                use\_result\_cache benutzt wird

    -   *Die "icinga\_web"-Datenbank*

        Sie müssen eine Icinga-Web-Datenbank haben, die Informationen
        über Benutzer, Anmeldeinformationen, View-Persistenz, etc.
        enthält. Diese Datenbank muss 'icinga\_web' heißen. Alle
        Einstellungen sind im vorigen Abschnitt beschrieben.

    -   *Die "icinga"-Datenbank*

        Ab Icinga-Web v1.5 wird die Icinga-API über Doctrine
        angesprochen (vorher gab es ein eigenes Projekt, die
        'icinga-api'). Im Folgenden werden nur spezielle bzw.
        zusätzliche Einstellungen erklärt. Solange nicht anders erwähnt,
        gelten alle Regeln aus ["Allgemeine
        Einstellungen"](icinga-web-config.md#configweb-general).

        -   Datenbank-Identifier

            Der Icinga-Datenbank-Identifier muss
            "IcingaDoctrineDatabase" als 'class'-Attribut und 'icinga'
            als Datenbankname benutzen, also:

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
            </db:database>
            ~~~~

        -   dsn

            Sie können die gleichen Anmeldeinformationen wie in der
            `ido2db.cfg`{.filename} benutzen, aber als
            Sicherheitsgründen ist es sehr ratsam, einen Benutzer nur
            mit Leserechten für Icinga-Web anzulegen. Nachfolgend ein
            Beispiel, welche Werte aus der `ido2db.cfg`{.filename}
            passen.

            ~~~~ {.screen}
                <ae:parameter name="dsn">mysql://db_user:db_pass@db_host:db_port/db_name</ae:parameter>
            ~~~~

        -   prefix

            Definiert den Präfix wie in `ido2db.cfg`{.filename}
            angegeben

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                <ae:parameter name="prefix">icinga_</ae:parameter>
            ...
            </db:database>
            ~~~~

            Für Oracle benutzen Sie einen leeren Wert

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                <ae:parameter name="prefix"></ae:parameter>
            ...
            </db:database>
            ~~~~

        -   use\_retained

            Whether to use retained or original data dumps (see the
            value in idomod.cfg)

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                 <ae:parameter name="use_retained">true</ae:parameter>
            </db:database>
            ~~~~

    -   *Komplettes Listing*

        ~~~~ {.screen}
        <?xml version="1.0" encoding="UTF-8"?>
         
        <databases xmlns:db="http://agavi.org/agavi/config/parts/databases/1.0" xmlns:ae="http://agavi.org/agavi/config/global/envelope/1.0">
            
            <db:database name="icinga_web" class="AppKitDoctrineDatabase">
                <ae:parameter name="dsn">mysql://icinga_web:icinga_web@localhost:3306/icinga_web</ae:parameter>
                <ae:parameter name="charset">utf8</ae:parameter>
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>

                <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
                <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>
                <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>

                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                    <ae:parameter name="use_result_cache">true</ae:parameter>
                    <ae:parameter name="result_cache_lifespan">60</ae:parameter>
                </ae:parameter>

            </db:database>
            
            <db:database xmlns="http://agavi.org/agavi/config/parts/databases/1.0" name="icinga" class="IcingaDoctrineDatabase">
                <ae:parameter name="dsn">mysql://icinga:icinga@localhost:3306/icinga</ae:parameter>
                <ae:parameter name="prefix">icinga_</ae:parameter>
                <ae:parameter name="charset">utf8</ae:parameter>
                 <ae:parameter name="use_retained">true</ae:parameter>
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>
                <ae:parameter name="load_models">%core.module_dir%/Api/lib/database/models/generated</ae:parameter>
                <ae:parameter name="models_directory">%core.module_dir%/Api/lib/database/models</ae:parameter>
                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                </ae:parameter>

            </db:database>

        </databases>
        ~~~~

-   `factories.xml`{.filename} - Agavi Systemkonfiguration, Storage- und
    Session-Konfiguration

    holds the config for your web session, e.g. the
    session\_cookie\_lifetime-parameter

    **Session Cookie Lifetime**

    Beispiel: Ändern von session\_cookie\_lifetime

    Die Session Lifetime ist die Zeit in Sekunden, bis die Icinga
    Web-Session abläuft. Sie kann auf globaler Ebene in der Datei
    `app/config/factories.xml`{.filename} konfiguriert werden.

    ~~~~ {.programlisting}
    <ae:parameter name="session_cookie_lifetime">3600<ae:parameter>
    ~~~~

    Wenn Sie die session\_cookie\_lifetime ändern möchten, editieren Sie
    bitte `app/config/factories.site.xml`{.filename}

-   `logging.xml`{.filename} - enthält die Verbindungsinformationen für
    Ihr Icinga Web

-   `settings.xml`{.filename} - Icinga-Einstellungen, z.B. Version und
    Präfixe / Versionsname

    enthält auch `icinga.xml`{.filename} (enthält die Konfiguration für
    Ihr Icinga Web ROOT-Verzeichnis und den Icinga-Web Pfad)

-   `translation.xml`{.filename} - Default-Sprache, Datum- und
    Zeitformate und Einstellungen

    Falls Ihre Zeitzone von GMT abweicht, dann müssen Sie ggf. die
    entsprechenden Einstellungen in `php.ini`{.filename} (oder in
    `translation.xml`{.filename}, falls Sie dort nicht ändern können).
    Anderenfalls erhalten Sie möglicherweise eine Fehlermeldung ähnlich
    der folgenden:

    **Abbildung 6.1. Icinga Web instance down**

    ![Icinga Web instance down](../images/icinga-web-instance-down.png)

    \

    Setzen Sie die Direktive auf einen gültigen Wert (z.B.
    'Europe/Berlin').

-   `views.xml`{.filename} - erlaubt dem Benutzer das Hinzufügen/Ändern
    von API-Ansichten.

### 6.6.4. Fehlersuche

-   Ich kann keine Befehle senden/ausführen!

    Stellen Sie sicher, dass der WebServer-Benutzer Schreibberechtigung
    auf die Icinga-Pipe besitzt und dass das "icinga\_pipe"-Symbol im
    "readwrite"- oder "write"-Abschnitt Ihres Host (oder im
    default-Abschnitt) vorhanden ist. Stellen Sie sicher, dass der Pfad
    korrekt ist.

**Icinga Web-Zeitzone**

Wenn die Zeitzone von Icinga Web von Ihrer lokalen Zeitzone abweicht,
überprüfen Sie bitte den Parameter "date.timezone" in Ihrer
`php.ini`{.filename}. Alternativ überprüfen Sie den Eintrag in
`app/modules/AppKit/config/module.xml`{.filename} (z.B. 'Europe/Berlin')

~~~~ {.programlisting}
#> vi app/modules/AppKit/config/module.xml
<ae:parameter name="date.timezone">Europe/Berlin</ae:parameter>
~~~~

**Benutzervorgaben ändern**

Die Datei `module.xml`{.filename} enthält verschiedene Einstellungen,
die durch eigene Werte überschrieben werden können, die in der Datei
`userpreferences.xml`{.filename} (im Ordner `etc/config`{.filename}
einzutragen sind).

### 6.6.5. Modul-Konfiguration:

-   **app/modules/AppKit**

    Hier "lebt" das Framework: Authentifikation, Menüs und weiteres.

    **Authentifizierung**

    Beispiel: LDAP-Authentifizierung

    Öffnen Sie `app/modules/AppKit/config/auth.xml`{.filename}.

    Ein Anbieter ist wie folgt aufgebaut:

    ~~~~ {.programlisting}
     <ae:parameter name="msad-ldap1">
                <ae:parameter name="auth_module">AppKit</ae:parameter>
                <ae:parameter name="auth_provider">Auth.Provider.LDAP</ae:parameter>
                <ae:parameter name="auth_enable">true</ae:parameter>
                <ae:parameter name="auth_authoritative">true</ae:parameter>
                <ae:parameter name="auth_create">true</ae:parameter>
                <ae:parameter name="auth_update">true</ae:parameter>

                <ae:parameter name="auth_map">
                    <ae:parameter name="user_firstname">givenName</ae:parameter>
                    <ae:parameter name="user_lastname">sn</ae:parameter>
                    <ae:parameter name="user_email">mail</ae:parameter> 
                </ae:parameter>

                <ae:parameter name="ldap_dsn">ldap://ad.icinga.org</ae:parameter>
                <ae:parameter name="ldap_basedn">DC=ad,DC=icinga,DC=org</ae:parameter>
                <ae:parameter name="ldap_binddn">ldap@AD.ICINGA.ORG</ae:parameter>
                <ae:parameter name="ldap_bindpw"><![CDATA[XXXXXXXXX]]></ae:parameter>
                <ae:parameter name="ldap_userattr">uid</ae:parameter>
                <ae:parameter name="ldap_filter_user"><![CDATA[(&(sAmAccountName=__USERNAME__))]]></ae:parameter>
            </ae:parameter>
    ~~~~

    Die `auth.xml`{.filename} hält die Dokumentation für die globale
    Konfiguration. Die LDAP-Authentifizierung sollte mit einigen
    grundlegenden LDAP-Kenntnissen möglich sein.

    Sie können die Anbieter duplizieren und so Ihre
    Authentifizierungs-Basis vergrößern.

    Bitte speichern Sie Ihre Konfiguration in
    `auth.site.xml`{.filename}!

-   **app/modules/Cronks**

    Alle Cronks werden hier implementiert: Grids und iframes. Sie sind
    einfache HTML-Seiten, die ExtJS-Komponenten-Code enthalten. Wenn Sie
    einen neuen Cronk hinzufügen möchten, wird dieses Modul Ihr Freund
    sein.

    Wenn Sie einen neuen Cronk entwickeln möchten, schauen Sie hier:
    [HowToDevelopCronks](https://dev.icinga.org/projects/icinga-development/wiki/HowToDevelopCronks)

    Die Konfiguration können Sie im Cronk-Module ändern:

    ~~~~ {.programlisting}
    #> ls app/modules/Cronks/config
    autoload.xml  config_handlers.xml  cronks.xml  module.xml  validators.xml
    ~~~~

    -   `module.xml`{.filename} - definieren von neuen Kategorien in
        denen die Cronks erscheinen, die Datei `module.xml`{.filename}
        hält dazu alle Informationen

    -   `cronks.xml`{.filename} - um auf neue Cronks zu zugreifen,
        definieren von neuen iframe Cronks

-   **app/modules/Web**

    Oder besser:**Icinga**. Dieses Modul enthält alle Icinga relevanten
    Dinge wie IcingaAPI2Json und die Statusinformationen.

### 6.6.6. Benutzerdefinierte Konfiguration

**Bitte beachten:**

Wenn Sie Konfigurationsdateien ändern oder erstellen, denken Sie bitte
an folgendes:

-   Zeilen die mit \<!-- beginnen und enden mit --\> werden als
    Kommentare interpretiert.

-   Variablennamen sind case-sensitive

![[Anmerkung]](../images/note.png)

Anmerkung

Nach dem Ändern von Konfigurationsdateien leeren Sie bitte den Cache!

~~~~ {.programlisting}
 #> rm -rf app/cache/config/*.php
~~~~

oder

~~~~ {.programlisting}
 #> /usr/local/icinga-web/bin/clearcache.sh
~~~~

Benötigen Sie weitere Informationen? Schauen Sie bitte in
unserem[Development
Wiki.](https://dev.icinga.org/projects/icinga-development/wiki/)

* * * * *

  -------------------------------------------- -------------------------- --------------------------------------------------------------
  [Zurück](icinga-web-scratch.md)            [Nach oben](ch06.md)      [Weiter](upgrading_icingaweb.md)
  6.5. Installation des Icinga Web Frontend    [Zum Anfang](index.md)    6.7. Aktualisierung von Icinga Web und Icinga Web Datenbank
  -------------------------------------------- -------------------------- --------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
