 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.18. Öffentlich zugängliche Dienste überwachen
-----------------------------------------------

2.18.1. [Einführung](monitoring-publicservices.md#introduction)

2.18.2. [Plugins zur Überwachung von
Services](monitoring-publicservices.md#pluginsformonitoringservices)

2.18.3. [erstellen einer
Host-Definition](monitoring-publicservices.md#createhostdefinition)

2.18.4. [erstellen von
Service-Definitionen](monitoring-publicservices.md#createservicedefinition)

2.18.5. [Icinga erneut
starten](monitoring-publicservices.md#restarticinga)

### 2.18.1. Einführung

Dieses Dokument beschreibt, wie Sie öffentlich zugängliche Dienste,
Applikationen und Protokolle überwachen können. Mit "öffentlich" meinen
Netzwerk oder das größere Internet. Beispiele von öffentlichen Diensten
umfassen u.a. HTTP, POP3, IMAP, FTP und SSH. Es gibt viele weitere
öffentliche Dienste, die Sie wahrscheinlich jeden Tag benutzen. Diese
Dienste und Applikationen, genau wie ihre zu Grunde liegenden
Protokolle, können normalerweise mit Icinga ohne spezielle
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




![](../images/tip.gif) Hinweis: Gelegentlich werden Sie feststellen,
dass Informationen zu privaten Diensten und Applikationen mit SNMP
überwacht werden können. Der SNMP-Agent erlaubt Ihnen, entfernt liegende
anderenfalls private (und unzugängliche) Informationen des Hosts zu
überwachen. Mehr Informationen zur Überwachung von Diensten mit SNMP
finden Sie in der Dokumentation zur [Überwachung von Switches und
Routern](monitoring-routers.md "2.17. Router und Switches überwachen").

![](../images/note.gif) Anmerkung: Diese Anweisungen gehen davon aus,
dass Sie Icinga anhand der
[Schnellstartanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
installiert haben. Die nachfolgenden Beispiel-Konfigurationseinträge
beziehen sich auf Objekte, die in den Beispiel-Konfigurationsdateien
(*commands.cfg* und *localhost.cfg*) definiert sind. Diese Dateien
werden installiert, wenn Sie der Schnellstartanleitung folgen.

Falls Sie ein Paket installiert haben, dann fehlen die Beispieldateien
möglicherweise. Sie finden den Inhalt
[hier](sample-config.md "13.1. Beispielkonfigurationsdateien und Definitionen")
zum Nachschlagen.

### 2.18.2. Plugins zur Überwachung von Services

Wenn Sie feststellen, dass Sie eine bestimmte Applikation, einen Service
oder ein Protokoll überwachen müssen, dann stehen die Chancen gut, dass
bereits ein [Plugin](plugins.md) existiert. Die offizielle
Icinga-Plugin-Distribution enthält Plugins, mit denen eine Reihe von
Services und Protokollen überwacht werden können. Es gibt auch eine
große Zahl von Plugins, die andere Leute beigetragen haben, die Sie im
*contrib/*-Unterverzeichnis der Plugin-Distribution finden. Die [Icinga
Exchange](https://exchange.icinga.org/)-Website stellt eine Reihe von
zusätzlichen Plugins bereit, die andere Benutzer geschrieben haben, also
schauen Sie vorbei, wenn Sie Zeit finden.

Wenn Sie zufällig kein entsprechendes Plugin für das finden, was Sie
überwachen möchten, dann können Sie immer Ihr eigenes schreiben. Plugins
sind einfach zu schreiben, also lassen Sie sich nicht von diesem
Gedanken abschrecken. Lesen Sie dazu die Dokumentation über die
[Entwicklung von Plugins](pluginapi.md "11.1. Nagios Plugin API").

Ich werde Sie durch die Überwachung von einigen grundlegenden Diensten
führen, die Sie vielleicht früher oder später brauchen. Jeder dieser
Services kann mit einem der Plugins überwacht werden, die als Teil der
Icinga-Plugin-Distribution installiert werden. Lassen Sie uns
beginnen...

### 2.18.3. erstellen einer Host-Definition

Bevor Sie einen Service überwachen können, müssen Sie einen
[Host](objectdefinitions.md#objectdefinitions-host) definieren, der
mit dem Service verbunden ist. Sie können Host-Definitionen in jeder
Objektkonfigurationsdatei platzieren, die mit einer
[cfg\_file](configmain.md#configmain-cfg_file)-Direktive definiert ist
oder in einem Verzeichnis, das in einer
[cfg\_dir](configmain.md#configmain-cfg_dir)-Direktive angegeben ist.
Wenn Sie bereits eine Host-Definition angelegt haben, dann können Sie
diesen Schritt überspringen.

Lassen Sie uns für dieses Beispiel annehmen, dass Sie eine Reihe von
Services auf einem entfernten Host überwachen wollen. Lassen Sie uns
diesen Host *remotehost* nennen. Die Host-Definition kann in einer
eigenen Datei ablegt oder zu einer bereits existierenden
Objektkonfigurationsdatei hinzugefügt werden. Hier nun, wie die
Host-Definition für *remotehost* aussehen könnte:

<pre><code>
 define host{
</code></pre>

Nachdem für den Host eine Definition hinzugefügt wurde, können wir mit
der Definition von zu überwachenden Services beginnen. Genau wie
Host-Definitionen können auch Service-Definitionen in jeder
Objektkonfigurationdatei abgelegt werden.

### 2.18.4. erstellen von Service-Definitionen

Für jeden Service, den Sie überwachen wollen, müssen Sie in Icinga einen
[Service](objectdefinitions.md#objectdefinitions-service) definieren,
der mit der Host-Definition verbunden ist, die Sie gerade angelegt
haben. Sie können Host-Definitionen in jeder Objektkonfigurationsdatei
platzieren, die mit einer
[cfg\_file](configmain.md#configmain-cfg_file)-Direktive definiert ist
oder in einem Verzeichnis, das in einer
[cfg\_dir](configmain.md#configmain-cfg_dir)-Direktive angegeben ist.

Einige Beispiel-Service-Definitionen zur Überwachung von gebräuchlichen
Services (HTTP, FTP, usw.) finden Sie nachfolgend.



















































### 2.18.5. Icinga erneut starten

Sobald Sie die neuen Host- und Service-Definitionen zu Ihrer/n
Konfigurationsdatei(en) hinzugefügt haben, sind Sie bereit, sie zu
überwachen. Um dies zu tun, müssen Sie [die Konfiguration
überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration")
und [Icinga erneut
starten](startstop.md "4.2. Icinga starten und stoppen").

Wenn der Überprüfungsprozess irgendwelche Fehler produziert, dann
verbessern Sie Ihre Konfigurationsdatei, bevor Sie fortfahren. Stellen
Sie sicher, dass Sie Icinga nicht erneut starten, bevor der
Überprüfungsprozess ohne Fehler durchläuft!

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
