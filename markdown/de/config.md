![Icinga](../images/logofullsize.png "Icinga")

3.1. Konfigurationsüberblick

[Zurück](ch03.md) 

Kapitel 3. Icinga konfigurieren

 [Weiter](configmain.md)

* * * * *

3.1. Konfigurationsüberblick
----------------------------

3.1.1. [Einführung](config.md#introduction)

3.1.2. [Dateinamen](config.md#config-filenames)

3.1.3. [Hauptkonfigurationsdatei](config.md#mainconfigfile)

3.1.4. [Ressource-Datei(en)](config.md#resourcefile)

3.1.5. [Objektdefinitionen-Dateien](config.md#objectdefinitionfiles)

3.1.6. [CGI-Konfigurationsdatei](config.md#cgiconfigfile)

### 3.1.1. Einführung

Es gibt verschiedene Konfigurationsdateien, die Sie erstellen oder
editieren müssen, bevor Sie irgendetwas überwachen können. Haben Sie
Geduld! Icinga zu konfigurieren kann eine Weile dauern, besonders wenn
Sie ein Neuling sind. Sobald Sie herausgefunden haben, wie die Dinge
funktionieren, werden Sie feststellen, dass es die Mühe wert ist. :-)

![[Anmerkung]](../images/note.png)

Anmerkung

Beispiel-Konfigurationsdateien werden im
*/usr/local/icinga/etc/*-Verzeichnis installiert, wenn Sie der
[Schnellstart-Installationsanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
folgen.

Falls Sie ein Paket installiert haben, dann fehlen die Beispieldateien
möglicherweise. Sie finden den Inhalt
[hier](sample-config.md "13.1. Beispielkonfigurationsdateien und Definitionen")
zum Nachschlagen.

![](../images/configoverview.png)

### 3.1.2. Dateinamen

Die Namen und Positionen dieser Konfigurationsdateien können von Ihnen
nach Belieben festgelegt werden, aber es hat sich eingebürgert, die
Dateien `icinga.cfg`{.filename}, `resource.cfg`{.filename} und
`cgi.cfg`{.filename} im Hauptkonfigurationsverzeichnis abzulegen.

Die Namen der Objektdefinitionsdaten können den Typ der Definitionen
enthalten (`contacts.cfg, commands.cfg`{.filename},
`timeperiods.cfg`{.filename}, `notifications.cfg`{.filename}), den Typ
der Hardware (`printer.cfg`{.filename}, `switch.cfg`{.filename}) oder
das zu beschreibende Objekt (`localhost.cfg`{.filename}). Wenn Ihre
Installation keine dieser Dateien enthält, dann ist das kein Grund zur
Panik. Wenn Sie ein web-basiertes Konfigurations-Tool, ein
datenbankgetriebenes Script, oder Ihren bevorzugten Editor benutzen,
dann können die Dateien pro geographischer Lage (Land, Filiale, ...) in
separaten Verzeichnissen abgelegt sein mit einer Datei pro physischer
oder logischer Einheit (Raum, Rack, Applikation, Entwicklung, ...) oder
abhängig vom Konzept, das für Sie am besten geeignet ist.

### 3.1.3. Hauptkonfigurationsdatei

Die Hauptkonfigurationsdatei enthält eine Reihe von Direktiven, die die
Arbeitsweise des Icinga-Daemon beeinflussen. Diese Konfigurationsdatei
wird vom Icinga-Daemon und den CGIs gelesen. Hier werden Sie in Ihr
Konfigurationsabenteuer starten wollen.

Dokumentation zur Hauptkonfigurationsdatei finden Sie
[hier](configmain.md "3.2. Optionen der Hauptkonfigurationsdatei").

### 3.1.4. Ressource-Datei(en)

Ressource-Dateien können zur Speicherung von benutzerdefinierten Makros
genutzt werden. Der Hauptgrund für Ressource-Dateien liegt darin, dass
sie genutzt werden können, um sensible Informationen (wie z.B.
Passworte) zu speichern, ohne dass sie für CGIs zugänglich sind, weil
diese Dateien nicht von den CGIs gelesen werden.

Sie können eine oder mehrere optionale Ressource-Dateien mit Hilfe der
[resource\_file](configmain.md#configmain-resource_file)-Direktive in
Ihrer Hauptkonfigurationsdatei angeben.

### 3.1.5. Objektdefinitionen-Dateien

Objektdefinitionen-Dateien werden genutzt, um Hosts, Services,
Hostgruppen, Kontakte, Kontaktgruppen, Befehle usw. zu definieren. Hier
definieren Sie, welche Dinge Sie überwachen wollen und wie Sie diese
überwachen wollen.

Sie können eine oder mehrere Objektdefinitionen-Dateien mit Hilfe der
[cfg\_file](configmain.md#configmain-cfg_file)- und/oder
[cfg\_dir](configmain.md#configmain-cfg_dir)-Direktiven in Ihrer
Hauptkonfigurationsdatei angeben, aber es wird empfohlen lediglich eine
der beiden Direktiventypen zu nutzen (also *entweder* cfg\_dir *oder*
cfg\_file bis Sie die Auswirkungen verstanden haben, wenn Sie beide
*gleichzeitig* verwenden).

Eine Einführung zu Objektdefinitionen und wie sie in Beziehung zu
einander stehen, finden Sie
[hier](configobject.md "3.3. Überblick Objektkonfiguration").

Ihre Objektkonfigurationsdateien können wiederum andere Dateien
einschließen mit Hilfe der
[include\_file](configobject.md#configobject-include_file)- oder
[include\_dir](configobject.md#configobject-include_dir)-Direktiven.
Sie können lediglich außerhalb der eigentlichen Objektdefinitionen
auftreten und verhalten sich analog zu den
[cfg\_file=](configmain.md#configmain-cfg_file)- und
[cfg\_dir=](configmain.md#configmain-cfg_dir)-Direktiven in der
Hauptkonfigurationsdatei.

### 3.1.6. CGI-Konfigurationsdatei

Die CGI-Konfigurationsdatei enthält eine Reihe von Direktiven, die die
Arbeitsweise der
[CGIs](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module")
beeinflussen. Sie enthält auch einen Verweis auf die
Hauptkonfigurationsdatei, so dass die CGIs wissen, wie Sie Icinga
konfiguriert haben und wo Ihre Objektdefinitionen gespeichert sind.

Dokumentation zur CGI-Konfigurationsdatei finden Sie
[hier](configcgi.md "3.6. Optionen CGI-Konfigurationsdatei").

* * * * *

  ---------------------------------- -------------------------- ---------------------------------------------
  [Zurück](ch03.md)                [Nach oben](ch03.md)      [Weiter](configmain.md)
  Kapitel 3. Icinga konfigurieren    [Zum Anfang](index.md)    3.2. Optionen der Hauptkonfigurationsdatei
  ---------------------------------- -------------------------- ---------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
