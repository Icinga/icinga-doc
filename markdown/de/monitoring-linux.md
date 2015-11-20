 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.14. Linux/Unix-Rechner überwachen
-----------------------------------

2.14.1. [Einführung](monitoring-linux.md#introduction)

2.14.2. [Überblick](monitoring-linux.md#overview)

### 2.14.1. Einführung

Dieses Dokument beschreibt, wie Sie "private" Dienste und Attribute auf
Linux/UNIX-Servern überwachen, wie z.B.:







Öffentlich nutzbare Dienste, die von Linux-Servern zur Verfügung
gestellt werden (HTTP, FTP, SSH, SMTP, etc.), können einfach mit Hilfe
der Dokumentation [öffentlich zugängliche Dienste
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

### 2.14.2. Überblick

[Anmerkung: Dieses Dokument ist noch nicht vollständig. Wir würden
empfehlen, die Dokumentation zum [NRPE-Addon](addons.md#addons-nrpe)
zu lesen, um zu sehen, wie ein entfernter Linux/Unix-Server zu
überwachen ist.]

Es gibt verschiedene Wege, Attribute oder entfernte Linux/Unix-Server zu
überwachen. Einer benutzt gemeinsame SSH-Schlüssel und das
*check\_by\_ssh*-Plugin auf entfernten Servern. Diese Methode wird hier
nicht behandelt, kann aber zu hoher Last auf Ihrem Überwachungs-Server
führen, wenn Sie hunderte oder tausende von Services überwachen. Der
Overhead durch das Auf- und Abbauen von SSH-Verbindungen ist der Grund
dafür.

![](../images/nrpe.png)

Eine andere gebräuchliche Methode der Überwachung von entfernten
Linux/Unix-Hosts ist die Nutzung des
[NRPE-Addons](addons.md#addons-nrpe). NRPE erlaubt Ihnen, Plugins auf
entfernten Linux/Unix-Hosts auszuführen. Das ist nützlich, wenn Sie
lokale Ressourcen/Attribute wie z.B. Plattenbelegung, CPU-Auslastung,
Speichernutzung auf einem entfernten Host überwachen wollen.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
