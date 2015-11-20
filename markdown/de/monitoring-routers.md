 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.17. Router und Switches überwachen
------------------------------------

2.17.1. [Einführung](monitoring-routers.md#introduction)

2.17.2. [Überblick](monitoring-routers.md#overview)

2.17.3. [Schritte](monitoring-routers.md#steps)

2.17.4. [Was bereits für Sie vorbereitet
wurde](monitoring-routers.md#whatsdone)

2.17.5. [Voraussetzungen](monitoring-routers.md#prereuisites)

2.17.6. [Icinga konfigurieren](monitoring-routers.md#configicinga)

2.17.7. [Icinga neu starten](monitoring-routers.md#restarticinga)

### 2.17.1. Einführung

![](../images/switch.png)

Dieses Dokument beschreibt, wie Sie den Zustand von Netzwerk-Switches
und Routern überwachen können. Einige preiswerte "unmanaged" Switches
und Router haben keine IP-Adresse und sind in Ihrem Netzwerk nicht
sichtbar, so dass es keinen Weg gibt, um sie zu überwachen. Teurere
Switches und Router haben eigene Adressen und können durch Ping
überwacht oder über SNMP nach Statusinformationen abgefragt werden.

Ich werde beschreiben, wie Sie die folgenden Dinge auf "managed"
Switches, Hubs und Routern überwachen können:




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

### 2.17.2. Überblick

![](../images/monitoring-routers.png)

Die Überwachung von Switches und Routern kann entweder einfach oder auch
Sie überwachen wollen. Da es sich um kritische Infrastrukturkomponenten
handelt, werden Sie diese ohne Zweifel mindestens in grundlegender Art
und Weise überwachen.

Switches und Router können einfach per "Ping" überwacht werden, um
Paketverlust, RTA usw. zu ermitteln. Wenn Ihr Switch SNMP unterstützt,
können Sie mit dem *check\_snmp*-Plugin z.B. den Port-Status und (wenn
Sie MRTG benutzen) mit dem *check\_mrtgtraf*-Plugin die Bandbreite
überwachen.

Das *check\_snmp*-Plugin wird nur dann kompiliert und installiert, wenn
Sie die net-snmp- und net-snmp-utils-Pakete auf Ihrem System haben.
Stellen Sie sicher, dass das Plugin im
*/usr/local/icinga/libexec*-Verzeichnis existiert, bevor Sie fortfahren.
Falls nicht, installieren Sie net-snmp und net-snmp-utils und
kompilieren und installieren Sie die Icinga-Plugins erneut.

### 2.17.3. Schritte

Es gibt einige Schritte, die Sie durchführen müssen, um einen neuen
Router oder Switch zu überwachen. Das sind:




### 2.17.4. Was bereits für Sie vorbereitet wurde

Um Ihnen das Leben ein wenig zu erleichtern, wurden bereits ein paar
Konfigurationsaufgaben für Sie erledigt:



Die o.g. Konfigurationsdateien finden Sie im
*/usr/local/icinga/etc/objects/*-Verzeichnis. Sie können diese und
andere Definitionen anpassen, damit Sie Ihren Anforderungen besser
entsprechen. Allerdings empfehlen wir Ihnen, noch ein wenig damit zu
warten, bis Sie besser mit der Konfiguration von Icinga vertraut sind.
Für den Moment folgen Sie einfach den nachfolgenden Anweisungen und Sie
werden im Nu Ihre Router/Switches überwachen.

### 2.17.5. Voraussetzungen

Wenn Sie Icinga das erste Mal konfigurieren, um einen Netzwerk-Switch zu
überwachen, dann müssen Sie ein paar zusätzliche Dinge tun. Denken Sie
daran, dass Sie dies nur für den \*ersten\* Switch machen müssen, den
Sie überwachen wollen.

Editieren Sie die Hauptkonfigurationsdatei.

#> vi /usr/local/icinga/etc/icinga.cfg
</code></pre>

Entfernen Sie das führende Hash-(\#)-Zeichen der folgenden Zeile in der
Hauptkonfigurationsdatei:

<pre><code>
 #cfg_file=/usr/local/icinga/etc/objects/switch.cfg
</code></pre>

Speichern Sie die Datei und verlassen den Editor.

Was haben Sie gerade getan? Sie haben Icinga mitgeteilt, in der
*/usr/local/icinga/etc/objects/switch.cfg*-Datei nach weiteren
Objektdefinitionen zu schauen. Dort werden Sie Host- und
Service-Definitionen für Router- und Switches einfügen. Diese
Konfigurationsdatei enthält bereits einige Beispiel-Host-, Hostgroup-
und Service-Definitionen. Für den \*ersten\* Router/Switch, den Sie
überwachen, passen Sie einfach die Beispiel-Host- und
Service-Definitionen an, statt neue zu erstellen.

### 2.17.6. Icinga konfigurieren

Sie müssen einige [Objektdefinitionen
anlegen](objectdefinitions.md "3.4. Objektdefinitionen"), um einen
neuen Router/Switch zu überwachen.

Öffnen Sie die *switch.cfg*-Datei.

#> vi /usr/local/icinga/etc/objects/switch.cfg
</code></pre>

Fügen Sie eine neue
[Host](objectdefinitions.md#objectdefinitions-host)-Definition für den
Switch hinzu, den Sie überwachen möchten. Wenn dies der \*erste\* Switch
ist, den Sie überwachen, dann können Sie einfach die
Beispiel-Definitionen in der *switch.cfg*-Datei anpassen. Ändern Sie die
*host\_name*-, *alias*- und *address*-Felder auf die entsprechenden
Werte des Switches.

<pre><code>
 define host{
</code></pre>

**Services überwachen**

Nun können Sie einige Service-Definitionen hinzufügen (in der gleichen
Konfigurationsdatei), um Icinga mitzuteilen, welche Dinge auf dem Switch
zu überwachen sind. Wenn dies der \*erste\* Switch ist, den Sie
überwachen, dann können Sie einfach die Beispiel-Definitionen in der
*switch.cfg*-Datei anpassen.

![](../images/note.gif) Anmerkung: Ersetzen Sie "*linksys-srw224p*" in
der folgenden Beispiel-Definition durch den Namen, den Sie in der
*host\_name*-Direktive der Host-Definition angegeben haben, die Sie
gerade hinzugefügt haben.























Speichern Sie die Datei.

### 2.17.7. Icinga neu starten

Sobald Sie die neuen Host- und Service-Definitionen in der
*switch.cfg*-Datei hinzugefügt haben, sind Sie bereit, mit der
Überwachung des Routers/Switches zu beginnen. Um dies zu tun, müssen Sie
[die Konfigurationsdateien
überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration")
und [Icinga neu
starten](startstop.md "4.2. Icinga starten und stoppen").

Wenn die Überprüfung irgendwelche Fehler enthält, dann müssen Sie diese
beheben, bevor Sie fortfahren. Stellen Sie sicher, dass Sie Icinga nicht
(erneut) starten, bevor die Überprüfung ohne Fehler durchgelaufen ist!

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
