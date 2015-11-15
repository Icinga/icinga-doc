![Icinga](../images/logofullsize.png "Icinga")

9.5. Installation von Icinga Reporting mit JasperReports Server

[Zurück](int-mklivestatus.md) 

Kapitel 9. Integration mit anderer Software

 [Weiter](ch10.md)

* * * * *

9.5. Installation von Icinga Reporting mit JasperReports Server
---------------------------------------------------------------

9.5.1. [Offizielle Dokumentation](reporting.md#introduction)

9.5.2. [Voraussetzungen](reporting.md#officialdocs)

9.5.3. [Icinga Reporting](reporting.md#icingareporting)

9.5.4. [Konfiguration](reporting.md#configuration)

9.5.5. [Reports](reporting.md#reports)

9.5.6. [Fehler](reporting.md#errors)

Icinga Reporting basiert auf dem IDOUtils-Backend und unterstützt, genau
wie der Icinga Core, alle großen Datenbankplattformen.

Hier geben wir Ihnen einige Hinweise, wie Sie das Icinga Reporting mit
JasperReports Server installieren.

### 9.5.1. Offizielle Dokumentation

Mehr Information finden Sie unter
[http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/JasperReports-Server-CP-Install-Guide.pdf](http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/JasperReports-Server-CP-Install-Guide.pdf)
oder
[http://jasperforge.org/espdocs/espbrowse.php?id=86&type=folder&group\_id=112&parent=86](http://jasperforge.org/espdocs/espbrowse.php?id=86&type=folder&group_id=112&parent=86)

### 9.5.2. Voraussetzungen

-   Icinga und IDOUtils

    Installiert wie in den Schnellstartanleitungen beschrieben, entweder
    über die
    [Sourcen](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
    oder über
    [Distributionspakete](icinga_packages.md#icinga-packages)

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Ab Icinga 1.8 gibt es eine Funktion in der Datenbank die alle
    benötigten SLA- Informationen bereitstellt. Diese Funktion muss
    zusätzlich zu dem Report- Paket zu in die bestehende IDOUtils
    Datenbank importiert werden.

    MySQL

    ~~~~ {.screen}
    #> /usr/bin/mysql icinga < icinga-reports-1.10.0/db/icinga/mysql/availability.sql
    ~~~~

    Stellen Sie bitte ebenfalls sicher, dass der Datenbank- Benutzer
    (hier icinga@localhost) das Recht EXECUTE besitzt.

    ~~~~ {.screen}
    #> /usr/bin/mysql -u root -p <password> icinga
    mysql> GRANT EXECUTE ON icinga.* TO 'icinga'@'localhost' ;
    quit
    ~~~~

-   Apache Tomcat

    Nur falls Sie nicht den mit JasperReports Server gebündelten Tomcat
    benutzen möchten.

    ~~~~ {.screen}
     #> apt-get install tomcat6
    ~~~~

-   PostgreSQL

    Nur falls Sie nicht das mit JasperServer gebündelte PostgreSQL
    benutzen möchten. PostgreSQL ist für die JasperReports Server
    interne Speicherung erforderlich.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Das Backend von JasperReports Server wurde ab Version 4.2.1 von
    MySQL nach PostgreSQL geändert!
    [Source](http://jasperforge.org/plugins/espnews/browse.php?group_id=112&news_id=292)

-   JasperReports Server

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    JasperReports Server 5.0.0 wird erst ab Icinga Reporting 1.9
    unterstützt! Für die Installation Version des Icinga Reporting-
    Paketes \< 1.9 , nutzen Sie bitte mindestens JasperReports Server
    4.5.0.

    Abhängig von Ihrer Architektur (`uname -a`{.code}) holen Sie sich
    den entsprechenden Installer - hier im Beispiel x64

    ~~~~ {.screen}
     $> wget http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/jasperreports-server-cp-5.0.0-linux-x64-installer.run

     $> chmod +x jasperreports-server-cp-5.0.0-linux-x64-installer.run
     $> sudo ./jasperreports-server-cp-5.0.0-linux-x64-installer.run
    ~~~~

    -   stimmen Sie der Lizenz zu

    -   wählen Sie "bundled tomcat"

    -   wählen Sie "bundled postgresql"

        -   wählen Sie eine anderen PostgreSQL-Port, wie z.B. 5443, um
            nicht mit existierenden Einstellungen zu kollidieren

    -   installieren Sie die Beispiel-Reports und "ireports"

    Der Installer wird automatisch die benötigte Datenbank und das
    Schema anlegen und die Beispiele installieren.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Die standardmäßig wird JasperReports Server nach
    /opt/jasperreports-server-cp-5.0.0/ installiert. Wenn Sie den
    JasperReports Server aktualisieren, versichern Sie sich mit der
    richtigen Version zu arbeiten!

    *Start*

    ~~~~ {.screen}
     #> cd /opt/jasperreports-server-cp-5.0.0/
     #> ./ctlscript.sh start
    ~~~~

    Für einzelne Komponenten

    ~~~~ {.screen}
     #> ./ctlscript.sh postgresql start|stop
     #> ./ctlscript.sh tomcat start|stop
    ~~~~

### 9.5.3. Icinga Reporting

-   Sourcen

    Laden Sie das Paket herunter und entpacken es. Falls Sie ein Problem
    haben, das ggf. in der Entwickerversion gelöst ist, dann holen Sie
    sich den aktuellen Entwickler-Snapshot aus git

    ~~~~ {.screen}
     $> wget https://github.com/Icinga/icinga-reports/releases/download/v1.10.0/icinga-reports-1.10.0.tar.gz; \
        tar xzf icinga-reports-1.10.0.tar.gz; \
        cd icinga-reports-1.10.0
    ~~~~

    oder

    ~~~~ {.screen}
     $> git clone git://git.icinga.org/icinga-reports.git ; \
        cd icinga-reports
    ~~~~

    Falls ein Entwickler Sie gebeten hat, ihren/seinen Branch zu
    benutzen, dann benutzen Sie

    ~~~~ {.screen}
     $> git branch localbranch origin/devhead/devbranch
     $> git checkout localbranch
     $> git log
    ~~~~

-   Konfigurieren

    Falls Sie den JasperReports Server vorher nicht mit dem
    Default-Präfix installiert haben, dann müssen Sie configure den
    Standort mitteilen.

    ~~~~ {.screen}
     $> ./configure --with-jasper-server=/opt/jasperreports-server-cp-5.0.0
    ~~~~

-   Make

    Rufen Sie 'make' ohne Parameter auf, um eine komplette Liste der
    verfügbaren Optionen zu erhalten.

    -   MySQL Connector

        JasperReports Server wird mit dem PostgreSQL-Connector
        ausgeliefert, aber wenn Sie MySQL benötigen, dann bietet das
        Icinga Reporting-Paket einen Connector zur Installation an.

        ~~~~ {.screen}
         #> make install-mysql-connector
        ~~~~

        Starten Sie den Tomcat-Server neu

        ~~~~ {.screen}
         #> cd /opt/jasperreports-server-cp-5.0.0
         #> ./ctlscript.sh stop tomcat
         #> ./ctlscript.sh start tomcat
        ~~~~

    -   Installieren

        Der JasperReports Server muss gestartet sein!

        ~~~~ {.screen}
         #> make install
        ~~~~

        Starten Sie den Tomcat-Server neu

        ~~~~ {.screen}
         #> cd /opt/jasperreports-server-cp-5.0.0
         #> ./ctlscript.sh stop tomcat
         #> ./ctlscript.sh start tomcat
        ~~~~

### 9.5.4. Konfiguration

Öffnen Sie das Web-Interface, Standardwerte sind jasperadmin:jasperadmin

`http://127.0.0.1:8080/jasperserver`{.uri}

-   IDO

    Gehen Sie nach `/root/Icinga/datasource`{.uri} (stellen Sie sicher,
    dass Refine den Wert "changed by anyone" enthält).

    **Abbildung 9.1. Icinga reporting datasource ido mysql**

    ![Icinga reporting datasource ido
    mysql](../images/icinga-reporting-datasource-ido-mysql_1.8.png)

    \

    -   Editieren Sie die vorhandene "datasource" und stellen Sie Ihre
        Werte ein. MySQL driver: com.mysql.jdbc.Driver MySQL URL:
        jdbc:mysql://localhost:3306/icinga

        **Abbildung 9.2. Icinga reporting**

        ![Icinga reporting](../images/icinga-reporting-overview_1.8.png)

        \

    -   Testen Sie die Konfiguration und speichern Sie die Verbindung.

    -   Alle Reports in unserem Paket zeigen auf diese "datasource" und
        sollten lauffähig sein.

### 9.5.5. Reports

Überprüfen Sie, dass die Reports verfügbar und lauffähig sind.

**Abbildung 9.3. Icinga reporting**

![Icinga reporting](../images/icinga-reporting-overview_1.8.png)

\

### 9.5.6. Fehler

-   Anzeigefehler

    ~~~~ {.screen}
     org.springframework.web.util.NestedServletException: Handler processing failed; 
     nested exception is java.lang.InternalError:
     Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
    ~~~~

    Der Tomcat läuft als root und versucht, auf das X11-Display des
    Benutzers zuzugreifen. Erlauben Sie es für jeden lokalen Benutzer.

    ~~~~ {.screen}
     $> xhost +local:all
    ~~~~

-   Generierungsfehler

    ~~~~ {.screen}
     org.springframework.web.util.NestedServletException: Handler processing failed;
     nested exception is java.lang.NoClassDefFoundError:
     Could not initialize class net.sf.jasperreports.engine.util.JRStyledTextParser
    ~~~~

    Es könnte Sun AWT sein, das versucht, auf X11-Klassen zuzugreifen,
    aber tatsächlich ist es die PDF-Generierung für einen Report.

    ~~~~ {.screen}
     $> sudo apt-get install msttcorefonts
     $> cd /opt/jasperreports-server-cp-5.0.0
     $> sudo sh ctlscript.sh stop
     $> sudo sh ctlscript.sh start
    ~~~~

* * * * *

  ---------------------------------- -------------------------- -------------------------------
  [Zurück](int-mklivestatus.md)    [Nach oben](ch09.md)      [Weiter](ch10.md)
  9.4. MKLiveStatus-Integration      [Zum Anfang](index.md)    Kapitel 10. weitere Software
  ---------------------------------- -------------------------- -------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
