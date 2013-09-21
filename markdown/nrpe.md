NAME-NRPE
=========

Einführung
----------

Nagios Remote Plugin Executor (oder kurz NAME-NRPE) ist ein Addon, das
benutzt wird, um Plugins auszuführen, die "lokale" Ressourcen auf
entfernten (Linux/Unix) Systemen überwachen. Einige Ressourcen können
(oder sollen) nicht per SNMP oder andere Agenten über das Netzwerk
überwacht werden, so dass Sie diese Prüfungen mit Programmen durchführen
müssen, die lokal auf den zu überwachenden Maschinen installiert sind
und die Ergebnisse an den NAME-ICINGA-Server zurückliefern. Im Gegensatz
zu NSCA geschieht dies aktiv, d.h. durch den NAME-ICINGA-Server
initiiert.

> **Note**
>
> Mit Hilfe von [NAME-NSCLIENT](http://www.nsclient.org) anstatt
> NAME-NRPE auf dem entfernten Host können Sie auch Prüfungen auf
> Windows-Maschinen ausführen.

Sie können *check\_by\_ssh* benutzen, um Plugins auf entfernten
Maschinen auszuführen, aber es gibt einen Nachteil bei diesen Ansatz.
Der Aufbau einer SSH-Session erfordert CPU-Ressourcen sowohl auf dem
Überwachungsrechner als auch auf dem entfernten Host, was zu einer
Performance-Beeinträchtigung führen kann, wenn Sie auf diese Weise eine
Vielzahl von Hosts und/oder Services überwachen. Die Benutzung von
NAME-NRPE ist ein wenig unsicherer als SSH, aber in vielen Fällen mag
der Performance-Gewinn die Abstriche bei der Sicherheit überwiegen. SSL
kann übrigens aktiviert werden, wenn Sie eine sicherere Verbindung
benötigen.

![](../images/nrpe.png)

*check\_nrpe* ist ein Plugin, das auf dem lokalen NAME-ICINGA-Server
genau wie jedes andere Plugin ausgeführt wird. Es verbindet sich mit dem
NAME-NRPE-Prozess, der als Daemon auf der entfernten Maschine läuft. Der
Daemon selbst führt das Plugin auf der gleichen Maschine aus und
überträgt die gesammelten Informationen an das check\_nrpe-Plugin, das
sie wiederum an NAME-ICINGA weitergibt.

> **Note**
>
> Abhängig von der CPU / dem OS auf der entfernten Maschine müssen Sie
> ggf. NAME-NRPE und die Plugins auf verschiedenen Plattformen
> kompilieren.

Mit Hilfe von NAME-NRPE werden Sie vorwiegend Ressourcen überwachen, die
lokal auf der gleichen Maschine sind, wie z.B. die CPU-Auslastung,
Speicherverbrauch, Plattenplatz, Prozesse, etc., aber es kann auch
genutzt werden, um Ressourcen zu kontrollieren, die nicht direkt vom
Überwachungsrechner erreichbar sind. Die Maschine mit dem
NAME-NRPE-Daemon dient in diesem Fall als eine Art Relais.

![](../images/nrpe_remote.png)

Die folgenden Anweisungen basieren teilweise auf der Dokumentation, die
im ursprünglichen NAME-NRPE-Paket von Ethan Galstad zu finden ist.

Voraussetzungen
---------------

-   NAME-ICINGA sollte auf dem Überwachungsserver installiert und
    lauffähig sein

-   ein C-Compiler (wie z.B. gcc) ist auf dem lokalen Host installiert.
    Wenn nicht:

         #> yum install gcc       # NAME-RHEL / NAME-FEDORA / NAME-CENTOS
         #> apt-get install gcc   # NAME-DEBIAN / NAME-UBUNTU
         #> zypper install gcc    # NAME-SLES / NAME-OPENSUSE (oder benutzen Sie YaST)

-   openssl ist (optional) auf dem lokalen Host installiert. Wenn nicht:

         #> yum install openssl openssl-devel       # NAME-RHEL / NAME-FEDORA / NAME-CENTOS
         #> apt-get install openssl openssl-devel   # NAME-DEBIAN / NAME-UBUNTU
         #> zypper install openssl openssl-devel    # NAME-SLES / NAME-OPENSUSE (oder benutzen Sie YaST)

Download
--------

> **Note**
>
> Anstatt NAME-NRPE von Grund auf zu installieren möchten Sie vielleicht
> ein Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt.
>
> Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie
> bitte die offiziellen Release-Tarballs, z.B. durch
>
>      #> wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-VER-NRPE/nrpe-VER-NRPE.tar.gz -O nrpe.tgz
>      #> tar xzf nrpe.tgz

> **Important**
>
> Bitte benutzen Sie keine Snapshots, solange Sie kein Problem haben,
> das in der aktuellen Entwicklerversion ggf. gelöst ist.

Optionale Anpassungen
---------------------

Die maximale Länge von Daten, die übertragen werden können, ist auf
2.048 Bytes begrenzt, die maximale Länge von Plugin-Ausgaben auf 512
Bytes. Wenn das für Ihre Zwecke nicht ausreicht, dann müssen Sie die
entsprechenden Werte in der Datei `nrpe-VER-NRPE/include/common.h`
anpassen (und NAME-NRPE neu kompilieren!).

     #define MAX_INPUT_BUFFER        2048    /* max size of most buffers we use */
     #define MAX_PLUGINOUTPUT_LENGTH 512 

Bitte denken Sie daran, dass Sie die Programme erneut kompilieren
müssen, wenn Sie diese Werte zu einem späteren Zeitpunkt ändern.

Bedingt durch die Einstellung des folgenden define in `include/common.h`
(im Icinga-Core) kann der maximale Wert 8.192 Bytes nicht überschreiten.

     #define MAX_EXTERNAL_COMMAND_LENGTH     8192   /* max length of an external command */

Kompilieren auf dem NAME-ICINGA-Server
--------------------------------------

Wechseln Sie in das neu angelegte Verzeichnis und führen Sie "configure"
und "make " aus

     #> cd nrpe-VER-NRPE
     #> ./configure 
     #> make all
     #> make install-plugin

> **Note**
>
> Wenn Sie später SSL benutzen wollen, dann müssen Sie stattdessen
> "`./configure --enable-ssl`" angeben. Außerdem gibt es weitere
> Optionen, um den Standort von SSL-Dateien anzugeben, falls sie nicht
> automatisch gefunden werden.

Wenn Benutzer oder Gruppe für den Daemon-Prozess von "icinga" abweichen
oder der zu benutzende Port nicht der Default 5666 ist, dann können Sie
verschiedene Optionen benutzen, um abweichende Werte anzugeben
(`--with-nrpe-user=`\<user\>, `--with-nrpe-group=`\<group\>,
`--with-nrpe-port=`\<port\>). Benutzen Sie "`./configure -h`", um eine
vollständige Liste der Optionen zu erhalten. "`make install-plugin`"
kopiert `check_nrpe` in das Plugin-Verzeichnis.

> **Note**
>
> Mit Hilfe von "`ldd src/check_nrpe`" und "`ldd src/nrpe`" sollten Sie
> feststellen können, ob SSL-Bibliotheken in den erzeugten Programmen
> enthalten sind.

Erster Test
-----------

Starten Sie den Daemon-Prozess und rufen Sie das Plugin auf

     #> /usr/src/nrpe-VER-NRPE/src/nrpe -n \
        -c /usr/src/nrpe-VER-NRPE/sample-config/nrpe.cfg -d
     #> /usr/local/icinga/libexec/check_nrpe -H 127.0.0.1 -n

Dies sollte die Versionsnummer von NAME-NRPE zurückliefern. Wenn Sie die
Meldung "CHECK\_NRPE: Error receiving data from daemon" erhalten, wurde
der angegebene Host nicht in der Datei `nrpe.cfg` gefunden (Direktive
allowed\_hosts). Mehrere IP-Adressen werden durch Komma getrennt.

Stoppen Sie den Daemon-Prozess

     #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`

Entfernte/s System/e
--------------------

Die Konfiguration und Installation auf dem NAME-ICINGA-Server ist
vorerst abgeschlossen. Der zweite Teil erfolgt auf dem entfernten
System, auf dem der NAME-NRPE-Daemon auf ankommende Anfragen lauscht,
sie ausführt und die Ergebnisse an den NAME-ICINGA-Server zurückliefert.

Voraussetzungen auf dem entfernten System
-----------------------------------------

-   Stellen Sie sicher, dass die benötigten Plugins auf dem entfernten
    System verfügbar sind. Lesen Sie ggf. in der
    [Schnellstartanleitung](#quickstart), wie die Plugins zu
    installieren sind.

-   Sie können das Verzeichnis `nrpe-VER-NRPE` samt Unterverzeichnisses
    vom NAME-ICINGA-Server kopieren. Eine Möglichkeit ist

         #> cd /usr/src/
         #> scp -pr <NAME-ICINGA-server>:/$PWD/nrpe-VER-NRPE .

    > **Note**
    >
    > Wenn die Architektur auf Ihrem entfernten System von Ihrem
    > NAME-ICINGA-Server abweicht, dann müssen Sie die Sourcen erneut
    > kompilieren. Dies trifft zu, wenn Sie verschiedene CPUs
    > (i386/Itanium/PA-RISC/...) und/oder unterschiedliche OS-Versionen
    > (32-Bit/64-Bit) einsetzen. Wenn dies der Fall ist, dann müssen Sie
    > (wie oben beschrieben) einen C-Compiler und OpenSSL (wenn Sie SSL
    > benutzen wollen) installieren, bevor Sie fortfahren können.
    >
    >      #> cd nrpe-VER-NRPE
    >      #> make distclean
    >      #> ./configure     # bitte benutzen Sie die gleichen Optionen wie auf dem NAME-ICINGA-Server 
    >      #> make all

    Editieren Sie die Konfigurationsdatei `sample-config/nrpe.cfg` und
    ändern Sie die Einstellung von "allowed\_hosts=\<IP address\>" auf
    die IP-Adresse Ihres NAME-ICINGA-Servers. Mehrere IP-Adressen werden
    durch Komma getrennt.

Zweiter Test
------------

Starten Sie den Daemon-Prozess auf dem entfernten Host

     #> /usr/src/nrpe-VER-NRPE/src/nrpe -n \
        -c /usr/src/nrpe-VER-NRPE/sample-config/nrpe.cfg -d

und führen Sie das Plugin auf dem NAME-ICINGA-Server erneut aus, dieses
Mal mit der IP-Adresse des entfernten Hosts

     #> /usr/local/icinga/libexec/check_nrpe -H <IP remote host> -n

Dies sollte die Versionsnummer von NAME-NRPE zurückliefern. Wenn Sie die
Meldung "CHECK\_NRPE: Error receiving data from daemon" erhalten, wurde
der NAME-ICINGA-Server nicht in der Datei `nrpe.cfg` (Direktive
allowed\_hosts) auf dem entfernten Host gefunden.

Stoppen Sie den Daemon-Prozess auf dem entfernten Host

     #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`

Installation auf dem entfernten Host
------------------------------------

Unabhängig vom verwendeten Modus, in dem der NAME-NRPE-Prozess auf dem
entfernten Host läuft, benötigen Sie eine Konfigurationsdatei, die die
auszuführenden Befehle enthält. Mit dem folgenden Befehl wird sie
installiert

     #> make install-daemon-config

Es gibt zwei Arten, den NAME-NRPE-Prozess zu starten, entweder als
eigenständigen Daemon-Prozess oder per xinetd (was empfohlen wird).

-   **nrpe-Daemon**

    Installieren Sie zuerst den Daemon

         #> make install-daemon

    Wenn Sie xinetd benutzen, wird der Daemon automatisch gestartet. Den
    eigenständigen Prozess müssen Sie manuell starten

         #> /usr/local/icinga/bin/nrpe -c /usr/local/icinga/etc/nrpe.cfg

-   **inetd/xinetd**

    Wenn der Daemon durch (x)inetd gestartet werden soll, dann müssen
    Sie /etc/services erweitern, eine weitere Datei ändern/kopieren und
    (x)inetd erneut starten. Wenn das Paket nicht installiert ist, dann
    tun Sie bitte folgendes

         #> yum install xinetd       # NAME-RHEL / NAME-FEDORA / NAME-CENTOS
         #> apt-get install xinetd   # NAME-DEBIAN / NAME-UBUNTU
         #> zypper install xinetd    # NAME-SLES / NAME-OPENSUSE (oder benutzen Sie YaST)

    > **Note**
    >
    > Die Einstellung von "server\_port" in der Datei `nrpe.cfg` wird
    > ignoriert, wenn Sie inetd/xinetd benutzen.

         #> echo "nrpe 5666/tcp # nrpe" >> /etc/services

    Abhängig vom installierten Superserver auf dem entfernten System
    gibt es drei Alternativen

    -   inetd MIT tcpwrappers

        Fügen Sie Einträge in `/etc/hosts.allow` und `/etc/hosts.deny`
        ein, um TCP-wrapper-protection für den nrpe-Service zu
        aktivieren. Dies ist optional, wird aber wärmstens empfohlen.
        Fügen Sie "`nrpe stream tcp nowait `\<user\>
        `/usr/sbin/tcpd `\<nrpe-binary\>` -c
                    `\<nrpe-cfg\>` --inetd`" zur Datei `/etc/inetd.conf`
        hinzu, z.B.

             #> echo "nrpe stream tcp nowait icinga /usr/sbin/tcpd /usr/local/icinga/bin/nrpe \
                -c /usr/local/icinga/etc/nrpe.cfg --inetd" >> /etc/inetd.conf
             #> /etc/init.d/inetd restart

    -   inetd OHNE tcpwrappers

        Fügen Sie "`nrpe stream tcp nowait `\<user\> \<nrpe-binary\>` -c
                    `\<nrpe-cfg\>` --inetd`" zur Datei `/etc/inetd.conf`
        hinzu, z.B.

             #> echo "nrpe stream tcp nowait icinga /usr/local/icinga/bin/nrpe \
                -c /usr/local/icinga/etc/nrpe.cfg --inetd" >> /etc/inetd.conf
             #> /etc/init.d/inetd restart

    -   xinetd (empfohlen)

        Editieren Sie die Konfigurationsdatei `nrpe.xinetd` im
        Verzeichnis `sample-config` und ersetzen Sie die Adresse hinter
        \<only\_from\> durch die IP-Adresse des NAME-ICINGA-Servers (wo
        check\_nrpe laufen wird). Mehrere IP-Adressen werden durch
        Leerzeichen voneinander getrennt.

        Fügen Sie Einträge in `/etc/hosts.allow` und `/etc/hosts.deny`
        ein, um TCP-wrapper-protection für den nrpe-Service zu
        aktivieren. Dies ist optional, wird aber wärmstens empfohlen.
        Kopieren Sie die Datei in das xinetd-Verzeichnis und starten Sie
        den xinetd-Prozess neu

             #> make install-xinetd
             #> /etc/init.d/xinetd restart

Dritter Test
------------

Wechseln Sie auf dem NAME-ICINGA-Server zum NAME-ICINGA-Benutzer und
führen Sie einen weiteren Test aus

     #> su - icinga
     $> /usr/local/icinga/libexec/check_nrpe -H <IP remote server>

Dies sollte ein weiteres Mal die NAME-NRPE-Versionsnummer ausgeben. Wenn
dieser Test fehlschlägt, dann ist es nicht sinnvoll fortzufahren. Prüfen
Sie stattdessen die Einstellungen in `nrpe.cfg/nrpe.xinet` auf dem
entfernten Server. Prüfen Sie außerdem, ob es Meldungen im Syslog (z.B.
`/var/log/messages`) auf dem entfernten Host gibt.

Fehlersuche
-----------

Prüfen Sie auf dem entfernten Host, ob der nrpe-Prozess läuft

-   wenn als eigenständiger Prozess installiert

         #> ps -ef | grep -v grep | grep nrpe

    Falls der Prozess nicht läuft, dann

    -   starten Sie ihn wie oben angegeben

    -   prüfen Sie, ob die Konfigurationsdatei
        `/usr/local/icinga/etc/nrpe.cfg` vorhanden ist

    -   prüfen Sie, ob die Direktive *allowed\_hosts* in der Datei
        `/usr/local/icinga/etc/nrpe.cfg` einen Eintrag für die
        IP-Adresse des NAME-ICINGA-Servers enthält. Mehrere IP-Adressen
        werden durch Komma getrennt

-   wenn per xinetd gestartet

         #> netstat -at | grep -v grep | grep nrpe

    Die Ausgabe sollte etwa dem Folgenden entsprechen

         tcp 0 0 *:nrpe *:* LISTEN

    Wenn das nicht der Fall ist, dann prüfen Sie, ob

    -   die Datei `/etc/services` einen Eintrag für nrpe enthält

    -   die Datei `/etc/xinetd.d/nrpe` vorhanden ist

    -   die Direktive *only\_from* directive in der Datei
        `/etc/xinetd.d/nrpe` einen Eintrag für die IP-Adresse des
        NAME-ICINGA-Servers enthält. Mehrere IP-Adressen werden durch
        Leerzeichen voneinander getrennt

    -   xinetd installiert und gestartet ist

    -   die System-Logs Fehler von xinetd und/oder nrpe enthalten.
        Beheben Sie die gemeldeten Probleme

Aktivieren Sie "debug=1" in `nrpe.cfg`, starten Sie den Daemon (falls
zutreffend) und schauen Sie nach Meldungen in Syslog / `nrpe.log`.

Sicherheit
----------

Konsultieren Sie die Datei `SECURITY`, um mehr Informationen zu den
Sicherheitsrisiken zu kommen, die beim Betrieb von NAME-NRPE auftreten
können, zusammen mit einer Erklärung, welche Art von Schutz die
Verschlüsselung bietet.

Definition von lokalen Prüfungen
--------------------------------

Einige Dinge wurden bereits in `etc/nrpe.cfg` auf dem entfernten Host
vorkonfiguriert

     # command[<command_name>]=<command_line>
     command[check_users]=/usr/local/icinga/libexec/check_users -w 5 -c 10
     command[check_load]=/usr/local/icinga/libexec/check_load -w 1.5,1.1,0.9 -c 3.0,2.2,1.9
     command[check_hda1]=/usr/local/icinga/libexec/check_disk -w 20% -c 10% -p /dev/hda1
     command[check_zombie_procs]=/usr/local/icinga/libexec/check_procs -w 5 -c 10 -s Z
     command[check_total_procs]=/usr/local/icinga/libexec/check_procs -w 150 -c 200 

Die erste Zeile zeigt das generelle Format

  Zeichenkette        Beschreibung
  ------------------- --------------------------------------------------------------------------------------------------------------
  command             Kennzeichnung, dass das Folgende eine command-Definition ist
  \<command\_name\>   Verbindung zwischen der command-Definition auf dem NAME-ICINGA-Server und dem Befehl auf dem entfernten Host
  \<command\_line\>   Aufruf des Plugins inklusive aller notwendigen Argumente

Definitionen auf dem NAME-ICINGA-Server
---------------------------------------

Nun wechseln wir auf den NAME-ICINGA-Server, um einige
Objekt-Definitionen anzulegen. Zuerst fügen Sie eine command-Definition
zu Ihrer Konfiguration hinzu (falls Sie noch keine passende haben). Wie
immer ist der Name der Konfigurationsdatei Ihnen überlassen, aber bei
den meisten Leuten heißt sie `commands.cfg`.

     define command{
        command_name        check_nrpe
        command_line        $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
       }

Wir nehmen an, dass Sie bereits eine Host-Definition haben, die der
folgenden ähnlich ist

     define host{
        use                 generic-host     ; Default-Werte von einer Vorlage erben
        host_name           remotehost       ; Der Name, den wir diesem Host geben
        alias               Linux Host       ; Ein laengerer Name fuer diesen Host
        address             192.168.0.1      ; IP-Adresse des Servers
        }

Diese Beispieldefinitionen benutzen die oben gezeigten Befehle.

Der folgende Service wird die Anzahl der momentan angemeldeten Benutzer
auf dem entfernten Host überwachen

     define service{
        use                 generic-service
        host_name           remotehost
        service_description Current Users
        check_command       check_nrpe!check_users
        }

"`check_nrpe`" ist die Verbindung zwischen der Service-Direktive
"`check_command`" und der "`command_name`"-Direktive in der
command-Definition auf dem NAME-ICINGA-Server. Die "`command_line`" in
der command-Definition zeigt, dass "`check_nrpe`" aufgerufen wird.
"`check_users`" wird als erstes Argument übergeben. Der nrpe-Prozess auf
dem entfernten Host nimmt dieses Argument und sucht nach einer passenden
Definition in `nrpe.cfg`. Der Befehl wird ausgeführt und das Ergebnis an
das check\_nrpe-Plugin auf dem NAME-ICINGA-Server zurückgeliefert.

Der folgende Service wird die CPU-Auslastung auf dem entfernten Host
überwachen

     define service{
        use                 generic-service
        host_name           remotehost
        service_description CPU Load
        check_command       check_nrpe!check_load
        }

Der folgende Service wird den Plattenplatz auf /dev/hda1 auf dem
entfernten Host überwachen

     define service{
        use                 generic-service
        host_name           remotehost
        service_description /dev/hda1 Free Space
        check_command       check_nrpe!check_hda1
        }

Der folgende Service wird die Anzahl der Prozesse auf dem entfernten
Host überwachen

     define service{
        use                 generic-service
        host_name           remotehost
        service_description Total Processes
        check_command       check_nrpe!check_total_procs
        }

Der folgende Service wird die Anzahl der Zombie-Prozesse auf dem
entfernten Host überwachen

     define service{
        use                 generic-service
        host_name           remotehost
        service_description Zombie Processes
        check_command       check_nrpe!check_zombie_procs
        }

Starten Sie Icinga neu, damit die Änderungen in Ihre laufende
Konfiguration übernommen werden

     #> /etc/init.d/icinga restart

Nach einer Weile sollten Ihre Plugins ausgeführt worden sein.

Weitere Fehlersuche
-------------------

Einige Fehler während der Installation wurden bereits angesprochen.
Unglücklicherweise gibt es weitere Fehlermöglichkeiten. Nachfolgend
finden Sie Hinweise für einige der häufigsten Fehler mit dem
NAME-NRPE-Addon.

-   "NRPE: Command timed out after x seconds"

    Der Befehl, der vom NAME-NRPE-Daemon ausgeführt wurde, endete nicht
    innerhalb der angegebenen Zeit. Sie können den Timeout-Wert für
    Befehle durch Editieren der NAME-NRPE-Konfigurationsdatei erhöhen
    und die Wert der command\_timeout-Variable anpassen. Verwenden Sie
    die -t -Kommandozeilenoption, um einen höheren Timeout-Wert für das
    check\_nrpe-Plugin anzugeben. Das folgende Beispiel erhöht den
    Timeout auf 30 Sekunden:

         /usr/local/icinga/libexec/check_nrpe -H localhost -c somecommand -t 30

    Wenn Sie den NAME-NRPE-Daemon im Standalone-Modus ausführen (und
    nicht unter inetd oder xinetd), dann müssen Sie ihn neustarten,
    damit der neue Timeout-Wert erkannt wird.

-   "Connection refused or timed out"

    Dieser Fehler kann mehrere Ursachen haben:

    -   Es gibt eine Firewall, die die Kommmunikation zwischen dem
        Überwachungs-Server (auf dem das check\_nrpe-Plugin läuft) und
        dem entfernten Host (auf dem der NAME-NRPE-Daemon läuft)
        blockiert. Stellen Sie sicher, dass die Firewall-Regeln (z.B.
        iptables) auf dem entfernten Host die Kommunikation erlauben und
        prüfen Sie, dass sich keine physikalische Firewall zwischen den
        Überwachungs-Server und dem entfernten Host befindet.

    -   Wenn Sie den Daemon-Modus benutzen: Die IP-Adresse in `nrpe.cfg`
        (allowed\_hosts=...) stimmt nicht nicht der IP-Adresse des
        Überwachungs-Servers überein. Falls die Adressen übereinstimmen,
        dann haben Sie ggf. vergessen, den Daemon nach der letzten
        Änderung neu zu starten.

    -   Wenn Sie die (x)inetd-Version benutzen: Die IP-Adresse in
        /etc/xinetd/nrpe (only\_from=...) stimmt nicht nicht der
        IP-Adresse des Überwachungs-Servers überein. Falls die Adressen
        übereinstimmen, dann haben Sie ggf. vergessen, den
        xindetd-Prozess nach der letzten Änderung neu zu starten.

    -   Der NAME-NRPE-Daemon ist nicht installiert oder läuft nicht auf
        dem entfernten Host. Prüfen Sie mit einem der folgenden Befehle,
        dass der NAME-NRPE-Daemon als eigenständiger Prozess läuft bzw.
        unter inetd/xinetd:

             ps axuw | grep nrpe       # falls standalone-Daemon
             netstat -at | grep nrpe   # falls via xinetd

-   "CHECK\_NRPE: Received 0 bytes from daemon. Check the remote server
    logs for an error message."

    Als erstes sollten Sie die Protokolle des entfernten Hosts auf
    Fehlermeldungen prüfen. Ehrlich :-). Dieser Fehler kann u.a.
    folgende Ursachen haben:

    -   Das check\_nrpe-Plugin konnte keinen SSL-Handshake mit dem
        NAME-NRPE-Daemon durchführen. Eine Fehlermeldung in den
        Log-Dateien sollte zeigen, ob dies der Fall war oder nicht.
        Prüfen Sie die Versionsstände von OpenSSL auf dem
        Überwachungs-Server und dem entfernten Host. Wenn Sie eine
        kommerzielle SSL-Version auf dem entfernten Host betreiben, dann
        kann es ggf. zu Kompatibilitätsproblemen kommen.

-   "NRPE: Unable to read output"

    Dieser Fehler zeigt an, dass der vom NAME-NRPE-Daemon ausgeführte
    Befehl keinerlei Zeichenausgaben zurückliefert. Dies kann auf
    folgende Probleme hinweisen:

    -   Der Pfad des auszuführenden Plugins auf dem entfernten Host ist
        inkorrekt. Falls Sie die Definition in nrpe.cfg ändern, dann
        denke Sie daran, den Daemon neu zu starten.

    -   Das hinter command\_line angegebene Plugin arbeitet fehlerhaft.
        Führen Sie den Befehl manuell auf der Kommandozeile aus, um
        sicherzustellen, dass das Plugin Textausgaben liefert. Starten
        Sie den Befehl NICHT als root!

-   "NRPE: Command 'x' not defined"

    Der Befehl 'x' ist nicht in der NAME-NRPE-Konfigurationsdatei auf
    dem entfernten Host definiert. Bitte fügen Sie die Befehlsdefinition
    für 'x' hinzu. Sehen Sie sich die vorhandenen Befehlsdefinitionen in
    der NAME-NRPE-Konfigurationsdatei an, um einen Eindruck davon zu
    bekommen, wie es aussehen sollte. Wenn Sie den NAME-NRPE-Daemon im
    Standalone-Modus ausführen (und nicht unter inetd oder xinetd), dann
    müssen Sie ihn neustarten, damit der neue Timeout-Wert erkannt wird.

Falls Sie immer noch Probleme haben, dann setzen Sie "debug=1" in
`nrpe.cfg` auf dem entfernen Host. Denken Sie daran, den
NAME-NRPE-Prozess neu zu starten, wenn dieser im Standalone-Modus läuft.
Führen Sie die Prüfung auf dem Überwachungs-Server aus. Anschließend
sollten Sie Debugging-Informationen im Syslog (z.B. `/var/log/messages`)
finden, die bei der Fehlerbehebung weiterhelfen sollten.

Sie können such auch an eine der Mailing-Listen bzw. Foren wenden
([URL-ICINGAsupport/](http://www.icinga.org/support/)).

Aktualisierung
--------------

-   Aktualisierung des NAME-ICINGA-Servers

    Laden Sie die Software herunter

         #> cd /usr/src
         #> wget "http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-VER-NRPE/nrpe-VER-NRPE.tar.gz" -O nrpe.tgz
         #> tar xzf nrpe.tgz

    Dann kompilieren Sie die Software und installieren das Plugin

         #> cd nrpe-VER-NRPE
         #> make distclean
         #> ./configure     # benutzen Sie die gleichen Optionen wie beim ersten Mal
         #> make all
         #> make install-plugin

-   Aktualisierung des entfernten Hosts

    Laden Sie die Software herunter

         #> cd /usr/src
         #> wget "http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-VER-NRPE/nrpe-VER-NRPE.tar.gz" -O nrpe.tgz
         #> tar xzf nrpe.tgz

    Dann kompilieren Sie die Software und installieren den
    Daemon-Prozess

         #> cd nrpe-VER-NRPE
         #> make distclean
         #> ./configure     # benutzen Sie fie gleichen Optionen wie beim ersten Mal
         #> make all
         ### beenden Sie den Standalone-Daemon (falls zutreffend)
         #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
         #> make install-daemon
         ### starten Sie den Standaline-Daemon (falls zutreffend)
         #> /usr/src/nrpe/src/nrpe -n \
            -c /usr/src/nrpe/sample-config/nrpe.cfg -d

nrpe
nrpe
nrpe
send\_nrpe
