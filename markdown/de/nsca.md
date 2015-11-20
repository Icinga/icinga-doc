 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

10.3. NSCA
----------

10.3.1. [Einführung](nsca.md#introduction)

10.3.2. [Voraussetzungen](nsca.md#prerequisites)

10.3.3. [Download und Compile](nsca.md#downloadcompile)

10.3.4. [Anpassen](nsca.md#customise)

10.3.5. [Erster Test](nsca.md#firsttest)

10.3.6. [Installation](nsca.md#installnsca)

10.3.7. [Entfernte/s System/e](nsca.md#remotesystem)

10.3.8. [Dateien kopieren](nsca.md#copyfiles)

10.3.9. [Zweiter Test](nsca.md#secondtest)

10.3.10. [Fehlersuche](nsca.md#troubleshooting)

10.3.11. [Sicherheit](nsca.md#security)

10.3.12. [Betrieb](nsca.md#operation)

10.3.13. [Integration in Icinga](nsca.md#icingaintegration)

### 10.3.1. Einführung

Nagios Service Check Acceptor (oder kurz NSCA) ist ein Addon, um
Prüfergebnisse von einem System zu einem anderen zu übertragen. Es
besteht aus zwei Modulen: Dem Sender (send\_nsca) und dem Empfänger
(nsca). Die Daten werden verschlüsselt übertragen. Trotz des Namens
werden auch Host-Prüfergebnisse übertragen.

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte sehen Sie sich auch [NSCA-ng](http://www.nsca-ng.org/) an, das ein
vollwertiger Ersatz für NSCA ist.

**Abbildung 10.3. NSCA**

![NSCA](../images/nsca.png)

\

NSCA läuft als Daemon auf dem Icinga-Server. Er lauscht auf
Informationen, die von entfernten Maschinen mit Hilfe des
send\_nsca-Programms (auf Unix/Linux-Maschinen) oder NSClient++ (oft auf
Windows-Maschinen benutzt) gesendet werden. Die Daten werden mit der in
`send_nsca.cfg` (oder `nsc.ini` im Falle von
NSClient++) festgelegten Methode verschlüsselt. Der Daemon wird die
Daten in einer \*sehr\* einfachen Weise validieren, indem die
Informationen mit dem in nsca.cfg eingetragenen Passwort entschlüsselt
werden. Wenn die Daten so aussehen, als seien sie mit dem gleichen
Passwort verschlüsselt worden, dann wird der Daemon versuchen, diese
Daten als externen Befehl in die lokale Icinga-Command-Pipe auszugeben.

Die folgenden Anweisungen basieren hauptsächlich auf dem README aus dem
NSCA-Paket.

### 10.3.2. Voraussetzungen







### 10.3.3. Download und Compile

![[Anmerkung]](../images/note.png)

Anmerkung

Anstatt NSCA von Grund auf zu installieren möchten Sie vielleicht ein
Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt.

Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs, z.B. durch

<pre><code>
 #> wget http://sourceforge.net/projects/nagios/files/nsca-2.x/nsca-2.9.1/nsca-2.9.1.tar.gz -O nsca-2.9.1.tar.gz
</code></pre>

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine Snapshots, solange Sie kein Problem haben, das
in der aktuellen Entwicklerversion ggf. gelöst ist.

Die maximale Länge der zu übertragenen Daten ist auf 2.048 Bytes
begrenzt, die maximale Länge von Plugin-Ausgaben auf 512 Bytes. Falls
das nicht ausreicht, dann müssen Sie den entsprechenden Wert in
`icinga-nsca/include/common.h` anpassen.

<pre><code>
</code></pre>

Bitte denken Sie daran, dass Sie die Programme erneut kompilieren
müssen, wenn Sie sich zu einem späteren Zeitpunkt für eine Änderung
entscheiden.

Bedingt durch den folgenden Wert in include/common.h (im Icinga-Core)
kann der maximale Wert 8.192 Bytes nicht überschreiten.

<pre><code>
</code></pre>

Nach Änderung des Besitzers wechseln Sie in das neu erstellte
Verzeichnis und rufen Sie configure und make auf

<pre><code>
 #> chown -R icinga icinga-nsca
 #> cd icinga-nsca
 #> make all
</code></pre>

Anschließend gibt es zwei Programme (send und send\_nsca) im
`src`-Verzeichnis.

![[Achtung]](../images/caution.png)

Achtung

Wenn die libmcrypt-Dateien nicht gefunden werden, dann wird
"./configure" sich beschweren, aber NICHT mit einem Return-Code ungleich
Null enden, so dass Sie *config.log* mit dem folgenden Befehl prüfen
sollten

<pre><code>
 #> grep mcrypt.h: config.log
</code></pre>

Dieser Befehl sollte keine Zeilen ausgeben.

Falls die libmcrypt-Module nicht gefunden werden, Benutzer oder Gruppe
vom Wert "icinga" abweichen oder der zu benutzende Port nicht dem
Default 5667 entspricht, dann können Sie dies über verschiedene Optionen
über die verfügbaren Optionen zu erfahren.

Nach dem Wechsel in "nsca\_tests" können Sie versuchen, "./runtests"
auszuführen. Bitte beachten Sie, dass diese Tests verschiedene
Perl-Module benötigen, die in der Datei README beschrieben sind.

### 10.3.4. Anpassen

Das `sample-config`-Verzeichnis enthält `nsca.cfg`
und `send_nsca.cfg`. Mindestens die Einstellungen der
Direktiven "password" und "encryption\_method" / "decryption\_method"
sollten Sie ansehen/verändern, bevor die Dateien kopiert werden. Bitte
denken Sie daran, das gleiche Passwort in allen Kopien dieser
Konfigurationsdateien zu setzen. Wenn Sie verschiedene Passworte auf
verschiedenen entfernten Servern einsetzen möchten, dann müssen Sie
mehrere nsca-Daemons auf dem Icinga-Server starten, die auf
unterschiedlichen Ports lauschen. Das funktioniert nicht, wenn Sie den
Daemon über inetd/xinetd starten.

### 10.3.5. Erster Test

Wechseln Sie zum Icinga-Benutzer und starten Sie einen ersten Test

<pre><code>
 $> cd /usr/src/icinga-nsca/src
 $> ./nsca -c ../sample-config/nsca.cfg
 $> echo -e "A\tB\tC\tD\n" | ./send_nsca -H localhost -c ../sample-config/send_nsca.cfg
 $> exit
</code></pre>

Dies sollte die Meldung "1 data packet(s) sent to host successfully."
zurückliefern. Eigentlich heißt das nur, dass sich send\_nsca und nsca
unter Verwendung der Konfigurationsdateien auf dem lokalen Host
miteinander unterhalten können, denn dieser Test funktioniert auch ohne
eine lauffähige Icinga-Instanz. Allerdings ist er trotzdem wichtig: Wenn
dieser Test fehlschlägt, dann ist es nicht sinnvoll fortzufahren. Prüfen
Sie stattdessen die Einstellungen nsca.cfg und send\_nsca.cfg. Schauen
Sie auch im Syslog (z.B. `/var/log/messages`) nach Meldungen.

Wenn die Voraussetzungen erfüllt sind, dann sollten Sie einige Warnungen
in `icinga.log` sehen, dass Host "A" und Service "B" nicht in
der Icinga-Konfiguration gefunden werden konnten. Dies bedeutet, dass
nsca ausreichende Berechtigungen hat, um in das Icinga-Command-File zu
schreiben. Prüfen Sie, ob der nsca-Daemon und Icinga mit
unterschiedlichen Benutzern laufen, wenn es keine Meldugen in icinga.log
gibt. Prüfen Sie außerdem die Einstellung von
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

### 10.3.6. Installation

"make install" macht (im Moment) nichts, so dass Sie selbst einige
Dateien kopieren müssen. Die folgenden Befehle kopieren das nsca-Modul
in das Verzeichnis, in dem das Icinga-Binary zu finden ist und die
Konfigurationsdatei in den Icinga-Konfigurationsordner. Wir nehmen an,
dass Sie Icinga nach einer der Schnellstartanleitungen installiert
haben.

<pre><code>
 #> cp -p nsca /usr/local/icinga/bin/
 #> cp ../sample-config/nsca.cfg /usr/local/icinga/etc/
</code></pre>





















### 10.3.7. Entfernte/s System/e

Sie sind mit dem lokalen System fertig, aber natürlich muss send\_nsca
noch auf entfernte Systeme kopiert werden.

Bitte denken Sie daran, dass send\_nsca für die Zielplattform kompiliert
werden muss, so dass Sie ggf. die libmcrypt-Pakete und configure/make
auf mehreren Servern installieren bzw. ausführen müssen.

### 10.3.8. Dateien kopieren

Sie können frei entscheiden, wo Sie Binary und Konfigurationsdatei
ablegen möchten. Wir nehmen an, dass Sie eine Verzeichnisstruktur haben,
die ähnlich zum Icinga-Server ist.

<pre><code>
 #> scp -p <Icinga server>:/usr/local/icinga-nsca/src/send_nsca /usr/local/icinga/bin/
 #> scp -p <Icinga server>:/usr/local/icinga-nsca/sample-config/send_nsca.cfg /usr/local/icinga/etc/
</code></pre>

### 10.3.9. Zweiter Test

Nun können Sie den Test auf dem entfernten System ausführen

<pre><code>
 $> echo -e "A\tB\tC\tD\n" | /usr/local/icinga/bin/send_nsca -H <Icinga server> -c /usr/local/icinga/etc/send_nsca.cfg
</code></pre>

Dies sollte ebenfalls die Meldung "1 data packet(s) sent to host
successfully." liefern und es sollte Warnungen im icinga.log auf dem
Icinga-Server geben, die ähnlich zu den o.g. sind. Wenn es keine
Meldungen gibt, dann prüfen Sie die Einstellung von
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

### 10.3.10. Fehlersuche

Wenn der Daemon nicht berechtigt ist, in die Command-Pipe zu schreiben,
dann sind die Daten verloren! Der Daemon sollte mit dem gleichen
Benutzer laufen wie Icinga.

Wenn das Objekt (Host und/oder Service) nicht in der laufenden
Konfiguration enthalten ist, werden die Daten verworfen.

Host-Name (und Service-Beschreibung, falls zutreffend) sind
Case-sensitiv und müssen exakt mit den Definitionen in Icinga
übereinstimmen.

Prüfen Sie, ob Sie in `nsca.cfg` und
`send_nsca.cfg` das gleiche Passwort angegeben haben.
Anderenfalls wird die Übertragung fehlschlagen.

Prüfen Sie, ob Sie gleiche Verschlüsselungs-/Entschlüsselungsmethode
verwenden. Anderenfalls wird die Übertragung fehlschlagen.

Prüfen Sie, ob Ihre Firewall-Einstellungen die Kommunikation über den
angegebenen Port zulassen (Default ist 5667)

Wenn Sie xinetd verwenden, dann prüfen Sie, ob die hinter "only\_from="
angegebenen IP-Adressen zu den entfernten Systemen passen oder entfernen
Sie diese Zeile (und starten Sie xinetd neu).

Aktivieren Sie "debug=1" in `nsca.cfg`, starten Sie den Daemon
(neu) und schauen Sie nach Meldungen im Syslog / in
`nsca.log`.

### 10.3.11. Sicherheit

Es gibt einige Sicherheitsimplikationen, wenn Sie entfernten Clients
erlauben, Prüfergebnisse an Icinga zu senden. Daher gibt es die
Möglichkeit, die Pakete zu verschlüsseln, die der NSCA-Client an den
NSCA-Daemon sendet. Lesen Sie die SECURITY-Datei, um weitere
Informationen über die Sicherheitsrisiken zu erhalten, die durch den
Betrieb von NSCA auftreten können, zusammen mit einer Erklärung, welche
Art von Schutz die Verschlüsselung Ihnen bietet.

### 10.3.12. Betrieb

send\_nsca wird benutzt, um die Prüfergebnisse vom entfernten Rechner
zum Icinga-Server zu senden. Die Syntax hängt vom Objekttyp ab. Um
Service-Prüfergebnisse zu versenden, benutzen Sie

\<host\_name\>[tab]\<svc\_description\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

wobei:

\<host\_name\>=der Kurzname des Hosts, mit dem der Service verbunden ist
(wie in der host\_name-Direktive der Service-Definition angegeben)

\<svc\_description\>=Beschreibung des Service (wie in der
service\_description-Direktive der Service-Definition angegeben)

\<return\_code\>=numerischer Return-Code (0,1,2,3 wie
[hier](pluginapi.md "11.1. Nagios Plugin API") beschrieben)

\<plugin\_output\>=Ausgabe des Service-Check

einfach die Service-Beschreibung weg:

\<host\_name\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

### 10.3.13. Integration in Icinga

Bisher haben Sie lediglich einige Voraussetzungen geschaffen, um passive
Prüfergebnisse zu übermitteln, aber Sie haben noch keinen Host oder
Service definiert, der diese Funktionalität nutzt.

Obwohl Sie nur Prüfergebnisse empfangen müssen Sie doch die
"check\_command"-Direktive in Ihren Definitionen angeben. Es gibt ein
Plugin namens "check\_dummy", das für diesen Zweck benutzt werden kann.
Es kann sein, dass Sie die folgende command-Definition einfügen müssen,
falls sie noch nicht vorhanden ist. Das zweite Argument ist optional und
kann z.B. einen erklärenden Text enthalten.

<pre><code>
 define command{
</code></pre>

Vielleicht möchten Sie ein Service-Template anlegen. Das Host-Template
könnte ähnlich aussehen (ersetzen Sie einfach "service" durch "host")

<pre><code>
 define service{
</code></pre>

Zusammen mit dem obigen Template könnte die Service-Definition wie folgt
aussehen:

<pre><code>
 define service{
</code></pre>

Starten Sie Icinga erneut, damit die Änderungen in der laufenden
Konfiguration enthalten sind

<pre><code>
 #> /etc/init.d/icinga restart
</code></pre>

Wechseln Sie auf Ihrem entfernten Host zum Icinga-Benutzer und führen
Sie send\_nsca aus. Ersetzen Sie dabei \<Icinga server\> durch die
IP-Adresse des Icinga-Servers

<pre><code>
 $> echo -e "remotehost\tDiskspace\t0\t/var=78%\n" | /usr/local/icinga/bin/send_nsca -H <Icinga server> -c /usr/local/icinga/etc/send_nsca.cfg
</code></pre>

Bitte denken Sie daran, dass Host-Name und Service-Beschreibung exakt
den Angaben in Ihrer Icinga-Definition entsprechen müssen (die Angaben
sind Case-sensitiv). Andernfalls bekommen Sie Meldungen in icinga.log,
dass das Objekt nicht gefunden werden kann. Falls es keine Meldungen
gibt, kontrollieren Sie die Einstellung von
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

Nach einem kurzen Moment sollten Sie Meldungen in icinga.log sehen, dass
die gesendeten Informationen verarbeitet wurden. Sie sollten die Daten
dann auch im klassischen Web-Interface sehen sowie feststellen, dass der
Service-Status von "Pending" auf "OK" gewechselt ist und die Ausgabe die
Daten enthält, die Sie versandt haben.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie verteiltes Monitoring mit mehreren Icinga-Servern haben, dann
sollten Sie auch den Abschnitt "[Verteilte
Überwachung](distributed.md "7.6. Verteilte Überwachung")" lesen.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
