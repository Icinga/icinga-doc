![Icinga](../images/logofullsize.png "Icinga")

3.2. Optionen der Hauptkonfigurationsdatei

[Zurück](config.md) 

Kapitel 3. Icinga konfigurieren

 [Weiter](configobject.md)

* * * * *

3.2. Optionen der Hauptkonfigurationsdatei
------------------------------------------

**Anmerkungen**

Bei der Erstellung und/oder Änderung von Konfigurationsdateien sollten
Sie folgendes beachten:

1.  Zeilen, die mit einem '\#'-Zeichen beginnen, werden als Kommentar
    angesehen und nicht verarbeitet

2.  Variablennamen müssen am Anfang der Zeile beginnen - "White space"
    vor dem Namen sind nicht erlaubt

3.  Variablennamen sind abhängig von Groß- und Kleinschreibung
    (case-sensitive)

**Beispiel-Konfigurationsdatei**

![](../images/tip.gif) Hinweis: eine Beispiel-Hauptkonfigurationsdatei
(*/usr/local/icinga/etc/icinga.cfg*) wird installiert, wenn Sie der
[Schnellstartanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
folgen.

**Position der Konfigurationsdatei**

Die Hauptkonfigurationsdatei heißt üblicherweise *icinga.cfg* und ist im
*/usr/local/icinga/etc/*-Verzeichnis zu finden.

**Variablen der Konfigurationsdatei**

Nachfolgend finden Sie Beschreibungen jeder Option der
Icinga-Hauptkonfigurationsdatei...

**Protokolldatei** (Log File)

Format:

**log\_file=\<file\_name\>**

Beispiel:

**log\_file=/usr/local/icinga/var/icinga.log**

Diese Variable gibt an, wo Icinga die Hauptprotokolldatei anlegen soll.
Dies sollte die erste Variable sein, die Sie in Ihrer
Konfigurationsdatei definieren, weil Icinga versucht, dorthin die Fehler
zu schreiben, die es in den übrigen Konfigurationsdaten findet. Wenn Sie
[Log-Rotation](configmain.md#configmain-log_rotation_method) aktiviert
haben, dann wird diese Datei automatisch jede Stunde, jeden Tag, jede
Woche oder jeden Monat rotiert.

**Objektkonfigurationsdatei** (Object Configuration File)

Format:

**cfg\_file=\<file\_name\>**

Beispiel:

**cfg\_file=/usr/local/icinga/etc/conf.d/hosts.cfg**

**cfg\_file=/usr/local/icinga/etc/conf.d/services.cfg**

**cfg\_file=/usr/local/icinga/etc/commands.cfg**

Diese Direktive wird benutzt, um eine
[Objektkonfigurationsdatei](configobject.md "3.3. Überblick Objektkonfiguration")
anzugeben, die Objektdefinitionen enthält, die Icinga zur Überwachung
nutzen soll. Objektkonfigurationsdateien enthalten Definitionen für
Hosts, Hostgruppen, Kontakte, Kontaktgruppe, Services, Befehle usw. Sie
können Ihre Konfigurationsinformationen in verschiedene Dateien
aufteilen und mehrere *cfg\_file=*-Einträge angeben, um jede einzelne zu
verarbeiten.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie `cfg_file=.../foo/bar.cfg`{.filename} für eine Datei benutzen,
die im gleichen Verzeichnis liegt, das Sie mit
`cfg_dir=.../foo`{.filename} angegeben haben, dann wird diese Datei
zweimal verarbeitet und führt dadurch zu einem Fehler bei der
Überprüfung der Konfigurationsdateien.

**Objektkonfigurationsverzeichnis** (Object Configuration Directory)

Format:

**cfg\_dir=\<directory\_name\>**

Beispiel:

**cfg\_dir=/usr/local/icinga/etc/conf.d**

Diese Direktive wird benutzt, um ein Verzeichnis anzugeben, das
[Objektkonfigurationsdateien](configobject.md "3.3. Überblick Objektkonfiguration")
enthält, die Icinga zur Überwachung nutzen soll. Alle Dateien in dem
Verzeichnis mit einer *.cfg*-Endung werden als
Objektkonfigurationsdateien verarbeitet. Zusätzlich wird Icinga rekursiv
alle Konfigurationsdateien in den Unterverzeichnissen des Verzeichnisses
verarbeiten, das Sie angegeben haben. Sie können Ihre
Konfigurationsinformationen in verschiedene Verzeichnisse aufteilen und
mehrere *cfg\_dir=*-Einträge angeben, um alle Konfigurationsdateien
jedes einzelnen Verzeichnisses zu verarbeiten.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie `cfg_file=.../foo/bar.cfg`{.filename} für eine Datei benutzen,
die im gleichen Verzeichnis liegt, das Sie mit
`cfg_dir=.../foo`{.filename} angegeben haben, dann wird diese Datei
zweimal verarbeitet und führt dadurch zu einem Fehler bei der
Überprüfung der Konfigurationsdateien.

**Objekt-Cache-Datei** (Object Cache File)

Format:

**object\_cache\_file=\<file\_name\>**

Beispiel:

**object\_cache\_file=/usr/local/icinga/var/objects.cache**

Diese Direktive wird benutzt, um eine Datei anzugeben, in der eine
zwischengespeicherte (cached) Kopie der
[Objektdefinitionen](configobject.md "3.3. Überblick Objektkonfiguration")
abgelegt wird. Die Cache-Datei wird jedes Mal (erneut) angelegt, wenn
Icinga (erneut) gestartet wird, und wird von den CGIs benutzt. Sie ist
dazu gedacht, die Zwischenspeicherung der Konfigurationsdateien in den
CGIs zu beschleunigen und es Ihnen zu erlauben, die
[Objektkonfigurationsdateien](configmain.md#configmain-cfg_file) zu
editieren, während Icinga läuft, ohne die Ausgaben der CGIs zu
beeinflussen.

**vorgespeicherte Objektdatei** (Precached Object File)

Format:

**precached\_object\_file=\<file\_name\>**

Beispiel:

**precached\_object\_file=/usr/local/icinga/var/objects.precache**

Diese Direktive wird benutzt, um eine Datei anzugeben, die eine
vorverarbeitete (pre-processed), vorgespeicherte (pre-cached) Kopie von
[Objektdefinitionen](configobject.md "3.3. Überblick Objektkonfiguration")
enthält. Diese Datei kann genutzt werden, um drastisch den Startvorgang
in großen/komplexen Icinga-Installationen zu beschleunigen. Lesen Sie
[hier](faststartup.md "8.4. Schnellstart-Optionen"), wie der
Startvorgang beschleunigt werden kann.

**Ressource-Datei** (Resource File)

Format:

**resource\_file=\<file\_name\>**

Beispiel:

**resource\_file=/usr/local/icinga/etc/resource.cfg**

Dies wird benutzt, um eine optionale Ressource-Datei anzugeben, die
\$USERn\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")-Definitionen
enthalten kann. \$USER\$-Makros sind sinnvoll zur Speicherung von
Benutzernamen, Passwörtern und Objekten, die häufig in
Befehlsdefinitionen (wie z.B. Verzeichnispfade) benutzt werden. Die CGIs
werden *nicht* versuchen, Ressource-Dateien zu lesen, so dass Sie die
Berechtigungen beschränken können (600 oder 660), um sensible
Informationen zu schützen. Sie können mehrere Ressource-Dateien angeben,
indem Sie mehrere resource\_file-Einträge in die
Hauptkonfigurationsdatei aufnehmen. Icinga wird sie alle verarbeiten.
Schauen Sie in die resource.cfg-Datei im
*sample-config/*-Unterverzeichnis der Icinga-Distribution, um ein
Beispiel für die Definition von \$USER\$-Makros zu sehen.

**temporäre Datei** (Temp File)

Format:

**temp\_file=\<file\_name\>**

Beispiel:

**temp\_file=/usr/local/icinga/var/icinga.tmp**

Dies ist eine temporäre Datei, die Icinga periodisch anlegt, wenn
Kommentardaten, Statusdaten usw. aktualisiert werden. Die Datei wird
gelöscht, wenn sie nicht länger benötigt wird.

**temporärer Pfad** (Temp Path)

Format:

**temp\_path=\<dir\_name\>**

Beispiel:

**temp\_path=/tmp**

Dies ist ein Verzeichnis, das Icinga als "Schmierblock" (scratch space)
benutzen kann, um während des Überwachungsprozesses temporäre Dateien
anlegen zu können. Sie sollten *tmpwatch* oder ein ähnliches Programm
ausführen, um in diesem Verzeichnis Dateien zu löschen, die älter als 24
Stunden sind.

**Status-Datei** (Status File)

Format:

**status\_file=\<file\_name\>**

Beispiel:

**status\_file=/usr/local/icinga/var/status.dat**

Dies ist die Datei, die Icinga nutzt, um den aktuellen Zustand,
Kommentar- und Ausfallzeitinformationen zu speichern. Diese Datei wird
von den CGIs genutzt, so dass der aktuelle Überwachungszustand über ein
Web-Interface berichtet werden kann. Die CGIs müssen Lesezugriff auf
diese Datei haben, um richtig funktionieren zu können. Diese Datei wird
jedes Mal gelöscht, wenn Icinga endet und neu angelegt, wenn Icinga
startet.

**Statusdatei-Aktualisierungsintervall** (Status File Update Interval)

Format:

**status\_update\_interval=\<seconds\>**

Beispiel:

**status\_update\_interval=15**

Diese Einstellung legt fest, wie oft (in Sekunden) Icinga Statusdaten in
der [Statusdatei](configmain.md#configmain-status_file) aktualisiert.
Das kleinste Aktualisierungsintervall ist eine Sekunde.

**Icinga-Benutzer** (Icinga User)

Format:

**icinga\_user=\<username/UID\>**

Beispiel:

**icinga\_user=nagios**

Dies wird benutzt, um den "eigentlichen" (effective) Benutzer zu setzen,
mit dem der Icinga-Prozess laufen soll. Nach dem anfänglichen
Programmstart und bevor irgendeine Überwachung beginnt, wird Icinga die
vorhandenen Berechtigungen "fallen lassen" (drop) und als dieser
Benutzer laufen. Sie können entweder einen Benutzernamen oder eine UID
angeben.

**Icinga-Gruppe** (Icinga Group)

Format:

**icinga\_group=\<groupname/GID\>**

Beispiel:

**icinga\_group=nagios**

Dies wird benutzt, um die "eigentliche" (effective) Gruppe zu setzen,
mit der der Icinga-Prozess laufen soll. Nach dem anfänglichen
Programmstart und bevor irgendeine Überwachung beginnt, wird Icinga die
vorhandenen Berechtigungen "fallen lassen" (drop) und als diese Gruppe
laufen. Sie können entweder einen Gruppennamen oder eine GID angeben.

**Benachrichtigungsoption** (Notifications Option)

Format:

**enable\_notifications=\<0/1\>**

Beispiel:

**enable\_notifications=1**

Diese Option legt fest, ob Icinga
[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")
versendet. Wenn diese Optionen deaktiviert ist, wird Icinga nach dem
(Neu-) Start keine Benachrichtigungen für irgendeinen Host oder Service
versenden. Anmerkung: Wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = Benachrichtigungen deaktivieren

-   1 = Benachrichtigungen aktivieren (Default)

**Option Service-Prüfungen ausführen** (Service Check Execution Option)

Format:

**execute\_service\_checks=\<0/1\>**

Beispiel:

**execute\_service\_checks=1**

Diese Option legt fest, ob Icinga nach dem (Neu-) Start
Service-Prüfungen ausführt. Wenn diese Option deaktiviert ist, wird
Icinga nicht aktiv irgendwelche Service-Prüfungen ausführen und in einer
Art von "Schlafmodus" verbleiben (es kann weiterhin [passive
Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
empfangen, es sei denn, Sie haben [diese
deaktiviert](configmain.md#configmain-accept_passive_service_checks)).
Diese Option wird oft benutzt, wenn Ersatz-Überwachungs-Server (backup
monitoring server) konfiguriert werden, wie dies in der Dokumentation zu
[Redundanz](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")
beschrieben ist, oder wenn Sie eine
[verteilte](distributed.md "7.6. Verteilte Überwachung")-Überwachungsumgebung
aufbauen. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = keine Service-Prüfungen ausführen

-   1 = Service-Prüfungen ausführen (Default)

**Option passive Service-Prüfungen akzeptieren** (Passive Service Check
Acceptance Option)

Format:

**accept\_passive\_service\_checks=\<0/1\>**

Beispiel:

**accept\_passive\_service\_checks=1**

Diese Option legt fest, ob Icinga nach dem (Neu-) Start [passive
Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
akzeptiert. Wenn diese Option deaktiviert ist, wird Icinga keine
passiven Service-Prüfungen akzeptieren. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = keine passiven Service-Prüfungen akzeptieren

-   1 = passive Service-Prüfungen akzeptieren (Default)

**Option Host-Prüfungen ausführen** (Host Check Execution Option)

Format:

**execute\_host\_checks=\<0/1\>**

Beispiel:

**execute\_host\_checks=1**

Diese Option legt fest, ob Icinga nach dem (Neu-) Start nach Bedarf oder
regelmäßig geplante Host-Prüfungen ausführt. Wenn diese Option
deaktiviert ist, wird Icinga nicht aktiv irgendwelche Host-Prüfungen
ausführen, obwohl es weiterhin [passive
Host-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
empfangen wird, es sei denn, Sie haben [diese
deaktiviert](configmain.md#configmain-accept_passive_host_checks)).
Diese Option wird am meisten genutzt, wenn Ersatz-Überwachungs-Server
(backup monitoring server) konfiguriert werden, wie dies in der
Dokumentation zu
[Redundanz](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")
beschrieben ist, oder wenn Sie eine
[verteilte](distributed.md "7.6. Verteilte Überwachung")-Überwachungsumgebung
aufbauen. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = keine Host-Prüfungen ausführen

-   1 = Host-Prüfungen ausführen (Default)

**Option passive Host-Prüfungen akzeptieren** (Passive Host Check
Acceptance Option)

Format:

**accept\_passive\_host\_checks=\<0/1\>**

Beispiel:

**accept\_passive\_host\_checks=1**

Diese Option legt fest, ob Icinga nach dem (Neu-) Start [passive
Host-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
akzeptiert. Wenn diese Option deaktiviert ist, wird Icinga keine
passiven Host-Prüfungen akzeptieren. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = keine passiven Host-Prüfungen akzeptieren

-   1 = passive Host-Prüfungen akzeptieren (Default)

**Eventhandler-Option** (Event Handler Option)

Format:

**enable\_event\_handlers=\<0/1\>**

Beispiel:

**enable\_event\_handlers=1**

Diese Option legt fest, ob Icinga nach dem (Neu-) Start
[Eventhandler](eventhandlers.md "7.3. Eventhandler") ausführt. Wenn
diese Option deaktiviert ist, wird Icinga keine Host- oder
Service-Eventhandler ausführen. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](configmain.md#configmain-retain_state_information)
(retain state information) aktiviert haben, wird Icinga diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern. Die Werte sind wie folgt:

-   0 = Eventhandler deaktivieren

-   1 = Eventhandler aktivieren (Default)

**Protokollrotationsmethode** (Log Rotation Method)

Format:

**log\_rotation\_method=\<n/h/d/w/m\>**

Beispiel:

**log\_rotation\_method=d**

Dies ist die Rotationsmethode, die Icinga für Ihre Protokolldatei nutzen
soll. Die Werte sind wie folgt:

-   n = keine ("none" - die Protokolldatei nicht rotieren, das ist der
    Standard)

-   h = stündlich ("hourly" - die Protokolldatei jede volle Stunde
    rotieren)

-   d = täglich ("daily" - die Protokolldatei jeden Tag um Mitternacht
    rotieren)

-   w = wöchentlich ("weekly" - die Protokolldatei jeden Samstag um
    Mitternacht rotieren)

-   m = monatlich ("monthly" - die Protokolldatei am letzten Tag des
    Monats um Mitternacht rotieren)

**Protokollarchiv-Pfad** (Log Archiv Path)

Format:

**log\_archive\_path=\<path\>**

Beispiel:

**log\_archive\_path=/usr/local/icinga/var/archives/**

Dies ist das Verzeichnis, in dem Icinga die Protokolldateien ablegen
soll, die rotiert wurden. Diese Option wird ignoriert, wenn Sie die
Funktionalität der
[Protokollrotation](configmain.md#configmain-log_rotation_method) (log
rotation) nicht nutzen.

**Protokollierungsoptionen des Daemons** (LOGGING OPTIONS FOR DAEMON)

Format:

**use\_daemon\_log=\<0/1\>**

Beispiel:

**use\_daemon\_log=1**

Mit dieser Option können Sie die Protokollierung des Log-Daemons in die
Protokolldatei (normalerweise icinga.log) ein- und abschalten.

-   0 = keine Protokollierung

-   1 = Protokollierung (Default)

**Option externe Befehle prüfen** (External Command Check Option)

Format:

**check\_external\_commands=\<0/1\>**

Beispiel:

**check\_external\_commands=1**

Diese Option legt fest, ob Icinga das [command
file](configmain.md#configmain-command_file) auf auszuführende Befehle
prüfen soll. Diese Option muss aktiviert sein, wenn Sie planen, das
[Command-CGI](cgis.md#cgis-cmd_cgi) zu nutzen, um Befehle über das
Web-Interface zu erteilen. Icinga Web und Addons wie NagVis, Nagios
Checker, Nagstamon oder auch NagiosQL nutzen ebenfalls das Icinga
Command File um Befehle an Icinga zu senden. Mehr Informationen zu
externen Befehlen finden Sie
[hier](extcommands.md "7.1. Externe Befehle").

-   0 = nicht auf externe Befehle prüfen

-   1 = auf externe Befehle prüfen (Default)

**Prüfintervall externe Befehle** (External Command Check Interval)

Format:

**command\_check\_interval=\<xxx\>[s]**

Beispiel:

**command\_check\_interval=1**

Wenn Sie eine Zahl mit einem angehängten "s" angeben (z.B. 30s), dann
ist dies die Zahl in *Sekunden*, die zwischen Prüfungen auf externe
Befehle gewartet werden soll. Wenn Sie das "s" weglassen, ist dies die
Zahl von "Zeiteinheiten", die zwischen den Prüfungen auf externe Befehle
gewartet werden soll. Solange Sie nicht den Standardwert (60) der
[interval\_length](configmain.md#configmain-interval_length)-Direktive
geändert haben (wie weiter unten definiert), bedeutet dieser Wert
Minuten.

![[Anmerkung]](../images/note.png)

Anmerkung

Icinga prüft auch nach der Ausführung von Event-Handlern auf externe
Befehle.

Anmerkung: durch das Setzen dieses Wertes auf **-1** wird Icinga so oft
wie möglich auf externe Befehle prüfen. Jedes Mal, wenn Icinga auf
externe Befehle prüft, wird es alle im [command
file](configmain.md#configmain-command_file) befindlichen Befehle
lesen und verarbeiten, bevor es mit anderen Aufgaben fortfährt. Mehr
Informationen zu externen Befehlen finden Sie
[hier](extcommands.md "7.1. Externe Befehle").

**externe Befehlsdatei** (External Command File)

Format:

**command\_file=\<file\_name\>**

Beispiel:

**command\_file=/usr/local/icinga/var/rw/icinga.cmd**

Dies ist die Datei, die Icinga auf zu verarbeitende externe Befehle
prüfen wird. Das [Command-CGI](cgis.md#cgis-cmd_cgi), Icinga Web und
diverse Addons schreiben Befehle in diese Datei. Die externe
Befehlsdatei ist als "named pipe" (FIFO) implementiert, die beim Start
von Icinga angelegt und beim Herunterfahren wieder gelöscht wird. Wenn
die Datei beim Start von Icinga existiert, wird der Icinga-Prozess mit
einer Fehlermeldung enden. Mehr Informationen zu externen Befehlen
finden Sie [hier](extcommands.md "7.1. Externe Befehle").

**externe Befehlspuffer-Slots** (External Command Buffer Slots)

Format:

**external\_command\_buffer\_slots=\<n\>**

Beispiel:

**external\_command\_buffer\_slots=512**

Anmerkung: dies ist ein fortgeschrittenes Feature. Diese Option legt
fest, wie viele Puffer-Slots Icinga für die Zwischenspeicherung von
externen Befehlen reserviert, die von einem "worker thread" aus der
externen Befehlsdatei gelesen, aber noch nicht vom "main thread" des
Icinga-Daemons verarbeitet wurden. Jeder Slot kann einen externen Befehl
enthalten, so dass diese Option im Wesentlichen bestimmt, wie viele
Befehle gepuffert werden können. Bei Installationen, wo Sie eine große
Zahl von passiven Prüfungen verarbeiten (z.B. [verteilten
Setups](distributed.md "7.6. Verteilte Überwachung")), müssen Sie ggf.
diese Zahl erhöhen. Sie sollten den Einsatz von PNP4Nagios erwägen, um
die Nutzung der externen Befehlspuffer grafisch darzustellen. Mehr zur
Konfiguration der grafischen Darstellung finden Sie
[hier](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios").

**Sperrdatei** (Lock File)

Format:

**lock\_file=\<file\_name\>**

Beispiel:

**lock\_file=/tmp/icinga.lock**

Diese Option gibt die Position der Sperrdatei an, die Icinga anlegen
sollte, wenn es als Daemon läuft (wenn es mit der -d
Kommandozeilenoption gestartet wurde). Diese Datei enthält die
Prozess-ID (PID) des laufenden Icinga-Prozesses.

**Statusaufbewahrungsoption** (State Retention Option)

Format:

**retain\_state\_information=\<0/1\>**

Beispiel:

**retain\_state\_information=1**

Diese Option legt fest, ob Icinga Statusinformationen für Hosts und
Services zwischen Programmneustarts aufbewahren soll. Wenn Sie diese
Option aktivieren, sollten Sie ein Wert für die
[state\_retention\_file](configmain.md#configmain-state_retention_file)-Variable
angeben. Wenn sie aktiviert ist, wird Icinga alle Statusinformationen
für Hosts und Services sichern, bevor es beendet (oder neu gestartet)
wird und vorher gespeicherte Statusinformationen einlesen, wenn es neu
gestartet wird.

-   0 = Statusinformationen nicht aufbewahren

-   1 = Statusinformationen aufbewahren (Default)

**Statusaufbewahrungsdatei** (State Retention File)

Format:

**state\_retention\_file=\<file\_name\>**

Beispiel:

**state\_retention\_file=/usr/local/icinga/var/retention.dat**

Dies ist die Datei, die Icinga für die Speicherung von Status-,
Ausfallzeit- und Kommentarinformationen nutzt, bevor es endet. Wenn
Icinga neu startet, wird es die in dieser Datei gespeicherten
Informationen nutzen, um die anfänglichen Zustände von Services und
Hosts zu setzen, bevor es mit der Überwachung beginnt. Damit Icinga
Statusinformationen zwischen Programmneustarts aufbewahrt, müssen Sie
die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Option
aktivieren.

**Sync-Aufbewahrungsdatei** (Sync Retention File)

Format:

**sync\_retention\_file=\<file\_name\>**

Beispiel:

**sync\_retention\_file=/usr/local/icinga/var/retention.dat**

Dies ist eine fortgeschrittene Option, die wie state\_retention\_file
arbeitet, so dass Sie eine Untermenge von Aufbewahrungsinformationen wie
Status, Bestätigung, Ausfallzeiten und Kommentaren laden können (Sie
müssen den Inhalt dieser Datei außerhalb von Icinga erstellen). Wenn
Icinga erneut gestartet wird, liest es die Informationen aus der durch
sync\_retention\_file definierten Datei und aktualisiert den angegebenen
Host oder Service, *wenn die Last\_update-Zeit in der Sync-Datei neuer
ist* als in der state\_retention\_file-Datei, anderenfalls wird die
Information ignoriert. Nach dem Lesen der Datei wird diese gelöscht. Um
die Option zu deaktivieren, kommentieren Sie sie aus.

**automatisches Statusaufbewahrungs-Aktualisierungsintervall**
(Automatic State Retention Update Interval)

Format:

**retention\_update\_interval=\<minutes\>**

Beispiel:

**retention\_update\_interval=60**

Diese Einstellung legt fest, wie oft (in Minuten) Icinga automatisch
während des normalen Betriebs die Aufbewahrungsdaten aktualisiert. Wenn
Sie einen Wert von Null angeben, wird Icinga nicht in regelmäßigen
Intervallen die Aufbewahrungsdaten sichern, aber es wird die
Aufbewahrungsdaten vor der Beendigung oder dem Neustart sichern. Wenn
Sie die Statusaufbewahrung deaktiviert haben (mit der
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Option),
hat diese Option keine Auswirkung.

**Option aufbewahrten Programmzustand nutzen** (Use Retained Program
State Option)

Format:

**use\_retained\_program\_state=\<0/1\>**

Beispiel:

**use\_retained\_program\_state=1**

Diese Einstellung legt fest, ob Icinga verschiedene programmweite
Statusvariablen auf Basis der Aufbewahrungsdatei setzen soll. Einige
dieser programmweiten Statusvariablen, die normalerweise über
Programmstarts hinweg gesichert werden, wenn Statusaufbewahrung
aktiviert ist, umfassen die
[enable\_notifications](configmain.md#configmain-enable_notifications)-,
[enable\_flap\_detection](configmain.md#configmain-enable_flap_detection)-,
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)-,
[execute\_service\_checks](configmain.md#configmain-execute_service_checks)-
und
[accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)-Optionen.
Wenn Sie
[Statusaufbewahrung](configmain.md#configmain-retain_state_information)
deaktiviert haben, hat diese Option keine Auswirkung.

-   0 = keinen aufbewahrten Programmzustand nutzen

-   1 = aufbewahrten Programmzustand nutzen (Default)

**Option Weitergabe der Statusinformationen an Neb-Module** (Dump
Retained Host Service States To Neb Option)

Format:

**dump\_retained\_host\_service\_states\_to\_neb=\<0/1\>**

Beispiel:

**dump\_retained\_host\_service\_states\_to\_neb=0**

Diese Einstellung legt fest, ob Icinga die in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
gespeicherten Statusinformationen der Host- und Services an die
NEB-Module weitergibt. Wenn Sie das nicht wünschen, deaktivieren Sie
diese Option auf Ihr eigenes Risiko.

-   0 = Statusinformationen nicht weitergeben (default in 1.10+)

-   1 = Statusinformationen weitergeben

**Option aufbewahrte Planungsinformationen nutzen** (Use Retained
Scheduling Info Option)

Format:

**use\_retained\_scheduling\_info=\<0/1\>**

Beispiel:

**use\_retained\_scheduling\_info=1**

Diese Einstellung legt fest, ob Icinga Planungsinformationen für Hosts
und Services aufbewahrt, wenn es neu startet. Wenn Sie eine große Zahl
(oder einen großen Anteil) von Hosts oder Services hinzufügen, empfehlen
wir diese Option zu deaktivieren, wenn Sie das erste Mal Icinga neu
starten, weil es nachteilig die Verteilung von initialen Prüfungen
beeinflussen kann. Andernfalls werden Sie diese Option wahrscheinlich
aktiviert lassen.

-   0 = keine aufbewahrten Planungsinformationen nutzen

-   1 = aufbewahrten Planungsinformationen nutzen (Default)

**aufbewahrte Host- und Service-Attributmasken** (Retained Host and
Service Attribute Masks)

Format:

**retained\_host\_attribute\_mask=\<number\>**

**retained\_service\_attribute\_mask=\<number\>**

Beispiel:

**retained\_host\_attribute\_mask=0**

**retained\_service\_attribute\_mask=0**

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
Icinga-Quellcode lesen, um diese Option effizient nutzen zu können.

Diese Option legt fest, welche Host- oder Service-Attribute NICHT über
Programmneustarts hinweg aufbewahrt werden. Die Werte für diese Optionen
sind ein bitweises AND der durch die "MODATTR\_"-Definitionen
angegebenen Werte in den include/common.h-Quellcode-Dateien. Per Default
werden alle Host- und Service-Attribute aufbewahrt.

**aufbewahrte Prozessattributmasken** (Retained Process Attribute Masks)

Format:

**retained\_process\_host\_attribute\_mask=\<number\>**

**retained\_process\_service\_attribute\_mask=\<number\>**

Beispiel:

**retained\_process\_host\_attribute\_mask=0**

**retained\_process\_service\_attribute\_mask=0**

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
Icinga-Quellcode lesen, um diese Option effizient nutzen zu können.

Diese Option legt fest, welche Prozessattribute NICHT über
Programmneustarts hinweg aufbewahrt werden. Es gibt zwei Masken, weil es
oft separate Host- und Service-Prozessattribute gibt, die geändert
werden können. Beispielsweise können Host-Prüfungen auf Programmebene
deaktiviert werden, während Service-Prüfungen weiterhin aktiviert sind.
Die Werte für diese Optionen sind ein bitweises AND der durch die
"MODATTR\_"-Definitionen angegebenen Werte in den
include/common.h-Quellcode-Dateien. Per Default werden alle
Prozessattribute aufbewahrt.

**aufbewahrte Kontaktattributmasken** (Retained Contact Attribute Masks)

Format:

**retained\_contact\_host\_attribute\_mask=\<number\>**

**retained\_contact\_service\_attribute\_mask=\<number\>**

Beispiel:

**retained\_contact\_host\_attribute\_mask=0**

**retained\_contact\_service\_attribute\_mask=0**

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
Icinga-Quellcode lesen, um diese Option effizient nutzen zu können.

Diese Option legt fest, welche Kontaktattribute NICHT über
Programmneustarts hinweg aufbewahrt werden. Es gibt zwei Masken, weil es
oft separate Host- und Service-Prozessattribute gibt, die geändert
werden können. Die Werte für diese Optionen sind ein bitweises AND der
durch die "MODATTR\_"-Definitionen angegebenen Werte in den
include/common.h-Quellcode-Dateien. Per Default werden alle
Kontaktattribute aufbewahrt.

**Syslog-Protokollierungsoption** (Syslog Logging Option)

Format:

**use\_syslog=\<0/1\>**

Beispiel:

**use\_syslog=1**

Diese Variable legt fest, ob Meldungen im Syslog des lokalen Hosts
protokolliert werden sollen. Die Werte sind wie folgt:

-   0 = Syslog nicht nutzen

-   1 = Syslog nutzen [Default]

**Syslog Local Facility Option**

Format:

**use\_syslog\_local\_facility=\<0/1\>**

Beispiel:

**use\_syslog\_local\_facility=1**

Wenn Sie use\_syslog aktiviert haben, dann können Sie Icinga anweisen,
eine local-Facility zu benutzen statt des Defaults. Werte sind wie
folgt:

-   0 = Syslog Local Facility nicht nutzen

-   1 = Syslog Local Facility benutzen

**Syslog Local Facility Wert**

Format:

**syslog\_local\_facility=\<0|1|2|3|4|5|6|7\>**

Beispiel:

**syslog\_local\_facility=1**

Wenn Sie use\_syslog\_local\_facility aktiviert haben, können Sie
auswählen, welche Local-Facility benutzt werden soll. Gültige Werte sind
von 0 bis 7.

**Benachrichtigungsprotokollierungsoption** (Notification Logging
Option)

Format:

**log\_notifications=\<0/1\>**

Beispiel:

**log\_notifications=1**

Diese Variable legt fest, ob Benachrichtungsmeldungen protokolliert
werden. Wenn Sie eine Menge von Kontakten oder ständigen
Service-Ausfällen haben, dann wird Ihre Protokolldatei relativ schnell
wachsen. Benutzen Sie diese Option, um die Protokollierung von
(Kontakt-)Benachrichtigungen zu verhindern.

-   0 = keine Benachrichtigungen protokollieren

-   1 = Benachrichtigungen protokollieren [Default]

**Option Service-Wiederholungsprüfungen protokollieren** (Service Check
Retry Logging Option)

Format:

**log\_service\_retries=\<0/1\>**

Beispiel:

**log\_service\_retries=1**

Diese Variable legt fest, ob Service-Wiederholungsprüfungen
protokolliert werden. Service-Wiederholungsprüfungen treten auf, wenn
ein Service-Prüfergebnis einen nicht-OK-Status ergibt, Sie Icinga aber
so konfiguriert haben, dass die Prüfung mehr als einmal wiederholt wird,
bevor ein Fehler gemeldet wird. Services in diesem Zustand befinden sich
in einem "Soft"-Status. Die Protokollierung von
Service-Wiederholungsprüfungen ist meist dann sinnvoll, wenn Sie
versuchen, Icinga zu debuggen, oder
Service-[Eventhandler](eventhandlers.md "7.3. Eventhandler") zu
testen.

-   0 = keine Service-Wiederholungsprüfungen protokollieren [Default-H]

-   1 = Service-Wiederholungsprüfungen protokollieren [Default-C]

**Option Host-Wiederholungsprüfungen-protokollieren** (Host Check Retry
Logging Option)

Format:

**log\_host\_retries=\<0/1\>**

Beispiel:

**log\_host\_retries=1**

Diese Variable legt fest, ob Host-Wiederholungsprüfungen protokolliert
werden. Die Protokollierung von Host-Wiederholungsprüfungen ist meist
dann sinnvoll, wenn Sie versuchen, Icinga zu debuggen, oder
Host-[Eventhandler](eventhandlers.md "7.3. Eventhandler") zu testen.

-   0 = keine Host-Wiederholungsprüfungen protokollieren [Default-H]

-   1 = Host-Wiederholungsprüfungen protokollieren [Default-C]

**Option Eventhandler-protokollieren** (Event Handler Logging Option)

Format:

**log\_event\_handlers=\<0/1\>**

Beispiel:

**log\_event\_handlers=1**

Diese Variable legt fest, ob Service- und
Host-[Eventhandlers](eventhandlers.md "7.3. Eventhandler")
protokolliert werden. Eventhandler sind optionale Befehle, die
ausgeführt werden können, wenn sich der Zustand eines Hosts oder Service
ändert. Die Protokollierung von Eventhandlern ist meist dann sinnvoll,
wenn Sie versuchen, Icinga zu debuggen, oder Ihre
[Eventhandler](eventhandlers.md "7.3. Eventhandler")-Scripts zu
testen.

-   0 = Eventhandler nicht protokollieren

-   1 = Eventhandler protokollieren [Default]

**Option initiale Zustände protokollieren** (Initial States Logging
Option)

Format:

**log\_initial\_states=\<0/1\>**

Beispiel:

**log\_initial\_states=1**

Diese Variable legt fest, ob Icinga alle anfänglichen Host- und
Service-Zustände protokolliert, selbst wenn sie in einem OK-Zustand
sind. Anfängliche Service- und Host-Zustände werden normalerweise nur
dann protokolliert, wenn es bei der ersten Prüfung ein Problem gibt. Die
Aktivierung dieser Option ist sinnvoll, wenn Sie eine Applikation
benutzen, die die Protokolldatei abfragt, um
Langzeit-Zustandsstatistiken für Services und Hosts zu erstellen.

-   0 = keine anfänglichen Zustände protokollieren (Default)

-   1 = anfängliche Zustände protokollieren

**Option externe Befehle protokollieren** (External Command Logging
Option)

Format:

**log\_external\_commands=\<0/1\>**

Beispiel:

**log\_external\_commands=1**

Diese Variable legt fest, ob Icinga [externe
Befehle](extcommands.md "7.1. Externe Befehle") protokolliert, die es
aus der [externen Befehlsdatei](configmain.md#configmain-command_file)
erhält. Anmerkung: diese Option kontrolliert nicht, ob [passive
Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
(die eine Art von externen Befehlen sind) protokolliert werden. Zur
Aktivierung oder Deaktivierung der Protokollierung von passiven
Prüfungen nutzen Sie die
[log\_passive\_checks](configmain.md#configmain-log_passive_checks)-Option.

-   0 = keine externen Befehle protokollieren

-   1 = externe Befehle protokollieren (Default)

**Option Benutzer von externen Kommandos protokollieren**

Format:

**log\_external\_commands\_user=\<0/1\>**

Beispiel:

**log\_external\_commands\_user=1**

Diese Option erlaubt es Ihnen, den Namen des Benutzers zu
protokollieren, der aktuell externe Kommandos ausführt. Anstatt
CMD;cmdargs wird nun CMD;username;cmdargs in die Log-Datei geschrieben,
wenn die externe Applikation das korrekt sendet. Weil dies die
Kompatibilität mit bestehenden Log-Parsern gefährdet, ist diese Option
per Default deaktiviert.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist ab Icinga 1.4 veraltet, weil Sie nun die Direktive
[use\_logging](configcgi.md#configcgi-use_logging) benutzen können, um
CGI-Befehle zu protokollieren.

-   0 = Den Namen des aktuellen Benutzers von externen Kommandos nicht
    protokollieren (default)

-   1 = Den Namen des aktuellen Benutzers von externen Kommandos
    protokollieren

**Option passive Prüfungen protokollieren** (Passive Check Logging
Option)

Format:

**log\_passive\_checks=\<0/1\>**

Beispiel:

**log\_passive\_checks=1**

Diese Variable legt fest, ob Icinga [passive Host- und
Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
protokolliert, die es von der [externen
Befehlsdatei](configmain.md#configmain-command_file) bekommt. Wenn Sie
eine [verteilte
Überwachungsumgebung](distributed.md "7.6. Verteilte Überwachung")
aufbauen oder planen, eine große Zahl von passiven Prüfungen auf einer
regelmäßigen Basis zu behandeln, dann können Sie diese Option
deaktivieren, damit Ihre Protokolldatei nicht zu groß wird.

-   0 = keine passiven Prüfungen protokollieren

-   1 = passive Prüfungen protokollieren (Default)

**Option Aktuelle Zustände protokollieren**

Format:

**log\_current\_states=\<0/1\>**

Beispiel:

**log\_current\_states=1**

Diese Variable legt fest, ob Icinga die aktuellen Host- und
Service-Zustände nach einer Log-Datei-Rotation protokolliert. Wenn Sie
den Wert von log\_current\_states auf 0 setzen, werden die aktuellen
Zustände nach einer Rotation der Log-Datei nicht protokolliert.

-   0 = die aktuellen Host- und Service-Zustände nicht protokollieren

-   1 = die aktuellen Host- und Service-Zustände protokollieren
    (Default)

**Option langen Plugin-Output protokollieren**

Format:

**log\_long\_plugin\_output=\<0/1\>**

Beispiel:

**log\_long\_plugin\_output=1**

Diese Variable legt fest, ob Icinga die komplette Ausgabe von Plugin
(und nicht nur die erste Zeile) protokolliert. Wenn Sie den Wert von
log\_long\_plugin\_output auf 1 setzen, werden die kompletten Ausgaben
von Plugins protokolliert.

-   0 = nur die erste Zeile von Plugin-Ausgaben protokollieren (Default)

-   1 = die kompletten Plugin-Ausgaben protokollieren

**globale Host-Eventhandler Option** (Global Host Event Handler Option)

Format:

**global\_host\_event\_handler=\<command\>**

Beispiel:

**global\_host\_event\_handler=log-host-event-to-db**

Diese Option erlaubt Ihnen, einen Host-Eventhandler-Befehl anzugeben,
der für jeden Host-Zustandswechsel ausgeführt wird. Der globale
Eventhandler wird direkt vor dem Eventhandler ausgeführt, den Sie
optional in jeder Host-Definition angeben können. Das *Befehls*-Argument
ist der Kurzname eines Befehls, den Sie in Ihrer
[Objektkonfigurationsdatei](configobject.md "3.3. Überblick Objektkonfiguration")
angeben. Die maximale Ausführungszeit dieses Befehls kann durch die
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)-Option
angegeben werden. Mehr Informationen zu Eventhandlern finden Sie
[hier](eventhandlers.md "7.3. Eventhandler").

**Globale Service-Eventhandler-Option** (Global Service Event Handler
Option)

Format:

**global\_service\_event\_handler=\<command\>**

Beispiel:

**global\_service\_event\_handler=log-service-event-to-db**

Diese Option erlaubt Ihnen, einen Service-Eventhandler-Befehl anzugeben,
der für jeden Service-Zustandswechsel ausgeführt wird. Der globale
Eventhandler wird direkt vor dem Eventhandler ausgeführt, den Sie
optional in jeder Service-Definition angeben können. Das
*Befehls*-Argument ist der Kurzname eines Befehls, den Sie in Ihrer
[Objektkonfigurationsdatei](configobject.md "3.3. Überblick Objektkonfiguration")
angeben. Die maximale Ausführungszeit dieses Befehls kann durch die
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)-Option
angegeben werden. Mehr Informationen zu Eventhandlern finden Sie
[hier](eventhandlers.md "7.3. Eventhandler").

**Eventhandler für "verfolgte" Hosts (Event handlers for stalked
hosts)**

**Eventhandler für "verfolgte" Services (Event handlers for stalked
services)**

Format:

**stalking\_event\_handlers\_for\_hosts=\<0|1\>**

**stalking\_event\_handlers\_for\_services=\<0|1\>**

Example:

**stalking\_event\_handlers\_for\_hosts=1**

Diese Optionen erlauben Ihnen festzulegen, ob Icinga Eventhandler für
"stalked" Hosts oder Services ausführt. Auf diese Weise können
Statusinformationsänderungen an externe Systeme weitergeleitet werden.

-   0 = Eventhandler deaktivieren (Default)

-   1 = Eventhandler aktivieren

**Benachrichtigungen für "verfolgte" Hosts (Notifications for stalked
hosts)**

**Benachrichtigungen für "verfolgte" Services (Notifications for stalked
services)**

Format:

**stalking\_notifications\_for\_hosts=\<0|1\>**

**stalking\_notifications\_for\_services=\<0|1\>**

Beispiel:

**stalking\_notifications\_for\_hosts=1**

Diese Optionen legen global für alle Kontakte fest, ob Icinga
Benachrichtigungen für "stalked" Hosts oder Services ausführt. Das
\$NOTIFICATION\_TYPE\$-Makro wird um den Typ "STALKING" erweitert.

![[Anmerkung]](../images/note.png)

Anmerkung

Solange keine stalking\_options beim Host/Service definiert sind, haben
diese Optionen keine Auswirkungen.

-   0 = Benachrichtigungen deaktivieren (Default)

-   1 = Benachrichtigungen aktivieren

**Ruhezeit zwischen Prüfungen** (Inter-Check Sleep Time)

Format:

**sleep\_time=\<seconds\>**

Beispiel:

**sleep\_time=1**

Dies ist die Anzahl von Sekunden, die Icinga "schlafen" wird, bevor es
in der Planungswarteschlange (scheduling queue) nach weiteren
auszuführenden Host- oder Service-Prüfungen schaut. Beachten Sie, dass
Icinga nur schlafen wird, nachdem es anstehende Service-Prüfungen
erledigt hat, die in Verzug geraten waren.

**Verzögerungsmethode für Service-Prüfungen** (Service Inter-Check Delay
Method)

Format:

**service\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**

Beispiel:

**service\_inter\_check\_delay\_method=s**

Diese Option erlaubt Ihnen die Kontrolle darüber, wie Service-Prüfungen
anfänglich in der Planungswarteschlange "ausgebreitet" werden. Die
Verwendung einer "schlauen" Verzögerungsberechnung (der Standard)
veranlasst Icinga, ein durchschnittliches Prüfintervall zu berechnen und
die anfänglichen Prüfungen aller Services über dieses Intervall zu
verteilen, um dadurch CPU-Lastspitzen zu eliminieren. Keine Verzögerung
zu benutzen wird *nicht* empfohlen, weil es dafür sorgt, dass die
Ausführung aller Service-Prüfungen zur gleichen Zeit geplant wird. Das
bedeutet, dass Sie generell hohe CPU-Spitzen haben werden, wenn die
Services alle parallel ausgeführt werden. Mehr Informationen dazu, wie
die Verzögerung von Service-Prüfungen die Planung dieser Prüfungen
beeinflusst, finden Sie
[hier](checkscheduling.md#serviceintercheckdelay "7.23.4. Inter-Check-Verzögerung (inter-check delay)").
Die Werte sind wie folgt:

-   n = keine (none) Verzögerung benutzen - planen, dass alle
    Service-Prüfungen sofort ausgeführt werden (d.h. zur gleichen Zeit!)

-   d = eine "dumme" (dumb) Verzögerung von einer Sekunde zwischen
    Service-Prüfungen benutzen

-   s = eine "schlaue" (smart) Verzögerungsberechnung verwenden, um die
    Service-Prüfungen gleichmäßig zu verteilen (Default)

-   x.xx = eine benutzerdefinierte Verzögerung von x.xx Sekunden
    zwischen den Prüfungen benutzen

**maximale Service-Prüfungsverteilung** (Maximum Service Check Spread)

Format:

**max\_service\_check\_spread=\<minutes\>**

Beispiel:

**max\_service\_check\_spread=30**

Diese Option legt die maximale Anzahl in Minuten fest vom Icinga-Start
bis zur Ausführung aller (regelmäßig geplanten) Service-Prüfungen. Diese
Option wird automatisch die [Verzögerungsmethode für
Service-Prüfungen](configmain.md#configmain-service_inter_check_delay_method)
anpassen (falls notwendig), um sicherzustellen, dass die anfänglichen
Prüfungen aller Services in dem Zeitrahmen stattfinden, den Sie angeben.
Generell wird diese Optionen keine Auswirkung auf die Planung von
Service-Prüfungen haben, wenn die Planungsinformationen mit Hilfe der
[use\_retained\_scheduling\_info](configmain.md#configmain-use_retained_scheduling_info)-Option
aufbewahrt werden. Standardwert ist **30** (Minuten).

**Service-Verschachtelungsfaktor** (Service Interleave Factor)

Format:

**service\_interleave\_factor=\<s|x\>**

Beispiel:

**service\_interleave\_factor=s**

Diese Variable legt fest, wie Service-Prüfungen verschachtelt werden.
Verschachtelung erlaubt eine gleichmäßigere Verteilung von
Service-Prüfungen, reduzierte Last auf entfernten Hosts und schnellere
Erkennung von Host-Problemen. Das Setzen des Wertes auf 1 ist
gleichbedeutend mit keiner Verschachtelung der Service-Prüfungen (so
arbeiteten die Icinga-Version bis 0.0.5). Setzen Sie diesen Wert auf
**s** (schlau/smart) für die automatische Berechnung, solange Sie keinen
bestimmten Grund für die Änderung haben. Der beste Weg zum Verständnis,
wie Verschachtelung funktioniert, ist der Blick auf das [status
CGI](cgis.md#cgis-status_cgi) (detail view), während Icinga startet.
Sie sollten sehen, dass die Service-Prüfergebnisse verteilt werden,
während sie auftauchen. Mehr Informationen dazu, wie Verschachtelung
funktioniert, finden Sie
[hier](checkscheduling.md#serviceinterleaving "7.23.5. Service-Verschachtelung (service interleaving)").

-   *x* = eine Zahl gleich oder größer 1, die den zu benutzenden
    Verschachtelungsfaktor angibt. Ein Verschachtelungsfaktor von 1
    bedeutet keine Verschachtelung von Service-Prüfungen

-   s = eine "schlaue" (smart) Verschachtelungsberechnung benutzen
    (Default)

**maximale Anzahl gleichzeitiger Service-Prüfungen** (Maximum Concurrent
Service Checks)

Format:

**max\_concurrent\_checks=\<max\_checks\>**

Beispiel:

**max\_concurrent\_checks=20**

Diese Option erlaubt Ihnen die Angabe der maximalen Anzahl von
Service-Prüfungen, die zu irgendeiner Zeit gleichzeitig ausgeführt
werden. Das Angeben eines Wertes von 1 verhindert grundsätzlich die
Ausführung von parallelen Service-Prüfungen. Der Wert 0 (der Standard)
sorgt dafür, dass es keine Beschränkung der Anzahl von gleichzeitig
ausgeführten Service-Prüfungen gibt. Sie müssen den Wert auf der Basis
der Systemressourcen anpassen, die Ihr Icinga-Rechner zur Verfügung
stellt, da er direkt die maximale Last des System beeinflusst
(Prozessorauslastung, Speicher, usw.). Mehr Informationen dazu, wie
viele parallele Prüfungen Sie zulassen sollten, finden Sie
[hier](checkscheduling.md#maxconcurrentchecks "7.23.6. Maximale Zahl gleichzeitiger Service-Prüfungen").

**Prüfergebnis-Erntefrequenz** (Check Result Reaper Frequency)

Format:

**check\_result\_reaper\_frequency=\<frequency\_in\_seconds\>**

Beispiel:

**check\_result\_reaper\_frequency=5**

Diese Option erlaubt Ihnen die Kontrolle über die Frequenz *in Sekunden*
der Prüfergebnis-"Ernte"-Ereignisse. "Ernte"-Ereignisse verarbeiten die
Ergebnisse von Host- und Service-Prüfungen, die beendet wurden. Diese
Ereignisse bilden den Kern der Überwachungslogik von Icinga.

**maximale Prüfergebnis-Erntezeit** (Maximum Check Result Reaper Time)

Format:

**max\_check\_result\_reaper\_time=\<seconds\>**

Beispiel:

**max\_check\_result\_reaper\_time=30**

Diese Option erlaubt Ihnen die Kontrolle der maximalen Zeit *in
Sekunden*, die Host- und Service-Prüfergebnis-"Ernte"-Ereignisse laufen
dürfen. "Ernte"-Ereignisse verarbeiten die Ergebnisse von Host- und
Service-Prüfungen, die beendet sind. Wenn es eine Menge von Ergebnissen
zu verarbeiten gibt, können Ernte-Ereignisse lange brauchen, um zu
enden, was die pünktliche Ausführung von neuen Host- und
Service-Prüfungen verzögern könnte. Diese Variable erlaubt Ihnen die
Begrenzung der Zeit, die ein einzelnes Ernte-Ereignis laufen darf, bevor
es die Kontrolle an andere Teile der Icinga-Überwachungslogik
zurückgibt.

**Prüfergebnis-Pfad** (Check Result Path)

Format:

**check\_result\_path=\<path\>**

Beispiel:

**check\_result\_path=/var/spool/nagios/checkresults**

Diese Option legt fest, welches Verzeichnis Icinga benutzen wird, um
temporär Host- und Service-Prüfergebnisse zu speichern, bevor sie
verarbeitet werden. Diese Verzeichnis sollte nicht benutzt werden, um
andere Dateien dort zu speichern, weil Icinga dieses Verzeichnis
periodisch von alten Dateien säubern wird (mehr Informationen dazu
finden Sie bei der
[max\_check\_result\_file\_age](configmain.md#configmain-max_check_result_file_age)-Option).

Anmerkung: stellen Sie sicher, dass nur eine einzelne Icinga-Instanz
Zugriff auf den Prüfergebnispfad hat. Wenn mehrere Icinga-Instanzen
Zugriff auf das gleiche Verzeichnis haben, werden Sie Probleme bekommen,
weil Prüfergebnisse von der falschen Icinga-Instanz verarbeitet wurden!

**maximales Alter der Prüfergebnisdatei** (Max Check Result File Age)

Format:

**max\_check\_result\_file\_age=\<seconds\>**

Beispiel:

**max\_check\_result\_file\_age=3600**

Diese Option legt das maximale Alter in Sekunden fest, die Daten aus den
Prüfergebnisdateien im
[check\_result\_path](configmain.md#configmain-check_result_path)-Verzeichnis
als gültig angesehen werden. Prüfergebnisdateien, die älter als dieser
Schwellwert sind, werden von Icinga gelöscht und die darin enthaltenen
Daten werden nicht verarbeitet. Durch die Angabe eines Wertes von Null
(0) bei dieser Option wird Icinga alle Prüfergebnisdateien verarbeiten -
selbst wenn sie älter als Ihre Hardware sind :-).

**Verzögerungsmethode für Host-Prüfungen** (Host Inter-Check Delay
Method)

Format:

**host\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**

Beispiel:

**host\_inter\_check\_delay\_method=s**

Diese Option erlaubt Ihnen die Kontrolle darüber, wie Host-Prüfungen,
*die für eine regelmäßige Prüfung geplant sind*, anfänglich in der
Planungswarteschlange "ausgebreitet" werden. Die Verwendung einer
"schlauen" Verzögerungsberechnung (der Standard) veranlasst Icinga, ein
durchschnittliches Prüfintervall zu berechnen und die anfänglichen
Prüfungen aller Hosts über dieses Intervall zu verteilen, um dadurch
CPU-Lastspitzen zu eliminieren. Keine Verzögerung zu benutzen wird
generell *nicht* empfohlen, weil es dafür sorgt, dass die Ausführung
aller Host-Prüfungen zur gleichen Zeit geplant wird. Mehr Informationen
dazu, wie die Verzögerung von Host-Prüfungen die Planung dieser
Prüfungen beeinflusst, finden Sie
[hier](checkscheduling.md#serviceintercheckdelay "7.23.4. Inter-Check-Verzögerung (inter-check delay)").
Die Werte sind wie folgt:

-   n = keine (none) Verzögerung benutzen - planen, dass alle
    Host-Prüfungen sofort ausgeführt werden (d.h. zur gleichen Zeit!)

-   d = eine "dumme" (dumb) Verzögerung von einer Sekunde zwischen
    Host-Prüfungen benutzen

-   s = eine "schlaue" (smart) Verzögerungsberechnung verwenden, um die
    Host-Prüfungen gleichmäßig zu verteilen (Default)

-   x.xx = eine benutzerdefinierte Verzögerung von x.xx Sekunden
    zwischen den Prüfungen benutzen

**maximale Host-Prüfungsverteilung** (Maximum Host Check Spread)

Format:

**max\_host\_check\_spread=\<minutes\>**

Beispiel:

**max\_host\_check\_spread=30**

Diese Option legt die maximale Anzahl in Minuten fest vom Icinga-Start
bis zur Ausführung aller (regelmäßig geplanten) Host-Prüfungen. Diese
Option wird automatisch die [Verzögerungsmethode für
Host-Prüfungen](configmain.md#configmain-host_inter_check_delay_method)
anpassen (falls notwendig), um sicherzustellen, dass die anfänglichen
Prüfungen aller Hosts in dem Zeitrahmen stattfinden, den Sie angeben.
Generell wird diese Optionen keine Auswirkung auf die Planung von
Host-Prüfungen haben, wenn die Planungsinformationen mit Hilfe der
[use\_retained\_scheduling\_info](configmain.md#configmain-use_retained_scheduling_info)-Option
aufbewahrt werden. Standardwert ist **30** (Minuten).

**Zeitintervalllänge** (Timing Interval Length)

Format:

**interval\_length=\<seconds\>**

Beispiel:

**interval\_length=60**

Dies ist die Zahl von Sekunden pro "Zeitintervall" (unit interval), das
für die Steuerung in der Planungswarteschlange, bei erneuten
Benachrichtigungen usw. verwendet wird. "Zeitintervalle" werden in den
Objektkonfigurationsdateien benutzt, um festzulegen, wie oft eine
Service-Prüfung ausgeführt, ein Kontakt erneut informiert wird usw.

**Wichtig:** Der Standardwert hierfür ist auf 60 eingestellt, was
bedeutet, dass ein "Zeitwert" von eins (1) in der
Objektkonfigurationsdatei 60 Sekunden bedeutet (eine Minute). Wir haben
keine anderen Werte für diese Variable ausprobiert, also machen Sie
Änderungen auf Ihr eigenes Risiko, wenn Sie etwas anderes einstellen!

**automatische Wiedereinplanungs-Option** (Auto-Rescheduling Option)

Format:

**auto\_reschedule\_checks=\<0/1\>**

Beispiel:

**auto\_reschedule\_checks=1**

Diese Option legt fest, ob Icinga versucht, aktive Host- und
Service-Prüfungen automatisch erneut einzuplanen, um sie über die Zeit
"auszugleichen" (smooth out). Dies kann helfen, die Last des
Überwachungsrechners auszubalancieren, da es versucht, die Zeit zwischen
aufeinander folgenden Prüfungen einheitlich zu halten, auf Kosten der
Ausführung von Prüfungen mit einer rigideren Planung.

**WARNUNG:** DIES IST EIN EXPERIMENTELLES FEATURE UND KÖNNTE IN DER
ZUKUNFT ENTFERNT WERDEN. DIE AKTIVIERUNG DIESER OPTION KANN DIE LEISTUNG
REDUZIEREN - STATT SIE ZU ERHÖHEN - WENN SIE UNGEEIGNET BENUTZT WIRD!

**automatisches Wiedereinplanungs-Intervall** (Auto-Rescheduling
Interval)

Format:

**auto\_rescheduling\_interval=\<seconds\>**

Beispiel:

**auto\_rescheduling\_interval=30**

Diese Option legt fest, wie oft (in Sekunden) Icinga versuchen wird,
automatisch Prüfungen erneut einzuplanen. Diese Option ist nur wirksam,
wenn die
[auto\_reschedule\_checks](configmain.md#configmain-auto_reschedule_checks)-Option
aktiviert ist. Standard ist 30 Sekunden.

**WARNUNG:** DIES IST EIN EXPERIMENTELLES FEATURE UND KÖNNTE IN DER
ZUKUNFT ENTFERNT WERDEN. DIE AKTIVIERUNG DIESER OPTION KANN DIE LEISTUNG
REDUZIEREN - STATT SIE ZU ERHÖHEN - WENN SIE UNGEEIGNET BENUTZT WIRD!

**automatisches Wiedereinplanungsfenster** (Auto-Rescheduling Window)

Format:

**auto\_rescheduling\_window=\<seconds\>**

Beispiel:

**auto\_rescheduling\_window=180**

Diese Option legt das Zeit-"Fenster" fest (in Sekunden), auf das Icinga
blickt, wenn es automatisch Prüfungen erneut einplant. Nur Host- und
Service-Prüfungen, die in den nächsten X Sekunden (festgelegt durch
diese Variable) stattfinden, werden erneut eingeplant. Diese Option ist
nur wirksam, wenn die
[auto\_reschedule\_checks](configmain.md#configmain-auto_reschedule_checks)-Option
aktiviert ist. Standard ist 180 Sekunden (3 Minuten).

**WARNING:** DIES IST EIN EXPERIMENTELLES FEATURE UND KÖNNTE IN DER
ZUKUNFT ENTFERNT WERDEN. DIE AKTIVIERUNG DIESER OPTION KANN DIE LEISTUNG
REDUZIEREN - STATT SIE ZU ERHÖHEN - WENN SIE UNGEEIGNET GENUTZT WIRD!

**Option aggressive Host-Prüfung** (Aggressive Host Checking Option)

Format:

**use\_aggressive\_host\_checking=\<0/1\>**

Beispiel:

**use\_aggressive\_host\_checking=0**

Icinga versucht, schlau zu sein, wie und wann es den Status von Hosts
prüft. Im Allgemeinen wird die Deaktivierung dieser Option Icinga dazu
veranlassen, einige schlauere Entscheidungen zu treffen und Hosts ein
bisschen schneller zu prüfen. Die Aktivierung dieser Option wird den
Zeitaufwand zur Prüfung von Hosts erhöhen, aber es mag die
Zuverlässigkeit ein wenig steigern. Solange Sie keine Probleme damit
haben, dass Icinga die Erholung eines Hosts nicht korrekt erkennt,
würden wir empfehlen, diese Option **nicht** zu aktivieren.

-   0 = keine aggressive Host-Prüfung benutzen (Default)

-   1 = aggressive Host-Prüfung benutzen

**Option passive Host-Prüfung übersetzen** (Translate Passive Host
Checks Option)

Format:

**translate\_passive\_host\_checks=\<0/1\>**

Beispiel:

**translate\_passive\_host\_checks=1**

Diese Option legt fest, ob Icinga DOWN/UNREACHABLE-Ergebnisse von
passiven Host-Prüfungen in ihre "korrekten" Zustände vom Standpunkt der
lokalen Icinga-Instanz aus übersetzt. Dies kann sehr nützlich in
verteilten und Failover-Umgebungen sein. Mehr Informationen zur
Übersetzung von passiven Prüfergebnissen finden Sie
[hier](passivestatetranslation.md "7.22. Passive Host-Zustandsübersetzung").

-   0 = Prüfübersetzung deaktivieren (Default)

-   1 = Prüfübersetzung aktivieren

**Option passive Host-Prüfungen sind SOFT** (Passive Host Checks Are
SOFT Option)

Format:

**passive\_host\_checks\_are\_soft=\<0/1\>**

Beispiel:

**passive\_host\_checks\_are\_soft=1**

Diese Option legt fest, ob Icinga [passive
Host-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
als HARD- oder SOFT-Zustände behandelt. Per Default wird ein passives
Prüfergebnis einen Host in einen
[HARD-Status](statetypes.md "5.8. Statustypen") setzen. Sie können
dieses Verhalten durch aktivieren dieser Option verändern.

-   0 = passive Host-Prüfungen sind HARD (Default)

-   1 = passive Host-Prüfungen sind SOFT

**Option vorausschauende Host-Abhängigkeitsprüfung** (Predictive Host
Dependency Checks Option)

Format:

**enable\_predictive\_host\_dependency\_checks=\<0/1\>**

Beispiel:

**enable\_predictive\_host\_dependency\_checks=1**

Diese Option legt fest, ob Icinga vorausschauende Prüfungen von Hosts
ausführen soll, von denen andere abhängig sind (wie in
[Host-Abhängigkeiten](objectdefinitions.md#objectdefinitions-hostdependency)
definiert) für einen bestimmten Host, dessen Zustand wechselt.
Vorausschauende Prüfungen helfen dabei, die Abhängigkeitslogik so genau
wie möglich zu machen. Mehr Informationen darüber, wie vorausschauende
Prüfungen arbeiten, finden Sie
[hier](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen").

-   0 = vorausschauende Prüfungen deaktivieren

-   1 = vorausschauende Prüfungen aktivieren (Default)

**Option vorausschauende Service-Abhängigkeitsprüfung** (Predictive
Service Dependency Checks Option)

Format:

**enable\_predictive\_service\_dependency\_checks=\<0/1\>**

Beispiel:

**enable\_predictive\_service\_dependency\_checks=1**

Diese Option legt fest, ob Icinga vorausschauende Prüfungen von Services
ausführen soll, von denen andere abhängig sind (wie in
[Service-Abhängigkeiten](objectdefinitions.md#objectdefinitions-hostdependency)
definiert) für einen bestimmten Service, dessen Zustand wechselt.
Vorausschauende Prüfungen helfen dabei, die Abhängigkeitslogik so genau
wie möglich zu machen. Mehr Informationen darüber, wie vorausschauende
Prüfungen arbeiten, finden Sie
[hier](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen").

-   0 = vorausschauende Prüfungen deaktivieren

-   1 = vorausschauende Prüfungen aktivieren (Default)

**Horizont für zwischengespeicherte Host-Prüfungen** (Cached Host Check
Horizon)

Format:

**cached\_host\_check\_horizon=\<seconds\>**

Beispiel:

**cached\_host\_check\_horizon=15**

Diese Option legt die maximale Zeit (in Sekunden) fest, die der Zustand
einer vorherigen Host-Prüfung als aktuell angesehen wird.
Zwischengespeicherte Host-Zustände (von Host-Prüfungen, die aktueller
sind als die in diesem Wert angegebene Zeit) können die Leistung von
Host-Prüfungen immens steigern. Ein zu hoher Wert für diese Option kann
in (vorübergehend) ungenauen Host-Zuständen resultieren, während ein
niedriger Wert zu einem Leistungseinbruch bei Host-Prüfungen führen
kann. Benutzen Sie einen Wert von 0, wenn Sie die Zwischenspeicherung
von Host-Prüfungen deaktivieren wollen. Mehr Informationen zu
zwischengespeicherten Prüfungen finden Sie
[hier](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen").

**Horizont für zwischengespeicherte Service-Prüfungen** (Cached Service
Check Horizon)

Format:

**cached\_service\_check\_horizon=\<seconds\>**

Beispiel:

**cached\_service\_check\_horizon=15**

Diese Option legt die maximale Zeit (in Sekunden) fest, die der Zustand
einer vorherigen Service-Prüfung als aktuell angesehen wird.
Zwischengespeicherte Service-Zustände (von Service-Prüfungen, die
aktueller sind als die in diesem Wert angegebene Zeit) können die
Leistung von Service-Prüfungen steigern, wenn eine Menge von
[Service-Abhängigkeiten](objectdefinitions.md#objectdefinitions-servicedependency)
benutzt werden. Ein zu hoher Wert für diese Option kann in
(vorübergehend) ungenauen Service-Zuständen resultieren, während ein
niedriger Wert zu einem Leistungseinbruch bei Service-Prüfungen führen
kann. Benutzen Sie einen Wert von 0, wenn Sie die Zwischenspeicherung
von Service-Prüfungen deaktivieren wollen. Mehr Informationen zu
zwischengespeicherten Prüfungen finden Sie
[hier](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen").

**Option Verbesserungen für große Installationen** (Large Installation
Tweaks Option)

Format:

**use\_large\_installation\_tweaks=\<0/1\>**

Beispiel:

**use\_large\_installation\_tweaks=0**

Diese Option legt fest, ob der Icinga-Daemon verschiedene Abkürzungen
nimmt, um die Leistung zu steigern. Diese Abkürzungen resultieren im
Verlust einiger Features, aber große Installationen werden
wahrscheinlich einen hohen Nutzen davon haben. Mehr Informationen,
welche Optimierungen vorgenommen werden, wenn Sie diese Option
aktivieren, finden Sie
[hier](largeinstalltweaks.md "8.5. Large Installation Tweaks").

-   0 = keine Verbesserungen verwenden (Default)

-   1 = Verbesserungen verwenden

**Kindprozess-Speicher-Option** (Child Process Memory Option)

Format:

**free\_child\_process\_memory=\<0/1\>**

Beispiel:

**free\_child\_process\_memory=0**

Diese Option legt fest, ob Icinga Speicher in Kindprozessen freigibt,
wenn sie vom Hauptprozess ge"fork()"ed werden. Per Default gibt Icinga
den Speicher frei. Wenn allerdings die
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)-Option
aktiviert ist, wird der Speicher nicht freigegeben. Durch Definition
dieser Option in Ihrer Konfigurationsdatei sind Sie in der Lage, das
Verhalten einzustellen, das Sie möchten.

-   0 = Speicher nicht freigeben

-   1 = Speicher freigeben

**Kindprozesse zweimal "fork()"en**

Format:

**child\_processes\_fork\_twice=\<0/1\>**

Beispiel:

**child\_processes\_fork\_twice=0**

Diese Option legt fest, ob Icinga Kindprozesse zweimal "fork()"ed, wenn
es Host- und Service-Prüfungen ausführt. Per Default "fork()"ed Icinga
zweimal. Wenn allerdings die
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)-Option
aktiviert ist, "fork()"ed Icinga nur einmal. Durch Definition dieser
Option in Ihrer Konfigurationsdatei sind Sie in der Lage, das Verhalten
einzustellen, das Sie möchten.

-   0 = nur einmal "fork()"en

-   1 = zweimal "fork()"en

**Umgebungsmakros-Option**

Format:

**enable\_environment\_macros=\<0/1\>**

Beispiel:

**enable\_environment\_macros=0**

Diese Option legt fest, ob Icinga alle
Standard-[Makros](macrolist.md "5.3. Standard-Makros in Icinga") als
Umgebungsvariablen für Prüfungen, Benachrichtigungen, Eventhandler usw.
zur Verfügung stellt. In großen Installationen kann dies problematisch
sein, weil es zusätzlichen Speicher (und wichtiger) mehr CPU benötigt,
um die Werte aller Makros zu berechnen und sie der Umgebung zur
Verfügung zu stellen.

-   0 = Makros nicht als Umgebungsvariablen verfügbar machen (Default)

-   1 = Makros als Umgebungsvariablen verfügbar machen

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5 hat sich der Default geändert. Vorher war diese Direktive
aktiviert, nun ist sie *deaktiviert*.

**Flattererkennungsoption**

Format:

**enable\_flap\_detection=\<0/1\>**

Beispiel:

**enable\_flap\_detection=0**

Diese Option legt fest, ob Icinga versucht festzustellen, ob Hosts und
Services "flattern". Flattern tritt auf, wenn ein Host oder Service zu
schnell zwischen verschiedenen Zuständen wechselt, was in einem
Bombardement von Benachrichtigungen resultiert. Wenn Icinga erkennt,
dass ein Host oder Service flattert, wird es vorübergehend
Benachrichtigungen für diesen Host/Service unterdrücken, bis das
Flattern endet. Flattererkennung ist sehr experimentell zu diesem
Zeitpunkt, also benutzen Sie diese Option mit Vorsicht! Mehr
Informationen dazu, wie Flattererkennung und Behandlung funktionieren,
finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Anmerkung: Wenn Sie
[Statusaufbewahrung](configmain.md#configmain-retain_state_information)
aktiviert haben, wird Icinga diese Einstellung ignorieren, wenn es
(erneut) startet und die letzte bekannte Einstellung dieser Option
nutzen (wie sie in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](extcommands.md "7.1. Externe Befehle") benutzen oder sie über
das Web-Interface ändern.

-   0 = Flattererkennung deaktivieren (Default)

-   1 = Flattererkennung aktivieren

**niedriger Service-Flatterschwellwert** (Low Service Flap Threshold)

Format:

**low\_service\_flap\_threshold=\<percent\>**

Beispiel:

**low\_service\_flap\_threshold=25.0**

Diese Option wird benutzt, um den niedrigen Schwellwert für die
Erkennung von Service-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

**hoher Service-Flatterschwellwert** (High Service Flap Threshold)

Format:

**high\_service\_flap\_threshold=\<percent\>**

Beispiel:

**high\_service\_flap\_threshold=50.0**

Diese Option wird benutzt, um den hohen Schwellwert für die Erkennung
von Service-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

**niedriger Host-Flatterschwellwert** (Low Host Flap Threshold)

Format:

**low\_host\_flap\_threshold=\<percent\>**

Beispiel:

**low\_host\_flap\_threshold=25.0**

Diese Option wird benutzt, um den niedrigen Schwellwert für die
Erkennung von Host-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

**hoher Host-Flatterschwellwert** (High Host Flap Threshold)

Format:

**high\_host\_flap\_threshold=\<percent\>**

Beispiel:

**high\_host\_flap\_threshold=50.0**

Diese Option wird benutzt, um den hohen Schwellwert für die Erkennung
von Host-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

**Soft-Statusabhängigkeitsoption** (Soft State Dependencies Option)

Format:

**soft\_state\_dependencies=\<0/1\>**

Beispiel:

**soft\_state\_dependencies=0**

Diese Option legt fest, ob Icinga Soft-Statusinformationen benutzen
soll, um [Host- und
Serviceabhängigkeiten](dependencies.md "7.13. Host- und Service-Abhängigkeiten")
zu prüfen. Normalerweise wird Icinga nur den letzten Hard-Status des
Hosts oder Service verwenden, wenn Abhängigkeiten geprüft werden. Wenn
Sie möchten, dass der letzte Zustand (unabhängig davon, ob es ein Soft-
oder Hard-[Zustandstyp](statetypes.md "5.8. Statustypen") ist), dann
aktivieren Sie diese Option.

-   0 = keine Soft-Status-Abhängigkeiten benutzen (Default)

-   1 = Soft-Status-Abhängigkeiten benutzen

**Schwellwert für die Abweichung von der Systemzeit** (Time Change
Threshold Option)

Format:

**time\_change\_threshold=(seconds)**

Beispiel:

**time\_change\_threshold=900**

Diese Option legt fest, wann Icinga auf festgestellte
System-Zeit-Abweichungen reagieren soll.

**Service-Prüfungs-Zeitüberschreitung** (Service Check Timeout)

Format:

**service\_check\_timeout=\<seconds\>**

Beispiel:

**service\_check\_timeout=60**

Dies ist die maximale Zahl von Sekunden, die Service-Prüfungen laufen
dürfen. Wenn Prüfungen diese Grenze überschreiten, werden sie
abgebrochen (killed) und ein CRITICAL-Zustand wird zurückgeliefert.
Außerdem wird ein Fehler protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Plugins sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jede Service-Prüfung normalerweise innerhalb dieser Zeit beendet
ist. Wenn eine Service-Prüfung länger läuft, dann wird Icinga diese
Prüfung abbrechen, weil es denkt, dass es sich um einen außer Kontrolle
geratenen Prozess handelt.

**Service-Prüfungs-Zeitüberschreitungs-Status**

Format:

**service\_check\_timeout\_state=\<c/w/u/o\>**

Example:

**service\_check\_timeout\_state=u**

Diese Option legt den Status fest den ein Service erhält, wenn er in
einen Timeout läuft. Er also nicht in der, mit service\_check\_timeout
definierten Zeit, eine Rückmeldung bekommt. Das kann sehr nützlich sein,
wenn eine Maschine gerade einen sehr hohen Load hat und der
Service-Check fehlschlägt und dann kein Critical-Alarm generiert werden
soll. Der Default-Wert wurde von service\_check\_timeout\_state=c zu
service\_check\_timeout\_state=u in Icinga 1.0.1 geändert.

**Host-Prüfungs-Zeitüberschreitung** (Host Check Timeout)

Format:

**host\_check\_timeout=\<seconds\>**

Beispiel:

**host\_check\_timeout=60**

Dies ist die maximale Zahl von Sekunden, die Host-Prüfungen laufen
dürfen. Wenn Prüfungen diese Grenze überschreiten, werden sie
abgebrochen (killed), ein CRITICAL-Zustand wird zurückgeliefert und der
Host als "DOWN" angesehen. Außerdem wird ein Fehler protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Plugins sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jede Host-Prüfung normalerweise innerhalb dieser Zeit beendet ist.
Wenn eine Host-Prüfung länger läuft, dann wird Icinga diese Prüfung
abbrechen, weil es denkt, dass es sich um einen außer Kontrolle
geratenen Prozess handelt.

**Eventhandler-Zeitüberschreitung**

Format:

**event\_handler\_timeout=\<seconds\>**

Beispiel:

**event\_handler\_timeout=60**

Dies ist die maximale Zahl von Sekunden, die
[Eventhandler](eventhandlers.md "7.3. Eventhandler") laufen dürfen.
Wenn ein Eventhandler diese Grenze überschreitet, wird er abgebrochen
(killed) und eine Warnung protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Befehle sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jeder Eventhandler normalerweise innerhalb dieser Zeit beendet ist.
Wenn ein Eventhandler länger läuft, dann wird Icinga diesen Eventhandler
abbrechen, weil es denkt, dass es sich um einen außer Kontrolle
geratenen Prozess handelt.

**Benachrichtigungs-Zeitüberschreitung**

Format:

**notification\_timeout=\<seconds\>**

Beispiel:

**notification\_timeout=60**

Dies ist die maximale Zahl von Sekunden, die Benachrichtigungsbefehle
laufen dürfen. Wenn ein Benachrichtigungsbefehl diese Grenze
überschreitet, wird er abgebrochen (killed) und eine Warnung
protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Befehle sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jeder Benachrichtigungsbefehl normalerweise innerhalb dieser Zeit
beendet ist. Wenn ein Benachrichtigungsbefehl länger läuft, dann wird
Icinga diesen Benachrichtigungsbefehl abbrechen, weil es denkt, dass es
sich um einen außer Kontrolle geratenen Prozess handelt.

**Zwangsverfolgungs-Service-Prozessor-Zeitüberschreitung** (Obsessive
Compulsive Service Processor Timeout)

Format:

**ocsp\_timeout=\<seconds\>**

Beispiel:

**ocsp\_timeout=5**

Dies ist die maximale Zahl von Sekunden, die ein
[Zwangsverfolgungs-Service-Prozessor-Befehl](configmain.md#configmain-ocsp_command)
(obsessive compulsive service processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Zwangsverfolgungs-Host-Prozessor-Zeitüberschreitung** (Obsessive
Compulsive Host Processor Timeout)

Format:

**ochp\_timeout=\<seconds\>**

Beispiel:

**ochp\_timeout=5**

Dies ist die maximale Zahl von Sekunden, die ein
[Zwangsverfolgungs-Host-Prozessor-Befehl](configmain.md#configmain-ochp_command)
(obsessive compulsive host processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Performance-Daten-Prozessorbefehls-Zeitüberschreitung** (Performance
Data Processor Command Timeout)

Format:

**perfdata\_timeout=\<seconds\>**

Beispiel:

**perfdata\_timeout=5**

Dies ist die maximale Zahl von Sekunden, die ein
[Host-Performance-Daten-Prozessorbefehl](configmain.md#configmain-host_perfdata_command)
(host performance data processor command) oder
[Service-Performance-Daten-Prozessorbefehl](configmain.md#configmain-service_perfdata_command)
(service performance data processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Verfolgung-von-Services-Option** (Obsess Over Services Option)

Format:

**obsess\_over\_services=\<0/1\>**

Beispiel:

**obsess\_over\_services=1**

Dieser Wert legt fest, ob Icinga Service-Prüfergebnisse "verfolgt"
(obsess) und den
[Zwangsverfolgungs-Service-Prozessorbefehl](configmain.md#configmain-ocsp_command)
ausführt, den Sie angeben. Nun ja - ein komischer Name, aber das ist
alles, was Ethan Galstad eingefallen ist. Diese Option ist nützlich, um
[verteilte Überwachung](distributed.md "7.6. Verteilte Überwachung")
durchzuführen. Wenn Sie keine verteilte Überwachung machen, dann
aktivieren Sie diese Option nicht.

-   0 = Services nicht verfolgen (Default)

-   1 = Services verfolgen

**Zwangsverfolgungs-Service-Prozessorbefehl** (Obsessive Compulsive
Service Processor Command)

Format:

**ocsp\_command=\<command\>**

Beispiel:

**ocsp\_command=obsessive\_service\_handler**

Diese Option erlaubt Ihnen einen Befehl anzugeben, der nach *jeder*
Service-Prüfung ausgeführt wird, was bei [verteilter
Überwachung](distributed.md "7.6. Verteilte Überwachung") nützlich
sein kann. Dieser Befehl wird nach
[Eventhandler](eventhandlers.md "7.3. Eventhandler")- oder
[Benachrichtigungs](notifications.md "5.11. Benachrichtigungen")-Befehlen
ausgeführt. Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Die maximale Zeit,
die dieser Befehl laufen darf, wird mit der
[ocsp\_timeout](configmain.md#configmain-ocsp_timeout)-Option
kontrolliert. Mehr Informationen zu verteilter Überwachung finden Sie
[hier](distributed.md "7.6. Verteilte Überwachung"). Dieser Befehl
wird nur ausgeführt, wenn die
[obsess\_over\_services](configmain.md#configmain-obsess_over_services)-Option
global aktiviert ist und wenn die *obsess\_over\_service*-Direktive in
der
[Service-Definition](objectdefinitions.md#objectdefinitions-service)
aktiviert ist.

**Verfolgung-von-Hosts-Option** (Obsess Over Hosts Option)

Format:

**obsess\_over\_hosts=\<0/1\>**

Beispiel:

**obsess\_over\_hosts=1**

Dieser Wert legt fest, ob Icinga Host-Prüfergebnisse "verfolgt" (obsess)
und den
[Zwangsverfolgungs-Host-Prozessorbefehl](configmain.md#configmain-ocsp_command)
ausführt, den Sie angeben. Nun ja - ein komischer Name, aber das ist
alles, was Ethan Galstad eingefallen ist. Diese Option ist nützlich, um
[verteilte Überwachung](distributed.md "7.6. Verteilte Überwachung")
durchzuführen. Wenn Sie keine verteilte Überwachung machen, dann
aktivieren Sie diese Option nicht.

-   0 = Hosts nicht verfolgen (Default)

-   1 = Hosts verfolgen

**Zwangsverfolgungs-Host-Prozessorbefehl** (Obsessive Compulsive Host
Processor Command)

Format:

**ochp\_command=\<command\>**

Beispiel:

**ochp\_command=obsessive\_host\_handler**

Diese Option erlaubt Ihnen einen Befehl anzugeben, der nach *jeder*
Host-Prüfung ausgeführt wird, was bei [verteilter
Überwachung](distributed.md "7.6. Verteilte Überwachung") nützlich
sein kann. Dieser Befehl wird nach
[Eventhandler](eventhandlers.md "7.3. Eventhandler")- oder
[Benachrichtigungs](notifications.md "5.11. Benachrichtigungen")-Befehlen
ausgeführt. Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Die maximale Zeit,
die dieser Befehl laufen darf, wird mit der
[ochp\_timeout](configmain.md#configmain-ochp_timeout)-Option
kontrolliert. Mehr Informationen zu verteilter Überwachung finden Sie
[hier](distributed.md "7.6. Verteilte Überwachung"). Dieser Befehl
wird nur ausgeführt, wenn die
[obsess\_over\_hosts](configmain.md#configmain-obsess_over_hosts)-Option
global aktiviert ist und wenn die *obsess\_over\_hosts*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-service)
aktiviert ist.

**Performance-Daten-Verarbeitungsoption** (Performance Data Processing
Option)

Format:

**process\_performance\_data=\<0/1\>**

Beispiel:

**process\_performance\_data=1**

Dieser Wert legt fest, ob Icinga
[Performance-Daten](perfdata.md "7.15. Performance-Daten") von Host-
und Service-Prüfungen verarbeitet.

-   0 = keine Performance-Daten verarbeiten (Default)

-   1 = Performance-Daten verarbeiten

**Host-Performance-Daten-Verarbeitungsbefehl** (Host Performance Data
Processing Command)

Format:

**host\_perfdata\_command=\<command\>**

Beispiel:

**host\_perfdata\_command=process-host-perfdata**

Diese Option erlaubt es Ihnen, einen Befehl anzugeben, der nach *jeder*
Host-Prüfung ausgeführt wird, um
Host-[Performance-Daten](perfdata.md "7.15. Performance-Daten") zu
verarbeiten, die von der Prüfung zurückgeliefert worden sein könnten.
Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Dieser Befehl wird
nur ausgeführt, wenn die
[process\_performance\_data](configmain.md#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
aktiviert ist.

**Service-Performance-Daten-Verarbeitungsbefehl** (Service Performance
Data Processing Command)

Format:

**service\_perfdata\_command=\<command\>**

Beispiel:

**service\_perfdata\_command=process-service-perfdata**

Diese Option erlaubt es Ihnen, einen Befehl anzugeben, der nach *jeder*
Service-Prüfung ausgeführt wird, um
Service-[Performance-Daten](perfdata.md "7.15. Performance-Daten") zu
verarbeiten, die von der Prüfung zurückgeliefert worden sein könnten.
Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Dieser Befehl wird
nur ausgeführt, wenn die
[process\_performance\_data](configmain.md#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Service-Definition](objectdefinitions.md#objectdefinitions-host)
aktiviert ist.

**Host-Performance-Daten-Datei** (Host Performance Data File)

Format:

**host\_perfdata\_file=\<file\_name\>**

Beispiel:

**host\_perfdata\_file=/usr/local/icinga/var/host-perfdata.dat**

Diese Option erlaubt es Ihnen, eine Datei anzugeben, in die nach jeder
Host-Prüfung
[Performance-Daten](perfdata.md "7.15. Performance-Daten") geschrieben
werden. Daten werden in die Performance-Datei geschrieben, wie es in der
[host\_perfdata\_file\_template](configmain.md#configmain-host_perfdata_file_template)-Option
angegeben ist. Performance-Daten werden nur in diese Datei geschrieben,
wenn die
[process\_performance\_data](configmain.md#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
aktiviert ist.

**Service-Performance-Daten-Datei** (Service Performance Data File)

Format:

**service\_perfdata\_file=\<file\_name\>**

Beispiel:

**service\_perfdata\_file=/usr/local/icinga/var/service-perfdata.dat**

Diese Option erlaubt es Ihnen, eine Datei anzugeben, in die nach jeder
Service-Prüfung
[Performance-Daten](perfdata.md "7.15. Performance-Daten") geschrieben
werden. Daten werden in die Performance-Datei geschrieben, wie es in der
[service\_perfdata\_file\_template](configmain.md#configmain-service_perfdata_file_template)-Option
angegeben ist. Performance-Daten werden nur in diese Datei geschrieben,
wenn die
[process\_performance\_data](configmain.md#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Service-Definition](objectdefinitions.md#objectdefinitions-host)
aktiviert ist.

**Host-Performance-Daten-Dateivorlage** (Host Performance Data File
Template)

Format:

**host\_perfdata\_file\_template=\<template\>**

Beispiel:

**host\_perfdata\_file\_template=[HOSTPERFDATA]\\t\$TIMET\$\\t\$HOSTNAME\$\\
\\ \\t\$HOSTEXECUTIONTIME\$\\t\$HOSTOUTPUT\$\\t\$HOSTPERFDATA\$**

Diese Option legt fest, welche (und wie) Daten in die
[Host-Performancedaten-Datei](configmain.md#configmain-host_perfdata_file)
geschrieben werden. Diese Vorlage kann
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten"),
Sonderzeichen (\\t für Tabulator, \\r für Wagenrücklauf (carriage
return), \\n für Zeilenvorschub (newline)) und reinen Text enthalten.
Nach jedem Schreibvorgang wird ein Zeilenvorschub an die
Performancedaten-Datei angehängt.

**Service-Performance-Daten-Dateivorlage** (Service Performance Data
File Template)

Format:

**service\_perfdata\_file\_template=\<template\>**

Beispiel:

**service\_perfdata\_file\_template=[SERVICEPERFDATA]\\t\$TIMET\$\\t\$HOSTNAME\$
\\
\\t\$SERVICEDESC\$\\t\$SERVICEEXECUTIONTIME\$\\t\$SERVICELATENCY\$\\t\$SERVICEOUTPUT\$\\t\$SERVICEPERFDATA\$**

Diese Option legt fest, welche (und wie) Daten in die
[Service-Performancedaten-Datei](configmain.md#configmain-service_perfdata_file)
geschrieben werden. Diese Vorlage kann
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten"),
Sonderzeichen (\\t für Tabulator, \\r für Wagenrücklauf (carriage
return), \\n für Zeilenvorschub (newline)) und reinen Text enthalten.
Nach jedem Schreibvorgang wird ein Zeilenvorschub an die
Performancedaten-Datei angehängt.

**Host-Performance-Daten-Dateimodus** (Host Performance Data File Mode)

Format:

**host\_perfdata\_file\_mode=\<mode\>**

Beispiel:

**host\_perfdata\_file\_mode=a**

Diese Option legt fest, wie die
[Host-Performance-Datendatei](configmain.md#configmain-host_perfdata_file)
geöffnet wird. Solange die Datei keine "named pipe" ist, werden Sie
diese wahrscheinlich im append-Modus (anhängen) öffnen wollen.

-   a = Datei im append-Modus öffnen (Default)

-   w = Datei im Write-Modus öffnen

-   p = Datei im nicht-blockierenden Schreib-/Lesemodus öffnen
    (nützlich, wenn man in Pipes schreibt)

**Service-Performance-Daten-Dateimodus** (Service Performance Data File
Mode)

Format:

**service\_perfdata\_file\_mode=\<mode\>**

Beispiel:

**service\_perfdata\_file\_mode=a**

Diese Option legt fest, wie die
[Service-Performance-Datendatei](configmain.md#configmain-service_perfdata_file)
geöffnet wird. Solange die Datei keine "named pipe" ist, werden Sie
diese wahrscheinlich im append-Modus (anhängen) öffnen wollen.

-   a = Datei im append-Modus öffnen (Default)

-   w = Datei im Write-Modus öffnen

-   p = Datei im nicht-blockierenden Schreib-/Lesemodus öffnen
    (nützlich, wenn man in Pipes schreibt)

**Host-Performance-Daten-Dateiverarbeitungsintervall** (Host Performance
Data File Processing Interval)

Format:

**host\_perfdata\_file\_processing\_interval=\<seconds\>**

Beispiel:

**host\_perfdata\_file\_processing\_interval=0**

Diese Option erlaubt es Ihnen, das Intervall (in Sekunden) anzugeben, in
dem die
[Host-Performance-Daten-Datei](configmain.md#configmain-host_perfdata_file)
mit dem
[Host-Performance-Daten-Dateiverarbeitungsbefehl](configmain.md#configmain-host_perfdata_file_processing_command)
verarbeitet wird. Ein Wert von 0 gibt an, dass die
Performance-Daten-Datei nicht in regelmäßigen Intervallen verarbeiten
werden soll.

**Service-Performance-Daten-Dateiverarbeitungsintervall** (Service
Performance Data File Processing Interval)

Format:

**service\_perfdata\_file\_processing\_interval=\<seconds\>**

Beispiel:

**service\_perfdata\_file\_processing\_interval=0**

Diese Option erlaubt es Ihnen, das Intervall (in Sekunden) anzugeben, in
dem die
[Service-Performance-Daten-Datei](configmain.md#configmain-service_perfdata_file)
mit dem
[Service-Performance-Daten-Dateiverarbeitungsbefehl](configmain.md#configmain-service_perfdata_file_processing_command)
verarbeitet wird. Ein Wert von 0 gibt an, dass die
Performance-Daten-Datei nicht in regelmäßigen Intervallen verarbeiten
werden soll.

**Host-Performance-Daten-Dateiverarbeitungsbefehl** (Host Performance
Data File Processing Command)

Format:

**host\_perfdata\_file\_processing\_command=\<command\>**

Beispiel:

**host\_perfdata\_file\_processing\_command=process-host-perfdata-file**

Diese Option erlaubt es Ihnen, den Befehl anzugeben, der ausgeführt
werden soll, um die
[Host-Performance-Daten-Datei](configmain.md#configmain-host_perfdata_file)
zu verarbeiten. Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Das Intervall, in
dem dieser Befehl ausgeführt wird, ist durch die
[host\_perfdata\_file\_processing\_interval](configmain.md#configmain-host_perfdata_file_processing_interval)-Direktive
festgelegt.

**Service-Performance-Daten-Dateiverarbeitungsbefehl** (Service
Performance Data File Processing Command)

Format:

**service\_perfdata\_file\_processing\_command=\<command\>**

Beispiel:

**service\_perfdata\_file\_processing\_command=process-service-perfdata-file**

Diese Option erlaubt es Ihnen, den Befehl anzugeben, der ausgeführt
werden soll, um die
[Service-Performance-Daten-Datei](configmain.md#configmain-service_perfdata_file)
zu verarbeiten. Das *command*-Argument ist der Kurzname einer
[command-Definition](objectdefinitions.md#objectdefinitions-command),
die Sie in Ihrer Objektkonfigurationsdatei angeben. Das Intervall, in
dem dieser Befehl ausgeführt wird, ist durch die
[service\_perfdata\_file\_processing\_interval](configmain.md#configmain-service_perfdata_file_processing_interval)-Direktive
festgelegt.

**verwaiste Service-Prüfungsoption** (Orphaned Service Check Option)

Format:

**check\_for\_orphaned\_services=\<0/1\>**

Beispiel:

**check\_for\_orphaned\_services=1**

Diese Option erlaubt es Ihnen, Prüfungen auf verwaiste Service-Prüfungen
zu aktivieren oder zu deaktivieren. Verwaiste Service-Prüfungen sind
Prüfungen, die ausgeführt und aus der Ereigniswarteschlange entfernt
wurden, aber während langer Zeit keine Ergebnisse geliefert haben. Weil
keine Ergebnisse für den Service zurückgeliefert wurden, wird er nicht
erneut in der Ereigniswarteschlange eingeplant. Das kann dazu führen,
dass Service-Prüfungen nicht mehr ausgeführt werden. Normalerweise
passiert das sehr selten - es kann dann auftreten, wenn ein externer
Benutzer oder Prozess den Prozess abgebrochen (killed) hat, der benutzt
wurde, um eine Service-Prüfung auszuführen. Wenn diese Option aktiviert
ist und Icinga feststellt, dass eine bestimmte Service-Prüfung kein
Ergebnis geliefert hat, dann wird es einen Fehler protokollieren und die
Service-Prüfung erneut einplanen. Wenn Sie feststellen, dass
Service-Prüfungen anscheinend nie erneut eingeplant werden, dann
aktivieren Sie diese Option und schauen Sie nach Protokollmeldungen zu
verwaisten Services.

-   0 = nicht auf verwaiste Service-Prüfungen prüfen

-   1 = auf verwaiste Service-Prüfungen prüfen (Default)

**verwaiste Host-Prüfungsoption** (Orphaned Host Check Option)

Format:

**check\_for\_orphaned\_hosts=\<0/1\>**

Beispiel:

**check\_for\_orphaned\_hosts=1**

Diese Option erlaubt es Ihnen, Prüfungen auf verwaiste Host-Prüfungen zu
aktivieren oder zu deaktivieren. Verwaiste Host-Prüfungen sind
Prüfungen, die ausgeführt und aus der Ereigniswarteschlange entfernt
wurden, aber während langer Zeit keine Ergebnisse geliefert haben. Weil
keine Ergebnisse für den Host zurückgeliefert wurden, wird er nicht
erneut in der Ereigniswarteschlange eingeplant. Das kann dazu führen,
dass Host-Prüfungen nicht mehr ausgeführt werden. Normalerweise passiert
das sehr selten - es kann dann auftreten, wenn ein externer Benutzer
oder Prozess den Prozess abgebrochen (killed) hat, der benutzt wurde, um
eine Host-Prüfung auszuführen. Wenn diese Option aktiviert ist und
Icinga feststellt, dass eine bestimmte Host-Prüfung kein Ergebnis
geliefert hat, dann wird es einen Fehler protokollieren und die
Host-Prüfung erneut einplanen. Wenn Sie feststellen, dass Host-Prüfungen
anscheinend nie erneut eingeplant werden, dann aktivieren Sie diese
Option und schauen Sie nach Protokollmeldungen zu verwaisten Hosts.

-   0 = nicht auf verwaiste Host-Prüfungen prüfen

-   1 = auf verwaiste Host-Prüfungen prüfen (Default)

**Service-Frischeprüfungsoption** (Service Freshness Checking Option)

Format:

**check\_service\_freshness=\<0/1\>**

Beispiel:

**check\_service\_freshness=0**

Diese Option legt fest, ob Icinga regelmäßig die "Frische" (freshness)
von Service-Prüfungen prüft. Das Aktivieren dieser Option ist nützlich,
um sicherzustellen, dass [passive
Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
rechtzeitig empfangen werden. Mehr Informationen zur Frische-Prüfung
finden Sie
[hier](freshness.md "7.5. Service- und Host-Frische-Prüfungen").

-   0 = Service-Frische nicht prüfen

-   1 = Service-Frische prüfen (Default)

**Service-Frische-Prüfintervall** (Service Freshness Check Interval)

Format:

**service\_freshness\_check\_interval=\<seconds\>**

Beispiel:

**service\_freshness\_check\_interval=60**

Diese Einstellung legt fest, wie oft (in Sekunden) Icinga regelmäßig die
"Frische" (freshness) von Service-Prüfergebnissen prüfen wird. Wenn Sie
die Service-Frische-Prüfung (mit der
[check\_service\_freshness](configmain.md#configmain-check_service_freshness)-Option)
deaktiviert haben, dann hat diese Option keine Auswirkungen. Mehr
Informationen zur Frische-Prüfung finden Sie
[hier](freshness.md "7.5. Service- und Host-Frische-Prüfungen").

**Host-Frischeprüfungsoption** (Host Freshness Checking Option)

Format:

**check\_host\_freshness=\<0/1\>**

Beispiel:

**check\_host\_freshness=0**

Diese Option legt fest, ob Icinga regelmäßig die "Frische" (freshness)
von Host-Prüfungen prüft. Das Aktivieren dieser Option ist nützlich, um
sicherzustellen, dass [passive
Host-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
rechtzeitig empfangen werden. Mehr Informationen zur Frische-Prüfung
finden Sie
[hier](freshness.md "7.5. Service- und Host-Frische-Prüfungen").

-   0 = Host-Frische nicht prüfen (Default)

-   1 = Host-Frische prüfen

**Host-Frische-Prüfintervall** (Host Freshness Check Interval)

Format:

**host\_freshness\_check\_interval=\<seconds\>**

Beispiel:

**host\_freshness\_check\_interval=60**

Diese Einstellung legt fest, wie oft (in Sekunden) Icinga regelmäßig die
"Frische" (freshness) von Host-Prüfergebnissen prüfen wird. Wenn Sie die
Host-Frische-Prüfung (mit der
[check\_host\_freshness](configmain.md#configmain-check_host_freshness)-Option)
deaktiviert haben, dann hat diese Option keine Auswirkungen. Mehr
Informationen zur Frische-Prüfung finden Sie
[hier](freshness.md "7.5. Service- und Host-Frische-Prüfungen").

**zusätzliche Frische-Latenzschwellwert-Option** (Additional Freshness
Threshold Latency Option)

Format:

**additional\_freshness\_latency=\<\#\>**

Beispiel:

**additional\_freshness\_latency=15**

Diese Option legt die Anzahl von Sekunden fest, die Icinga zu jedem
Host- oder Service-Frischeschwellwert hinzurechnet, den es automatisch
berechnet (d.h., die nicht explizit durch den Benutzer angegeben
wurden). Mehr Informationen zur Frische-Prüfung finden Sie
[hier](freshness.md "7.5. Service- und Host-Frische-Prüfungen").

**Lokation des P1.pl Perl-Skriptes** (P1.PL File Location)

Format:

**p1\_file=@P1FILELOC@/p1.pl**

Diese Option gibt den Speicherort des p1.pl Perl-Skriptes an das vom
eingebetteten Perl- Interpreter genutzt wird. Diese Option ist aktiv
wenn Sie Icinga mit eingebetteten Perl- Interpreter compiliert haben.

**eingebetteter-Perl-Interpreter-Option** (Embedded Perl Interpreter
Option)

Format:

**enable\_embedded\_perl=\<0/1\>**

Beispiel:

**enable\_embedded\_perl=0**

Diese Einstellung legt fest, ob der eingebettete Perl-Interpreter auf
programmweiter Basis aktiviert ist. Icinga muss mit Unterstützung für
eingebettetes Perl kompiliert sein, damit diese Option eine Auswirkung
hat. Mehr Informationen zum eingebauten Perl-Interpreter finden Sie
[hier](embeddedperl.md "7.18. Benutzen des Embedded Perl Interpreters").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5 hat sich der Default geändert. Vorher war diese Direktive
aktiviert, nun ist sie *deaktiviert*.

**Option implizite Nutzung des eingebetteten Perl-Interpreters**
(Embedded Perl Implicit Use Option)

Format:

**use\_embedded\_perl\_implicitly=\<0/1\>**

Beispiel:

**use\_embedded\_perl\_implicitly=1**

Diese Einstellung legt fest, ob der eingebettete Perl-Interpreter für
Perl-Plugins/Scripte benutzt werden soll, die ihn nicht explizit
aktiviert/deaktiviert haben. Icinga muss mit Unterstützung für
eingebettetes Perl kompiliert sein, damit diese Option eine Auswirkung
hat. Mehr Informationen zum eingebauten Perl-Interpreter finden Sie
[hier](embeddedperl.md "7.18. Benutzen des Embedded Perl Interpreters").

**Datumformat** (Date Format)

Format:

**date\_format=\<option\>**

Beispiel:

**date\_format=us**

Diese Option erlaubt es Ihnen anzugeben, welche Art von
Datums-/Zeitformat Icinga im Web-Interface und in den
Datums-/Zeit-[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
benutzen soll. Mögliche Optionen (zusammen mit einer Beispielausgabe)
umfassen u.a.:

**Option**

**Ausgabeformat**

**Beispielausgabe**

us

MM-DD-YYYY HH:MM:SS

06-30-2002 03:15:00

euro

DD-MM-YYYY HH:MM:SS

30-06-2002 03:15:00

iso8601

YYYY-MM-DD HH:MM:SS

2002-06-30 03:15:00

strict-iso8601

YYYY-MM-DDTHH:MM:SS

2002-06-30T03:15:00

**Zeitzonen-Option** (Timezone Option)

Format:

**use\_timezone=\<tz\>**

Beispiel:

**use\_timezone=US/Mountain**

Diese Option erlaubt es Ihnen, die Standard-Zeitzone zu überschreiben,
in der die Icinga-Instanz läuft. Das ist nützlich, wenn Sie mehrere
Icinga-Instanzen haben, die auf dem gleichen Server laufen, aber mit
verschiedenen lokalen Zeiten verbunden sind. Wenn nichts angegeben ist,
wird Icinga die Zeitzone des Rechners benutzen.

![](../images/note.gif) Anmerkung: wenn Sie diese Option nutzen, um eine
eigene Zeitzone anzugeben, müssen Sie auch die
Apache-Konfigurationsdirektiven für die CGIs auf die Zeitzone ändern,
die Sie haben möchten. Beispiel:

\<Directory "/usr/local/icinga/sbin/"\>

SetEnv TZ "US/Mountain"

...

\</Directory\>

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von Ihrem Betriebssystem kann es sein, dass Sie vor der
Zeitzone einen Doppelpunkt einfügen müssen, damit es wie gewünscht
funktioniert

`use_timezone=:US/Mountain`{.literal}

**Illegale Zeichen für Objektnamen** (Illegal Object Name Characters)

Format:

**illegal\_object\_name\_chars=\<chars...\>**

Beispiel:

**illegal\_object\_name\_chars=\`\~!\$%\^&\*"|'\<\>?,()=**

Diese Option erlaubt es Ihnen, illegale Zeichen anzugeben, die nicht in
Host-Namen, Service-Beschreibungen oder Namen anderer Objektarten
benutzt werden können. Icinga gestattet Ihnen, die meisten Zeichen in
Objektdefinitionen zu benutzen, aber wir raten Ihnen, die im Beispiel
gezeigten Zeichen nicht zu nutzen. Wenn Sie es dennoch tun, können Sie
Probleme im Web-Interface, in Benachrichtigungsbefehlen usw. bekommen.

**illegale Zeichen für Makroausgaben** (Illegal Macro Output Characters)

Format:

**illegal\_macro\_output\_chars=\<chars...\>**

Beispiel:

**illegal\_macro\_output\_chars=\`\~\$&"|'\<\>**

Diese Option erlaubt es Ihnen, illegale Zeichen anzugeben, die aus
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
entfernt werden, bevor diese in Benachrichtigungen, Eventhandlern und
anderen Befehlen benutzt werden. Dies betrifft AUCH Makros, die in
Service- oder Host-Prüfbefehlen benutzt werden. Sie können sich
entscheiden, die Zeichen im Beispiel nicht zu entfernen, aber wir raten
Ihnen, das nicht zu tun. Einige dieser Zeichen werden von der Shell
interpretiert (z.B. der "Backtick") und können zu Sicherheitsproblemen
führen. Die folgenden Makros werden von den Zeichen gereinigt, die Sie
angeben:

**\$HOSTOUTPUT\$**, **\$HOSTPERFDATA\$**, **\$HOSTACKAUTHOR\$**,
**\$HOSTACKCOMMENT\$**, **\$SERVICEOUTPUT\$**, **\$SERVICEPERFDATA\$**,
**\$SERVICEACKAUTHOR\$**, und **\$SERVICEACKCOMMENT\$**

**Option Behalten von unbekannten Makros**

Format:

**keep\_unknown\_macros=\<0/1\>**

Beispiel:

**keep\_unknown\_macros=0**

Diese Option kann verwendet werden, um unbekannte Makros in der Ausgabe
zu belassen, z.B. check\_proc -C \$foo\$, verbleibt in der
Kommandozeile. Die Shell versucht \$foo zu interpretieren und belässt
ein einzelnes \$- Zeichen in der Ausgabe. Ab Icinga 1.8 werden solche
unbekannten Makros aus der Ausgabe gelöscht. Siehe auch
[\#2291](https://dev.icinga.org/issues/2291)für weitere Informationen.
Um das alte Verhalten wieder herzustellen muss diese Option aktiviert
werden.

**Option Anpassung regulärer Ausdrücke** (Regular Expression Matching
Option)

Format:

**use\_regexp\_matching=\<0/1\>**

Beispiel:

**use\_regexp\_matching=0**

Diese Option legt fest, ob verschiedene Direktiven in Ihren
[Objektdefinitionen](configobject.md "3.3. Überblick Objektkonfiguration")
als reguläre Ausdrücke verarbeitet werden. Mehr Informationen dazu, wie
das funktioniert, finden Sie
[hier](objecttricks.md "7.27. Zeitsparende Tricks für Objektdefinitionen").

-   0 = keine angepassten regulären Ausdrücke benutzen (Default)

-   1 = angepasste reguläre Ausdrücke benutzen

**Option wahre reguläre Ausdrucksanpassung** (True Regular Expression
Matching Option)

Format:

**use\_true\_regexp\_matching=\<0/1\>**

Beispiel:

**use\_true\_regexp\_matching=0**

Wenn Sie reguläre Ausdrücke von verschiedenen Objektdirektiven mit der
[use\_regexp\_matching](configmain.md#configmain-use_regexp_matching)-Option
aktiviert haben, dann wird diese Option festlegen, wann Objektdirektiven
als reguläre Ausdrücke behandelt werden. Wenn diese Option deaktiviert
ist (der Standard), dann werden Direktiven nur dann als reguläre
Ausdrücke behandelt, wenn sie **\***, **?**, ***\$,* +** oder **\\.**
enthalten (POSIX ERE). Wenn diese Option aktiviert ist, werden alle
entsprechenden Direktiven als reguläre Ausdrücke behandelt - seien Sie
vorsichtig bei der Aktivierung! Mehr Informationen darüber, wie das
funktioniert, finden Sie
[hier](objecttricks.md "7.27. Zeitsparende Tricks für Objektdefinitionen").

-   0 = keine Anpassung wahrer regulärer Ausdrücke benutzen (Default)

-   1 = Anpassung wahrer regul¨rer Ausdrücke benutzen

**Administrator-e-Mail-Adresse** (Administrator Email Address)

Format:

**admin\_email=\<email\_address\>**

Beispiel:

**admin\_email=root@localhost.localdomain**

Dies ist die e-Mail-Adresse des Administrators der lokalen Maschine
(d.h. die, auf der Icinga läuft). Dieser Wert kann mit Hilfe des
**\$ADMINEMAIL\$**-[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
in Benachrichtigungsbefehlen benutzt werden.

**Administrator-Pager** (Administrator Pager)

Format:

**admin\_pager=\<pager\_number\_or\_pager\_email\_gateway\>**

Beispiel:

**admin\_pager=pageroot@localhost.localdomain**

Dies ist die Pager-Nummer (oder die des Pager-e-Mail-Gateways) des
Administrators der lokalen Maschine (d.h. die, auf der Icinga läuft).
Die Pager-Nummer/Adresse kann mit Hilfe des
**\$ADMINPAGER\$**-[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
in Benachrichtigungsbefehlen benutzt werden.

**Daemon Core Dump Option**

Format:

**daemon\_dumps\_core=\<0/1\>**

Beispiel:

**daemon\_dumps\_core=1**

Diese Direktive bestimmt ob es Icinga, wenn es als Daemon gestartet
wird, erlaubt ist Core Dumps zu erstellen. Dies kann im Fehlerfall sehr
hilfsreich sein, allerdings garantiert das Aktivieren dieser Option
nicht, dass auch wirklich ein Core Dump erstellt wird.

-   0 = Keine Core Dumps (Default)

-   1 = Erlaube Core Dumps

**Ereignisvermittler-Optionen** (Event Broker Options)

Format:

**event\_broker\_options=\<\#\>**

Beispiel:

**event\_broker\_options=-1**

Diese Option kontrolliert, welche Daten an den Ereignisvermittler
gesandt werden und damit an jedes geladene Ereignisvermittler-Modul.
Dies ist ein fortgeschrittenes Feature. Falls Sie im Zweifel sind,
vermitteln Sie entweder gar nichts (wenn Sie keine
Ereignisvermittler-Module benutzen) oder alles (wenn Sie
Ereignisvermittler-Module benutzen). Mögliche Werte sehen Sie
nachfolgend.

-   0 = nichts vermitteln

-   -1 = alles vermitteln

-   \# = sehen Sie sich die BROKER\_\*-Definitionen im Quellcode an
    (include/broker.h), um andere Werte zu ermitteln

**Ereignisvermittler-Module** (Event Broker Modules)

Format:

**broker\_module=\<modulepath\> [moduleargs]**

Beispiel:

**broker\_module=/usr/local/icinga/lib/idomod.so
cfg\_file=/usr/local/icinga/etc/idomod.cfg**

Diese Option wird benutzt, um ein Ereignisvermittler-Modul anzugeben,
das beim Icinga-Start geladen werden soll. Benutzen Sie mehrere
Direktiven, wenn Sie mehrere Module laden wollen. An das Modul zu
übergebende Argumente werden durch ein Leerzeichen vom Pfad des Moduls
getrennt.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist veraltet seit Icinga 1.13. Verwenden Sie bitte die
[Module-Objectdefinition](objectdefinitions.md#objectdefinitions-module)
stattdessen.

**Debug-Datei** (Debug File)

Format:

**debug\_file=\<file\_name\>**

Beispiel:

**debug\_file=/usr/local/icinga/var/nagios.debug**

Diese Option legt fest, wohin Icinga Debugging-Informationen schreiben
soll. Welche Informationen (falls überhaupt) geschrieben werden, wird
durch die [debug\_level](configmain.md#configmain-debug_level)- und
[debug\_verbosity](configmain.md#configmain-debug_verbosity)-Optionen
festgelegt. Sie können die Debug-Datei automatisch rotieren lassen, wenn
sie eine bestimmte Größe überschreitet, die Sie über die
[max\_debug\_file\_size](configmain.md#configmain-max_debug_file_size)-Option
festlegen können.

**Debug-Stufe** (Debug Level)

Format:

**debug\_level=\<\#\>**

Beispiel:

**debug\_level=24**

Diese Option legt fest, welche Arten von Informationen Icinga in das
[debug\_file](configmain.md#configmain-debug_file) schreiben soll.
Dieser Wert ist ein logisches ODER der nachfolgenden Werte:

-   -1 = alles protokollieren

-   0 = nichts protokollieren (Default)

-   1 = Informationen zu Funktionsbeginn/Ende

-   2 = Konfigurationsinformationen

-   4 = Prozessinformationen

-   8 = geplante Ereignisinformationen

-   16 = Host-/Service-Prüfinformationen

-   32 = Benachrichtigungsinformationen

-   64 = Ereignisvermittlerinformationen

-   128 = Externe Kommandos

-   256 = Befehle

-   512 = Geplante Ausfallzeiten

-   1024 = Kommentare

-   2048 = Makros

**Debug-Ausführlichkeit** (Debug Verbosity)

Format:

**debug\_verbosity=\<\#\>**

Beispiel:

**debug\_verbosity=1**

Diese Option legt fest, wie viel Debugging-Informationen Icinga in das
[debug\_file](configmain.md#configmain-debug_file) schreiben soll.

-   0 = grundlegende Informationen

-   1 = detailliertere Informationen (Default)

-   2 = sehr detaillierte Informationen

**maximale Debug-Dateigröße** (Maximum Debug File Size)

Format:

**max\_debug\_file\_size=\<\#\>**

Beispiel:

**max\_debug\_file\_size=1000000**

Diese Option legt die maximale Größe (in Bytes) der
[Debug-Datei](configmain.md#configmain-debug_file) fest. Wenn die
Datei die Größe überschreitet, dann wird ".old" als Erweiterung
angehängt. Wenn bereits eine Datei mit der ".old"-Erweiterung existiert,
wird diese gelöscht. Das stellt sicher, dass Ihr Plattenplatz nicht
außer Kontrolle gerät, wenn Sie Icinga debuggen.

**Ereignis-Profiling**

Format:

**event\_profiling\_enabled=\<0/1\>**

Example:

**event\_profiling\_enabled=1**

Diese Option aktiviert oder deaktiviert die Statistik für Ereignisse und
deren Ausführungsdauer. Diese Option ist für Solaris mit gcc3 nicht
verfügbar.

**Leere Hostgruppenzuordnung erlauben**

Format:

**allow\_empty\_hostgroup\_assignment=\<0|1\>**

Beispiel:

**allow\_empty\_hostgroup\_assignment=1**

Diese boolesche Option legt fest, ob Services, Host-Abhängigkeiten oder
Service-Abhängigkeiten, die leeren Hostgruppen zuordnet sind
(Hostgruppen ohne Host-Member), Icinga beim Start (oder bei der
Konfigurationsprüfung) mit einem Fehler abbrechen lassen oder nicht. Das
Default-Verhalten, wenn die Option nicht in der Hauptkonfigurationsdatei
vorhanden ist (oder auf "0" gesetzt ist), besteht darin, dass Icinga mit
einem Fehler abbricht, wenn Services, Host-Abhängigkeiten oder
Service-Abhängigkeiten, mit Hostgruppen verbunden sind, denen in der
hostgroup-Definition keine Host-Member zugeordnet sind.

Aktivieren dieser Option kann sinnvoll sein, wenn:

-   Konfigurationdateien oder vorgespeicherte Objektdateien an viele
    Icinga-Poller verteilt werden.

-   Automation benutzt wird, um einen "Baum" mit
    Icinga-Konfigurationsdateien zu erzeugen.

-   es einen Satz von Services, Host-Abhängigkeiten oder
    Service-Abhängigkeiten gibt, der von Administrationen verwaltet
    werden, be dem Benutzer der Einfachheit halber Hosts über die
    Hostgruppenzugehörigkeit hinzufügen können (z.B. eine Suite von
    Prüfungen, die mit einem entfernten Überwachungsagenten verbunden
    sind), wobei es aber keine Garantie dafür gibt, dass die Benutzer
    die Services verwenden, die mit der Hostgruppe verbunden sind, oder
    dass die Hosts existieren (z.B. ein entfernter Agent, dessen Hosts
    mit der Zeit stillgelegt werden).

**Leere Performance-Ergebnisse verarbeiten**

Format:

**host\_perfdata\_process\_empty\_results=\<0|1\>**

**service\_perfdata\_process\_empty\_results=\<0|1\>**

Beispiel:

**host\_perfdata\_process\_empty\_results=1**

**service\_perfdata\_process\_empty\_results=1**

Diese Optionen legen fest, ob der Core leere
Performance-Daten-Ergebnisse verarbeiten soll oder nicht. Dies wird für
verteilte Überwachung benötigt und ist per Default aktiviert. Wenn Sie
keine leeren Performance-Daten benötigen - und ein paar CPU-Zyklen bei
der Berechnung von Makros sparen wollen - dann können Sie diese Optionen
abschalten. Seien Sie vorsichtig! Werte: 1 = aktiviert, 0 = deaktiviert.

**Anzahl von Einträgen in Check-Result-Liste begrenzen**

Format:

**max\_check\_result\_list\_items=\<n\>**

Beispiel:

**max\_check\_result\_list\_items=1024**

Diese experimentelle Option erlaubt es Ihnen, die maximale Anzahl von
Einträgen zu begrenzen, die der Check-Result-Reaper in die
Check-Result-Liste stellt, damit sie vom Code weiter bearbeitet wird.
Wenn dies zuviele sind, wird das "Reaping" vorzeitig beendet, damit der
Coe die Ergebnisse früher verarbeiten kann. In größeren Setups könnte
diese Liste zu sehr wachsen und die Performance verschlechtern. Sie
können mit diesem Wert experimentieren, wobei der Core-Default "0" ist,
wodurch dieses Feature deaktiviert ist (die Größe der Liste wird nicht
begrenzt). Werte: 0 = Deaktieren der Begrenzung; Anzahl = max. Anzahl
der Einträge in der Check-Result-Liste

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.8

* * * * *

  ------------------------------- -------------------------- -------------------------------------
  [Zurück](config.md)           [Nach oben](ch03.md)      [Weiter](configobject.md)
  3.1. Konfigurationsüberblick    [Zum Anfang](index.md)    3.3. Überblick Objektkonfiguration
  ------------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
