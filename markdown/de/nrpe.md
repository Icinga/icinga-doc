 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

10.2. NRPE
----------

10.2.1. [Einführung](nrpe.md#introduction)

10.2.2. [Voraussetzungen](nrpe.md#prerequisites)

10.2.3. [Download](nrpe.md#download)

10.2.4. [Optionale Anpassungen](nrpe.md#optionalchanges)

10.2.5. [Kompilieren auf dem Icinga-Server](nrpe.md#compile)

10.2.6. [Erster Test](nrpe.md#firsttest)

10.2.7. [Entfernte/s System/e](nrpe.md#remotesystem)

10.2.8. [Voraussetzungen auf dem entfernten
System](nrpe.md#prerequisitesremotehost)

10.2.9. [Zweiter Test](nrpe.md#secondtest)

10.2.10. [Installation auf dem entfernten
Host](nrpe.md#remotehostinstall)

10.2.11. [Dritter Test](nrpe.md#thirdtest)

10.2.12. [Fehlersuche](nrpe.md#troubleshooting)

10.2.13. [Sicherheit](nrpe.md#security)

10.2.14. [Definition von lokalen
Prüfungen](nrpe.md#localcheckdefinition)

10.2.15. [Definitionen auf dem
Icinga-Server](nrpe.md#icingaserverdefinitions)

10.2.16. [Weitere Fehlersuche](nrpe.md#moretroubleshooting)

10.2.17. [Aktualisierung](nrpe.md#upgrading)

### 10.2.1. Einführung

Nagios Remote Plugin Executor (oder kurz NRPE) ist ein Addon, das
benutzt wird, um Plugins auszuführen, die "lokale" Ressourcen auf
entfernten (Linux/Unix) Systemen überwachen. Einige Ressourcen können
(oder sollen) nicht per SNMP oder andere Agenten über das Netzwerk
überwacht werden, so dass Sie diese Prüfungen mit Programmen durchführen
müssen, die lokal auf den zu überwachenden Maschinen installiert sind
und die Ergebnisse an den Icinga-Server zurückliefern. Im Gegensatz zu
NSCA geschieht dies aktiv, d.h. durch den Icinga-Server initiiert.

![[Anmerkung]](../images/note.png)

Anmerkung

Mit Hilfe von [NSClient++](http://www.nsclient.org) anstatt NRPE auf dem
entfernten Host können Sie auch Prüfungen auf Windows-Maschinen
ausführen.

Sie können *check\_by\_ssh* benutzen, um Plugins auf entfernten
Maschinen auszuführen, aber es gibt einen Nachteil bei diesen Ansatz.
Der Aufbau einer SSH-Session erfordert CPU-Ressourcen sowohl auf dem
Überwachungsrechner als auch auf dem entfernten Host, was zu einer
Performance-Beeinträchtigung führen kann, wenn Sie auf diese Weise eine
Vielzahl von Hosts und/oder Services überwachen. Die Benutzung von NRPE
ist ein wenig unsicherer als SSH, aber in vielen Fällen mag der
Performance-Gewinn die Abstriche bei der Sicherheit überwiegen. SSL kann
übrigens aktiviert werden, wenn Sie eine sicherere Verbindung benötigen.

**Abbildung 10.1. NRPE**

![NRPE](../images/nrpe.png)

\

*check\_nrpe* ist ein Plugin, das auf dem lokalen Icinga-Server genau
wie jedes andere Plugin ausgeführt wird. Es verbindet sich mit dem
NRPE-Prozess, der als Daemon auf der entfernten Maschine läuft. Der
Daemon selbst führt das Plugin auf der gleichen Maschine aus und
überträgt die gesammelten Informationen an das check\_nrpe-Plugin, das
sie wiederum an Icinga weitergibt.

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von der CPU / dem OS auf der entfernten Maschine müssen Sie
ggf. NRPE und die Plugins auf verschiedenen Plattformen kompilieren.

Mit Hilfe von NRPE werden Sie vorwiegend Ressourcen überwachen, die
lokal auf der gleichen Maschine sind, wie z.B. die CPU-Auslastung,
Speicherverbrauch, Plattenplatz, Prozesse, etc., aber es kann auch
genutzt werden, um Ressourcen zu kontrollieren, die nicht direkt vom
Überwachungsrechner erreichbar sind. Die Maschine mit dem NRPE-Daemon
dient in diesem Fall als eine Art Relais.

**Abbildung 10.2. NRPE remote**

![NRPE remote](../images/nrpe_remote.png)

\

Die folgenden Anweisungen basieren teilweise auf der Dokumentation, die
im ursprünglichen NRPE-Paket von Ethan Galstad zu finden ist.

### 10.2.2. Voraussetzungen






### 10.2.3. Download

![[Anmerkung]](../images/note.png)

Anmerkung

Anstatt NRPE von Grund auf zu installieren möchten Sie vielleicht ein
Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt.

Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs, z.B. durch

<pre><code>
 #> wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz -O nrpe.tgz
 #> tar xzf nrpe.tgz
</code></pre>

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine Snapshots, solange Sie kein Problem haben, das
in der aktuellen Entwicklerversion ggf. gelöst ist.

### 10.2.4. Optionale Anpassungen

Die maximale Länge von Daten, die übertragen werden können, ist auf
2.048 Bytes begrenzt, die maximale Länge von Plugin-Ausgaben auf 512
Bytes. Wenn das für Ihre Zwecke nicht ausreicht, dann müssen Sie die
entsprechenden Werte in der Datei
`nrpe-2.15/include/common.h` anpassen (und NRPE neu
kompilieren!).

<pre><code>
</code></pre>

Bitte denken Sie daran, dass Sie die Programme erneut kompilieren
müssen, wenn Sie diese Werte zu einem späteren Zeitpunkt ändern.

Bedingt durch die Einstellung des folgenden define in
`include/common.h` (im Icinga-Core) kann der maximale Wert
8.192 Bytes nicht überschreiten.

<pre><code>
</code></pre>

### 10.2.5. Kompilieren auf dem Icinga-Server

Wechseln Sie in das neu angelegte Verzeichnis und führen Sie "configure"
und "make " aus

<pre><code>
 #> cd nrpe-2.15
 #> make all
 #> make install-plugin
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie später SSL benutzen wollen, dann müssen Sie stattdessen
"`./configure --enable-ssl`" angeben. Außerdem gibt es weitere
Optionen, um den Standort von SSL-Dateien anzugeben, falls sie nicht
automatisch gefunden werden.

Wenn Benutzer oder Gruppe für den Daemon-Prozess von "icinga" abweichen
oder der zu benutzende Port nicht der Default 5666 ist, dann können Sie
verschiedene Optionen benutzen, um abweichende Werte anzugeben
(`--with-nrpe-user=`\<user\>,
`--with-nrpe-group=`\<group\>,
`--with-nrpe-port=`\<port\>). Benutzen Sie
"`./configure -h`", um eine vollständige Liste der Optionen zu
erhalten. "`make install-plugin`" kopiert
`check_nrpe` in das Plugin-Verzeichnis.

![[Anmerkung]](../images/note.png)

Anmerkung

Mit Hilfe von "`ldd src/check_nrpe`" und
"`ldd src/nrpe`" sollten Sie feststellen können, ob
SSL-Bibliotheken in den erzeugten Programmen enthalten sind.

### 10.2.6. Erster Test

Starten Sie den Daemon-Prozess und rufen Sie das Plugin auf

<pre><code>
 #> /usr/src/nrpe-2.15/src/nrpe -n \
 #> /usr/local/icinga/libexec/check_nrpe -H 127.0.0.1 -n
</code></pre>

Dies sollte die Versionsnummer von NRPE zurückliefern. Wenn Sie die
Meldung "CHECK\_NRPE: Error receiving data from daemon" erhalten, wurde
der angegebene Host nicht in der Datei `nrpe.cfg` gefunden
(Direktive allowed\_hosts). Mehrere IP-Adressen werden durch Komma
getrennt.

Stoppen Sie den Daemon-Prozess

<pre><code>
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
</code></pre>

### 10.2.7. Entfernte/s System/e

Die Konfiguration und Installation auf dem Icinga-Server ist vorerst
abgeschlossen. Der zweite Teil erfolgt auf dem entfernten System, auf
dem der NRPE-Daemon auf ankommende Anfragen lauscht, sie ausführt und
die Ergebnisse an den Icinga-Server zurückliefert.

### 10.2.8. Voraussetzungen auf dem entfernten System









### 10.2.9. Zweiter Test

Starten Sie den Daemon-Prozess auf dem entfernten Host

<pre><code>
 #> /usr/src/nrpe-2.15/src/nrpe -n \
</code></pre>

und führen Sie das Plugin auf dem Icinga-Server erneut aus, dieses Mal
mit der IP-Adresse des entfernten Hosts

<pre><code>
 #> /usr/local/icinga/libexec/check_nrpe -H <IP remote host> -n
</code></pre>

Dies sollte die Versionsnummer von NRPE zurückliefern. Wenn Sie die
Meldung "CHECK\_NRPE: Error receiving data from daemon" erhalten, wurde
der Icinga-Server nicht in der Datei `nrpe.cfg` (Direktive
allowed\_hosts) auf dem entfernten Host gefunden.

Stoppen Sie den Daemon-Prozess auf dem entfernten Host

<pre><code>
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
</code></pre>

### 10.2.10. Installation auf dem entfernten Host

Unabhängig vom verwendeten Modus, in dem der NRPE-Prozess auf dem
entfernten Host läuft, benötigen Sie eine Konfigurationsdatei, die die
auszuführenden Befehle enthält. Mit dem folgenden Befehl wird sie
installiert

<pre><code>
 #> make install-daemon-config
</code></pre>

Es gibt zwei Arten, den NRPE-Prozess zu starten, entweder als
eigenständigen Daemon-Prozess oder per xinetd (was empfohlen wird).
























### 10.2.11. Dritter Test

Wechseln Sie auf dem Icinga-Server zum Icinga-Benutzer und führen Sie
einen weiteren Test aus

<pre><code>
 $> /usr/local/icinga/libexec/check_nrpe -H <IP remote server>
</code></pre>

Dies sollte ein weiteres Mal die NRPE-Versionsnummer ausgeben. Wenn
dieser Test fehlschlägt, dann ist es nicht sinnvoll fortzufahren. Prüfen
Sie stattdessen die Einstellungen in `nrpe.cfg/nrpe.xinet`
auf dem entfernten Server. Prüfen Sie außerdem, ob es Meldungen im
Syslog (z.B. `/var/log/messages`) auf dem entfernten Host
gibt.

### 10.2.12. Fehlersuche

Prüfen Sie auf dem entfernten Host, ob der nrpe-Prozess läuft

















Aktivieren Sie "debug=1" in `nrpe.cfg`, starten Sie den
Daemon (falls zutreffend) und schauen Sie nach Meldungen in Syslog /
`nrpe.log`.

### 10.2.13. Sicherheit

Konsultieren Sie die Datei `SECURITY`, um mehr Informationen
zu den Sicherheitsrisiken zu kommen, die beim Betrieb von NRPE auftreten
können, zusammen mit einer Erklärung, welche Art von Schutz die
Verschlüsselung bietet.

### 10.2.14. Definition von lokalen Prüfungen

Einige Dinge wurden bereits in `etc/nrpe.cfg` auf dem
entfernten Host vorkonfiguriert

<pre><code>
 # command[<command_name>]=<command_line>
 command[check_users]=/usr/local/icinga/libexec/check_users -w 5 -c 10
 command[check_load]=/usr/local/icinga/libexec/check_load -w 1.5,1.1,0.9 -c 3.0,2.2,1.9
 command[check_hda1]=/usr/local/icinga/libexec/check_disk -w 20% -c 10% -p /dev/hda1
 command[check_zombie_procs]=/usr/local/icinga/libexec/check_procs -w 5 -c 10 -s Z
</code></pre>

Die erste Zeile zeigt das generelle Format

Zeichenkette

Beschreibung

command

Kennzeichnung, dass das Folgende eine command-Definition ist

\<command\_name\>

Verbindung zwischen der command-Definition auf dem Icinga-Server und dem
Befehl auf dem entfernten Host

\<command\_line\>

Aufruf des Plugins inklusive aller notwendigen Argumente

### 10.2.15. Definitionen auf dem Icinga-Server

Nun wechseln wir auf den Icinga-Server, um einige Objekt-Definitionen
anzulegen. Zuerst fügen Sie eine command-Definition zu Ihrer
Konfiguration hinzu (falls Sie noch keine passende haben). Wie immer ist
der Name der Konfigurationsdatei Ihnen überlassen, aber bei den meisten
Leuten heißt sie `commands.cfg`.

<pre><code>
 define command{
</code></pre>

Wir nehmen an, dass Sie bereits eine Host-Definition haben, die der
folgenden ähnlich ist

<pre><code>
 define host{
</code></pre>

Diese Beispieldefinitionen benutzen die oben gezeigten Befehle.

Der folgende Service wird die Anzahl der momentan angemeldeten Benutzer
auf dem entfernten Host überwachen

<pre><code>
 define service{
</code></pre>

"`check_nrpe`" ist die Verbindung zwischen der
Service-Direktive "`check_command`" und der
"`command_name`"-Direktive in der command-Definition auf dem
Icinga-Server. Die "`command_line`" in der command-Definition
zeigt, dass "`check_nrpe`" aufgerufen wird.
"`check_users`" wird als erstes Argument übergeben. Der
nrpe-Prozess auf dem entfernten Host nimmt dieses Argument und sucht
nach einer passenden Definition in `nrpe.cfg`. Der Befehl
wird ausgeführt und das Ergebnis an das check\_nrpe-Plugin auf dem
Icinga-Server zurückgeliefert.

Der folgende Service wird die CPU-Auslastung auf dem entfernten Host
überwachen

<pre><code>
 define service{
</code></pre>

Der folgende Service wird den Plattenplatz auf /dev/hda1 auf dem
entfernten Host überwachen

<pre><code>
 define service{
</code></pre>

Der folgende Service wird die Anzahl der Prozesse auf dem entfernten
Host überwachen

<pre><code>
 define service{
</code></pre>

Der folgende Service wird die Anzahl der Zombie-Prozesse auf dem
entfernten Host überwachen

<pre><code>
 define service{
</code></pre>

Starten Sie Icinga neu, damit die Änderungen in Ihre laufende
Konfiguration übernommen werden

<pre><code>
 #> /etc/init.d/icinga restart
</code></pre>

Nach einer Weile sollten Ihre Plugins ausgeführt worden sein.

### 10.2.16. Weitere Fehlersuche

Einige Fehler während der Installation wurden bereits angesprochen.
Unglücklicherweise gibt es weitere Fehlermöglichkeiten. Nachfolgend
finden Sie Hinweise für einige der häufigsten Fehler mit dem NRPE-Addon.





















Falls Sie immer noch Probleme haben, dann setzen Sie "debug=1" in
`nrpe.cfg` auf dem entfernen Host. Denken Sie daran, den
NRPE-Prozess neu zu starten, wenn dieser im Standalone-Modus läuft.
Führen Sie die Prüfung auf dem Überwachungs-Server aus. Anschließend
sollten Sie Debugging-Informationen im Syslog (z.B.
`/var/log/messages`) finden, die bei der Fehlerbehebung
weiterhelfen sollten.

Sie können such auch an eine der Mailing-Listen bzw. Foren wenden
([https://www.icinga.org/support/](http://www.icinga.org/support/)).

### 10.2.17. Aktualisierung











* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
