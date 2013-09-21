NAME-NSCA
=========

Einführung
----------

Nagios Service Check Acceptor (oder kurz NAME-NSCA) ist ein Addon, um
Prüfergebnisse von einem System zu einem anderen zu übertragen. Es
besteht aus zwei Modulen: Dem Sender (send\_nsca) und dem Empfänger
(nsca). Die Daten werden verschlüsselt übertragen. Trotz des Namens
werden auch Host-Prüfergebnisse übertragen.

![](../images/nsca.png)

NAME-NSCA läuft als Daemon auf dem NAME-ICINGA-Server. Er lauscht auf
Informationen, die von entfernten Maschinen mit Hilfe des
send\_nsca-Programms (auf Unix/Linux-Maschinen) oder NSClient++ (oft auf
Windows-Maschinen benutzt) gesendet werden. Die Daten werden mit der in
`send_nsca.cfg` (oder `nsc.ini` im Falle von NSClient++) festgelegten
Methode verschlüsselt. Der Daemon wird die Daten in einer \*sehr\*
einfachen Weise validieren, indem die Informationen mit dem in nsca.cfg
eingetragenen Passwort entschlüsselt werden. Wenn die Daten so aussehen,
als seien sie mit dem gleichen Passwort verschlüsselt worden, dann wird
der Daemon versuchen, diese Daten als externen Befehl in die lokale
NAME-ICINGA-Command-Pipe auszugeben.

Die folgenden Anweisungen basieren hauptsächlich auf dem README aus dem
NAME-NSCA-Paket.

Voraussetzungen
---------------

-   NAME-ICINGA sollte laufen

