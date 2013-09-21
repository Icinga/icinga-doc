NAME-ICINGA-Schnellstart mit NAME-IDOUTILS
==========================================

Einführung
----------

> **Note**
>
> Anstatt NAME-ICINGA von Grund auf zu installieren möchten Sie
> vielleicht ein Paket benutzen, das es möglicherweise für Ihr
> Betriebssystem gibt. Bitte werfen Sie einen Blick auf die [Tabelle der
> Pakete](https://www.icinga.org/download/packages).
>
> Bitte bedenken Sie, dass die Upstream-Pakete evtl. relativ alt sind,
> so dass die Verwendung von Backports-Paketen ein Weg ist, eine
> aktuelle Version zu bekommen. Bitte werfen Sie einen Blick auf die
> (englischsprachigen) Wiki-Artikel für detaillierte Informationen:
>
> -   [Debian](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Debian)
>
> -   [Ubuntu](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Ubuntu)
>
> -   [RHEL/CentOS](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+RHEL)
>
> Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie
> bitte die offiziellen Release-Tarballs.

> **Important**
>
> Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem
> haben, das in der aktuellen Entwicklerversion ggf. gelöst ist.

Diese Schnellstartanleitung ist dazu gedacht, Ihnen einfache Anweisungen
zu liefern, wie Sie NAME-ICINGA innerhalb von 30 Minuten aus dem
Quellcode installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
lediglich die Grundlagen, die für 95% aller Benutzer funktionieren, die
anfangen wollen.

Diese Anleitung enthält Anweisungen für drei verschiedene
Linux-Distributionen: [NAME-FEDORA](http://fedoraproject.org/),
[NAME-UBUNTU](http://www.ubuntu.com/) und
[NAME-OPENSUSE](http://www.opensuse.org/). Ähnliche Distributionen
werden wahrscheinlich auch funktionieren, darunter
[NAME-REDHAT](http://www.redhat.com/),
[NAME-CENTOS](http://www.centos.org/),
[NAME-DEBIAN](http://www.debian.org/) und
[NAME-SLES](http://www.novell.com/products/server/).

> **Important**
>
> Wenn Sie planen, NAME-ICINGA OHNE NAME-IDOUTILS zu nutzen, dann lesen
> Sie statt dessen ?!

**Was dabei herauskommt**

Wenn Sie diesen Anweisungen folgen, werden Sie am Ende folgendes haben:

-   NAME-ICINGA und die Plugins werden unterhalb von URL-ICINGA-BASE
    installiert sein

-   NAME-ICINGA wird so konfiguriert sein, dass es einige Dinge auf
    Ihrem lokalen System überwacht (CPU-Auslastung, Plattenbelegung,
    usw.)

-   Das klassische NAME-ICINGA-Web-Interface ist erreichbar unter
    http://localhost/icinga/

-   Eine Datenbank, die von NAME-ICINGA mit Hilfe von NAME-IDOUTILS
    gefüllt wird

Voraussetzungen
---------------

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

NAME-IDOUTILS benutzt die [libdbi](http://libdbi.sourceforge.net) und
die libdbi-Treiber für verschiedene Datenbanken. Die
Development-Libraries werden ebenfalls benötigt. Die folgenden Beispiele
zeigen, wie die NAME-IDOUTILS mit libdbi für NAME-MYSQL oder
NAME-POSTGRES installiert werden.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   NAME-APACHE

-   GCC-Compiler

-   C/C++ development libraries

-   [NAME-GD](http://www.boutell.com/gd/)-Development-Libraries

-   libdbi/libdbi-Treiber, eine Datenbank wie z.B. NAME-MYSQL oder
    NAME-POSTGRES

    > **Note**
    >
    > PostgreSQL: Aufgrund von Änderungen an Insert-Statements
    > funktioniert PostgreSQL 8.1 nicht länger (und ist auch bereits
    > ["End-of-life"](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    > seit November 2010), also benutzen Sie bitte 8.2 oder besser noch
    > 8.4. String escaping mit PostgreSQL 9.x befindet sich noch in
    > einem experimentellen Stadium.

**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

Neue Features für die NAME-IDOUTILS:
------------------------------------

-   **SSL-Verschlüsselung zwischen idomod und ido2db**

    Wenn Sie **SSL-Verschlüsselung**verwenden möchten, werden zusätzlich
    die Pakete openssl und openssl-devel/libssl-dev benötigt!

    > **Note**
    >
    > SSL muss auch bei allen idomod-Clients aktiviert werden, sonst
    > gehen Daten verloren!!!

-   **Oracle-Datenbankunterstützung**

    Wenn Sie Oracle als RDBMS einsetzen möchten, müssen Sie
    installieren:

    -   die Oracle Libraries und SDK (zum Beispiel den Oracle
        Instantclient)

    -   installieren Sie statt des libdbi-Treibers den ocilib-Treiber

        > **Note**
        >
        > Zum Einsatz von NAME-IDOUTILS 1.5.0 mit NAME-ORACLE benötigen
        > Sie OCILIB 3.9.2 - installieren Sie nicht 3.9.0 oder 3.9.1,
        > denn diese Version sind fehlerbehaftet.

        > **Note**
        >
        > Detailliertere Informationen zu NAME-IDOUTILS mit NAME-ORACLE
        > finden Sie in unserer Wiki-HowTo-Serie zu
        > [NAME-ORACLE](https://wiki.icinga.org/display/howtos/Icinga+and+Oracle).

    Stellen Sie sicher, dass die Libraries in der Path-Variablen
    enthalten sind. Oder setzen Sie die den Oracle Library Path mit
    --with-oracle-lib=/path/to/instantclient

    Download des ocilib-Treiber von URL-ORCLIB und verweisen Sie beim
    configure auf Ihre Oracle-Libraries und die Header-Files, z.B. die
    des Oracle Instant-Client:

         #> ./configure --with-oracle-headers-path=/path/to/instantclient/sdk/include \
            --with-oracle-lib-path=/path/to/instantclient/
         #> make
         #> make install

    *NAME-ICINGA 1.4*

    Seit NAME-ICINGA 1.4 wird mindestens NAME-ORACLE 10gR2 benötigt.
    Ältere Versionen funktionieren möglicherweise, werden aber nicht
    unterstützt. Die NAME-ORACLE-Skripte wurden geändert, um für Daten,
    Indexe und LOBs nun unterschiedliche Tablespaces zu nutzen. Aus
    diesem Grund gibt es die Notwendigkeit, den Tablespace-Namen
    anzugeben, den Sie benutzen möchten. Wenn Sie eine kleine Umgebung
    haben, dann können Sie für alle "defines" den gleichen Tablespace
    angeben. Sie müssen das neue Skript `icinga_defines.sql` auf Ihre
    Bedürfnisse anpassen, bevor Sie das Skript `oracle.sql` ausführen.
    Um Ihnen ein wenig Arbeit abzunehmen, gibt es ein neues Skript
    `create_oracle_sys.sql`, das Ihnen helfen soll, die benötigten
    Tablespaces und einen NAME-ICINGA-Applikations-Benutzer anzulegen,
    das als SYS ausgeführt werden muss. Es benutzt außerdem
    `icinga_defines.sql`. Die Erzeugung von Objekten wurde von
    `oracle.sql` in das Skript `create_icinga_objects_oracle.sql`
    verlagert. Das alte `oracle.sql` wurde in ein "Master"-Skript
    umgewandelt und enthält per "include" Verweise auf alle anderen
    Skripte, die im aktuellen Verzeichnis erwartet werden. Aus diesem
    Grund sollten Sie `sqlplus` in diesem Verzeichnis starten, um
    `oracle.sql` auszuführen. Auf diese Weise erfolgt die Erzeugung von
    Benutzer und Tablespaces sowie die Erzeugung der
    NAME-ICINGA-Tabellen in einem Schritt. Als ein All-in-one-Beispiel
    gibt es das neue Skript `db/scripts/create_oracledb.sh`. Passen Sie
    die Variablen auf Ihre Bedürfnisse an und freuen Sie sich. Wenn Sie
    es vorziehen, die Schritte als SYS selbst zu erledigen, dann
    entfernen Sie den Kommentar vor `create_oracle_sys.sql` und stellen
    Sie sicher, dass Ihr NAME-ICINGA-Datenbankbenutzer und die Tabellen
    existieren und (mindestens) mit den gleichen Rechten definiert sind
    und dass die korrekten Einstellungen in `icinga_defines.sql`
    vorhanden sind.

    **Zeitzonenunterstützung**

    Ab NAME-ICINGA 1.6 werden alle Zeit-/Datumsinformationen als lokale
    Zeitstempel in der Datenbank gespeichert. Vorher gab es für jedes
    Datenbanksystem unterschiedliche Vorgehensweisen beim Speichern und
    Abrufen der Daten, was schwierig für Frontend-Applikationen war.
    Deshalb wurden die Datentypen geändert: für NAME-MYSQL von DATETIME
    in TIMESTAMP und für NAME-ORACLE von DATE in LOCAL TIMESTAMP (0).
    NAME-POSTGRES benutzt bereits TIMESTAMP, es wurde aber in TIMESTAMP
    WITH TIME ZONE geändert. IDO2DB wird die Sitzungszeitzone auf UTC
    setzen und alle Unix-Timestamps (die per Definition UTC sind) als
    UTC-basierte Werte speichern. Bitte stellen Sie sicher, dass Ihr
    System Unix-Timestamps als UTC-basierte Werte ausgibt (wie "date -u
    '+%s'").

    > **Note**
    >
    > Stellen Sie sicher, dass Ihre Datenbanksitzung in der gleichen
    > Zeitzone läuft, in der die existierenden Zeit-/Datumsinformationen
    > gespeichert wurden (überprüfen Sie Ihre lokale Zeitzone, z.B.
    > NAME-ORACLE: "select sessiontimezone from dual;"), wenn Sie das
    > Upgrade-Script laufen lassen. Zusätzlich für Ihre Bequemlichkeit
    > sollten Sie in NAME-ORACLE das Format der Sitzungszeitstempel auf
    > den Wert zu setzen, den Sie wünschen, z.B. "alter session set
    > nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS'; oder etwas
    > ähnliches. Nun können Sie Einträge von verschiedenen
    > NAME-ICINGA-Installationen in unterschiedlichen Zeitzonen ansehen,
    > die in der gleichen Datenbank gespeichert wurden, und unabhängig
    > davon, von woher Sie darauf zugreifen, werden sie in Ihrer lokalen
    > Zeitzone angezeigt.

Installation der Pakete
-----------------------

Sie können diese Pakete mit Hilfe der folgenden Befehle installieren
(als root oder mit sudo).

> **Note**
>
> Unglücklicherweise ändern sich manchmal die Paketnamen zwischen
> verschiedenen Ausgaben der gleichen Distribution, so dass Sie die
> Suchoption Ihres Paket-Managers nutzen sollten, falls Sie die
> Fehlermeldung bekommen, dass eins der Pakete nicht gefunden wurde.
>
> -   `yum search <package name>` ( *NAME-FEDORA/NAME-RHEL/NAME-CENTOS*
>     )
>
> -   `apt-cache search <package name>` ( *NAME-DEBIAN/NAME-UBUNTU* )
>
> -   `zypper search <package name>` ( *NAME-OPENSUSE/NAME-SLES* )
>
-   **NAME-FEDORA / NAME-REDHAT / NAME-CENTOS:**

         #> yum install httpd gcc glibc glibc-common gd gd-devel
         #> yum install libjpeg libjpeg-devel libpng libpng-devel

    > **Note**
    >
    > ggf. sind libjpeg-turbo bzw. libjpeg-turbo-devel zu installieren

    -   **NAME-MYSQL:**

             #> yum install mysql mysql-server libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql

    -   **NAME-POSTGRES:**

             #> yum install postgresql postgresql-server libdbi libdbi-devel libdbi-drivers libdbi-dbd-pgsql

-   **NAME-DEBIAN / NAME-UBUNTU:**

         #> apt-get install apache2 build-essential libgd2-xpm-dev
         #> apt-get install libjpeg62 libjpeg62-dev libpng12 libpng12-dev

    > **Note**
    >
    > Die Zahlen \<62/12\> können je nach Distribution abweichen

    > **Note**
    >
    > Ab NAME-DEBIAN 6.0/NAME-UBUNTU 10.10 heißen die Pakete libpng12-0
    > und libdbi0, Debian 6.0 verwendet zudem libdbi0-dev, Debian 7.0
    > wird hingegen libdbi-dev benötigen.

    -   **NAME-MYSQL:**

             #> apt-get install mysql-server mysql-client libdbi1 libdbi-dev libdbd-mysql

    -   **NAME-POSTGRES:**

             #> apt-get install postgresql libdbi1 libdbi-dev libdbd-pgsql libpq-dev

-   **NAME-OPENSUSE:**

    Bitte nutzen Sie YaST für die Installation der Pakete gd, gd-devel,
    libjpeg, libjpeg-devel, libpng, libpng-devel und -optional-
    net-snmp, net-snmp-devel und perl-Net-SNMP.

    Die Nutzung von zypper sollte ebenfalls funktionieren:

         #> zypper install gd gd-devel libjpeg libjpeg-devel libpng libpng-devel
         #> zypper install net-snmp net-snmp-devel perl-Net-SNMP

    > **Note**
    >
    > Die devel-Pakete sind ggf. auf den SDK-DVDs zu finden.

    -   **NAME-MYSQL:**

        Benutzen Sie yast zur Installation der Pakete für das RDBMS, das
        Sie verwenden möchten, also "mysql", "mysql-devel" sowie die
        libdbi-Pakete "libdbi", "libdbi-devel", "libdbi-drivers" und
        "libdbi-dbd-mysql" oder alternativ `zypper`

             #> zypper install mysql mysql-devel libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql

        Bei OpenSuSE 11 (SLES 11) lautet der Name des Packages statt
        "mysql-devel" nun "libmysqlclient-devel".

    -   **NAME-POSTGRES:**

        Benutzen Sie yast zur Installation der Pakete für das RDBMS, das
        Sie verwenden möchten, also "postgresql", "postgresql-devel" und
        "postgresql-server" sowie die libdbi-Pakete "libdbi",
        "libdbi-devel" und "libdbi-drivers" oder alternativ `zypper>`.

             #> zypper install postgresql postgresql-devel postgresql-server
             #> zypper install libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql

    Bei alten OpenSuSE-/(SLES) Versionen einschließlich Version 10 ist
    es ziemlich wahrscheinlich, dass es keine libdbi-Packages gibt, so
    dass Sie die Sourcen herunterladen und kompilieren müssen. Ersetzen
    Sie dabei \<rdbm\> durch Ihr RDBM wie mysql oder pgsql. Bitte
    beachten Sie, dass der Oracle-Treiber noch nicht funktioniert. Lesen
    Sie daher den entsprechenden Abschnitt zu ocilib (anstatt libdbi).

    1.  Laden Sie die tar.gz-Dateien herunter und entpacken Sie diese

        [http://libdbi.sourceforge.net/download.html](http://libdbi.sourceforge.net/download.html)

        [http://libdbi-drivers.sourceforge.net/download.html](http://libdbi-drivers.sourceforge.net/download.html)

             #> tar xvzf libdbi-0.8.3.tar.gz
             #> tar xvzf libdbi-drivers-0.8.3-1.tar.gz

    2.  Installieren Sie die libdbi. Möglicherweise brauchen Sie beim
        configure weitere Optionen (set --prefix=/usr ... )

             #> cd libdbi-0.8.3
             #> ./configure --disable-docs
             #> make
             #> make install

    3.  Installieren Sie die libdbi-Treiber

             #> cd libdbi-drivers-0.8.3-1
             #> ./configure --with-<rdbm> --disable-docs
             #> make
             #> make install

        > **Note**
        >
        > Bei den 64-bit-Versionen müssen Sie die Pfade zu den include-
        > und lib-dir-Verzeichnissen explizit angeben:
        >
        >      #> ./configure --with-<rdbm> \
        >         --with-<rdbm>-incdir=/usr/include/<rdbm>/ \
        >         --with-<rdbm>-libdir=/usr/lib64/ --disable-docs

Benutzerinformationen erstellen
-------------------------------

Werden Sie zum root-Benutzer.

     $> su -l

Erstellen Sie ein neues Benutzerkonto *icinga* und vergeben Sie ein
Passwort:

     #> /usr/sbin/useradd -m icinga 
     #> passwd icinga  

Bei einigen Distributionen müssen Sie die Gruppe in einem gesonderten
Schritt anlegen:

     #> /usr/sbin/groupadd icinga

Damit Sie über das klassische Web-Interface Befehle an NAME-ICINGA
senden können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen
Sie den Webbenutzer und den Icingabenutzer dieser Gruppe hinzu.

     #> /usr/sbin/groupadd icinga-cmd
     #> /usr/sbin/usermod -a -G icinga-cmd icinga
     #> /usr/sbin/usermod -a -G icinga-cmd www-data

(oder www, wwwrun, apache je nach Distribution)

> **Note**
>
> Bei einigen usermod-Versionen (z.B. OpenSuSE 11 bzw. SLES 11) fehlt
> die Option -a. In diesen Fällen kann sie entfallen.

> **Important**
>
> Solaris unterstützt nur Gruppennamen bis max. 8 Zeichen, verwenden Sie
> icingcmd anstelle von icinga-cmd.

NAME-ICINGA und die Plugins herunterladen
-----------------------------------------

Wechseln Sie in Ihr lokales Source-Verzeichnis, z.B. /usr/src

     #> cd /usr/src

Laden Sie die Sourcen von der [NAME-ICINGA
Website](http://www.icinga.org/).

Vergessen Sie nicht die [Nagios Plugins](http://www.nagiosplugins.org/).

NAME-ICINGA und die NAME-IDOUTILS kompilieren und installieren
--------------------------------------------------------------

Entpacken Sie das NAME-ICINGA-Archiv

     #> cd /usr/src/ 
     #> tar xvzf icinga-VER-ICINGA.tar.gz 
     #> cd icinga-VER-ICINGA

> **Note**
>
> Dieser absolute Pfad ist gemeint, wenn im Nachfolgenden von
> '/path/to/icinga-src/' die Rede ist.

Führen Sie das NAME-ICINGA-configure-Script aus. Durch die Nutzung des
--help-Flags erhalten Sie Hilfe zu den Optionen.

> **Note**
>
> Beginnend mit NAME-ICINGA 1.9 hat sich der Default geändert, so dass
> die NAME-IDOUTILS automatisch kompiliert werden, wenn Sie dies nicht
> explizit verhindern.

     #> ./configure --with-command-group=icinga-cmd

> **Important**
>
> Das Kompilieren auf Solaris kann wegen unerfüllten
> Bibliotheksabhängigkeiten von gethostbyname fehlschlagen. Wenn dies
> der Fall ist, führen Sie folgenden Befehl vor configure aus:
>
>      #> export LIBS=-lsocket -lnsl

> **Note**
>
> Auch mit **NAME-POSTGRES** sollten Sie nicht den Parameter
> `--enable-pgsq` verwenden, denn dieser wird noch nicht unterstützt.

-   **Mit **SSL**-Verschlüsselung:**

         #> ./configure --with-command-group=icinga-cmd --enable-idoutils --enable-ssl

-   **Mit Oracle-Datenbankunterstützung:**

         #> ./configure --with-command-group=icinga-cmd \
            --enable-idoutils --enable-oracle

    Wenn Ihre Oracle Libraries nicht in der Path-Variablen enthalten
    sind, können Sie sie im configure angeben:

         #> ./configure --with-command-group=icinga-cmd \
            --enable-idoutils --enable-oracle \
            --with-oracle-lib=/path/to/instantclient

    Wenn Sie die ocilib nicht im Standardpfad (/usr/local) installiert
    haben, können Sie configure die lib/inc Verzeichnisse angeben:

         #> ./configure --with-command-group=icinga-cmd \
            --enable-idoutils --enable-oracle \
            --with-ocilib-lib=/path/to/ocilib/lib --with-ocilib-inc=/path/to/ocilib/include

    > **Note**
    >
    > Wenn Sie von einer Oracle-Datenbank auf ein anderes RDBMS wechseln
    > möchten, dann müssen Sie die NAME-IDOUTILS erneut kompilieren und
    > installieren!

         #> make distclean
         #> ./configure --enable-idoutils

Kompilieren und Installieren
----------------------------

Kompilieren Sie den NAME-ICINGA-Source-Code. Es gibt auch eine extra
Option für NAME-IDOUTILS (*make idoutils*), wenn Sie nur dieses Module
erneut kompilieren möchten. Um mögliche Optionen zu sehen, rufen Sie
lediglich "make" auf.

     #> make all

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien und setzen Sie die Berechtigungen für das
External-Command-Verzeichnis.

     #> make install 
     #> make install-init 
     #> make install-config 
     #> make install-eventhandlers
     #> make install-commandmode 
     #> make install-idoutils

oder kürzer

     #> make fullinstall
     #> make install-config

> **Note**
>
> Ab NAME-ICINGA 1.5.0 ist `make install-config` NICHT mehr in
> `make fullinstall `enthalten, um ein versehentliches Überschreiben der
> Konfigurationsdateien zu verhindern.

> **Note**
>
> Ab NAME-ICINGA 1.7.0 werden mit `make install-eventhandlers` einige
> Beispiel-Eventhandler installiert. Das ist lediglich in
> `make fullinstall` enthalten, um ein versehentliches Überschreiben der
> Dateien zu verhindern.

> **Note**
>
> Installieren Sie die IDOUtils und andere Ereignis-Broker-Module nur
> mit dem primären Ziel **make install**. Manuelles Kopieren und
> Überschreiben des vorhandenen Moduls erzeugt einen Segfault des
> Icinga-Kerns mit Hilfe von idomod.so, da eine Verwendung einer
> temporären Kopie explizit verhindert werden soll. Dies ist nützlich
> für [OMD](http://omdistro.org/)

> **Note**
>
> Die NAME-ICINGA-API diente als eine in PHP geschriebene
> Datenbank-Abstraktionsschicht. Seit NAME-ICINGA ist sie durch eine
> interne Datenbank-Abstraktionsschicht ersetzt worden, so dass
> NAME-ICINGA-API nicht mehr installiert werden muss.

Bitte starten Sie NAME-ICINGA noch nicht - es gibt noch ein paar Dinge
zu tun...

Anpassen der Konfiguration
--------------------------

Beispiel-Konfigurationsdateien werden durch

     #> make install-config

in URL-ICINGA-BASE/etc/ installiert.

Ändern Sie die
*URL-ICINGA-BASE/etc/objects/contacts.cfg*-Konfigurationsdatei mit Ihrem
bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

     #> vi URL-ICINGA-BASE/etc/objects/contacts.cfg

     #> cd URL-ICINGA-BASE/etc
     #> mv idomod.cfg-sample idomod.cfg
     #> mv ido2db.cfg-sample ido2db.cfg

Wenn Sie die NAME-IDOUTILS mit ssl kompiliert haben, aktivieren Sie ssl
in der `idomod.cfg` mit

     use_ssl=1
     output_type=tcpsocket
     output=127.0.0.1

(Passen Sie die IP-Adresse an, wenn sich Ihre Datenbank nicht auf
localhost befindet!) und der `ido2db.cfg` mit

     use_ssl=1
     socket_type=tcp 

> **Note**
>
> Vergessen Sie nicht, alle anderen idomod-Clients auch neu zu
> kompilieren und auf ssl umzustellen, **anderenfalls werden Sie Daten
> verlieren**!!!

Aktivieren des idomod-Eventbroker-Moduls
----------------------------------------

> **Important**
>
> Unter normalen Umständen gibt es im `modules`-Unterverzeichnis bereits
> die folgende module-Definition, so dass Sie keine Änderungen an der
> Hauptkonfigurationsdatei vornehmen müssen.
>
>      define module{
>             module_name    ido_mod
>             path           URL-ICINGA-BASE/lib/idomod.so
>             module_type    neb
>             args           config_file=URL-ICINGA-BASE/etc/idomod.cfg
>             }
>
> Das bedeutet auch, dass ein entsprechender broker\_module-Eintrag
> nicht aktiviert werden darf!

Anlegen und konfigurieren von Datenbank, Benutzer und Berechtigungen
--------------------------------------------------------------------

> **Note**
>
> Wenn Sie wie weiter oben beschrieben das Datenbanksystem neu
> installiert haben, dann müssen Sie den Datenbank-Server starten, bevor
> Sie eine Datenbank anlegen können. Im Falle von MySQL erfolgt der
> Start z.B. mit `/etc/init.d/mysqld start` (oder `/etc/init.d/mysql`,
> abhängig von Ihrer Distribution).

-   **NAME-MYSQL:**

    Anlegen von Datenbank, Benutzer und Berechtigungen:

         #> mysql -u root -p
          
         mysql> CREATE DATABASE icinga;
          
         GRANT USAGE ON icinga.* TO 'icinga'@'localhost' 
           IDENTIFIED BY 'icinga'
           WITH MAX_QUERIES_PER_HOUR 0
           MAX_CONNECTIONS_PER_HOUR 0
           MAX_UPDATES_PER_HOUR 0;
           
         GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE
           ON icinga.* TO 'icinga'@'localhost';
         
         FLUSH PRIVILEGES ;

         quit

    > **Note**
    >
    > Ab NAME-ICINGA 1.8 benötigt der icinga-User zusätzlich die Rechte
    > EXECUTE.

    Importieren des Datenbankschemas für NAME-MYSQL:

         #> cd /path/to/icinga-src/module/idoutils/db/mysql
         #> mysql -u root -p icinga < mysql.sql

    Editieren der DB-Konfigurationsdatei, um die NAME-IDOUTILS
    anzupassen

         #> vi URL-ICINGA-BASE/etc/ido2db.cfg

         db_servertype=mysql
         db_port=3306
         db_user=icinga
         db_pass=icinga

-   **NAME-POSTGRES:**

    Anlegen von Datenbank und Benutzer

         #> su - postgres
         
         $ psql
         postgres=# CREATE USER icinga;
         postgres=# ALTER USER icinga WITH PASSWORD 'icinga';
         postgres=# CREATE DATABASE icinga;
         postgres=# \q
         $ createlang plpgsql icinga;

    Beginnend mit NAME-POSTGRES 9.1 ist "createlang ..." obsolet.

    -   **NAME-DEBIAN:**

             #> vi /etc/postgresql/8.x/main/pg_hba.conf

    -   **NAME-FEDORA / NAME-REDHAT / NAME-CENTOS:**

             #> vi /var/lib/pgsql/data/pg_hba.conf

    Editieren Sie die Konfiguration z.B. wie folgt (dem lokalen Benutzer
    muss vertraut werden)

         # database administrative login by UNIX sockets
         local    all        postgres                  ident
         # TYPE   DATABASE   USER       CIDR-ADDRESS   METHOD 
         #icinga
         local    icinga     icinga                    trust
         # "local" is for Unix domain socket connections only
         local    all        all                       trust
         # IPv4 local connections
         host     all        all        127.0.0.1/32   trust
         # IPV6 local connections
         host     all        all        ::1/128        trust

    Neuladen und konfigurieren des Datenbankschemas

         #> /etc/init.d/postgresql-8.x reload

         #> cd /path/to/icinga-src/module/idoutils/db/pgsql/
         #> psql -U icinga -d icinga < pgsql.sql

    Editieren der DB-Konfigurationsdatei, um die NAME-IDOUTILS
    anzupassen

         #> vi /usr/local/icinga/etc/ido2db.cfg

         db_servertype=pgsql
         db_port=5432
         db_user=icinga
         db_pass=icinga

-   **Oracle:**

    Erstellen Sie ein Datenbank-Schema und eine
    username/password-Kombination (lesen Sie dazu die
    Oracle-Dokumentation unter URL-ORACLE oder fragen Sie Ihren DBA).
    Importieren Sie das Datenbank-Schema mit sqlplus (oder Ihrer
    bevorzugten Methode). Kopieren Sie `module/idoutils/db/oracle/*`
    nach \$ORACLE\_HOME und ändern Sie in `icinga_defines.sql` die Werte
    zu Tablespace-Namen und Benutzerdaten.

         #> su - oracle
         $ sqlplus dbuser/dbpass
         SQL> @oracle.sql

    Editieren Sie das DB-Config-File, um die NAME-IDOUTILS anzupassen.
    Denken Sie daran, dass Oracle den DB-Host ignoriert, nutzen Sie
    statt dessen db\_name, um auf //DBSERVER/DBNAME zu verweisen

         #> vi /usr/local/icinga/etc/ido2db.cfg

          db_servertype=oracle
          db_port=1521
          db_user=icinga
          db_pass=icinga

Installieren und konfigurieren des klassischen Web-Interface
------------------------------------------------------------

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

     #> cd /path/to/icinga-src
     #> make cgis
     #> make install-cgis
     #> make install-html

Wenn Sie (zusätzlich) das neue Icinga-Web installieren wollen, lesen Sie
bitte [Installation des Web-Interface](#icinga-web-scratch).

Installieren Sie die NAME-ICINGA-Web-Konfigurationsdatei im NAME-APACHE
conf.d-Verzeichnis.

     #> cd /path/to/icinga-src
     #> make install-webconf

> **Note**
>
> Ab NAME-ICINGA 1.9 installiert der Befehl 'make install-webconf-auth'
> zusätzlich die Datei `htpasswd.users`, die Anmeldeinformationen für
> den Benutzer *icingaadmin* enthält, so dass Sie den nächsten Schritt
> überspringen können. Das Passwort lautet *icingaadmin*.

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie
diesem Konto geben - Sie brauchen es später.

     #> htpasswd -c URL-ICINGA-BASE/etc/htpasswd.users icingaadmin

> **Note**
>
> Abhängig von der Apache-Version müssen Sie ggf. *htpasswd2 verwenden.*

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

     #> htpasswd URL-ICINGA-BASE/etc/htpasswd.users <USERNAME>

Starten Sie NAME-APACHE neu, damit die Änderungen wirksam werden.

-   **NAME-FEDORA / NAME-RHEL / NAME-CENTOS**:

         #> service httpd restart

-   **NAME-UBUNTU / NAME-OPENSUSE:**

         #> service apache2 restart

-   **NAME-DEBIAN:**

         #> /etc/init.d/apache2 reload

> **Note**
>
> Prüfen Sie die Implementierung der verbesserten
> CGI-Sicherheitsmaßnahmen wie [hier](#cgisecurity) beschrieben, um
> sicherzustellen, dass Ihre Web-Authentifizierungsinformationen nicht
> kompromittiert werden.

Kompilieren und installieren der NAME-NAGIOS-Plugins
----------------------------------------------------

Entpacken Sie die NAME-NAGIOS-Plugins-Quellcode-Archivdatei.

     #> cd /usr/src
     #> tar xzf nagios-plugins-VER-NAGIOSPLUG.tar.gz
     #> cd nagios-plugins-VER-NAGIOSPLUG

Kompilieren und installieren Sie die Plugins.

     #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
        --with-nagios-user=icinga --with-nagios-group=icinga
     #> make
     #> make install

Anpassen der SENAME-LINUX-Einstellungen
---------------------------------------

NAME-RHEL und ähnliche Distributionen wie NAME-FEDORA oder NAME-CENTOS
werden mit installiertem SENAME-LINUX (Security Enhanced NAME-LINUX)
ausgeliefert und laufen im "Enforcing"-Modus. Dies kann zu "Internal
Server Error"-Fehlern führen, wenn Sie versuchen, die NAME-ICINGA-CGIs
aufzurufen.

Schauen Sie, ob SENAME-LINUX im Enforcing-Modus läuft.

     #> getenforce

Setzen Sie SENAME-LINUX in den "Permissive"-Modus.

     #> setenforce 0

Damit diese Änderung dauerhaft wird, müssen Sie diese Einstellung in
*/etc/selinux/config* anpassen und das System neustarten.

Statt SENAME-LINUX zu deaktivieren oder es in den Permissive-Modus zu
versetzen, können Sie den folgenden Befehl benutzen, um die CGIs im
Enforcing/Targeted-Modus laufen zu lassen:

     #> chcon -R -t httpd_sys_script_exec_t URL-ICINGA-BASE/sbin/
     #> chcon -R -t httpd_sys_content_t URL-ICINGA-BASE/share/
     #> chcon -t httpd_sys_script_rw_t URL-ICINGA-BASE/var/rw/icinga.cmd

Eine alternative Vorgehensweise wird unter
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/)
beschrieben (englisch).

NAME-IDOUTILS und NAME-ICINGA starten
-------------------------------------

NAME-IDOUTILS muss vor NAME-ICINGA gestartet werden

**NAME-IDOUTILS starten**

-   **NAME-FEDORA / NAME-OPENSUSE/NAME-UBUNTU:**

         #> service ido2db start

-   **NAME-DEBIAN:**

         #> /etc/init.d/ido2db start

**NAME-IDOUTILS beenden**

-   **NAME-FEDORA / NAME-OPENSUSE/NAME-UBUNTU:**

         #> service ido2db stop

-   **NAME-DEBIAN:**

         #> /etc/init.d/ido2db stop

Automatischer Start von NAME-IDOUTILS
-------------------------------------

Fügen Sie NAME-IDOUTILS zu der Liste der System-Services hinzu und
sorgen Sie für einen automatischen Start, wenn das System hochfährt
(stellen Sie sicher, dass Sie vorher das Init-Script installiert haben).

**NAME-FEDORA / NAME-OPENSUSE:**

     #> chkconfig --add ido2db
     #> chkconfig ido2db on 

**NAME-DEBIAN / NAME-UBUNTU:**

     #> update-rc.d ido2db defaults

**NAME-ICINGA starten:**

**Start von NAME-ICINGA**

Überprüfen Sie die NAME-ICINGA-Beispielkonfigurationsdateien.

     #> URL-ICINGA-BIN -v URL-ICINGA-CFG

Wenn es dabei keine Fehler gibt, starten Sie NAME-ICINGA.

**NAME-FEDORA / NAME-OPENSUSE/NAME-UBUNTU:**

     #> service icinga start

**NAME-DEBIAN:**

     #> /etc/init.d/icinga start

**Automatischer Start von NAME-ICINGA**

Fügen Sie NAME-ICINGA zu der Liste der System-Services hinzu und sorgen
Sie für einen automatischen Start, wenn das System hochfährt (stellen
Sie sicher, dass Sie vorher das Init-Script installiert haben).

**NAME-FEDORA / NAME-OPENSUSE:**

     #> chkconfig --add icinga 
     #> chkconfig icinga on 

**NAME-DEBIAN / NAME-UBUNTU:**

     #> update-rc.d icinga defaults

Anmelden am klassischen Web-Interface
-------------------------------------

Sie sollten nun auf das klassische NAME-ICINGA-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*nagiosadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

     http://localhost/icinga/

oder

     http://yourdomain.com/icinga/

Klicken Sie auf den "Service Detail"-Verweis in der Navigationsleiste,
um Details darüber zu erhalten, was auf Ihrer lokalen Maschine überwacht
wird. Es wird ein paar Minuten dauern, bis NAME-ICINGA alle mit Ihrer
Maschine verbundenen Services geprüft hat, weil die Prüfungen über eine
gewisse Zeit verteilt werden.

Andere Anpassungen
------------------

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

     #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT

Die Konfiguration von e-Mail-Benachrichtigungen ist nicht Gegenstand
dieser Anleitung. NAME-ICINGA ist konfiguriert, um
e-Mail-Benachrichtigungen zu versenden, aber möglicherweise ist auf
Ihrem System noch kein Mail-Programm installiert bzw. konfiguriert.
Schauen Sie in Ihre Systemdokumentation oder suchen Sie im Web nach
genauen Anweisungen, wie Ihr System konfiguriert werden muss, damit es
e-Mail-Mitteilungen an externe Adressen versendet. Mehr Informationen zu
Benachrichtigungen finden Sie [hier](#notifications)

Fertig
------

Glückwunsch! Sie haben erfolgreich NAME-ICINGA installiert. Ihre Reise
in die Überwachung hat gerade begonnen. Sie werden ohne Zweifel mehr als
nur Ihre lokale Maschine überwachen wollen, so dass Sie u.a. das
folgende [Kapitel](#ch02) lesen sollten...

Quickstart
NAME-ICINGA mit NAME-IDOUTILS
NAME-IDOUTILS / Zeitzonen-Unterstützung
