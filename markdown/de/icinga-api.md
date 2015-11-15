![Icinga](../images/logofullsize.png "Icinga")

11.3. Keine Icinga API mehr zu installieren

[Zurück](epnplugins.md) 

Kapitel 11. Entwicklung

 [Weiter](icinga-web-api.md)

* * * * *

11.3. Keine Icinga API mehr zu installieren
-------------------------------------------

11.3.1. [Installation und Benutzung der Icinga
API](icinga-api.md#idp16704272)

11.3.2. [Konfiguration](icinga-api.md#idp16734992)

11.3.3. [Unterstützte Backends](icinga-api.md#idp16737520)

![[Wichtig]](../images/important.png)

Wichtig

In der Zeit vor dem Release der Version 1.5 sagten wir unserer Icinga
API "Tschüss" und führten ein neues API- und Web-Konzept ein.

Sie fragen sich vielleicht, was war diese API überhaupt? In der Tat,
wenn Sie keine Erweiterungen oder Anpassungen für das neue Web-Interface
entwickelt haben, dann hatten Sie wahrscheinlich wenig Kontakt mit
dieser wichtigen Projektkomponente. Als Icinga konzipiert wurde, war
eines der Hauptziele die Unterstützung der Entwicklung von Addons und
Plugins. Die API stellte einen Satz von allgemein verwendbaren
Abfragebefehlen zur Verfügung, um die Notwendigkeit zu beseitigen,
SQL-Abfragen und generell eine Menge überflüssigen Code zu schreiben.

Alles war in Ordnung, bis wir uns entschieden, etwas mehr zusätzliche
Datenbankflexibilität anzubieten. Als wir neben MySQL Unterstützung für
Oracle and PostgreSQL hinzufügten, gaben wir auch dem Icinga API-Team
etwas zusätzliche Arbeit. Mit jeder Änderung, jedem Bugfix oder neuer
Funktionalität mussten Marius, Michael L und Jannis die Abfragen für
jedes Datenbank-Backend separat anpassen. Dieser Prozess war nicht nur
kompliziert und fehlerbehaftet, sondern auch ein Zeichen dafür, dass wir
eine neue flexiblere Architektur benötigten.

Mit Icinga 1.5 wurde die externe Icinga API durch eine interne
Datenbankschicht namens Doctrine ersetzt und mit Icinga Web
verschmolzen. Ähnlich wie vorher laufen Abfragen durch diese Schicht
zwischen der Datenbank (IDOUtils) und dem Web-Interface. Trotzdem können
wir dank Doctrine mehrere Datenbank-Backends benutzen und das Abfragen
der Datenbank ist nun viel einfacher. Im Gegensatz zu SQL nutzt der
"object relational mapper" (ORM) die Doctrine Query Language, so dass
wir nun die Flexibilität ohne die Code-Duplizierung haben.

![](../images/Architecture_1.5_800px.png)

Allerdings funktionieren Abfragen mit der alten API nach wie vor, dank
des 'Legacy Layer', der alte API-Abfragen in diesen neuen ORM-Typ
umwandelt. Auf diese Weise erhalten wir die Kompatibilität mit Addons,
die für ältere Icinga-Versionen erstellt wurden. Das Rest-API ist also
weiterhin vorhanden als ein Teil von Icinga Web, und erweitert unsere
Doctrine-Schicht mit HTTP für Addons, die nur bestimmte Teile der
Überwachungsinformationen benötigen.

Durch den Wegfall einer eigenständigen API wird der durchschnittliche
Icinga-Benutzer kaum einen Unterschied bemerken, außer der Tatsache,
dass die Konfiguration nun in die `databases.xml`{.filename} verschoben
wurde. Das Beste daran ist, dass jeder Modul-Entwickler nun einfach,
ohne viel Code-Overhead, auf die Icinga-Datenbank zugreifen kann- also
Adddon-Entwickler, legt los!

Mehr (englischsprachige) Informationen gibt es in unserem Wiki:

-   [Development Guide for Icinga
    Web](https://wiki.icinga.org/display/Dev/Development+guide+for+Icinga-Web)

-   [Icinga Database
    Essentials](https://wiki.icinga.org/display/Dev/Icinga+Database+essentials)

-   [Icinga Web REST
    API](https://wiki.icinga.org/display/Dev/Icinga-Web+REST+API)

![[Wichtig]](../images/important.png)

Wichtig

Das Folgende ist veraltet

### 11.3.1. Installation und Benutzung der Icinga API

-   **Voraussetzungen**

    Sie benötigen installierte und lauffähige Versionen von Icinga und
    IDOUtils oder MKLiveStatus, um die Icinga API nutzen zu können.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Falls Sie Icinga noch nicht installiert haben, folgen Sie den
    Anweisungen in der
    [quickstart-idoutils](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")-Dokumentation.

    Wenn Sie die IDOUtils-Datenbank als Datenquelle verwenden,
    installieren Sie bitte PHP-PDO.

    -   **RHEL/Fedora/CentOS**

        Stellen Sie sicher, dass Sie ein Repository/Packages für PHP
        5.2.x zur Verfügung haben - RHEL/CentOS (CentOS \<= 5.4)
        unterstützen lediglich 5.1.6.

        ~~~~ {.programlisting}
         # yum install php-pdo php-mysql|pgsql 
        ~~~~

    -   **Debian/Ubuntu**

        ~~~~ {.programlisting}
         # apt-get install php5 php5-mysql|pgsql 
        ~~~~

    -   **openSuSE;**

        Bitte benutzen Sie yast zur Installation der Pakete php5,
        php5-pdo und php5-mysql bzw. php5-pgsql.

    **Installation und Konfiguration**

    1.  **Software**

        Klonen Sie von icinga-api.git, um einen neuen Branch zu
        bekommen:

        ~~~~ {.programlisting}
         # git clone git://git.icinga.org/icinga-api.git
        ~~~~

        oder laden Sie die Software von
        [https://git.icinga.org/index?p=icinga-api.git;a=snapshot;h=refs/heads/master;sf=tgz](https://git.icinga.org/index?p=icinga-api.git;a=snapshot;h=refs/heads/master;sf=tgz).

    2.  **Installation**

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Die Icinga API ist innerhalb des Pakets von Icinga Core,
        IDOUtils und Docs enthalten und wird während 'make install' mit
        installiert. Sofern Sie das schon durchgeführt haben, befindet
        sich die API standardmäßig in
        /usr/local/icinga/share/icinga-api/ und Sie können diesen
        Abschnitt überspringen.

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Wenn Sie die Icinga API für das neue Icinga Web benötigen und
        schon Icinga Core mit den IDOUtils installiert haben, können Sie
        diesen Guide verlassen und direkt [Icinga
        Web](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend")
        installieren.

        **Download**

        Sie können die Icinga API direkt aus dem GIT Repository
        beziehen, für einen frischen Clone führen Sie folgenden Befehl
        aus:

        ~~~~ {.programlisting}
         # git clone git://git.icinga.org/icinga-api.git
        ~~~~

        Sofern Sie lediglich ein Update benötigen:

        ~~~~ {.programlisting}
         # cd icinga-api && git pull origin master
        ~~~~

        Oder laden Sie einen Snapshot direkt über das Gitweb:
        [https://git.icinga.org/index?p=icinga-api.git;a=snapshot;h=refs/heads/master;sf=tgz](https://git.icinga.org/index?p=icinga-api.git;a=snapshot;h=refs/heads/master;sf=tgz).

        **Installation**

        Entpacken Sie die Icinga API, führen Sie configure aus und
        installieren Sie die Icinga API

        ~~~~ {.programlisting}
         # tar xzvf icinga-api-(version).tar.gz
        ~~~~

        ~~~~ {.programlisting}
         # ./configure
        ~~~~

        Sie können den Präfix definieren, wohin die Icinga API
        installiert wird, sowie den Ort der Systemkonfiguration für
        Icinga Core und IDOUtils und die ausführenden Benutzer. All
        diese Informationen werden bei einer Installation durch das Core
        Paket direkt gesetzt.

        ~~~~ {.programlisting}
         # ./configure --datarootdir=/usr/local/icinga/share \
            --sysconfdir=/usr/local/icinga/etc \
            --with-command-user=icinga-cmd \
            --with-command-group=icinga-cmd \
            --with-icinga-user=icinga \
            --with-icinga-group=icinga \
            --with-web-user=www-data \
            --with-web-group=www-data
        ~~~~

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Die --with-web...-Direktiven müssen gesetzt sein. Anderenfalls
        werden die Web-Logs nicht korrekt erstellt. Außerdem kann dies
        zu einem leeren Haupt-Cronk führen. Bitte beachten Sie, dass die
        Werte von 'user' und 'group' abhängig von der Distribution sind.

        ~~~~ {.programlisting}
         # make install
        ~~~~

### 11.3.2. Konfiguration

Wenn Sie Ihr eigenes Addon auf Basis der Icinga API entwickeln möchten,
benötigen Sie das folgende assoziative Array:

~~~~ {.programlisting}
 $idoConfig = array (
    'type'         => '<Type of database>',
    'host'         => '<Database hostname>', 
    'database'     => '<Databasename>',
    'user'         => '<Username>',
    'password'     => '<password>',
    'persistent'   => <true | false>,
    'table_prefix' => '<table prefix>', 
 );
~~~~

Beispiel:

~~~~ {.programlisting}
 $idoConfig = array (
    'type'         => 'mysql',
    'host'         => 'localhost',
    'database'     => 'ido',
    'user'         => 'idouser',
    'password'     => 'idopassword',
    'persistent'   => true,
    'table_prefix' => 'icinga_',
 );
~~~~

### 11.3.3. Unterstützte Backends

Aktuell sind folgende Backend Typen verfügbar. Mehr Information finden
Sie unter doc/icinga-api-types.txt.

-   IDOUtils DB - OK

-   Livestatus Modul - experimentell, noch nicht produktiv einsetzbar.

-   Dateibasierend, status.dat - experimentell, noch nicht produktiv
    einsetzbar.

**Benutzung**

1.  **Datenermittlung**

    Host-Namen und zugehörige Zustände

    Erzeugen Sie eine Instant der Klasse IcingaApi:

    ~~~~ {.programlisting}
     $api = IcingaApi::getConnection(IcingaApi::CONNECTION_IDO, $idoConfig);
    ~~~~

    Erzeugen Sie die Suchkriterien:

    ~~~~ {.programlisting}
     $apiRes = $api->createSearch()
     ->setSearchTarget(IcingaApi::TARGET_HOST)
     ->setResultColumns(array('HOST_NAME', 'HOST_CURRENT_STATE'))
     ->fetch();
    ~~~~

    Mit Hilfe von setSearchFilter() können Sie Filter benutzen, um die
    Suche einzuschränken:

    ~~~~ {.programlisting}
     $apiRes = $api->createSearch()
     ->setSearchTarget(IcingaApi::TARGET_HOST)
     ->setResultColumns(array('HOST_NAME', 'HOST_CURRENT_STATE'))
     ->setSearchFilter(HOST_NAME, 'Switch%', IcingaApi::MATCH_LIKE)
     ->fetch();
    ~~~~

2.  **Verarbeiten der Ergebnisse**

    ~~~~ {.programlisting}
     foreach($apiRes as $apiHandle){
        echo 'Host '.$apiHandle->HOST_NAME.' has state '.$apiHandle->HOST_CURRENT_STATE.'<br />';
     }
    ~~~~

    Ausgabe ohne Filter:

    ~~~~ {.programlisting}
     Host localhost has state 0
     Host MySql has state 0
     Host router-01 has state 0
     Host windows100 has state 0
     Host Apache_01 has state 0
    ~~~~

    Ausgabe mit Filter:

    ~~~~ {.programlisting}
     Host switch70 has the current state 0
     Host switch71 has the current state 0
     Host switch72 has the current state 0
     Host switch73 has the current state 0
     Host switch74 has the current state 0
     Host switch75 has the current state 0
     Host switch76 has the current state 0
     Host switch77 has the current state 0
    ~~~~

3.  **Kompletter Code ohne die Nutzung von Filtern**

    ~~~~ {.programlisting}
     <?
     // Path to icinga api file
     $apiFile = 'icinga-api/IcingaApi.php';
     
     // Database connection
     $idoConfig = array (
        'type'         => 'mysql',
        'host'         => 'localhost',
        'database'     => 'ido',
        'user'         => 'idouser',
        'password'     => 'idopassword',
        'persistent'   => true,
        'table_prefix' => 'icinga_',
     );
     
     // Include required files
     require_once($apiFile);
     
     // Instance the class
     $api = IcingaApi::getConnection(IcingaApi::CONNECTION_IDO, $idoConfig);
     
     // Create search
     $apiRes = $api->createSearch()
     ->setSearchTarget(IcingaApi::TARGET_HOST)
     ->setResultColumns(array('HOST_NAME', 'HOST_CURRENT_STATE'))
     ->fetch();
     
     // Create output
     foreach($apiRes as $apiHandle){
        echo 'Host '.$apiHandle->HOST_NAME.' has the current state '.$apiHandle->HOST_CURRENT_STATE.'<br />';
     }
     ?>
    ~~~~

    Für nähere Informationen werfen Sie bitte einen Blick in das [git
    repository](http://git.icinga.org/) oder die Beispiele im
    doc/examples-Verzeichnis.

* * * * *

  ----------------------------------------------------------------- -------------------------- --------------------------------
  [Zurück](epnplugins.md)                                         [Nach oben](ch11.md)      [Weiter](icinga-web-api.md)
  11.2. Entwickeln von Plugins für die Nutzung mit Embedded Perl    [Zum Anfang](index.md)    11.4. Die Icinga Web REST API
  ----------------------------------------------------------------- -------------------------- --------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