-   *[check\_external\_commands =
    1](#configmain-check_external_commands)* sollte in `icinga.cfg`
    gesetzt sein

-   *[command\_check\_interval =
    \<n\>[s]](#configmain-command_check_interval)* sollte in
    `icinga.cfg` gesetzt sein` `

-   *[log\_passive\_checks = 1](#configmain-log_passive_checks)* sollte
    während der Testphase in `icinga.cfg` gesetzt sein, anderenfalls
    gibt es keine Meldungen über eintreffende passive Prüfungen

-   die libmcrypt- und libmcrypt-devel-Pakete sind installiert (die je
    nach Distribution ggf. anders heißen können), anderenfalls nutzen
    Sie einen der folgenden Befehle, um die Pakete zu installieren:

         #> apt-get install libmcrypt libmcrypt-devel # Debian / Ubuntu
         #> yum install libmcrypt libmcrypt-devel     # RHEL / Fedora / CentOS
         #> zypper install libmcrypt libmcrypt-devel  # SLES / OpenSuSE (oder benutzen Sie Yast)

Download und Compile
--------------------

> **Note**
>
> Anstatt NAME-NSCA von Grund auf zu installieren möchten Sie vielleicht
> ein Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt.
>
> Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie
> bitte die offiziellen Release-Tarballs, z.B. durch
>
>      #> wget http://sourceforge.net/projects/nagios/files/nsca-2.x/nsca-VER-NSCA/nsca-VER-NSCA.tar.gz -O nsca-VER-NSCA.tar.gz

> **Important**
>
> Bitte benutzen Sie keine Snapshots, solange Sie kein Problem haben,
> das in der aktuellen Entwicklerversion ggf. gelöst ist.

Die maximale Länge der zu übertragenen Daten ist auf 2.048 Bytes
begrenzt, die maximale Länge von Plugin-Ausgaben auf 512 Bytes. Falls
das nicht ausreicht, dann müssen Sie den entsprechenden Wert in
`icinga-nsca/include/common.h` anpassen.

     #define MAX_INPUT_BUFFER        2048    /* max size of most buffers we use */
     #define MAX_PLUGINOUTPUT_LENGTH 512 

Bitte denken Sie daran, dass Sie die Programme erneut kompilieren
müssen, wenn Sie sich zu einem späteren Zeitpunkt für eine Änderung
entscheiden.

Bedingt durch den folgenden Wert in include/common.h (im
NAME-ICINGA-Core) kann der maximale Wert 8.192 Bytes nicht
überschreiten.

     #define MAX_EXTERNAL_COMMAND_LENGTH             8192    /* max length of an external command */

Nach Änderung des Besitzers wechseln Sie in das neu erstellte
Verzeichnis und rufen Sie configure und make auf

     #> chown -R icinga icinga-nsca
     #> cd icinga-nsca
     #> ./configure 
     #> make all

Anschließend gibt es zwei Programme (send und send\_nsca) im
`src`-Verzeichnis.

> **Caution**
>
> Wenn die libmcrypt-Dateien nicht gefunden werden, dann wird
> "./configure" sich beschweren, aber NICHT mit einem Return-Code
> ungleich Null enden, so dass Sie *config.log* mit dem folgenden Befehl
> prüfen sollten
>
>      #> grep mcrypt.h: config.log
>
> Dieser Befehl sollte keine Zeilen ausgeben.

Falls die libmcrypt-Module nicht gefunden werden, Benutzer oder Gruppe
vom Wert "icinga" abweichen oder der zu benutzende Port nicht dem
Default 5667 entspricht, dann können Sie dies über verschiedene Optionen
beeinflussen. Rufen Sie "`./configure -h`" auf, um mehr über die
verfügbaren Optionen zu erfahren.

Nach dem Wechsel in "nsca\_tests" können Sie versuchen, "./runtests"
auszuführen. Bitte beachten Sie, dass diese Tests verschiedene
Perl-Module benötigen, die in der Datei README beschrieben sind.

Anpassen
--------

Das `sample-config`-Verzeichnis enthält `nsca.cfg` und `send_nsca.cfg`.
Mindestens die Einstellungen der Direktiven "password" und
"encryption\_method" / "decryption\_method" sollten Sie
ansehen/verändern, bevor die Dateien kopiert werden. Bitte denken Sie
daran, das gleiche Passwort in allen Kopien dieser Konfigurationsdateien
zu setzen. Wenn Sie verschiedene Passworte auf verschiedenen entfernten
Servern einsetzen möchten, dann müssen Sie mehrere nsca-Daemons auf dem
NAME-ICINGA-Server starten, die auf unterschiedlichen Ports lauschen.
Das funktioniert nicht, wenn Sie den Daemon über inetd/xinetd starten.

Erster Test
-----------

Wechseln Sie zum NAME-ICINGA-Benutzer und starten Sie einen ersten Test

     #> su - icinga
     $> cd /usr/src/icinga-nsca/src
     $> ./nsca -c ../sample-config/nsca.cfg
     $> echo -e "A\tB\tC\tD\n" | ./send_nsca -H localhost -c ../sample-config/send_nsca.cfg
     $> exit

Dies sollte die Meldung "1 data packet(s) sent to host successfully."
zurückliefern. Eigentlich heißt das nur, dass sich send\_nsca und nsca
unter Verwendung der Konfigurationsdateien auf dem lokalen Host
miteinander unterhalten können, denn dieser Test funktioniert auch ohne
eine lauffähige NAME-ICINGA-Instanz. Allerdings ist er trotzdem wichtig:
Wenn dieser Test fehlschlägt, dann ist es nicht sinnvoll fortzufahren.
Prüfen Sie stattdessen die Einstellungen nsca.cfg und send\_nsca.cfg.
Schauen Sie auch im Syslog (z.B. `/var/log/messages`) nach Meldungen.

Wenn die Voraussetzungen erfüllt sind, dann sollten Sie einige Warnungen
in `icinga.log` sehen, dass Host "A" und Service "B" nicht in der
NAME-ICINGA-Konfiguration gefunden werden konnten. Dies bedeutet, dass
nsca ausreichende Berechtigungen hat, um in das NAME-ICINGA-Command-File
zu schreiben. Prüfen Sie, ob der nsca-Daemon und NAME-ICINGA mit
unterschiedlichen Benutzern laufen, wenn es keine Meldugen in icinga.log
gibt. Prüfen Sie außerdem die Einstellung von
[log\_passive\_checks](#configmain-log_passive_checks) in `icinga.cfg`.

Installation
------------

"make install" macht (im Moment) nichts, so dass Sie selbst einige
Dateien kopieren müssen. Die folgenden Befehle kopieren das nsca-Modul
in das Verzeichnis, in dem das NAME-ICINGA-Binary zu finden ist und die
Konfigurationsdatei in den NAME-ICINGA-Konfigurationsordner. Wir nehmen
an, dass Sie NAME-ICINGA nach einer der Schnellstartanleitungen
installiert haben.

     #> cp -p nsca /usr/local/icinga/bin/
     #> cp ../sample-config/nsca.cfg /usr/local/icinga/etc/

-   **nsca daemon**

    Wenn Sie sich für xinetd entscheiden, dann wird der Daemon
    automatisch gestartet. Anderenfalls müssen Sie den Daemon manuell
    starten, nachdem Sie zum NAME-ICINGA-Benutzer gewechselt haben (was
    Sie ggf. bereits in "Erster Test" gemacht haben).

         #> su - icinga
         $> /usr/local/icinga/bin/nsca -c /usr/local/icinga/etc/nsca.cfg

-   **inetd/xinetd**

    Wenn Sie möchten, dass der Daemon von (x)inetd gestartet wird, dann
    müssen Sie `/etc/services` erweitern, eine weitere Datei
    ändern/kopieren und (x)inetd neustarten. Vergessen Sie nicht, den
    nsca-Daemon zu stoppen, der in "Erster Test" gestartet wurde.

    > **Note**
    >
    > Die Einstellung von "server\_port" in nsca.cfg wird ignoriert,
    > wenn Sie inetd/xinetd benutzen.

         #> kill < /var/run/nsca.pid
         #> echo "nsca 5667/tcp # NSCA" >> /etc/services

    Abhängig vom verwendeten Superserver gibt es drei Alternativen

    -   inetd MIT tcpwrappers

        Fügen Sie Einträge zu Ihrer `/etc/hosts.allow` und
        `/etc/hosts.deny` hinzu, um TCP wrapper-Protection für den
        nsca-Service zu aktivieren. Dies ist optional, allerdings sehr
        empfohlen. Fügen Sie "nsca stream tcp nowait \<user\>
        /usr/sbin/tcpd \<nsca-binary\> -c \<nsca-cfg\> --inetd" zur
        /etc/inetd.conf hinzu, z.B.

             #> echo "nsca stream tcp nowait icinga /usr/sbin/tcpd /usr/local/icinga/bin/nsca -c /usr/local/icinga/etc/nsca.cfg --inetd" >> /etc/inetd.conf
             #> /etc/init.d/inetd restart

    -   inetd OHNE tcpwrappers

        Fügen Sie "nsca stream tcp nowait \<user\> \<nsca-binary\> -c
        \<nsca-cfg\> --inetd" zur /etc/inetd.conf hinzu, z.B.

             #> echo "nsca stream tcp nowait icinga /usr/local/icinga/bin/nsca -c /usr/local/icinga/etc/nsca.cfg --inetd" >> /etc/inetd.conf
             #> /etc/init.d/inetd restart

    -   xinetd

        Denken Sie daran, die Konfigurationsdatei `nsca.xinetd` im
        `sample-config`-Verzeichnis zu editieren und \<ipaddress1\>
        durch die IP-Adressen Ihrer Client-Rechner (auf denen send\_nsca
        laufen wird) zu ersetzen. Dies funktioniert nur, wenn xinetd mit
        Unterstützung für tcpwrapper kompiliert wurde. Wenn Sie DHCP
        benutzen, funktioniert das nicht und Sie sollten diese Zeile
        löschen.

        Fügen Sie Einträge zu Ihrer `/etc/hosts.allow` und
        `/etc/hosts.deny` hinzu, um TCP wrapper-Protection für den
        nsca-Service zu aktivieren. Dies ist optional, allerdings sehr
        empfohlen. Fügen Sie "nsca stream tcp nowait \<user\>
        /usr/sbin/tcpd \<nsca-binary\> -c \<nsca-cfg\> --inetd" zur
        /etc/inetd.conf hinzu, z.B.

             #> cp -p ../sample-config/nsca.xinetd /etc/xinetd.d/
             #> /etc/init.d/xinetd restart

Entfernte/s System/e
--------------------

Sie sind mit dem lokalen System fertig, aber natürlich muss send\_nsca
noch auf entfernte Systeme kopiert werden.

Bitte denken Sie daran, dass send\_nsca für die Zielplattform kompiliert
werden muss, so dass Sie ggf. die libmcrypt-Pakete und configure/make
auf mehreren Servern installieren bzw. ausführen müssen.

Dateien kopieren
----------------

Sie können frei entscheiden, wo Sie Binary und Konfigurationsdatei
ablegen möchten. Wir nehmen an, dass Sie eine Verzeichnisstruktur haben,
die ähnlich zum NAME-ICINGA-Server ist.

     #> scp -p <NAME-ICINGA server>:/usr/local/icinga-nsca/src/send_nsca /usr/local/icinga/bin/
     #> scp -p <NAME-ICINGA server>:/usr/local/icinga-nsca/sample-config/send_nsca.cfg /usr/local/icinga/etc/

Zweiter Test
------------

Nun können Sie den Test auf dem entfernten System ausführen

     #> su - icinga
     $> echo -e "A\tB\tC\tD\n" | /usr/local/icinga/bin/send_nsca -H <NAME-ICINGA server> -c /usr/local/icinga/etc/send_nsca.cfg

Dies sollte ebenfalls die Meldung "1 data packet(s) sent to host
successfully." liefern und es sollte Warnungen im icinga.log auf dem
NAME-ICINGA-Server geben, die ähnlich zu den o.g. sind. Wenn es keine
Meldungen gibt, dann prüfen Sie die Einstellung von
[log\_passive\_checks](#configmain-log_passive_checks) in `icinga.cfg`.

Fehlersuche
-----------

Wenn der Daemon nicht berechtigt ist, in die Command-Pipe zu schreiben,
dann sind die Daten verloren! Der Daemon sollte mit dem gleichen
Benutzer laufen wie NAME-ICINGA.

Wenn das Objekt (Host und/oder Service) nicht in der laufenden
Konfiguration enthalten ist, werden die Daten verworfen.

Host-Name (und Service-Beschreibung, falls zutreffend) sind
Case-sensitiv und müssen exakt mit den Definitionen in NAME-ICINGA
übereinstimmen.

Prüfen Sie, ob Sie in `nsca.cfg` und `send_nsca.cfg` das gleiche
Passwort angegeben haben. Anderenfalls wird die Übertragung
fehlschlagen.

Prüfen Sie, ob Sie gleiche Verschlüsselungs-/Entschlüsselungsmethode
verwenden. Anderenfalls wird die Übertragung fehlschlagen.

Prüfen Sie, ob Ihre Firewall-Einstellungen die Kommunikation über den
angegebenen Port zulassen (Default ist 5667)

Wenn Sie xinetd verwenden, dann prüfen Sie, ob die hinter "only\_from="
angegebenen IP-Adressen zu den entfernten Systemen passen oder entfernen
Sie diese Zeile (und starten Sie xinetd neu).

Aktivieren Sie "debug=1" in `nsca.cfg`, starten Sie den Daemon (neu) und
schauen Sie nach Meldungen im Syslog / in `nsca.log`.

Sicherheit
----------

Es gibt einige Sicherheitsimplikationen, wenn Sie entfernten Clients
erlauben, Prüfergebnisse an NAME-ICINGA zu senden. Daher gibt es die
Möglichkeit, die Pakete zu verschlüsseln, die der NAME-NSCA-Client an
den NAME-NSCA-Daemon sendet. Lesen Sie die SECURITY-Datei, um weitere
Informationen über die Sicherheitsrisiken zu erhalten, die durch den
Betrieb von NAME-NSCA auftreten können, zusammen mit einer Erklärung,
welche Art von Schutz die Verschlüsselung Ihnen bietet.

Betrieb
-------

send\_nsca wird benutzt, um die Prüfergebnisse vom entfernten Rechner
zum NAME-ICINGA-Server zu senden. Die Syntax hängt vom Objekttyp ab. Um
Service-Prüfergebnisse zu versenden, benutzen Sie

\<host\_name\>[tab]\<svc\_description\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

wobei:

\<host\_name\>=der Kurzname des Hosts, mit dem der Service verbunden ist
(wie in der host\_name-Direktive der Service-Definition angegeben)

\<svc\_description\>=Beschreibung des Service (wie in der
service\_description-Direktive der Service-Definition angegeben)

\<return\_code\>=numerischer Return-Code (0,1,2,3 wie [hier](#pluginapi)
beschrieben)

\<plugin\_output\>=Ausgabe des Service-Check

Host-Prüfergebnisse werden in einer ähnlichen Form versandt - lassen Sie
einfach die Service-Beschreibung weg:

\<host\_name\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

Integration in Icinga
---------------------

Bisher haben Sie lediglich einige Voraussetzungen geschaffen, um passive
Prüfergebnisse zu übermitteln, aber Sie haben noch keinen Host oder
Service definiert, der diese Funktionalität nutzt.

Obwohl Sie nur Prüfergebnisse empfangen müssen Sie doch die
"check\_command"-Direktive in Ihren Definitionen angeben. Es gibt ein
Plugin namens "check\_dummy", das für diesen Zweck benutzt werden kann.
Es kann sein, dass Sie die folgende command-Definition einfügen müssen,
falls sie noch nicht vorhanden ist. Das zweite Argument ist optional und
kann z.B. einen erklärenden Text enthalten.

     define command{
        command_name check_dummy
        command_line $USER1$/check_dummy $ARG1$ $ARG2$
        }

Vielleicht möchten Sie ein Service-Template anlegen. Das Host-Template
könnte ähnlich aussehen (ersetzen Sie einfach "service" durch "host")

     define service{
        use                     generic-service   ; template to inherit from
        name                    passive-service   ; name of this template
        active_checks_enabled   0                 ; no active checks
        passive_checks_enabled  1                 ; allow passive checks
        check_command           check_dummy!0     ; use "check_dummy", RC=0 (OK)
        check_period            24x7              ; check active all the time
        check_freshness         0                 ; don't check if check result is "stale"
        register                0                 ; this is a template, not a real service
        }

Zusammen mit dem obigen Template könnte die Service-Definition wie folgt
aussehen:

     define service{
        use                     passive-service   ; template to inherit from
        host_name               remotehost        ; host where send_nsca is located
        service_description     Diskspace         ; service to be checked
        }

Starten Sie NAME-ICINGA erneut, damit die Änderungen in der laufenden
Konfiguration enthalten sind

     #> /etc/init.d/icinga restart

Wechseln Sie auf Ihrem entfernten Host zum NAME-ICINGA-Benutzer und
führen Sie send\_nsca aus. Ersetzen Sie dabei \<Icinga server\> durch
die IP-Adresse des NAME-ICINGA-Servers

     #> su - icinga
     $> echo -e "remotehost\tDiskspace\t0\t/var=78%\n" | /usr/local/icinga/bin/send_nsca -H <Icinga server> -c /usr/local/icinga/etc/send_nsca.cfg

Bitte denken Sie daran, dass Host-Name und Service-Beschreibung exakt
den Angaben in Ihrer Icinga-Definition entsprechen müssen (die Angaben
sind Case-sensitiv). Andernfalls bekommen Sie Meldungen in icinga.log,
dass das Objekt nicht gefunden werden kann. Falls es keine Meldungen
gibt, kontrollieren Sie die Einstellung von
[log\_passive\_checks](#configmain-log_passive_checks) in `icinga.cfg`.

Nach einem kurzen Moment sollten Sie Meldungen in icinga.log sehen, dass
die gesendeten Informationen verarbeitet wurden. Sie sollten die Daten
dann auch im klassischen Web-Interface sehen sowie feststellen, dass der
Service-Status von "Pending" auf "OK" gewechselt ist und die Ausgabe die
Daten enthält, die Sie versandt haben.

NSCA
nsca
NSCA
send\_nsca
