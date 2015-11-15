![Icinga](../images/logofullsize.png "Icinga")

2.6. Icinga-Schnellstart mit IDOUtils

[Zurück](quickstart-icinga-freebsd.md) 

Kapitel 2. Los geht's

 [Weiter](quickstart-idoutils-freebsd.md)

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

-   [Debian](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Debian)

-   [Ubuntu](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Ubuntu)

-   [RHEL/CentOS](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+RHEL)

Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs.

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem haben,
das in der aktuellen Entwicklerversion ggf. gelöst ist.

Diese Schnellstartanleitung ist dazu gedacht, Ihnen einfache Anweisungen
zu liefern, wie Sie Icinga innerhalb von 30 Minuten aus dem Quellcode
installieren und Ihren lokalen Rechner damit überwachen.

Hier werden keine fortgeschrittenen Installationsoptionen vorgestellt -
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

-   Icinga und die Plugins werden unterhalb von /usr/local/icinga
    installiert sein

-   Icinga wird so konfiguriert sein, dass es einige Dinge auf Ihrem
    lokalen System überwacht (CPU-Auslastung, Plattenbelegung, usw.)

-   Das klassische Icinga-Web-Interface ist erreichbar unter
    http://localhost/icinga/

-   Eine Datenbank, die von Icinga mit Hilfe von IDOUtils gefüllt wird

### 2.6.2. Voraussetzungen

Während einiger Teile der Installation benötigen Sie **root**-Zugang zu
Ihrer Maschine.

