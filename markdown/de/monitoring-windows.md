 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.13. Windows-Maschinen überwachen
----------------------------------

2.13.1. [Einführung](monitoring-windows.md#introduction)

2.13.2. [Überblick](monitoring-windows.md#overview)

2.13.3. [Schritte](monitoring-windows.md#steps)

2.13.4. [Was bereits für Sie vorbereitet
wurde](monitoring-windows.md#whatsdone)

2.13.5. [Voraussetzungen](monitoring-windows.md#prequisites)

2.13.6. [Installation des
Windows-Agenten](monitoring-windows.md#installwindowsagent)

2.13.7. [Icinga konfigurieren](monitoring-windows.md#configicinga)

2.13.8. [Passwortschutz](monitoring-windows.md#passwordprotect)

2.13.9. [Icinga neu starten](monitoring-windows.md#restarticinga)

2.13.10. [Troubleshooting](monitoring-windows.md#troubleshooting)

### 2.13.1. Einführung

Dieses Dokument beschreibt, wie Sie "private" Dienste und Attribute von
Windows-Rechnern überwachen können, wie z.B.:







Öffentlich nutzbare Dienste, die von Windows-Rechnern zur Verfügung
gestellt werden (HTTP, FTP, POP3, etc.), können einfach mit Hilfe der
Dokumentation [öffentlich zugängliche Dienste
überwachen](monitoring-publicservices.md "2.18. Öffentlich zugängliche Dienste überwachen")
kontrolliert werden.

![](../images/note.gif) Anmerkung: Diese Anweisungen gehen davon aus,
dass Sie Icinga anhand der
[Schnellstartanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
installiert haben. Die nachfolgenden Beispiel-Konfigurationseinträge
beziehen sich auf Objekte, die in den Beispiel-Konfigurationsdateien
(*commands.cfg*, *templates.cfg*, etc.) definiert sind. Diese Dateien
werden installiert, wenn Sie der Schnellstartanleitung folgen.

Falls Sie ein Paket installiert haben, dann fehlen die Beispieldateien
möglicherweise. Sie finden den Inhalt
[hier](sample-config.md "13.1. Beispielkonfigurationsdateien und Definitionen")
zum Nachschlagen.

### 2.13.2. Überblick

![](../images/monitoring-windows.png)

Die Überwachung von privaten Diensten oder Attributen eines
Windows-Rechners erfordert die Installation eines Agenten. Dieser Agent
dient als ein Bindeglied zwischen der Überwachung und dem eigentlichen
Dienst oder Attribut auf dem Windows-Rechner. Ohne diesen Agenten wäre
Icinga nicht in der Lage, private Dienste oder Attribute auf dem
Window-Rechner zu überwachen.

Für dieses Beispiel installieren wir das
[NSClient++](http://sourceforge.net/projects/nscplus)-Addon auf dem
Windows-Rechner und werden das *check\_nt*-Plugin zur Kommunikation mit
dem NSClient++-Addon benutzen. Das *check\_nt*-Plugin sollte bereits auf
dem Icinga-Server installiert sein, wenn Sie der Schnellstartanleitung
gefolgt sind.

Andere Windows-Agenten (wie
[NC\_Net](http://sourceforge.net/projects/nc-net)) können statt
die Befehls- und Service-Definitionen usw. entsprechend an. Aus Gründen
der Einfachheit werden wir nur das NSClient++-Addon in diesen
Anweisungen berücksichtigen.

### 2.13.3. Schritte

Es gibt einige Schritte, die Sie durchführen müssen, um einen neuen
Windows-Rechner zu überwachen. Das sind:





### 2.13.4. Was bereits für Sie vorbereitet wurde

Um Ihnen das Leben ein wenig zu erleichtern, wurden bereits ein paar
Konfigurationsaufgaben für Sie erledigt:



Die o.g. Konfigurationsdateien finden Sie im
*/usr/local/icinga/etc/objects/*-Verzeichnis. Sie können diese und
andere Definitionen anpassen, damit Sie Ihren Anforderungen besser
entsprechen. Allerdings empfehlen wir Ihnen, noch ein wenig damit zu
warten, bis Sie besser mit der Konfiguration von Icinga vertraut sind.
Für den Moment folgen Sie einfach den nachfolgenden Anweisungen und Sie
werden im Nu Ihre Windows-Rechner überwachen.

### 2.13.5. Voraussetzungen

Wenn Sie Icinga das erste Mal konfigurieren, um einen Windows-Rechner zu
überwachen, dann müssen Sie ein paar zusätzliche Dinge tun. Denken Sie
daran, dass Sie dies nur für den \*ersten\* Windows-Rechner machen
müssen, den Sie überwachen wollen.

Editieren Sie die Hauptkonfigurationsdatei.

#> vi /usr/local/icinga/etc/icinga.cfg
</code></pre>

Entfernen Sie das führende Hash-(\#)-Zeichen der folgenden Zeile in der
Hauptkonfigurationsdatei:

#cfg_file=/usr/local/icinga/etc/objects/windows.cfg
</code></pre>

Speichern Sie die Datei und verlassen den Editor.

Was haben Sie gerade getan? Sie haben Icinga mitgeteilt, in der
*/usr/local/icinga/etc/objects/windows.cfg*-Datei nach weiteren
Objektdefinitionen zu schauen. Dort werden Sie Host- und
Service-Definitionen für Windows-Rechner einfügen. Diese
Konfigurationsdatei enthält bereits einige Beispiel-Host-, Hostgroup-
und Service-Definitionen. Für den \*ersten\* Windows-Rechner, den Sie
überwachen, passen Sie einfach die Beispiel-Host- und
Service-Definitionen an, statt neue zu erstellen.

### 2.13.6. Installation des Windows-Agenten

Bevor Sie mit der Überwachung von privaten Diensten und Attributen von
Windows-Rechnern beginnen, müssen Sie einen Agenten auf diesen Rechnern
installieren. Wir empfehlen das NSClient++-Addon zu nutzen, das Sie
unter
[http://sourceforge.net/projects/nscplus](http://sourceforge.net/projects/nscplus)
finden. Diese Anweisungen werden Sie durch eine Basisinstallation des
NSClient++-Addons und die Icinga-Konfiguration für die Überwachung des
Windows-Rechners führen.

​1. Laden Sie die letzte stabile Version des NSClient++-Addons von
[http://sourceforge.net/projects/nscplus](http://sourceforge.net/projects/nscplus)

​2. Entpacken Sie die NSClient++-Dateien in ein neues
C:\\NSClient++-Verzeichnis

​3. Gehen Sie auf die Kommandozeile und wechseln Sie in das
C:\\NSClient++-Verzeichnis

​4. Registrieren Sie den NSClient++-Dienst mit dem folgenden Befehl:

 nsclient++ /install
</code></pre>

​5. Öffnen Sie die Dienste-Applikation und stellen Sie sicher, dass der
NSClient++-Dienst mit dem Desktop kommunizieren darf (Reiter "Anmelden",
Häkchen bei "Datenaustausch zwischen Dienst und Desktop zulassen"
gesetzt). Setzen Sie ggf. das Häkchen.

![](../images/nscpp.png)

​6. Editieren Sie die NSC.INI-Datei (im C:\\NSClient++-Verzeichnis) und
machen Sie folgende Änderungen:





​7. Starten Sie den NSClient++-Dienst mit dem folgenden Befehl:

 nsclient++ /start
</code></pre>

​8. Geschafft! Der Windows-Rechner kann nun der
Icinga-Überwachungskonfiguration hinzugefügt werden...

### 2.13.7. Icinga konfigurieren

Nun ist es Zeit, einige
[Objektdefinitionen](objectdefinitions.md "3.4. Objektdefinitionen")
in Ihren Icinga-Konfigurationsdateien anzulegen, um den neuen
Windows-Rechner zu überwachen.

Editieren Sie die *windows.cfg*-Datei.

#> vi /usr/local/icinga/etc/objects/windows.cfg
</code></pre>

Fügen Sie eine neue
[Host](objectdefinitions.md#objectdefinitions-host)-Definition für den
Windows-Rechner hinzu, den Sie überwachen möchten. Wenn dies der
\*erste\* Windows-Rechner ist, den Sie überwachen, dann können Sie
einfach die Beispiel-Definitionen in der *windows.cfg*-Datei anpassen.
Ändern Sie die *host\_name*-, *alias*- und *address*-Felder auf die
entsprechenden Werte des Windows-Rechners.

<pre><code>
 define host{
</code></pre>

Gut. Nun können Sie (in der gleichen Konfigurationsdatei) einige
Service-Definitionen hinzufügen, um Icinga mitzuteilen, welche Dinge auf
dem Windows-Server zu überwachen sind. Wenn dies der \*erste\*
Windows-Rechner ist, den Sie überwachen, dann können Sie einfach die
Beispiel-Definitionen in der *windows.cfg*-Datei anpassen.

![[Anmerkung]](../images/note.png)

Anmerkung

Ersetzen Sie "*winserver*" in den folgenden Beispiel-Definitionen durch
den Namen, den Sie in der *host\_name*-Direktive der Host-Definitionen
angegeben haben, die Sie gerade hinzugefügt haben.

Fügen Sie die folgende Service-Definition hinzu, um die Version des
NSClient++-Addons zu überwachen, das auf dem Windows-Rechner läuft. Dies
ist nützlich, wenn Sie Ihre Windows-Server mit einer neueren Version des
Addons aktualisieren möchten, weil Sie sehen können, welche
Windows-Rechner noch auf die neueste Version des NSClient++-Addon
aktualisiert werden muss.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um die Laufzeit des
Windows-Servers zu überwachen.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um die CPU-Belastung
des Windows-Servers zu überwachen und einen CRITICAL-Alarm zu erzeugen,
wenn die 5-Minuten-Belastung mindestens 90% beträgt oder einen
WARNING-Alarm, wenn die 5-Minuten-Belastung mindestens 80% beträgt.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um die Speicherbelegung
des Windows-Servers zu überwachen und einen CRITICAL-Alarm zu erzeugen,
wenn die Belegung mindestens 90% beträgt oder einen WARNING-Alarm, wenn
die Belegung mindestens 80% beträgt.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um die Plattenbelegung
von Laufwerk C: des Windows-Servers zu überwachen und einen
CRITICAL-Alarm zu erzeugen, wenn die Belegung mindestens 90% beträgt
oder einen WARNING-Alarm, wenn die Belegung mindestens 80% beträgt.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um den W3SVC-Dienst des
Windows-Servers zu überwachen und einen CRITICAL-Alarm zu erzeugen, wenn
der Dienst gestoppt ist.

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um den
Explorer.exe-Prozess des Windows-Servers zu überwachen und einen
CRITICAL-Alarm zu erzeugen, wenn der Prozess nicht läuft.

<pre><code>
 define service{
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Nun ja. Eigentlich ist es ziemlich unsinnig, zu überwachen, ob der
Explorer läuft. Allerdings läßt sich auf diese Weise sehr einfach
prüfen, ob alles wie gewünscht funktioniert ;-)

Das war es vorerst. Sie haben einige grundlegende Dienste hinzugefügt,
die auf dem Windows-Rechner überwacht werden sollen. Speichern Sie die
Konfigurationsdatei.

### 2.13.8. Passwortschutz

Wenn Sie ein Passwort in der NSClient++-Konfigurationsdatei auf dem
Windows-Rechner angegeben haben, dann müssen Sie die
*check\_nt*-Befehlsdefinition anpassen, damit sie das Passwort enthält.
Öffnen Sie die *commands.cfg*-Datei.

 #> vi /usr/local/icinga/etc/objects/commands.cfg
</code></pre>

Ändern Sie die Definition des *check\_nt*-Befehls, damit sie das "-s
\<PASSWORD\>"-Argument enthält (wobei PASSWORD das Passwort ist, das Sie
auf dem Windows-Rechner angegeben haben):

<pre><code>
 define command{
</code></pre>

Speichern Sie die Datei

### 2.13.9. Icinga neu starten

Sie sind fertig mit der Anpassung der Icinga-Konfiguration, so dass Sie
nun [die Konfigurationsdateien
überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration")
und [Icinga neu
starten](startstop.md "4.2. Icinga starten und stoppen") müssen.

Wenn die Überprüfung irgendwelche Fehler enthält, dann müssen Sie diese
beheben, bevor Sie fortfahren. Stellen Sie sicher, dass Sie Icinga nicht
(erneut) starten, bevor die Überprüfung ohne Fehler durchgelaufen ist!

### 2.13.10. Troubleshooting

Manchmal funktioniert es nicht. Der einfachste Weg ist es, das Plugin
als Icinga-Benutzer auf der Kommandozeile auszuführen:

 $> /usr/local/icinga/libexec/check_nt -H <ip address> -p <port> -s <password> -v UPTIME
</code></pre>

\<ip address\> ist die Adresse des Windows-Rechners, \<port\> und
\<password\> die Werte aus `nsc.ini`. Bitte beachten Sie,
dass ein leeres Passwort ggf. als "" (zwei Anführungszeichen) anzugeben
ist. Das Ergebnis könnte eins der folgenden sein:









* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
