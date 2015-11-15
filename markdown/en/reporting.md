![Icinga](../images/logofullsize.png "Icinga")

9.5. Installation of the Icinga Reporting with JasperReports Server

[Prev](int-mklivestatus.md) 

Chapter 9. Integration With Other Software

 [Next](ch10.md)

* * * * *

9.5. Installation of the Icinga Reporting with JasperReports Server
-------------------------------------------------------------------

9.5.1. [Introduction](reporting.md#introduction)

9.5.2. [Official Docs](reporting.md#officialdocs)

9.5.3. [Requirements](reporting.md#requirements)

9.5.4. [Icinga Reporting](reporting.md#icingareporting)

9.5.5. [Configuration](reporting.md#configuration)

9.5.6. [Reports](reporting.md#reports)

9.5.7. [Errors](reporting.md#errors)

### 9.5.1. Introduction

The Icinga Reporting is based on the IDOUtils backend and just like the
Icinga Core, it will support all major database platforms.

Here we'll give you some instructions on how to install the Icinga
Reporting with JasperReports Server.

### 9.5.2. Official Docs

For more information, please refer to
[http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/JasperReports-Server-CP-Install-Guide.pdf](http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/JasperReports-Server-CP-Install-Guide.pdf)
or
[http://jasperforge.org/espdocs/espbrowse.php?id=86&type=folder&group\_id=112&parent=86](http://jasperforge.org/espdocs/espbrowse.php?id=86&type=folder&group_id=112&parent=86)

### 9.5.3. Requirements

-   Icinga and IDOUtils

    Installed via
    [sources](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")
    or [packages.](icinga_packages.md#icinga-packages)

    ![[Note]](../images/note.png)

    Note

    Starting with Icinga 1.8 there is a database function providing all
    needed sla-informations. This function needs to be imported into
    your existing IDOUtils database additional to the Icinga Reporting
    package.

    MySQL

    ~~~~ {.screen}
    #> /usr/bin/mysql icinga < icinga-reports-1.10.0/db/icinga/mysql/availability.sql
    ~~~~

    Please make sure your database user (here icinga@localhost) has the
    correct GRANT for EXECUTE.

    ~~~~ {.screen}
    #> /usr/bin/mysql -u root -p <password> icinga
    mysql> GRANT EXECUTE ON icinga.* TO 'icinga'@'localhost' ;
    quit
    ~~~~

-   Apache Tomcat

    Only if you don't want to use the bundled one from JasperServer

    ~~~~ {.screen}
     #> apt-get install tomcat6
    ~~~~

-   PostgreSQL

    Only if you don't want to use the bundled one from JasperServer.
    PostgreSQL is required for JasperServer's internal storage.

    ![[Note]](../images/note.png)

    Note

    JasperServer changed their backend from MySQL to PostgreSQL in
    4.2.1!
    [Source](http://jasperforge.org/plugins/espnews/browse.php?group_id=112&news_id=292)

-   JasperReports Server

    ![[Note]](../images/note.png)

    Note

    The new JasperReports Server 5.0.0 is only supported starting with
    Icinga Reporting 1.9. If you want to use an older version of the
    Icinga Reporting- package, please use at least JasperReports Server
    4.5.0.

    Depending on your architecture (`uname -a`{.code}), fetch the
    appropriate installer - below is x64

    ~~~~ {.screen}
     $> wget http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%205.0.0/jasperreports-server-cp-5.0.0-linux-x64-installer.run

     $> chmod +x jasperreports-server-cp-5.0.0-linux-x64-installer.run
     $> sudo ./jasperreports-server-cp-5.0.0-linux-x64-installer.run
    ~~~~

    -   Agree to license

    -   select bundled tomcat

    -   select bundled postgresql

        -   select a different postgresql port, like 5433, not to
            interfere with existing setups

    -   install sample reports and ireports

    The installer will automatically create the needed database, create
    the schema and install samples.

    ![[Note]](../images/note.png)

    Note

    The default installation location will be
    /opt/jasperreports-server-cp-5.0.0/, so make sure to work on the
    correct JasperReports Server if you are doing an upgarde!

    *Start*

    ~~~~ {.screen}
     #> cd /opt/jasperreports-server-cp-5.0.0/
     #> ./ctlscript.sh start
    ~~~~

    For individual components

    ~~~~ {.screen}
     #> ./ctlscript.sh postgresql start|stop
     #> ./ctlscript.sh tomcat start|stop
    ~~~~

### 9.5.4. Icinga Reporting

As from Icinga 1.6 on, the package provides configure and make scripts.

-   Sources

    Download from sourceforge and extract. If you have an issue which
    might be solved in the developer version then get the latest
    developer snapshot from git

    ~~~~ {.screen}
     $> wget https://github.com/Icinga/icinga-reports/releases/download/v1.10.0/icinga-reports-1.10.0.tar.gz \
        tar xzf icinga-reports-1.10.0.tar.gz; \
        cd icinga-reports-1.10.0
    ~~~~

    or

    ~~~~ {.screen}
     $> git clone git://git.icinga.org/icinga-reports.git ; \
        cd icinga-reports
    ~~~~

    If a developer told you to use his/her branch, check that out with

    ~~~~ {.screen}
     $> git branch localbranch origin/devhead/devbranch
     $> git checkout localbranch
     $> git log
    ~~~~

-   Configure

    If you did not install the JasperReports Server into the default
    prefix before, you need to tell configure the location.

    ~~~~ {.screen}
     $> ./configure --with-jasper-server=/opt/jasperreports-server-cp-5.0.0
    ~~~~

-   Make

    Invoke 'make' without params to get a full list of available
    options.

    -   MySQL Connector

        JasperReports Server natively ships with the PostgreSQL
        Connector, but if you require MySQL, the Icinga Reporting
        package provides one for install.

        ~~~~ {.screen}
         #> make install-mysql-connector
        ~~~~

        Restart the Tomcat server

        ~~~~ {.screen}
         #> cd /opt/jasperreports-server-cp-5.0.0
         #> ./ctlscript.sh stop tomcat
         #> ./ctlscript.sh start tomcat
        ~~~~

    -   Install

        JasperReports Server must be running!

        ~~~~ {.screen}
         #> make install
        ~~~~

        Restart the Tomcat server

        ~~~~ {.screen}
         #> cd /opt/jasperreports-server-cp-5.0.0
         #> ./ctlscript.sh stop tomcat
         #> ./ctlscript.sh start tomcat
        ~~~~

### 9.5.5. Configuration

Open the webinterface, default credentials are jasperadmin:jasperadmin

`http://127.0.0.1:8080/jasperserver`{.uri}

-   IDO

    Go to `/root/Icinga/datasource`{.uri} (be sure that Refine contains
    "changed by anyone").

    **Figure 9.1. Icinga reporting datasource IDO**

    ![Icinga reporting datasource
    IDO](../images/icinga-reporting-datasource-ido_1.8.png)

    \

    -   edit the existing datasource and configure your values. MySQL
        driver: com.mysql.jdbc.Driver MySQL URL:
        jdbc:mysql://localhost:3306/icinga

        **Figure 9.2. Icinga reporting datasource ido mysql**

        ![Icinga reporting datasource ido
        mysql](../images/icinga-reporting-datasource-ido-mysql_1.8.png)

        \

    -   test the configuration and save the connection.

    -   all reports in our package point to this datasource and should
        be able to run.

### 9.5.6. Reports

Verify that the reports are available and working.

**Figure 9.3. Icinga reporting**

![Icinga reporting](../images/icinga-reporting-overview_1.8.png)

\

### 9.5.7. Errors

-   Display Errors

    ~~~~ {.screen}
     org.springframework.web.util.NestedServletException: Handler processing failed; nested exception is java.lang.InternalError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
    ~~~~

    The tomcat being run as root, trying to access the users x11
    display. Allow it for everyone locally.

    ~~~~ {.screen}
     $> xhost +local:all
    ~~~~

-   Generation Errors

    ~~~~ {.screen}
     org.springframework.web.util.NestedServletException: Handler processing failed; nested exception is java.lang.NoClassDefFoundError: Could not initialize class net.sf.jasperreports.engine.util.JRStyledTextParser
    ~~~~

    It could be Sun AWT trying to connect to X11 classes, but actually
    it's the PDF generation on a report.

    ~~~~ {.screen}
     $> sudo apt-get install msttcorefonts
     $> cd /opt/jasperreports-server-cp-5.0.0
     $> sudo sh ctlscript.sh stop
     $> sudo sh ctlscript.sh start
    ~~~~

* * * * *

  -------------------------------- -------------------- ----------------------------------
  [Prev](int-mklivestatus.md)    [Up](ch09.md)       [Next](ch10.md)
  9.4. MKLiveStatus Integration    [Home](index.md)    Chapter 10. Additional software
  -------------------------------- -------------------- ----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
