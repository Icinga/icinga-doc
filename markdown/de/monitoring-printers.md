 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.16. Netzwerk-Drucker überwachen
---------------------------------

2.16.1. [Einführung](monitoring-printers.md#introduction)

2.16.2. [Überblick](monitoring-printers.md#overview)

2.16.3. [Schritte](monitoring-printers.md#steps)

2.16.4. [Was bereits für Sie vorbereitet
wurde](monitoring-printers.md#whatsdone)

2.16.5. [Voraussetzungen](monitoring-printers.md#prerequisites)

2.16.6. [Icinga konfigurieren](monitoring-printers.md#configicinga)

2.16.7. [Icinga neu starten](monitoring-printers.md#restarticinga)

### 2.16.1. Einführung

![](../images/printer.png)

Dieses Dokument beschreibt, wie Sie den Status von Netzwerkdruckern
überwachen können. HP-Drucker haben interne/externe
JetDirect-Karten/Devices, andere Print-Server (wie der Troy PocketPro
100S oder der Netgear PS101) unterstützen das JetDirect-Protokoll.

Das *check\_hpjd*-Plugin (das Bestandteil der Icinga-Distribution ist),
erlaubt Ihnen die Überwachung des Zustands von JetDirect-fähigen
Druckern, auf denen SNMP aktiviert ist. Das Plugin kann die folgenden
Druckerzustände erkennen:










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

### 2.16.2. Überblick

![](../images/monitoring-printers.png)

Die Überwachung des Zustands eines Netzwerkdruckers ist ziemlich
einfach. Bei JetDirect-fähigen Druckern ist normalerweise SNMP
aktiviert, so dass Icinga ihren Zustand mit Hilfe des
*check\_hpjd*-Plugins überwachen kann.

![[Wichtig]](../images/important.png)

Wichtig

Das *check\_hpjd*-Plugin wird nur dann kompiliert und installiert, wenn
Sie die net-snmp- und net-snmp-utils-Pakete auf Ihrem System haben.
Stellen Sie sicher, dass das Plugin im
*/usr/local/icinga/libexec*-Verzeichnis existiert, bevor Sie fortfahren.
Falls nicht, installieren Sie net-snmp und net-snmp-utils und
kompilieren und installieren Sie die Icinga-Plugins erneut, nachdem Sie
"make clean" im Source-Verzeichnis ausgeführt haben. Einzelheiten finden
Sie in der
[Schnellstartanleitung](quickstart-icinga.md "2.4. Icinga-Schnellstart auf Linux").

### 2.16.3. Schritte

Es gibt einige Schritte, die Sie durchführen müssen, um einen neuen
Netzwerkdrucker zu überwachen. Das sind:




### 2.16.4. Was bereits für Sie vorbereitet wurde

Um Ihnen das Leben ein wenig zu erleichtern, wurden bereits ein paar
Konfigurationsaufgaben für Sie erledigt:



Die o.g. Konfigurationsdateien finden Sie im
*/usr/local/icinga/etc/objects/*-Verzeichnis. Sie können diese und
andere Definitionen anpassen, damit Sie Ihren Anforderungen besser
entsprechen. Allerdings empfehlen wir Ihnen, noch ein wenig damit zu
warten, bis Sie besser mit der Konfiguration von Icinga vertraut sind.
Für den Moment folgen Sie einfach den nachfolgenden Anweisungen und Sie
werden im Nu Ihre Netzwerkdrucker überwachen.

### 2.16.5. Voraussetzungen

Wenn Sie Icinga das erste Mal konfigurieren, um einen Netzwerkdrucker zu
überwachen, dann müssen Sie ein paar zusätzliche Dinge tun. Denken Sie
daran, dass Sie dies nur für den \*ersten\* Netzwerkdrucker machen
müssen, den Sie überwachen wollen.

Editieren Sie die Hauptkonfigurationsdatei.

 vi /usr/local/icinga/etc/icinga.cfg
</code></pre>

Entfernen Sie das führende Hash-(\#)-Zeichen der folgenden Zeile in der
Hauptkonfigurationsdatei:

<pre><code>
 #cfg_file=/usr/local/icinga/etc/objects/printer.cfg
</code></pre>

Speichern Sie die Datei und verlassen den Editor.

Was haben Sie gerade getan? Sie haben Icinga mitgeteilt, in der
*/usr/local/icinga/etc/objects/printer.cfg*-Datei nach weiteren
Objektdefinitionen zu schauen. Dort werden Sie Drucker-Host- und
Service-Definitionen einfügen. Diese Konfigurationsdatei enthält bereits
einige Beispiel-Host-, Hostgroup- und Service-Definitionen. Für den
\*ersten\* Netzwerkdrucker, den Sie überwachen, passen Sie einfach die
Beispiel-Host- und Service-Definitionen an, statt neue zu erstellen.

### 2.16.6. Icinga konfigurieren

Sie müssen einige [Objektdefinitionen
anlegen](objectdefinitions.md "3.4. Objektdefinitionen"), um einen
neuen Drucker zu überwachen.

Öffnen Sie die *printer.cfg*-Datei.

 vi /usr/local/icinga/etc/objects/printer.cfg
</code></pre>

Fügen Sie eine neue
[Host](objectdefinitions.md#objectdefinitions-host)-Definition für den
Netzwerkdrucker hinzu, den Sie überwachen möchten. Wenn dies der
\*erste\* Netzwerkdrucker ist, den Sie überwachen, dann können Sie
einfach die Beispiel-Definitionen in der *printer.cfg*-Datei anpassen.
Ändern Sie die *host\_name*-, *alias*- und *address*-Felder auf die
entsprechenden Werte des Netzwerkdruckers.

<pre><code>
 define host{
</code></pre>

Nun können Sie (in der gleichen Konfigurationsdatei) einige
Service-Definitionen hinzufügen, um Icinga mitzuteilen, welche Dinge auf
dem Drucker zu überwachen sind. Wenn dies der \*erste\* Drucker ist, den
Sie überwachen, dann können Sie einfach die Beispiel-Definitionen in der
*printer.cfg*-Datei anpassen.

![](../images/note.gif) Anmerkung: Ersetzen Sie "*hplj2605dn*" in der
folgenden Beispiel-Definition durch den Namen, den Sie in der
*host\_name*-Direktive der Host-Definition angegeben haben, die Sie
gerade hinzugefügt haben.

Fügen Sie die folgende Service-Definition hinzu, um den Zustand des
Druckers zu prüfen. Der Service benutzt das *check\_hpjd*-Plugin, um den
Drucker alle zehn Minuten zu prüfen. Der Wert für die SNMP-Community
lautet in diesem Beispiel "public".

<pre><code>
 define service{
</code></pre>

Fügen Sie die folgende Service-Definition hinzu, um alle zehn Minuten
einen Ping an den Drucker zu senden. Das ist nützlich, um die generelle
Netzwerkverbindung und Werte für RTA und Paketverlust zu überwachen.

<pre><code>
 define service{
</code></pre>

Speichern Sie die Datei.

### 2.16.7. Icinga neu starten

Sobald Sie die neuen Host- und Service-Definitionen in der
*printer.cfg*-Datei hinzugefügt haben, sind Sie bereit, mit der
Überwachung des Druckers zu beginnen. Um dies zu tun, müssen Sie [die
Konfigurationsdateien
überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration")
und [Icinga neu
starten](startstop.md "4.2. Icinga starten und stoppen").

Wenn die Überprüfung irgendwelche Fehler enthält, dann müssen Sie diese
beheben, bevor Sie fortfahren. Stellen Sie sicher, dass Sie Icinga nicht
(erneut) starten, bevor die Überprüfung ohne Fehler durchgelaufen ist!

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
