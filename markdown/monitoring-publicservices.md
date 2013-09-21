Öffentlich zugängliche Dienste überwachen
=========================================

Überwachung
Öffentlich zugängliche Dienste überwachen
Monitoring
Öffentlich zugängliche Dienste überwachen
Einführung
----------

Dieses Dokument beschreibt, wie Sie öffentlich zugängliche Dienste,
Applikationen und Protokolle überwachen können. Mit "öffentlich" meinen
wir Dienste, die über das Netzwerk zugänglich sind - entweder das lokale
Netzwerk oder das größere Internet. Beispiele von öffentlichen Diensten
umfassen u.a. HTTP, POP3, IMAP, FTP und SSH. Es gibt viele weitere
öffentliche Dienste, die Sie wahrscheinlich jeden Tag benutzen. Diese
Dienste und Applikationen, genau wie ihre zu Grunde liegenden
Protokolle, können normalerweise mit NAME-ICINGA ohne spezielle
Zugangsvoraussetzungen überwacht werden.

Private Dienste können im Gegensatz dazu nicht ohne einen dazwischen
geschalteten Agenten überwacht werden. Beispiele von mit Hosts
verbundenen privaten Diensten sind Dinge wie CPU-Auslastung,
Speicherbelegung, Plattenbelegung, angemeldete Benutzer,
Prozessinformationen usw. Diese privaten Dienste oder Attribute von
Hosts werden normalerweise nicht an externe Clients offengelegt. Diese
Situation erfordert, dass ein zwischengeschalteter Überwachungsagent auf
jedem Host installiert wird, den Sie überwachen müssen. Mehr
Informationen zur Überwachung von privaten Diensten auf verschiedenen
Arten von Hosts finden Sie in der Dokumentation zu:

-   [Windows-Rechner überwachen](#monitoring-windows)

-   [Netware-Server überwachen](#monitoring-netware)

-   [NAME-LINUX/Unix-Rechner überwachen](#monitoring-linux)

![](../images/tip.gif) Hinweis: Gelegentlich werden Sie feststellen,
dass Informationen zu privaten Diensten und Applikationen mit SNMP
überwacht werden können. Der SNMP-Agent erlaubt Ihnen, entfernt liegende
anderenfalls private (und unzugängliche) Informationen des Hosts zu
überwachen. Mehr Informationen zur Überwachung von Diensten mit SNMP
finden Sie in der Dokumentation zur [Überwachung von Switches und
Routern](#monitoring-routers).

![](../images/note.gif) Anmerkung: Diese Anweisungen gehen davon aus,
dass Sie NAME-ICINGA anhand der [Schnellstartanleitung](#quickstart)
installiert haben. Die nachfolgenden Beispiel-Konfigurationseinträge
beziehen sich auf Objekte, die in den Beispiel-Konfigurationsdateien
(*commands.cfg* und *localhost.cfg*) definiert sind. Diese Dateien
werden installiert, wenn Sie der Schnellstartanleitung folgen.

Falls Sie ein Paket installiert haben, dann fehlen die Beispieldateien
möglicherweise. Sie finden den Inhalt [hier](#sample-config) zum
Nachschlagen.

Plugins zur Überwachung von Services
------------------------------------

Wenn Sie feststellen, dass Sie eine bestimmte Applikation, einen Service
oder ein Protokoll überwachen müssen, dann stehen die Chancen gut, dass
bereits ein [Plugin](plugins.html) existiert. Die offizielle
NAME-ICINGA-Plugin-Distribution enthält Plugins, mit denen eine Reihe
von Services und Protokollen überwacht werden können. Es gibt auch eine
große Zahl von Plugins, die andere Leute beigetragen haben, die Sie im
*contrib/*-Unterverzeichnis der Plugin-Distribution finden. Die
[NAME-ICINGAExchange.org](http://www.nagiosexchange.org/)-Website stellt
eine Reihe von zusätzlichen Plugins bereit, die andere Benutzer
geschrieben haben, also schauen Sie vorbei, wenn Sie Zeit finden.

Wenn Sie zufällig kein entsprechendes Plugin für das finden, was Sie
überwachen möchten, dann können Sie immer Ihr eigenes schreiben. Plugins
sind einfach zu schreiben, also lassen Sie sich nicht von diesem
Gedanken abschrecken. Lesen Sie dazu die Dokumentation über die
[Entwicklung von Plugins](#pluginapi).

Ich werde Sie durch die Überwachung von einigen grundlegenden Diensten
führen, die Sie vielleicht früher oder später brauchen. Jeder dieser
Services kann mit einem der Plugins überwacht werden, die als Teil der
NAME-ICINGA-Plugin-Distribution installiert werden. Lassen Sie uns
beginnen...

erstellen einer Host-Definition
-------------------------------

Bevor Sie einen Service überwachen können, müssen Sie einen
[Host](#objectdefinitions-host) definieren, der mit dem Service
verbunden ist. Sie können Host-Definitionen in jeder
Objektkonfigurationsdatei platzieren, die mit einer
[cfg\_file](#configmain-cfg_file)-Direktive definiert ist oder in einem
Verzeichnis, das in einer [cfg\_dir](#configmain-cfg_dir)-Direktive
angegeben ist. Wenn Sie bereits eine Host-Definition angelegt haben,
dann können Sie diesen Schritt überspringen.

Lassen Sie uns für dieses Beispiel annehmen, dass Sie eine Reihe von
Services auf einem entfernten Host überwachen wollen. Lassen Sie uns
diesen Host *remotehost* nennen. Die Host-Definition kann in einer
eigenen Datei ablegt oder zu einer bereits existierenden
Objektkonfigurationsdatei hinzugefügt werden. Hier nun, wie die
Host-Definition für *remotehost* aussehen könnte:

     define host{
            use             generic-host            ; Inherit default values from a template
            host_name       remotehost              ; The name we're giving to this host
            alias           Some Remote Host        ; A longer name associated with the host
            address         192.168.1.50            ; IP address of the host
            hostgroups      allhosts                ; Host groups this host is associated with
            }

Nachdem für den Host eine Definition hinzugefügt wurde, können wir mit
der Definition von zu überwachenden Services beginnen. Genau wie
Host-Definitionen können auch Service-Definitionen in jeder
Objektkonfigurationdatei abgelegt werden.

erstellen von Service-Definitionen
----------------------------------

Für jeden Service, den Sie überwachen wollen, müssen Sie in NAME-ICINGA
einen [Service](#objectdefinitions-service) definieren, der mit der
Host-Definition verbunden ist, die Sie gerade angelegt haben. Sie können
Host-Definitionen in jeder Objektkonfigurationsdatei platzieren, die mit
einer [cfg\_file](#configmain-cfg_file)-Direktive definiert ist oder in
einem Verzeichnis, das in einer
[cfg\_dir](#configmain-cfg_dir)-Direktive angegeben ist.

Einige Beispiel-Service-Definitionen zur Überwachung von gebräuchlichen
Services (HTTP, FTP, usw.) finden Sie nachfolgend.

-   **HTTP überwachen**

    Wahrscheinlich werden Sie zu irgendeinem Zeitpunkt Web-Server
    überwachen wollen - entweder Ihre eigenen oder die von anderen. Das
    *check\_http*-Plugin macht genau das. Es versteht HTTP und kann
    Antwortzeiten, Fehler-Codes, Zeichenketten im zurückgelieferten
    HTML, Server-Zertifikate und vieles mehr überwachen.

    Die *commands.cfg*-Datei enthält eine Befehlsdefinition für das
    *check\_http*-Plugin. Sie lautet:

         define command{
                name            check_http
                command_name    check_http
                command_line    $USER1$/check_http -I $HOSTADDRESS$ $ARG1$
                }

    Eine einfache Service-Definition, um den HTTP-Service auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     HTTP
                check_command           check_http
                }

    Diese einfache Service-Definition wird den auf *remotehost*
    laufenden HTTP-Service überwachen. Es werden Alarme erzeugt, wenn
    der Web-Server nicht innerhalb von 10 Sekunden antwortet bzw. wenn
    HTTP-Fehler-Codes (403, 404, usw.) zurückgeliefert werden. Das ist
    alles, was Sie für eine einfache Überwachung brauchen. Ziemlich
    simpel, oder?

    ![](../images/tip.gif) Hinweis: Für eine erweiterte Überwachung
    starten Sie das *check\_http*-Plugin manuell mit *--help* als
    Kommandozeilenargument, um alle Optionen zu sehen, die das Plugin
    unterstützt. Diese *--help*-Syntax funktioniert bei allen Plugins,
    die wir in diesem Dokument behandeln werden.

    Eine fortgeschrittenere Definition zur Überwachung des HTTP-Service
    finden Sie nachfolgend. Diese Service-Definition wird prüfen, ob der
    URI /download/index.php die Zeichenkette "latest-version.tar.gz"
    enthält. Falls die Zeichenkette nicht gefunden wird, der URI nicht
    gültig ist oder der Web-Server länger als fünf Sekunden für die
    Antwort braucht, wird ein Fehler erzeugt.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     Product Download Link
                check_command           check_http!-u /download/index.php -t 5 -s "latest-version.tar.gz"
                }

-   **FTP überwachen**

    Wenn Sie FTP-Server überwachen müssen, können Sie das
    *check\_ftp*-Plugin benutzen. Die *commands.cfg*-Datei enthält eine
    Befehlsdefinition für das *check\_ftp*-Plugin. Sie lautet:

         define command{
                command_name    check_ftp
                command_line    $USER1$/check_ftp -H $HOSTADDRESS$ $ARG1$
                }

    Eine einfache Service-Definition, um den FTP-Server auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     FTP
                check_command           check_ftp
                }

    Diese Service-Definition wird den FTP-Service überwachen und Alarme
    erzeugen, wenn der FTP-Server nicht innerhalb von 10 Sekunden
    antwortet.

    Eine fortgeschrittenere Definition finden Sie nachfolgend. Dieser
    Service wird den FTP-Server prüfen, der auf Port 1023 auf
    *remotehost* läuft. Falls der FTP-Server nicht innerhalb von fünf
    Sekunden antwortet oder die Server-Antwort nicht die Zeichenkette
    "Pure-FTPd [TLS]" enthält, wird ein Fehler erzeugt.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     Special FTP 
                check_command           check_ftp!-p 1023 -t 5 -e "Pure-FTPd [TLS]"
                }

-   **SSH überwachen**

    Wenn Sie SSH-Server überwachen müssen, können Sie das
    *check\_ssh*-Plugin benutzen. Die *commands.cfg*-Datei enthält eine
    Befehlsdefinition für das *check\_ssh*-Plugin. Sie lautet:

         define command{
                command_name    check_ssh
                command_line    $USER1$/check_ssh $ARG1$ $HOSTADDRESS$
                }

    Eine einfache Service-Definition, um den SSH-Server auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     SSH
                check_command           check_ssh
                }

    Diese Service-Definition wird den SSH-Service überwachen und Alarme
    erzeugen, wenn der SSH-Server nicht innerhalb von 10 Sekunden
    antwortet.

    Eine fortgeschrittenere Definition finden Sie nachfolgend. Dieser
    Service wird den SSH-Server prüfen und einen Fehler erzeugen, wenn
    der Server nicht innerhalb von fünf Sekunden antwortet oder die
    Server-Antwort nicht mit der Zeichenkette "OpenSSH\_4.2"
    übereinstimmt.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     SSH Version Check 
                check_command           check_ssh!-t 5 -r "OpenSSH_4.2"
                }

-   **SMTP**

    Das *check\_smtp*-Plugin kann genutzt werden, um Ihren e-Mail-Server
    zu überwachen. Die *commands.cfg*-Datei enthält eine
    Befehlsdefinition für das *check\_smtp*-Plugin. Sie lautet:

         define command{
                command_name    check_smtp
                command_line    $USER1$/check_smtp -H $HOSTADDRESS$ $ARG1$
                }

    Eine einfache Service-Definition, um den SMTP-Server auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     SMTP
                check_command           check_smtp
                }

    Diese Service-Definition wird den SMTP-Service überwachen und Alarme
    erzeugen, wenn der SMTP-Server nicht innerhalb von 10 Sekunden
    antwortet.

    Eine fortgeschrittenere Definition finden Sie nachfolgend. Dieser
    Service wird den SMTP-Server prüfen und einen Fehler erzeugen, wenn
    der Server nicht innerhalb von fünf Sekunden antwortet oder die
    Server-Antwort nicht die Zeichenkette "mygreatmailserver" enthält.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     SMTP Response Check 
                check_command           check_smtp!-t 5 -e "mygreatmailserver.com"
                }

-   **POP3 überwachen**

    Das *check\_pop*-Plugin kann genutzt werden, um den POP3-Service
    Ihres e-Mail-Servers zu überwachen. Die *commands.cfg*-Datei enthält
    eine Befehlsdefinition für das *check\_pop*-Plugin. Sie lautet:

         define command{
                command_name    check_pop
                command_line    $USER1$/check_pop -H $HOSTADDRESS$ $ARG1$
                }

    Eine einfache Service-Definition, um den POP3-Service auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     POP3
                check_command           check_pop
                }

    Diese Service-Definition wird den POP3-Service überwachen und Alarme
    erzeugen, wenn der POP3-Server nicht innerhalb von 10 Sekunden
    antwortet.

    Eine fortgeschrittenere Definition finden Sie nachfolgend. Dieser
    Service wird den POP3-Service prüfen und einen Fehler erzeugen, wenn
    der Server nicht innerhalb von fünf Sekunden antwortet oder die
    Server-Antwort nicht die Zeichenkette "mygreatmailserver.com"
    übereinstimmt.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     POP3 Response Check 
                check_command           check_pop!-t 5 -e "mygreatmailserver.com"
                }

-   **IMAP überwachen**

    Das *check\_imap*-Plugin kann genutzt werden, um den IMAP4-Service
    Ihres e-Mail-Servers zu überwachen. Die *commands.cfg*-Datei enthält
    eine Befehlsdefinition für das *check\_imap*-Plugin. Sie lautet:

         define command{
                command_name    check_imap
                command_line    $USER1$/check_imap -H $HOSTADDRESS$ $ARG1$
                }

    Eine einfache Service-Definition, um den IMAP4-Server auf dem
    *remotehost*-Rechner zu überwachen, würde so aussehen:

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     IMAP
                check_command           check_imap
                }

    Diese Service-Definition wird den IMAP4-Service überwachen und
    Alarme erzeugen, wenn der IMAP-Server nicht innerhalb von 10
    Sekunden antwortet.

    Eine fortgeschrittenere Definition finden Sie nachfolgend. Dieser
    Service wird den IMAP4-Service prüfen und einen Fehler erzeugen,
    wenn der Server nicht innerhalb von fünf Sekunden antwortet oder die
    Server-Antwort nicht die Zeichenkette "mygreatmailserver.com"
    enthält.

         define service{
                use                     generic-service         ; Inherit default values from a template
                host_name               remotehost
                service_description     IMAP4 Response Check 
                check_command           check_imap!-t 5 -e "mygreatmailserver.com"
                }

NAME-ICINGA erneut starten
--------------------------

Sobald Sie die neuen Host- und Service-Definitionen zu Ihrer/n
Konfigurationsdatei(en) hinzugefügt haben, sind Sie bereit, sie zu
überwachen. Um dies zu tun, müssen Sie [die Konfiguration
überprüfen](#verifyconfig) und [NAME-ICINGA erneut starten](#startstop).

Wenn der Überprüfungsprozess irgendwelche Fehler produziert, dann
verbessern Sie Ihre Konfigurationsdatei, bevor Sie fortfahren. Stellen
Sie sicher, dass Sie NAME-ICINGA nicht erneut starten, bevor der
Überprüfungsprozess ohne Fehler durchläuft!