IDOUtils benutzt die [libdbi](http://libdbi.sourceforge.net) und die
libdbi-Treiber für verschiedene Datenbanken. Die Development-Libraries
werden ebenfalls benötigt. Die folgenden Beispiele zeigen, wie die
IDOUtils mit libdbi für MySQL oder PostgreSQL installiert werden.

Stellen Sie sicher, dass die folgenden Pakete installiert sind, bevor
Sie fortfahren.

-   Apache

-   GCC-Compiler

-   C/C++ development libraries

-   [GD](http://www.boutell.com/gd/)-Development-Libraries

-   libdbi/libdbi-Treiber, eine Datenbank wie z.B. MySQL oder PostgreSQL

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    PostgreSQL: Aufgrund von Änderungen an Insert-Statements
    funktioniert PostgreSQL 8.1 nicht länger (und ist auch bereits
    ["End-of-life"](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    seit November 2010), also benutzen Sie bitte 8.2 oder besser noch
    8.4. String escaping mit PostgreSQL 9.x befindet sich noch in einem
    experimentellen Stadium.

**Optional**

Zu irgendeiner Zeit möchten Sie wahrscheinlich SNMP-basierte Prüfungen
verwenden, so dass es eine gute Idee ist, die benötigten Pakete gleich
zu installieren. Anderenfalls werden die Plugins nicht kompiliert und
sind nicht verfügbar, wenn Sie diese brauchen.

### 2.6.3. Neue Features für die IDOUtils:

-   **SSL-Verschlüsselung zwischen idomod und ido2db**

    Wenn Sie **SSL-Verschlüsselung**verwenden möchten, werden zusätzlich
    die Pakete openssl und openssl-devel/libssl-dev benötigt!

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    SSL muss auch bei allen idomod-Clients aktiviert werden, sonst gehen
    Daten verloren!!!

-   **Oracle-Datenbankunterstützung**

    Wenn Sie Oracle als RDBMS einsetzen möchten, müssen Sie
    installieren:

    -   die Oracle Libraries und SDK (zum Beispiel den Oracle
        Instantclient)

    -   installieren Sie statt des libdbi-Treibers den ocilib-Treiber

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Detailliertere Informationen zu IDOUtils mit Oracle finden Sie
        in unserer Wiki-HowTo-Serie zu
        [Oracle](https://wiki.icinga.org/display/howtos/Icinga+and+Oracle).

    Stellen Sie sicher, dass die Libraries in der Path-Variablen
    enthalten sind. Oder setzen Sie die den Oracle Library Path mit
    --with-oracle-lib=/path/to/instantclient

    Download des ocilib-Treiber von http://orclib.sourceforge.net/ und
    verweisen Sie beim configure auf Ihre Oracle-Libraries und die
    Header-Files, z.B. die des Oracle Instant-Client:

    ~~~~ {.programlisting}
     #> ./configure --with-oracle-headers-path=/path/to/instantclient/sdk/include \
        --with-oracle-lib-path=/path/to/instantclient/
     #> make
     #> make install
    ~~~~

    *Icinga 1.4*

    Seit Icinga 1.4 wird mindestens Oracle 10gR2 benötigt. Ältere
    Versionen funktionieren möglicherweise, werden aber nicht
    unterstützt. Die Oracle-Skripte wurden geändert, um für Daten,
    Indexe und LOBs nun unterschiedliche Tablespaces zu nutzen. Aus
    diesem Grund gibt es die Notwendigkeit, den Tablespace-Namen
    anzugeben, den Sie benutzen möchten. Wenn Sie eine kleine Umgebung
    haben, dann können Sie für alle "defines" den gleichen Tablespace
    angeben. Sie müssen das neue Skript `icinga_defines.sql`{.filename}
    auf Ihre Bedürfnisse anpassen, bevor Sie das Skript
    `oracle.sql`{.filename} ausführen. Um Ihnen ein wenig Arbeit
    abzunehmen, gibt es ein neues Skript
    `create_oracle_sys.sql`{.filename}, das Ihnen helfen soll, die
    benötigten Tablespaces und einen Icinga-Applikations-Benutzer
    anzulegen, das als SYS ausgeführt werden muss. Es benutzt außerdem
    `icinga_defines.sql`{.filename}. Die Erzeugung von Objekten wurde
    von `oracle.sql`{.filename} in das Skript
    `create_icinga_objects_oracle.sql`{.filename} verlagert. Das alte
    `oracle.sql`{.filename} wurde in ein "Master"-Skript umgewandelt und
    enthält per "include" Verweise auf alle anderen Skripte, die im
    aktuellen Verzeichnis erwartet werden. Aus diesem Grund sollten Sie
    `sqlplus`{.filename} in diesem Verzeichnis starten, um
    `oracle.sql`{.filename} auszuführen. Auf diese Weise erfolgt die
    Erzeugung von Benutzer und Tablespaces sowie die Erzeugung der
    Icinga-Tabellen in einem Schritt. Als ein All-in-one-Beispiel gibt
    es das neue Skript `db/scripts/create_oracledb.sh`{.filename}.
    Passen Sie die Variablen auf Ihre Bedürfnisse an und freuen Sie
    sich. Wenn Sie es vorziehen, die Schritte als SYS selbst zu
    erledigen, dann entfernen Sie den Kommentar vor
    `create_oracle_sys.sql`{.filename} und stellen Sie sicher, dass Ihr
    Icinga-Datenbankbenutzer und die Tabellen existieren und
    (mindestens) mit den gleichen Rechten definiert sind und dass die
    korrekten Einstellungen in `icinga_defines.sql`{.filename} vorhanden
    sind.

    **Zeitzonenunterstützung**

    Alle Zeit-/Datumsinformationen werden als lokale Zeitstempel in der
    Datenbank gespeichert. Als Datentypen werden TIMESTAMP für MySQL,
    LOCAL TIMESTAMP (0) für Oracle und TIMESTAMP WITH TIME ZONE für
    PostgreSQL benutzt. IDO2DB wird die Sitzungszeitzone auf UTC setzen
    und alle Unix-Timestamps (die per Definition UTC sind) als
    UTC-basierte Werte speichern. Bitte stellen Sie sicher, dass Ihr
    System Unix-Timestamps als UTC-basierte Werte ausgibt (wie "date -u
    '+%s'").

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Stellen Sie sicher, dass Ihre Datenbanksitzung in der gleichen
    Zeitzone läuft, in der die existierenden Zeit-/Datumsinformationen
    gespeichert wurden (überprüfen Sie Ihre lokale Zeitzone, z.B.
    Oracle: "select sessiontimezone from dual;"), wenn Sie das
    Upgrade-Script laufen lassen. Zusätzlich für Ihre Bequemlichkeit
    sollten Sie in Oracle das Format der Sitzungszeitstempel auf den
    Wert zu setzen, den Sie wünschen, z.B. "alter session set
    nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS'; oder etwas
    ähnliches. Nun können Sie Einträge von verschiedenen
    Icinga-Installationen in unterschiedlichen Zeitzonen ansehen, die in
    der gleichen Datenbank gespeichert wurden, und unabhängig davon, von
    woher Sie darauf zugreifen, werden sie in Ihrer lokalen Zeitzone
    angezeigt.

### 2.6.4. Installation der Pakete

Sie können diese Pakete mit Hilfe der folgenden Befehle installieren
(als root oder mit sudo).

![[Anmerkung]](../images/note.png)

Anmerkung

Unglücklicherweise ändern sich manchmal die Paketnamen zwischen
verschiedenen Ausgaben der gleichen Distribution, so dass Sie die
Suchoption Ihres Paket-Managers nutzen sollten, falls Sie die
Fehlermeldung bekommen, dass eins der Pakete nicht gefunden wurde.

-   `yum search <package name>`{.code} ( *Fedora/RHEL/CentOS* )

-   `apt-cache search <package name>`{.code} ( *Debian/Ubuntu* )

-   `zypper search <package name>`{.code} ( *openSuSE/SLES* )

-   **Fedora / RedHat / CentOS:**

    ~~~~ {.programlisting}
     #> yum install httpd gcc glibc glibc-common gd gd-devel
     #> yum install libjpeg libjpeg-devel libpng libpng-devel
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    ggf. sind libjpeg-turbo bzw. libjpeg-turbo-devel zu installieren

    -   **MySQL:**

        ~~~~ {.programlisting}
         #> yum install mysql mysql-server libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql
        ~~~~

    -   **PostgreSQL:**

        ~~~~ {.programlisting}
         #> yum install postgresql postgresql-server libdbi libdbi-devel libdbi-drivers libdbi-dbd-pgsql
        ~~~~

-   **Debian / Ubuntu:**

    ~~~~ {.programlisting}
     #> apt-get install apache2 build-essential libgd2-xpm-dev
     #> apt-get install libjpeg62 libjpeg62-dev libpng12 libpng12-dev
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Die Zahlen \<62/12\> können je nach Distribution abweichen

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Ab Debian 6.0/Ubuntu 10.10 heißen die Pakete libpng12-0 und libdbi0,
    Debian 6.0 verwendet zudem libdbi0-dev, Debian 7.0 wird hingegen
    libdbi-dev benötigen.

    -   **MySQL:**

        ~~~~ {.programlisting}
         #> apt-get install mysql-server mysql-client libdbi1 libdbi-dev libdbd-mysql
        ~~~~

    -   **PostgreSQL:**

        ~~~~ {.programlisting}
         #> apt-get install postgresql libdbi1 libdbi-dev libdbd-pgsql libpq-dev
        ~~~~

-   **openSuSE:**

    Bitte nutzen Sie YaST für die Installation der Pakete gd, gd-devel,
    libjpeg, libjpeg-devel, libpng, libpng-devel und -optional-
    net-snmp, net-snmp-devel und perl-Net-SNMP.

    Die Nutzung von zypper sollte ebenfalls funktionieren:

    ~~~~ {.programlisting}
     #> zypper install gd gd-devel libjpeg libjpeg-devel libpng libpng-devel
     #> zypper install net-snmp net-snmp-devel perl-Net-SNMP
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Die devel-Pakete sind ggf. auf den SDK-DVDs zu finden.

    -   **MySQL:**

        Benutzen Sie yast zur Installation der Pakete für das RDBMS, das
        Sie verwenden möchten, also "mysql", "mysql-devel" sowie die
        libdbi-Pakete "libdbi", "libdbi-devel", "libdbi-drivers" und
        "libdbi-dbd-mysql" oder alternativ `zypper`{.filename}

        ~~~~ {.programlisting}
         #> zypper install mysql mysql-devel libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql
        ~~~~

        Bei OpenSuSE 11 (SLES 11) lautet der Name des Packages statt
        "mysql-devel" nun "libmysqlclient-devel".

    -   **PostgreSQL:**

        Benutzen Sie yast zur Installation der Pakete für das RDBMS, das
        Sie verwenden möchten, also "postgresql", "postgresql-devel" und
        "postgresql-server" sowie die libdbi-Pakete "libdbi",
        "libdbi-devel" und "libdbi-drivers" oder alternativ
        `zypper>`{.filename}.

        ~~~~ {.programlisting}
         #> zypper install postgresql postgresql-devel postgresql-server
         #> zypper install libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql
        ~~~~

    Bei alten OpenSuSE-/(SLES) Versionen einschließlich Version 10 ist
    es ziemlich wahrscheinlich, dass es keine libdbi-Packages gibt, so
    dass Sie die Sourcen herunterladen und kompilieren müssen. Ersetzen
    Sie dabei \<rdbm\> durch Ihr RDBM wie mysql oder pgsql. Bitte
    beachten Sie, dass der Oracle-Treiber noch nicht funktioniert. Lesen
    Sie daher den entsprechenden Abschnitt zu ocilib (anstatt libdbi).

    1.  Laden Sie die tar.gz-Dateien herunter und entpacken Sie diese

        [http://libdbi.sourceforge.net/download.md](http://libdbi.sourceforge.net/download.md)

        [http://libdbi-drivers.sourceforge.net/download.md](http://libdbi-drivers.sourceforge.net/download.md)

        ~~~~ {.programlisting}
         #> tar xvzf libdbi-0.8.3.tar.gz
         #> tar xvzf libdbi-drivers-0.8.3-1.tar.gz
        ~~~~

    2.  Installieren Sie die libdbi. Möglicherweise brauchen Sie beim
        configure weitere Optionen (set --prefix=/usr ... )

        ~~~~ {.programlisting}
         #> cd libdbi-0.8.3
         #> ./configure --disable-docs
         #> make
         #> make install
        ~~~~

    3.  Installieren Sie die libdbi-Treiber

        ~~~~ {.programlisting}
         #> cd libdbi-drivers-0.8.3-1
         #> ./configure --with-<rdbm> --disable-docs
         #> make
         #> make install
        ~~~~

        ![[Anmerkung]](../images/note.png)

        Anmerkung

        Bei den 64-bit-Versionen müssen Sie die Pfade zu den include-
        und lib-dir-Verzeichnissen explizit angeben:

        ~~~~ {.programlisting}
         #> ./configure --with-<rdbm> \
            --with-<rdbm>-incdir=/usr/include/<rdbm>/ \
            --with-<rdbm>-libdir=/usr/lib64/ --disable-docs
        ~~~~

### 2.6.5. Benutzerinformationen erstellen

Werden Sie zum root-Benutzer.

~~~~ {.programlisting}
 $> su -l
~~~~

Erstellen Sie ein neues Benutzerkonto *icinga* und vergeben Sie ein
Passwort:

~~~~ {.programlisting}
 #> /usr/sbin/useradd -m icinga 
 #> passwd icinga  
~~~~

Bei einigen Distributionen müssen Sie die Gruppe in einem gesonderten
Schritt anlegen:

~~~~ {.programlisting}
 #> /usr/sbin/groupadd icinga
~~~~

Damit Sie über das klassische Web-Interface Befehle an Icinga senden
können, legen Sie noch eine neue Gruppe icinga-cmd an und fügen Sie den
Webbenutzer und den Icingabenutzer dieser Gruppe hinzu.

~~~~ {.programlisting}
 #> /usr/sbin/groupadd icinga-cmd
 #> /usr/sbin/usermod -a -G icinga-cmd icinga
 #> /usr/sbin/usermod -a -G icinga-cmd www-data
~~~~

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

~~~~ {.programlisting}
 #> cd /usr/src
~~~~

Laden Sie die Sourcen von der [Icinga Website](http://www.icinga.org/).

Vergessen Sie nicht die [Monitoring
Plugins](https://www.monitoring-plugins.org).

### 2.6.7. Icinga und die IDOUtils kompilieren und installieren

Entpacken Sie das Icinga-Archiv

~~~~ {.programlisting}
 #> cd /usr/src/ 
 #> tar xvzf icinga-1.13.tar.gz 
 #> cd icinga-1.13
~~~~

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

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Apache 2.4 hat sich der Standard-Konfigurationsordner von
`/etc/apache2/conf.d`{.filename} in
`/etc/apache2/conf-available`{.filename} geändert, so dass Sie abhängig
von Ihrer Distribution (testing-Versionen von Debian / Ubuntu) dem
Aufruf von configure diese Option hinzufügen müssen

~~~~ {.screen}
#> ./configure --with-httpd-conf=/etc/apache2/conf-available
~~~~

![[Wichtig]](../images/important.png)

Wichtig

Das Kompilieren auf Solaris kann wegen unerfüllten
Bibliotheksabhängigkeiten von gethostbyname fehlschlagen. Wenn dies der
Fall ist, führen Sie folgenden Befehl vor configure aus:

~~~~ {.programlisting}
 #> export LIBS=-lsocket -lnsl
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Auch mit **PostgreSQL** sollten Sie nicht den Parameter
`--enable-pgsq`{.literal} verwenden, denn dieser wird noch nicht
unterstützt.

-   **Mit **SSL**-Verschlüsselung:**

    ~~~~ {.programlisting}
     #> ./configure --with-command-group=icinga-cmd --enable-idoutils --enable-ssl
    ~~~~

-   **Mit Oracle-Datenbankunterstützung:**

    ~~~~ {.programlisting}
     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-oracle
    ~~~~

    Wenn Ihre Oracle Libraries nicht in der Path-Variablen enthalten
    sind, können Sie sie im configure angeben:

    ~~~~ {.programlisting}
     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-oracle \
        --with-oracle-lib=/path/to/instantclient
    ~~~~

    Wenn Sie die ocilib nicht im Standardpfad (/usr/local) installiert
    haben, können Sie configure die lib/inc Verzeichnisse angeben:

    ~~~~ {.programlisting}
     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-oracle \
        --with-ocilib-lib=/path/to/ocilib/lib --with-ocilib-inc=/path/to/ocilib/include
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Wenn Sie von einer Oracle-Datenbank auf ein anderes RDBMS wechseln
    möchten, dann müssen Sie die IDOUtils erneut kompilieren und
    installieren!

    ~~~~ {.screen}
     #> make distclean
     #> ./configure --enable-idoutils
    ~~~~

### 2.6.8. Kompilieren und Installieren

Kompilieren Sie den Icinga-Source-Code. Es gibt auch eine extra Option
für IDOUtils (*make idoutils*), wenn Sie nur dieses Module erneut
kompilieren möchten. Um mögliche Optionen zu sehen, rufen Sie lediglich
"make" auf.

~~~~ {.programlisting}
 #> make all
~~~~

Installieren Sie die Binaries, das Init-Script,
Beispiel-Konfigurationsdateien und setzen Sie die Berechtigungen für das
External-Command-Verzeichnis.

~~~~ {.programlisting}
 #> make install 
 #> make install-init 
 #> make install-config 
 #> make install-eventhandlers
 #> make install-commandmode 
 #> make install-idoutils
~~~~

oder kürzer

~~~~ {.programlisting}
 #> make fullinstall
 #> make install-config
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 ist `make install-config`{.literal} NICHT mehr in
`make fullinstall `{.literal}enthalten, um ein versehentliches
Überschreiben der Konfigurationsdateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.7.0 werden mit `make install-eventhandlers`{.literal} einige
Beispiel-Eventhandler installiert. Das ist lediglich in
`make fullinstall`{.literal} enthalten, um ein versehentliches
Überschreiben der Dateien zu verhindern.

![[Anmerkung]](../images/note.png)

Anmerkung

Installieren Sie die IDOUtils und andere Ereignis-Broker-Module nur mit
dem primären Ziel **make instal****l**. Manuelles Kopieren und
Überschreiben des vorhandenen Moduls erzeugt einen Segfault des
Icinga-Kerns mit Hilfe von idomod.so, da eine Verwendung einer
temporären Kopie explizit verhindert werden soll. Dies ist nützlich für
[OMD](http://omdistro.org/)

Bitte starten Sie Icinga noch nicht - es gibt noch ein paar Dinge zu
tun...

### 2.6.9. Anpassen der Konfiguration

Beispiel-Konfigurationsdateien werden durch

~~~~ {.programlisting}
 #> make install-config
~~~~

in /usr/local/icinga/etc/ installiert.

Ändern Sie die
*/usr/local/icinga/etc/objects/contacts.cfg*-Konfigurationsdatei mit
Ihrem bevorzugten Editor und passen die e-Mail-Adresse in der
*icingaadmin*-Kontaktdefinition an, so dass sie die Adresse enthält, die
im Falle von Alarmen benachrichtigt werden soll.

~~~~ {.programlisting}
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

~~~~ {.programlisting}
 #> cd /usr/local/icinga/etc
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
~~~~

Wenn Sie die IDOUtils mit ssl kompiliert haben, aktivieren Sie ssl in
der `idomod.cfg`{.filename} mit

~~~~ {.programlisting}
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
~~~~

(Passen Sie die IP-Adresse an, wenn sich Ihre Datenbank nicht auf
localhost befindet!) und der `ido2db.cfg`{.filename} mit

~~~~ {.programlisting}
 use_ssl=1
 socket_type=tcp 
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Vergessen Sie nicht, alle anderen idomod-Clients auch neu zu kompilieren
und auf ssl umzustellen, **anderenfalls werden Sie Daten verlieren**!!!

### 2.6.10. Aktivieren des idomod-Eventbroker-Moduls

![[Wichtig]](../images/important.png)

Wichtig

Unter normalen Umständen gibt es im
`modules`{.filename}-Unterverzeichnis bereits die folgende
module-Definition, so dass Sie keine Änderungen an der
Hauptkonfigurationsdatei vornehmen müssen.

~~~~ {.screen}
 define module{
        module_name    ido_mod
        path           /usr/local/icinga/lib/idomod.so
        module_type    neb
        args           config_file=/usr/local/icinga/etc/idomod.cfg
        }
~~~~

Das bedeutet auch, dass ein entsprechender broker\_module-Eintrag nicht
aktiviert werden darf!

### 2.6.11. Anlegen und konfigurieren von Datenbank, Benutzer und Berechtigungen

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie wie weiter oben beschrieben das Datenbanksystem neu installiert
haben, dann müssen Sie den Datenbank-Server starten, bevor Sie eine
Datenbank anlegen können. Im Falle von MySQL erfolgt der Start z.B. mit
`/etc/init.d/mysqld start`{.code} (oder `/etc/init.d/mysql`{.code},
abhängig von Ihrer Distribution).

-   **MySQL:**

    Anlegen von Datenbank, Benutzer und Berechtigungen:

    ~~~~ {.screen}
     # mysql -u root -p

     mysql> CREATE DATABASE icinga;

           GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';

            quit
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Ab Icinga 1.8 benötigt der icinga-User zusätzlich die Rechte
    EXECUTE.

    Importieren des Datenbankschemas für MySQL:

    ~~~~ {.programlisting}
     #> cd /path/to/icinga-src/module/idoutils/db/mysql
     #> mysql -u root -p icinga < mysql.sql
    ~~~~

    Editieren der DB-Konfigurationsdatei, um die IDOUtils anzupassen

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
     db_servertype=mysql
     db_port=3306
     db_user=icinga
     db_pass=icinga
    ~~~~

-   **PostgreSQL:**

    Anlegen von Datenbank und Benutzer

    ~~~~ {.programlisting}
     #> su - postgres
     
     $ psql
     postgres=# CREATE USER icinga;
     postgres=# ALTER USER icinga WITH PASSWORD 'icinga';
     postgres=# CREATE DATABASE icinga;
     postgres=# \q
     $ createlang plpgsql icinga;
    ~~~~

    Beginnend mit PostgreSQL 9.1 ist "createlang ..." obsolet.

    -   **Debian:**

        ~~~~ {.programlisting}
         #> vi /etc/postgresql/8.x/main/pg_hba.conf
        ~~~~

    -   **Fedora / RedHat / CentOS:**

        ~~~~ {.programlisting}
         #> vi /var/lib/pgsql/data/pg_hba.conf
        ~~~~

    Editieren Sie die Konfiguration z.B. wie folgt (dem lokalen Benutzer
    muss vertraut werden)

    ~~~~ {.programlisting}
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
    ~~~~

    Neuladen und konfigurieren des Datenbankschemas

    ~~~~ {.programlisting}
     #> /etc/init.d/postgresql-8.x reload
    ~~~~

    ~~~~ {.programlisting}
     #> cd /path/to/icinga-src/module/idoutils/db/pgsql/
     #> psql -U icinga -d icinga < pgsql.sql
    ~~~~

    Editieren der DB-Konfigurationsdatei, um die IDOUtils anzupassen

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
     db_servertype=pgsql
     db_port=5432
     db_user=icinga
     db_pass=icinga
    ~~~~

-   **Oracle:**

    Erstellen Sie ein Datenbank-Schema und eine
    username/password-Kombination (lesen Sie dazu die
    Oracle-Dokumentation unter http://www.oracle.com oder fragen Sie
    Ihren DBA). Importieren Sie das Datenbank-Schema mit sqlplus (oder
    Ihrer bevorzugten Methode). Kopieren Sie
    `module/idoutils/db/oracle/*`{.filename} nach \$ORACLE\_HOME und
    ändern Sie in `icinga_defines.sql`{.filename} die Werte zu
    Tablespace-Namen und Benutzerdaten.

    ~~~~ {.programlisting}
     #> su - oracle
     $ sqlplus dbuser/dbpass
     SQL> @oracle.sql
    ~~~~

    Editieren Sie das DB-Config-File, um die IDOUtils anzupassen. Denken
    Sie daran, dass Oracle den DB-Host ignoriert, nutzen Sie statt
    dessen db\_name, um auf //DBSERVER/DBNAME zu verweisen

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
      db_servertype=oracle
      db_port=1521
      db_user=icinga
      db_pass=icinga
    ~~~~

### 2.6.12. Installieren und konfigurieren des klassischen Web-Interface

Icinga stellt das klassische Web-Interface zur Verfügung ("Classic Web",
"die CGIs"). Sie können dieses wie folgt installieren:

~~~~ {.programlisting}
 #> cd /path/to/icinga-src
 #> make cgis
 #> make install-cgis
 #> make install-html
~~~~

Wenn Sie (zusätzlich) das neue Icinga-Web installieren wollen, lesen Sie
bitte [Installation des
Web-Interface](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend").

Installieren Sie die Icinga-Web-Konfigurationsdatei im Apache
conf.d-Verzeichnis.

~~~~ {.programlisting}
 #> cd /path/to/icinga-src
 #> make install-webconf
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.9 installiert der Befehl 'make install-webconf-auth'
zusätzlich die Datei `htpasswd.users`{.filename}, die
Anmeldeinformationen für den Benutzer *icingaadmin* enthält, so dass Sie
den nächsten Schritt überspringen können. Das Passwort lautet
*icingaadmin*.

![[Anmerkung]](../images/note.png)

Anmerkung

Beginnend mit Apache 2.4 (testing-Versionen von Debian / Ubuntu) müssen
Sie die Konfiguration aktivieren

~~~~ {.screen}
#> a2enconf icinga
~~~~

Legen Sie ein *icingaadmin*-Konto an, um sich am klassischen
Web-Interface anmelden zu können. Merken Sie sich das Passwort, das Sie
diesem Konto geben - Sie brauchen es später.

~~~~ {.screen}
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von der Apache-Version müssen Sie ggf. *htpasswd2 verwenden.*

Wenn Sie das Passwort später ändern oder einen weiteren Benutzer
hinzufügen möchten, verwenden Sie den folgenden Befehl:

~~~~ {.programlisting}
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

Starten Sie Apache neu, damit die Änderungen wirksam werden.

-   **Fedora / RHEL / CentOS**:

    ~~~~ {.programlisting}
     #> service httpd restart
    ~~~~

-   **Ubuntu / openSuSE:**

    ~~~~ {.programlisting}
     #> service apache2 restart
    ~~~~

-   **Debian:**

    ~~~~ {.programlisting}
     #> /etc/init.d/apache2 reload
    ~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Prüfen Sie die Implementierung der verbesserten CGI-Sicherheitsmaßnahmen
wie
[hier](cgisecurity.md "8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung")
beschrieben, um sicherzustellen, dass Ihre
Web-Authentifizierungsinformationen nicht kompromittiert werden.

### 2.6.13. Kompilieren und installieren der Plugins

Entpacken Sie die Plugins-Quellcode-Archivdatei.

~~~~ {.screen}
 #> cd /usr/src
 #> tar xzf nagios-plugins-2.1.tar.gz
 #> cd nagios-plugins-2.1
~~~~

Kompilieren und installieren Sie die Plugins.

~~~~ {.screen}
 #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 #> make
 #> make install
~~~~

### 2.6.14. Anpassen der SELinux-Einstellungen

RHEL und ähnliche Distributionen wie Fedora oder CentOS werden mit
installiertem SELinux (Security Enhanced Linux) ausgeliefert und laufen
im "Enforcing"-Modus. Dies kann zu "Internal Server Error"-Fehlern
führen, wenn Sie versuchen, die Icinga-CGIs aufzurufen.

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
Enforcing/Targeted-Modus laufen zu lassen. Der *semanage*-Befehl wird
automatisch Einträge in die Datei
`/etc/selinux/targeted/contexts/files/file_contexts.local`{.filename}
einfügen:

~~~~ {.programlisting}
 #> semanage fcontext -a -t httpd_sys_script_exec_t '/usr/local/icinga/sbin(/.*)?'
 #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga/share(/.*)?'
 #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga/var(/.*)?'
~~~~

Sobald Sie die notwendigen Kontexte definiert haben, müssen die Einträge
aktiviert werden.

~~~~ {.programlisting}
 #> chcon -R /usr/local/icinga/sbin
 #> chcon -R /usr/local/icinga/share
 #> chcon -R /usr/local/icinga/var
~~~~

Einzelheiten finden Sie unter
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/)
(englisch).

### 2.6.15. IDOUtils und Icinga starten

IDOUtils muss vor Icinga gestartet werden

**IDOUtils starten**

-   **Fedora / openSuSE/Ubuntu:**

    ~~~~ {.programlisting}
     #> service ido2db start
    ~~~~

-   **Debian:**

    ~~~~ {.programlisting}
     #> /etc/init.d/ido2db start
    ~~~~

**IDOUtils beenden**

-   **Fedora / openSuSE/Ubuntu:**

    ~~~~ {.programlisting}
     #> service ido2db stop
    ~~~~

-   **Debian:**

    ~~~~ {.programlisting}
     #> /etc/init.d/ido2db stop
    ~~~~

### 2.6.16. Automatischer Start von IDOUtils

Fügen Sie IDOUtils zu der Liste der System-Services hinzu und sorgen Sie
für einen automatischen Start, wenn das System hochfährt (stellen Sie
sicher, dass Sie vorher das Init-Script installiert haben).

**Fedora / openSuSE:**

~~~~ {.programlisting}
 #> chkconfig --add ido2db
 #> chkconfig ido2db on 
~~~~

**Debian / Ubuntu:**

~~~~ {.programlisting}
 #> update-rc.d ido2db defaults
~~~~

**Icinga starten:**

**Start von Icinga**

Überprüfen Sie die Icinga-Beispielkonfigurationsdateien.

~~~~ {.programlisting}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

Wenn es dabei keine Fehler gibt, starten Sie Icinga.

**Fedora / openSuSE/Ubuntu:**

~~~~ {.programlisting}
 #> service icinga start
~~~~

**Debian:**

~~~~ {.programlisting}
 #> /etc/init.d/icinga start
~~~~

**Automatischer Start von Icinga**

Fügen Sie Icinga zu der Liste der System-Services hinzu und sorgen Sie
für einen automatischen Start, wenn das System hochfährt (stellen Sie
sicher, dass Sie vorher das Init-Script installiert haben).

**Fedora / openSuSE:**

~~~~ {.programlisting}
 #> chkconfig --add icinga 
 #> chkconfig icinga on 
~~~~

**Debian / Ubuntu:**

~~~~ {.programlisting}
 #> update-rc.d icinga defaults
~~~~

### 2.6.17. Anmelden am klassischen Web-Interface

Sie sollten nun auf das klassische Icinga-Web-Interface zugreifen
können. Sie werden nach dem Benutzernamen (*icingaadmin*) und Passwort
gefragt, das Sie vorhin angegeben haben.

~~~~ {.screen}
 http://localhost/icinga/
~~~~

oder

~~~~ {.programlisting}
 http://yourdomain.com/icinga/
~~~~

Klicken Sie auf den "Service Detail"-Verweis in der Navigationsleiste,
um Details darüber zu erhalten, was auf Ihrer lokalen Maschine überwacht
wird. Es wird ein paar Minuten dauern, bis Icinga alle mit Ihrer
Maschine verbundenen Services geprüft hat, weil die Prüfungen über eine
gewisse Zeit verteilt werden.

### 2.6.18. Andere Anpassungen

Stellen Sie sicher, dass die Firewall-Einstellungen Ihrer Maschine einen
Zugriff auf das klassische Web-Interface ermöglichen, wenn Sie von
anderen Rechnern darauf zugreifen wollen.

~~~~ {.programlisting}
 #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
~~~~

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

  ------------------------------------------- -------------------------- ----------------------------------------------------
  [Zurück](quickstart-icinga-freebsd.md)    [Nach oben](ch02.md)      [Weiter](quickstart-idoutils-freebsd.md)
  2.5. Icinga-Schnellstart auf FreeBSD        [Zum Anfang](index.md)    2.7. Icinga-Schnellstart mit IDOUtils auf FreeBSD
  ------------------------------------------- -------------------------- ----------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
