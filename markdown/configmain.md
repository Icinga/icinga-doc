Optionen der Hauptkonfigurationsdatei
=====================================

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
(*URL-ICINGA-CFG*) wird installiert, wenn Sie der
[Schnellstartanleitung](#quickstart) folgen.

**Position der Konfigurationsdatei**

Die Hauptkonfigurationsdatei heißt üblicherweise *icinga.cfg* und ist im
*URL-ICINGA-BASE/etc/*-Verzeichnis zu finden.

**Variablen der Konfigurationsdatei**

Nachfolgend finden Sie Beschreibungen jeder Option der
NAME-ICINGA-Hauptkonfigurationsdatei...

**Protokolldatei** (Log File)

  ------ -----------------------------------------------------------------
  Format **log\_file=\<file\_name\>**
  :      

  Beispi ***log\_file=URL-ICINGA-BASE/var/icinga.log***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable gibt an, wo NAME-ICINGA die Hauptprotokolldatei anlegen
soll. Dies sollte die erste Variable sein, die Sie in Ihrer
Konfigurationsdatei definieren, weil NAME-ICINGA versucht, dorthin die
Fehler zu schreiben, die es in den übrigen Konfigurationsdaten findet.
Wenn Sie [Log-Rotation](#configmain-log_rotation_method) aktiviert
haben, dann wird diese Datei automatisch jede Stunde, jeden Tag, jede
Woche oder jeden Monat rotiert.

**Objektkonfigurationsdatei** (Object Configuration File)

  ------ -----------------------------------------------------------------
  Format **cfg\_file=\<file\_name\>**
  :      

  Beispi ***cfg\_file=URL-ICINGA-BASE/etc/conf.d/hosts.cfg***
  el:    
         ***cfg\_file=URL-ICINGA-BASE/etc/conf.d/services.cfg***
         
         ***cfg\_file=URL-ICINGA-BASE/etc/commands.cfg***
  ------ -----------------------------------------------------------------

Diese Direktive wird benutzt, um eine
[Objektkonfigurationsdatei](#configobject) anzugeben, die
Objektdefinitionen enthält, die NAME-ICINGA zur Überwachung nutzen soll.
Objektkonfigurationsdateien enthalten Definitionen für Hosts,
Hostgruppen, Kontakte, Kontaktgruppe, Services, Befehle usw. Sie können
Ihre Konfigurationsinformationen in verschiedene Dateien aufteilen und
mehrere *cfg\_file=*-Einträge angeben, um jede einzelne zu verarbeiten.

> **Note**
>
> Wenn Sie `cfg_file=.../foo/bar.cfg` für eine Datei benutzen, die im
> gleichen Verzeichnis liegt, das Sie mit `cfg_dir=.../foo` angegeben
> haben, dann wird diese Datei zweimal verarbeitet und führt dadurch zu
> einem Fehler bei der Überprüfung der Konfigurationsdateien.

**Objektkonfigurationsverzeichnis** (Object Configuration Directory)

  ------ -----------------------------------------------------------------
  Format **cfg\_dir=\<directory\_name\>**
  :      

  Beispi ***cfg\_dir=URL-ICINGA-BASE/etc/conf.d***
  el:    
  ------ -----------------------------------------------------------------

Diese Direktive wird benutzt, um ein Verzeichnis anzugeben, das
[Objektkonfigurationsdateien](#configobject) enthält, die NAME-ICINGA
zur Überwachung nutzen soll. Alle Dateien in dem Verzeichnis mit einer
*.cfg*-Endung werden als Objektkonfigurationsdateien verarbeitet.
Zusätzlich wird NAME-ICINGA rekursiv alle Konfigurationsdateien in den
Unterverzeichnissen des Verzeichnisses verarbeiten, das Sie angegeben
haben. Sie können Ihre Konfigurationsinformationen in verschiedene
Verzeichnisse aufteilen und mehrere *cfg\_dir=*-Einträge angeben, um
alle Konfigurationsdateien jedes einzelnen Verzeichnisses zu
verarbeiten.

> **Note**
>
> Wenn Sie `cfg_file=.../foo/bar.cfg` für eine Datei benutzen, die im
> gleichen Verzeichnis liegt, das Sie mit `cfg_dir=.../foo` angegeben
> haben, dann wird diese Datei zweimal verarbeitet und führt dadurch zu
> einem Fehler bei der Überprüfung der Konfigurationsdateien.

**Objekt-Cache-Datei** (Object Cache File)

  ------ -----------------------------------------------------------------
  Format **object\_cache\_file=\<file\_name\>**
  :      

  Beispi ***object\_cache\_file=URL-ICINGA-BASE/var/objects.cache***
  el:    
  ------ -----------------------------------------------------------------

Diese Direktive wird benutzt, um eine Datei anzugeben, in der eine
zwischengespeicherte (cached) Kopie der
[Objektdefinitionen](#configobject) abgelegt wird. Die Cache-Datei wird
jedes Mal (erneut) angelegt, wenn NAME-ICINGA (erneut) gestartet wird,
und wird von den CGIs benutzt. Sie ist dazu gedacht, die
Zwischenspeicherung der Konfigurationsdateien in den CGIs zu
beschleunigen und es Ihnen zu erlauben, die
[Objektkonfigurationsdateien](#configmain-cfg_file) zu editieren,
während NAME-ICINGA läuft, ohne die Ausgaben der CGIs zu beeinflussen.

**vorgespeicherte Objektdatei** (Precached Object File)

  ------ -----------------------------------------------------------------
  Format **precached\_object\_file=\<file\_name\>**
  :      

  Beispi ***precached\_object\_file=URL-ICINGA-BASE/var/objects.precache**
  el:    *
  ------ -----------------------------------------------------------------

Diese Direktive wird benutzt, um eine Datei anzugeben, die eine
vorverarbeitete (pre-processed), vorgespeicherte (pre-cached) Kopie von
[Objektdefinitionen](#configobject) enthält. Diese Datei kann genutzt
werden, um drastisch den Startvorgang in großen/komplexen
NAME-ICINGA-Installationen zu beschleunigen. Lesen Sie
[hier](#faststartup), wie der Startvorgang beschleunigt werden kann.

**Ressource-Datei** (Resource File)

  ------ -----------------------------------------------------------------
  Format **resource\_file=\<file\_name\>**
  :      

  Beispi ***resource\_file=URL-ICINGA-BASE/etc/resource.cfg***
  el:    
  ------ -----------------------------------------------------------------

Dies wird benutzt, um eine optionale Ressource-Datei anzugeben, die
\$USERn\$-[Makro](#macros)-Definitionen enthalten kann. \$USER\$-Makros
sind sinnvoll zur Speicherung von Benutzernamen, Passwörtern und
Objekten, die häufig in Befehlsdefinitionen (wie z.B. Verzeichnispfade)
benutzt werden. Die CGIs werden *nicht* versuchen, Ressource-Dateien zu
lesen, so dass Sie die Berechtigungen beschränken können (600 oder 660),
um sensible Informationen zu schützen. Sie können mehrere
Ressource-Dateien angeben, indem Sie mehrere resource\_file-Einträge in
die Hauptkonfigurationsdatei aufnehmen. NAME-ICINGA wird sie alle
verarbeiten. Schauen Sie in die resource.cfg-Datei im
*sample-config/*-Unterverzeichnis der NAME-ICINGA-Distribution, um ein
Beispiel für die Definition von \$USER\$-Makros zu sehen.

**temporäre Datei** (Temp File)

  ------ -----------------------------------------------------------------
  Format **temp\_file=\<file\_name\>**
  :      

  Beispi ***temp\_file=URL-ICINGA-BASE/var/icinga.tmp***
  el:    
  ------ -----------------------------------------------------------------

Dies ist eine temporäre Datei, die NAME-ICINGA periodisch anlegt, wenn
Kommentardaten, Statusdaten usw. aktualisiert werden. Die Datei wird
gelöscht, wenn sie nicht länger benötigt wird.

**temporärer Pfad** (Temp Path)

  ------ -----------------------------------------------------------------
  Format **temp\_path=\<dir\_name\>**
  :      

  Beispi ***temp\_path=/tmp***
  el:    
  ------ -----------------------------------------------------------------

Dies ist ein Verzeichnis, das NAME-ICINGA als "Schmierblock" (scratch
space) benutzen kann, um während des Überwachungsprozesses temporäre
Dateien anlegen zu können. Sie sollten *tmpwatch* oder ein ähnliches
Programm ausführen, um in diesem Verzeichnis Dateien zu löschen, die
älter als 24 Stunden sind.

**Status-Datei** (Status File)

  ------ -----------------------------------------------------------------
  Format **status\_file=\<file\_name\>**
  :      

  Beispi ***status\_file=URL-ICINGA-BASE/var/status.dat***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Datei, die NAME-ICINGA nutzt, um den aktuellen Zustand,
Kommentar- und Ausfallzeitinformationen zu speichern. Diese Datei wird
von den CGIs genutzt, so dass der aktuelle Überwachungszustand über ein
Web-Interface berichtet werden kann. Die CGIs müssen Lesezugriff auf
diese Datei haben, um richtig funktionieren zu können. Diese Datei wird
jedes Mal gelöscht, wenn NAME-ICINGA endet und neu angelegt, wenn
NAME-ICINGA startet.

**Statusdatei-Aktualisierungsintervall** (Status File Update Interval)

  ------ -----------------------------------------------------------------
  Format **status\_update\_interval=\<seconds\>**
  :      

  Beispi ***status\_update\_interval=15***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, wie oft (in Sekunden) NAME-ICINGA
Statusdaten in der [Statusdatei](#configmain-status_file) aktualisiert.
Das kleinste Aktualisierungsintervall ist eine Sekunde.

**NAME-ICINGA-Benutzer** (NAME-ICINGA User)

  ------ -----------------------------------------------------------------
  Format **icinga\_user=\<username/UID\>**
  :      

  Beispi ***icinga\_user=nagios***
  el:    
  ------ -----------------------------------------------------------------

Dies wird benutzt, um den "eigentlichen" (effective) Benutzer zu setzen,
mit dem der NAME-ICINGA-Prozess laufen soll. Nach dem anfänglichen
Programmstart und bevor irgendeine Überwachung beginnt, wird NAME-ICINGA
die vorhandenen Berechtigungen "fallen lassen" (drop) und als dieser
Benutzer laufen. Sie können entweder einen Benutzernamen oder eine UID
angeben.

**NAME-ICINGA-Gruppe** (NAME-ICINGA Group)

  ------ -----------------------------------------------------------------
  Format **icinga\_group=\<groupname/GID\>**
  :      

  Beispi ***icinga\_group=nagios***
  el:    
  ------ -----------------------------------------------------------------

Dies wird benutzt, um die "eigentliche" (effective) Gruppe zu setzen,
mit der der NAME-ICINGA-Prozess laufen soll. Nach dem anfänglichen
Programmstart und bevor irgendeine Überwachung beginnt, wird NAME-ICINGA
die vorhandenen Berechtigungen "fallen lassen" (drop) und als diese
Gruppe laufen. Sie können entweder einen Gruppennamen oder eine GID
angeben.

**Benachrichtigungsoption** (Notifications Option)

  ------ -----------------------------------------------------------------
  Format **enable\_notifications=\<0/1\>**
  :      

  Beispi ***enable\_notifications=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA
[Benachrichtigungen](#notifications) versendet. Wenn diese Optionen
deaktiviert ist, wird NAME-ICINGA nach dem (Neu-) Start keine
Benachrichtigungen für irgendeinen Host oder Service versenden.
Anmerkung: Wenn Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = Benachrichtigungen deaktivieren

-   1 = Benachrichtigungen aktivieren (Default)

**Option Service-Prüfungen ausführen** (Service Check Execution Option)

  ------ -----------------------------------------------------------------
  Format **execute\_service\_checks=\<0/1\>**
  :      

  Beispi ***execute\_service\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA nach dem (Neu-) Start
Service-Prüfungen ausführt. Wenn diese Option deaktiviert ist, wird
NAME-ICINGA nicht aktiv irgendwelche Service-Prüfungen ausführen und in
einer Art von "Schlafmodus" verbleiben (es kann weiterhin [passive
Prüfungen](#passivechecks) empfangen, es sei denn, Sie haben [diese
deaktiviert](#configmain-accept_passive_service_checks)). Diese Option
wird oft benutzt, wenn Ersatz-Überwachungs-Server (backup monitoring
server) konfiguriert werden, wie dies in der Dokumentation zu
[Redundanz](#redundancy) beschrieben ist, oder wenn Sie eine
[verteilte](#distributed)-Überwachungsumgebung aufbauen. Anmerkung: wenn
Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = keine Service-Prüfungen ausführen

-   1 = Service-Prüfungen ausführen (Default)

**Option passive Service-Prüfungen akzeptieren** (Passive Service Check
Acceptance Option)

  ------ -----------------------------------------------------------------
  Format **accept\_passive\_service\_checks=\<0/1\>**
  :      

  Beispi ***accept\_passive\_service\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA nach dem (Neu-) Start [passive
Service-Prüfungen](#passivechecks) akzeptiert. Wenn diese Option
deaktiviert ist, wird NAME-ICINGA keine passiven Service-Prüfungen
akzeptieren. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = keine passiven Service-Prüfungen akzeptieren

-   1 = passive Service-Prüfungen akzeptieren (Default)

**Option Host-Prüfungen ausführen** (Host Check Execution Option)

  ------ -----------------------------------------------------------------
  Format **execute\_host\_checks=\<0/1\>**
  :      

  Beispi ***execute\_host\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA nach dem (Neu-) Start nach Bedarf
oder regelmäßig geplante Host-Prüfungen ausführt. Wenn diese Option
deaktiviert ist, wird NAME-ICINGA nicht aktiv irgendwelche
Host-Prüfungen ausführen, obwohl es weiterhin [passive
Host-Prüfungen](#passivechecks) empfangen wird, es sei denn, Sie haben
[diese deaktiviert](#configmain-accept_passive_host_checks)). Diese
Option wird am meisten genutzt, wenn Ersatz-Überwachungs-Server (backup
monitoring server) konfiguriert werden, wie dies in der Dokumentation zu
[Redundanz](#redundancy) beschrieben ist, oder wenn Sie eine
[verteilte](#distributed)-Überwachungsumgebung aufbauen. Anmerkung: wenn
Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = keine Host-Prüfungen ausführen

-   1 = Host-Prüfungen ausführen (Default)

**Option passive Host-Prüfungen akzeptieren** (Passive Host Check
Acceptance Option)

  ------ -----------------------------------------------------------------
  Format **accept\_passive\_host\_checks=\<0/1\>**
  :      

  Beispi ***accept\_passive\_host\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA nach dem (Neu-) Start [passive
Host-Prüfungen](#passivechecks) akzeptiert. Wenn diese Option
deaktiviert ist, wird NAME-ICINGA keine passiven Host-Prüfungen
akzeptieren. Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = keine passiven Host-Prüfungen akzeptieren

-   1 = passive Host-Prüfungen akzeptieren (Default)

**Eventhandler-Option** (Event Handler Option)

  ------ -----------------------------------------------------------------
  Format **enable\_event\_handlers=\<0/1\>**
  :      

  Beispi ***enable\_event\_handlers=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA nach dem (Neu-) Start
[Eventhandler](#eventhandlers) ausführt. Wenn diese Option deaktiviert
ist, wird NAME-ICINGA keine Host- oder Service-Eventhandler ausführen.
Anmerkung: wenn Sie
[Statusinformationsaufbewahrung](#configmain-retain_state_information)
(retain state information) aktiviert haben, wird NAME-ICINGA diese
Einstellung ignorieren, wenn es (erneut) startet und die letzte bekannte
Einstellung dieser Option nutzen (wie sie in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file) abgelegt
ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.
Die Werte sind wie folgt:

-   0 = Eventhandler deaktivieren

-   1 = Eventhandler aktivieren (Default)

**Protokollrotationsmethode** (Log Rotation Method)

  ------ -----------------------------------------------------------------
  Format **log\_rotation\_method=\<n/h/d/w/m\>**
  :      

  Beispi ***log\_rotation\_method=d***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Rotationsmethode, die NAME-ICINGA für Ihre Protokolldatei
nutzen soll. Die Werte sind wie folgt:

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

  ------ -----------------------------------------------------------------
  Format **log\_archive\_path=\<path\>**
  :      

  Beispi ***log\_archive\_path=URL-ICINGA-BASE/var/archives/***
  el:    
  ------ -----------------------------------------------------------------

Dies ist das Verzeichnis, in dem NAME-ICINGA die Protokolldateien
ablegen soll, die rotiert wurden. Diese Option wird ignoriert, wenn Sie
die Funktionalität der
[Protokollrotation](#configmain-log_rotation_method) (log rotation)
nicht nutzen.

**Protokollierungsoptionen des Daemons** (LOGGING OPTIONS FOR DAEMON)

  ------ -----------------------------------------------------------------
  Format **use\_daemon\_log=\<0/1\>**
  :      

  Beispi ***use\_daemon\_log=1***
  el:    
  ------ -----------------------------------------------------------------

Mit dieser Option können Sie die Protokollierung des Log-Daemons in die
Protokolldatei (normalerweise icinga.log) ein- und abschalten.

-   0 = keine Protokollierung

-   1 = Protokollierung (Default)

**Option externe Befehle prüfen** (External Command Check Option)

  ------ -----------------------------------------------------------------
  Format **check\_external\_commands=\<0/1\>**
  :      

  Beispi ***check\_external\_commands=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA das [command
file](#configmain-command_file) auf auszuführende Befehle prüfen soll.
Diese Option muss aktiviert sein, wenn Sie planen, das
[Command-CGI](#cgis-cmd_cgi) zu nutzen, um Befehle über das
Web-Interface zu erteilen. NAME-WEB und Addons wie NAME-NAGVIS, Nagios
Checker, Nagstamon oder auch NAME-NAGIOSQL nutzen ebenfalls das
NAME-ICINGA Command File um Befehle an NAME-ICINGA zu senden. Mehr
Informationen zu externen Befehlen finden Sie [hier](#extcommands).

-   0 = nicht auf externe Befehle prüfen

-   1 = auf externe Befehle prüfen (Default)

**Prüfintervall externe Befehle** (External Command Check Interval)

  ------ -----------------------------------------------------------------
  Format **command\_check\_interval=\<xxx\>[s]**
  :      

  Beispi ***command\_check\_interval=1***
  el:    
  ------ -----------------------------------------------------------------

Wenn Sie eine Zahl mit einem angehängten "s" angeben (z.B. 30s), dann
ist dies die Zahl in *Sekunden*, die zwischen Prüfungen auf externe
Befehle gewartet werden soll. Wenn Sie das "s" weglassen, ist dies die
Zahl von "Zeiteinheiten", die zwischen den Prüfungen auf externe Befehle
gewartet werden soll. Solange Sie nicht den Standardwert (60) der
[interval\_length](#configmain-interval_length)-Direktive geändert haben
(wie weiter unten definiert), bedeutet dieser Wert Minuten.

> **Note**
>
> NAME-ICINGA prüft auch nach der Ausführung von Event-Handlern auf
> externe Befehle.

Anmerkung: durch das Setzen dieses Wertes auf **-1** wird NAME-ICINGA so
oft wie möglich auf externe Befehle prüfen. Jedes Mal, wenn NAME-ICINGA
auf externe Befehle prüft, wird es alle im [command
file](#configmain-command_file) befindlichen Befehle lesen und
verarbeiten, bevor es mit anderen Aufgaben fortfährt. Mehr Informationen
zu externen Befehlen finden Sie [hier](#extcommands).

**externe Befehlsdatei** (External Command File)

  ------ -----------------------------------------------------------------
  Format **command\_file=\<file\_name\>**
  :      

  Beispi ***command\_file=URL-ICINGA-BASE/var/rw/icinga.cmd***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Datei, die NAME-ICINGA auf zu verarbeitende externe Befehle
prüfen wird. Das [Command-CGI](#cgis-cmd_cgi), NAME-WEB und diverse
Addons schreiben Befehle in diese Datei. Die externe Befehlsdatei ist
als "named pipe" (FIFO) implementiert, die beim Start von NAME-ICINGA
angelegt und beim Herunterfahren wieder gelöscht wird. Wenn die Datei
beim Start von NAME-ICINGA existiert, wird der NAME-ICINGA-Prozess mit
einer Fehlermeldung enden. Mehr Informationen zu externen Befehlen
finden Sie [hier](#extcommands).

**externe Befehlspuffer-Slots** (External Command Buffer Slots)

  ------ -----------------------------------------------------------------
  Format **external\_command\_buffer\_slots=\<n\>**
  :      

  Beispi ***external\_command\_buffer\_slots=512***
  el:    
  ------ -----------------------------------------------------------------

Anmerkung: dies ist ein fortgeschrittenes Feature. Diese Option legt
fest, wie viele Puffer-Slots NAME-ICINGA für die Zwischenspeicherung von
externen Befehlen reserviert, die von einem "worker thread" aus der
externen Befehlsdatei gelesen, aber noch nicht vom "main thread" des
NAME-ICINGA-Daemons verarbeitet wurden. Jeder Slot kann einen externen
Befehl enthalten, so dass diese Option im Wesentlichen bestimmt, wie
viele Befehle gepuffert werden können. Bei Installationen, wo Sie eine
große Zahl von passiven Prüfungen verarbeiten (z.B. [verteilten
Setups](#distributed)), müssen Sie ggf. diese Zahl erhöhen. Sie sollten
den Einsatz von NAME-PNP erwägen, um die Nutzung der externen
Befehlspuffer grafisch darzustellen. Mehr zur Konfiguration der
grafischen Darstellung finden Sie [hier](#perfgraphs).

**Sperrdatei** (Lock File)

  ------ -----------------------------------------------------------------
  Format **lock\_file=\<file\_name\>**
  :      

  Beispi ***lock\_file=/tmp/icinga.lock***
  el:    
  ------ -----------------------------------------------------------------

Diese Option gibt die Position der Sperrdatei an, die NAME-ICINGA
anlegen sollte, wenn es als Daemon läuft (wenn es mit der -d
Kommandozeilenoption gestartet wurde). Diese Datei enthält die
Prozess-ID (PID) des laufenden NAME-ICINGA-Prozesses.

**Statusaufbewahrungsoption** (State Retention Option)

  ------ -----------------------------------------------------------------
  Format **retain\_state\_information=\<0/1\>**
  :      

  Beispi ***retain\_state\_information=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA Statusinformationen für Hosts und
Services zwischen Programmneustarts aufbewahren soll. Wenn Sie diese
Option aktivieren, sollten Sie ein Wert für die
[state\_retention\_file](#configmain-state_retention_file)-Variable
angeben. Wenn sie aktiviert ist, wird NAME-ICINGA alle
Statusinformationen für Hosts und Services sichern, bevor es beendet
(oder neu gestartet) wird und vorher gespeicherte Statusinformationen
einlesen, wenn es neu gestartet wird.

-   0 = Statusinformationen nicht aufbewahren

-   1 = Statusinformationen aufbewahren (Default)

**Statusaufbewahrungsdatei** (State Retention File)

  ------ -----------------------------------------------------------------
  Format **state\_retention\_file=\<file\_name\>**
  :      

  Beispi ***state\_retention\_file=URL-ICINGA-BASE/var/retention.dat***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Datei, die NAME-ICINGA für die Speicherung von Status-,
Ausfallzeit- und Kommentarinformationen nutzt, bevor es endet. Wenn
NAME-ICINGA neu startet, wird es die in dieser Datei gespeicherten
Informationen nutzen, um die anfänglichen Zustände von Services und
Hosts zu setzen, bevor es mit der Überwachung beginnt. Damit NAME-ICINGA
Statusinformationen zwischen Programmneustarts aufbewahrt, müssen Sie
die
[retain\_state\_information](#configmain-retain_state_information)-Option
aktivieren.

**Sync-Aufbewahrungsdatei** (Sync Retention File)

  ------ -----------------------------------------------------------------
  Format **sync\_retention\_file=\<file\_name\>**
  :      

  Beispi ***sync\_retention\_file=URL-ICINGA-BASE/var/retention.dat***
  el:    
  ------ -----------------------------------------------------------------

Dies ist eine fortgeschrittene Option, die wie state\_retention\_file
arbeitet, so dass Sie eine Untermenge von Aufbewahrungsinformationen wie
Status, Bestätigung, Ausfallzeiten und Kommentaren laden können (Sie
müssen den Inhalt dieser Datei außerhalb von NAME-ICINGA erstellen).
Wenn NAME-ICINGA erneut gestartet wird, liest es die Informationen aus
der durch sync\_retention\_file definierten Datei und aktualisiert den
angegebenen Host oder Service, *wenn die Last\_update-Zeit in der
Sync-Datei neuer ist* als in der state\_retention\_file-Datei,
anderenfalls wird die Information ignoriert. Nach dem Lesen der Datei
wird diese gelöscht. Um die Option zu deaktivieren, kommentieren Sie sie
aus. Diese Option gibt es seit NAME-ICINGA 1.0.2.

**automatisches Statusaufbewahrungs-Aktualisierungsintervall**
(Automatic State Retention Update Interval)

  ------ -----------------------------------------------------------------
  Format **retention\_update\_interval=\<minutes\>**
  :      

  Beispi ***retention\_update\_interval=60***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, wie oft (in Minuten) NAME-ICINGA
automatisch während des normalen Betriebs die Aufbewahrungsdaten
aktualisiert. Wenn Sie einen Wert von Null angeben, wird NAME-ICINGA
nicht in regelmäßigen Intervallen die Aufbewahrungsdaten sichern, aber
es wird die Aufbewahrungsdaten vor der Beendigung oder dem Neustart
sichern. Wenn Sie die Statusaufbewahrung deaktiviert haben (mit der
[retain\_state\_information](#configmain-retain_state_information)-Option),
hat diese Option keine Auswirkung.

**Option aufbewahrten Programmzustand nutzen** (Use Retained Program
State Option)

  ------ -----------------------------------------------------------------
  Format **use\_retained\_program\_state=\<0/1\>**
  :      

  Beispi ***use\_retained\_program\_state=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, ob NAME-ICINGA verschiedene programmweite
Statusvariablen auf Basis der Aufbewahrungsdatei setzen soll. Einige
dieser programmweiten Statusvariablen, die normalerweise über
Programmstarts hinweg gesichert werden, wenn Statusaufbewahrung
aktiviert ist, umfassen die
[enable\_notifications](#configmain-enable_notifications)-,
[enable\_flap\_detection](#configmain-enable_flap_detection)-,
[enable\_event\_handlers](#configmain-enable_event_handlers)-,
[execute\_service\_checks](#configmain-execute_service_checks)- und
[accept\_passive\_service\_checks](#configmain-accept_passive_service_checks)-Optionen.
Wenn Sie [Statusaufbewahrung](#configmain-retain_state_information)
deaktiviert haben, hat diese Option keine Auswirkung.

-   0 = keinen aufbewahrten Programmzustand nutzen

-   1 = aufbewahrten Programmzustand nutzen (Default)

**Option Weitergabe der Statusinformationen an Neb-Module** (Dump
Retained Host Service States To Neb Option)

  ------ -----------------------------------------------------------------
  Format **dump\_retained\_host\_service\_states\_to\_neb=\<0/1\>**
  :      

  Beispi ***dump\_retained\_host\_service\_states\_to\_neb=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, ob NAME-ICINGA die in der
[Statusaufbewahrungsdatei](#configmain-state_retention_file)
gespeicherten Statusinformationen der Host- und Services an die
NEB-Module weitergibt. Wenn Sie das nicht wünschen, deaktivieren Sie
diese Option auf Ihr eigenes Risiko.

-   0 = Statusinformationen nicht weitergeben

-   1 = Statusinformationen weitergeben (Default)

**Option aufbewahrte Planungsinformationen nutzen** (Use Retained
Scheduling Info Option)

  ------ -----------------------------------------------------------------
  Format **use\_retained\_scheduling\_info=\<0/1\>**
  :      

  Beispi ***use\_retained\_scheduling\_info=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, ob NAME-ICINGA Planungsinformationen für
Hosts und Services aufbewahrt, wenn es neu startet. Wenn Sie eine große
Zahl (oder einen großen Anteil) von Hosts oder Services hinzufügen,
empfehlen wir diese Option zu deaktivieren, wenn Sie das erste Mal
NAME-ICINGA neu starten, weil es nachteilig die Verteilung von initialen
Prüfungen beeinflussen kann. Andernfalls werden Sie diese Option
wahrscheinlich aktiviert lassen.

-   0 = keine aufbewahrten Planungsinformationen nutzen

-   1 = aufbewahrten Planungsinformationen nutzen (Default)

**aufbewahrte Host- und Service-Attributmasken** (Retained Host and
Service Attribute Masks)

  ------ -----------------------------------------------------------------
  Format **retained\_host\_attribute\_mask=\<number\>**
  :      
         **retained\_service\_attribute\_mask=\<number\>**

  Beispi ***retained\_host\_attribute\_mask=0***
  el:    
         ***retained\_service\_attribute\_mask=0***
  ------ -----------------------------------------------------------------

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
NAME-ICINGA-Quellcode lesen, um diese Option effizient nutzen zu können.

Diese Option legt fest, welche Host- oder Service-Attribute NICHT über
Programmneustarts hinweg aufbewahrt werden. Die Werte für diese Optionen
sind ein bitweises AND der durch die "MODATTR\_"-Definitionen
angegebenen Werte in den include/common.h-Quellcode-Dateien. Per Default
werden alle Host- und Service-Attribute aufbewahrt.

**aufbewahrte Prozessattributmasken** (Retained Process Attribute Masks)

  ------ -----------------------------------------------------------------
  Format **retained\_process\_host\_attribute\_mask=\<number\>**
  :      
         **retained\_process\_service\_attribute\_mask=\<number\>**

  Beispi ***retained\_process\_host\_attribute\_mask=0***
  el:    
         ***retained\_process\_service\_attribute\_mask=0***
  ------ -----------------------------------------------------------------

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
NAME-ICINGA-Quellcode lesen, um diese Option effizient nutzen zu können.

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

  ------ -----------------------------------------------------------------
  Format **retained\_contact\_host\_attribute\_mask=\<number\>**
  :      
         **retained\_contact\_service\_attribute\_mask=\<number\>**

  Beispi ***retained\_contact\_host\_attribute\_mask=0***
  el:    
         ***retained\_contact\_service\_attribute\_mask=0***
  ------ -----------------------------------------------------------------

WARNUNG: dies ist ein fortgeschrittenes Feature. Sie müssen den
NAME-ICINGA-Quellcode lesen, um diese Option effizient nutzen zu können.

Diese Option legt fest, welche Kontaktattribute NICHT über
Programmneustarts hinweg aufbewahrt werden. Es gibt zwei Masken, weil es
oft separate Host- und Service-Prozessattribute gibt, die geändert
werden können. Die Werte für diese Optionen sind ein bitweises AND der
durch die "MODATTR\_"-Definitionen angegebenen Werte in den
include/common.h-Quellcode-Dateien. Per Default werden alle
Kontaktattribute aufbewahrt.

**Syslog-Protokollierungsoption** (Syslog Logging Option)

  ------ -----------------------------------------------------------------
  Format **use\_syslog=\<0/1\>**
  :      

  Beispi ***use\_syslog=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob Meldungen im Syslog des lokalen Hosts
protokolliert werden sollen. Die Werte sind wie folgt:

-   0 = Syslog nicht nutzen

-   1 = Syslog nutzen [Default]

**Syslog Local Facility Option**

  ------ -----------------------------------------------------------------
  Format **use\_syslog\_local\_facility=\<0/1\>**
  :      

  Beispi ***use\_syslog\_local\_facility=1***
  el:    
  ------ -----------------------------------------------------------------

Wenn Sie use\_syslog aktiviert haben, dann können Sie NAME-ICINGA
anweisen, eine local-Facility zu benutzen statt des Defaults. Werte sind
wie folgt:

-   0 = Syslog Local Facility nicht nutzen

-   1 = Syslog Local Facility benutzen

Diese Option gibt es seit NAME-ICINGA 1.0.2.

**Syslog Local Facility Wert**

  ------ -----------------------------------------------------------------
  Format **syslog\_local\_facility=\<0|1|2|3|4|5|6|7\>**
  :      

  Beispi ***syslog\_local\_facility=1***
  el:    
  ------ -----------------------------------------------------------------

Wenn Sie use\_syslog\_local\_facility aktiviert haben, können Sie
auswählen, welche Local-Facility benutzt werden soll. Gültige Werte sind
von 0 bis 7. Diese Option gibt es seit NAME-ICINGA 1.0.2.

**Benachrichtigungsprotokollierungsoption** (Notification Logging
Option)

  ------ -----------------------------------------------------------------
  Format **log\_notifications=\<0/1\>**
  :      

  Beispi ***log\_notifications=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob Benachrichtungsmeldungen protokolliert
werden. Wenn Sie eine Menge von Kontakten oder ständigen
Service-Ausfällen haben, dann wird Ihre Protokolldatei relativ schnell
wachsen. Benutzen Sie diese Option, um die Protokollierung von
(Kontakt-)Benachrichtigungen zu verhindern.

-   0 = keine Benachrichtigungen protokollieren

-   1 = Benachrichtigungen protokollieren [Default]

**Option Service-Wiederholungsprüfungen protokollieren** (Service Check
Retry Logging Option)

  ------ -----------------------------------------------------------------
  Format **log\_service\_retries=\<0/1\>**
  :      

  Beispi ***log\_service\_retries=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob Service-Wiederholungsprüfungen
protokolliert werden. Service-Wiederholungsprüfungen treten auf, wenn
ein Service-Prüfergebnis einen nicht-OK-Status ergibt, Sie NAME-ICINGA
aber so konfiguriert haben, dass die Prüfung mehr als einmal wiederholt
wird, bevor ein Fehler gemeldet wird. Services in diesem Zustand
befinden sich in einem "Soft"-Status. Die Protokollierung von
Service-Wiederholungsprüfungen ist meist dann sinnvoll, wenn Sie
versuchen, NAME-ICINGA zu debuggen, oder
Service-[Eventhandler](#eventhandlers) zu testen.

-   0 = keine Service-Wiederholungsprüfungen protokollieren [Default-H]

-   1 = Service-Wiederholungsprüfungen protokollieren [Default-C]

**Option Host-Wiederholungsprüfungen-protokollieren** (Host Check Retry
Logging Option)

  ------ -----------------------------------------------------------------
  Format **log\_host\_retries=\<0/1\>**
  :      

  Beispi ***log\_host\_retries=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob Host-Wiederholungsprüfungen protokolliert
werden. Die Protokollierung von Host-Wiederholungsprüfungen ist meist
dann sinnvoll, wenn Sie versuchen, NAME-ICINGA zu debuggen, oder
Host-[Eventhandler](#eventhandlers) zu testen.

-   0 = keine Host-Wiederholungsprüfungen protokollieren [Default-H]

-   1 = Host-Wiederholungsprüfungen protokollieren [Default-C]

**Option Eventhandler-protokollieren** (Event Handler Logging Option)

  ------ -----------------------------------------------------------------
  Format **log\_event\_handlers=\<0/1\>**
  :      

  Beispi ***log\_event\_handlers=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob Service- und
Host-[Eventhandlers](#eventhandlers) protokolliert werden. Eventhandler
sind optionale Befehle, die ausgeführt werden können, wenn sich der
Zustand eines Hosts oder Service ändert. Die Protokollierung von
Eventhandlern ist meist dann sinnvoll, wenn Sie versuchen, NAME-ICINGA
zu debuggen, oder Ihre [Eventhandler](#eventhandlers)-Scripts zu testen.

-   0 = Eventhandler nicht protokollieren

-   1 = Eventhandler protokollieren [Default]

**Option initiale Zustände protokollieren** (Initial States Logging
Option)

  ------ -----------------------------------------------------------------
  Format **log\_initial\_states=\<0/1\>**
  :      

  Beispi ***log\_initial\_states=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob NAME-ICINGA alle anfänglichen Host- und
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

  ------ -----------------------------------------------------------------
  Format **log\_external\_commands=\<0/1\>**
  :      

  Beispi ***log\_external\_commands=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob NAME-ICINGA [externe Befehle](#extcommands)
protokolliert, die es aus der [externen
Befehlsdatei](#configmain-command_file) erhält. Anmerkung: diese Option
kontrolliert nicht, ob [passive Service-Prüfungen](#passivechecks) (die
eine Art von externen Befehlen sind) protokolliert werden. Zur
Aktivierung oder Deaktivierung der Protokollierung von passiven
Prüfungen nutzen Sie die
[log\_passive\_checks](#configmain-log_passive_checks)-Option.

-   0 = keine externen Befehle protokollieren

-   1 = externe Befehle protokollieren (Default)

**Option Benutzer von externen Kommandos protokollieren**

  ------ -----------------------------------------------------------------
  Format **log\_external\_commands\_user=\<0/1\>**
  :      

  Beispi ***log\_external\_commands\_user=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, den Namen des Benutzers zu
protokollieren, der aktuell externe Kommandos ausführt. Anstatt
CMD;cmdargs wird nun CMD;username;cmdargs in die Log-Datei geschrieben,
wenn die externe Applikation das korrekt sendet. Weil dies die
Kompatibilität mit bestehenden Log-Parsern gefährdet, ist diese Option
per Default deaktiviert.

> **Note**
>
> Diese Option ist ab NAME-ICINGA 1.4 veraltet, weil Sie nun die
> Direktive [use\_logging](#configcgi-use_logging) benutzen können, um
> CGI-Befehle zu protokollieren.

-   0 = Den Namen des aktuellen Benutzers von externen Kommandos nicht
    protokollieren (default)

-   1 = Den Namen des aktuellen Benutzers von externen Kommandos
    protokollieren

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.0.3.

**Option passive Prüfungen protokollieren** (Passive Check Logging
Option)

  ------ -----------------------------------------------------------------
  Format **log\_passive\_checks=\<0/1\>**
  :      

  Beispi ***log\_passive\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob NAME-ICINGA [passive Host- und
Service-Prüfungen](#passivechecks) protokolliert, die es von der
[externen Befehlsdatei](#configmain-command_file) bekommt. Wenn Sie eine
[verteilte Überwachungsumgebung](#distributed) aufbauen oder planen,
eine große Zahl von passiven Prüfungen auf einer regelmäßigen Basis zu
behandeln, dann können Sie diese Option deaktivieren, damit Ihre
Protokolldatei nicht zu groß wird.

-   0 = keine passiven Prüfungen protokollieren

-   1 = passive Prüfungen protokollieren (Default)

**Option Aktuelle Zustände protokollieren**

  ------ -----------------------------------------------------------------
  Format **log\_current\_states=\<0/1\>**
  :      

  Beispi ***log\_current\_states=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob NAME-ICINGA die aktuellen Host- und
Service-Zustände nach einer Log-Datei-Rotation protokolliert. Wenn Sie
den Wert von log\_current\_states auf 0 setzen, werden die aktuellen
Zustände nach einer Rotation der Log-Datei nicht protokolliert.

-   0 = die aktuellen Host- und Service-Zustände nicht protokollieren

-   1 = die aktuellen Host- und Service-Zustände protokollieren
    (Default)

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.0.3.

**Option langen Plugin-Output protokollieren**

  ------ -----------------------------------------------------------------
  Format **log\_long\_plugin\_output=\<0/1\>**
  :      

  Beispi ***log\_long\_plugin\_output=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, ob NAME-ICINGA die komplette Ausgabe von
Plugin (und nicht nur die erste Zeile) protokolliert. Wenn Sie den Wert
von log\_long\_plugin\_output auf 1 setzen, werden die kompletten
Ausgaben von Plugins protokolliert.

-   0 = nur die erste Zeile von Plugin-Ausgaben protokollieren (Default)

-   1 = die kompletten Plugin-Ausgaben protokollieren

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.0.3.

**globale Host-Eventhandler Option** (Global Host Event Handler Option)

  ------ -----------------------------------------------------------------
  Format **global\_host\_event\_handler=\<command\>**
  :      

  Beispi ***global\_host\_event\_handler=log-host-event-to-db***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen, einen Host-Eventhandler-Befehl anzugeben,
der für jeden Host-Zustandswechsel ausgeführt wird. Der globale
Eventhandler wird direkt vor dem Eventhandler ausgeführt, den Sie
optional in jeder Host-Definition angeben können. Das *Befehls*-Argument
ist der Kurzname eines Befehls, den Sie in Ihrer
[Objektkonfigurationsdatei](#configobject) angeben. Die maximale
Ausführungszeit dieses Befehls kann durch die
[event\_handler\_timeout](#configmain-event_handler_timeout)-Option
angegeben werden. Mehr Informationen zu Eventhandlern finden Sie
[hier](#eventhandlers).

**Globale Service-Eventhandler-Option** (Global Service Event Handler
Option)

  ------ -----------------------------------------------------------------
  Format **global\_service\_event\_handler=\<command\>**
  :      

  Beispi ***global\_service\_event\_handler=log-service-event-to-db***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen, einen Service-Eventhandler-Befehl anzugeben,
der für jeden Service-Zustandswechsel ausgeführt wird. Der globale
Eventhandler wird direkt vor dem Eventhandler ausgeführt, den Sie
optional in jeder Service-Definition angeben können. Das
*Befehls*-Argument ist der Kurzname eines Befehls, den Sie in Ihrer
[Objektkonfigurationsdatei](#configobject) angeben. Die maximale
Ausführungszeit dieses Befehls kann durch die
[event\_handler\_timeout](#configmain-event_handler_timeout)-Option
angegeben werden. Mehr Informationen zu Eventhandlern finden Sie
[hier](#eventhandlers).

**Eventhandler für "verfolgte" Hosts (Event handlers for stalked
hosts)**

**Eventhandler für "verfolgte" Services (Event handlers for stalked
services)**

  ------ -----------------------------------------------------------------
  Format **stalking\_event\_handlers\_for\_hosts=\<0|1\>**
  :      
         **stalking\_event\_handlers\_for\_services=\<0|1\>**

  Exampl ***stalking\_event\_handlers\_for\_hosts=1***
  e:     
  ------ -----------------------------------------------------------------

Diese Optionen erlauben Ihnen festzulegen, ob NAME-ICINGA Eventhandler
für "stalked" Hosts oder Services ausführt. Auf diese Weise können
Statusinformationsänderungen an externe Systeme weitergeleitet werden.

-   0 = Eventhandler deaktivieren (Default)

-   1 = Eventhandler aktivieren

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.0.3.

**Benachrichtigungen für "verfolgte" Hosts (Notifications for stalked
hosts)**

**Benachrichtigungen für "verfolgte" Services (Notifications for stalked
services)**

  ------ -----------------------------------------------------------------
  Format **stalking\_notifications\_for\_hosts=\<0|1\>**
  :      
         **stalking\_notifications\_for\_services=\<0|1\>**

  Beispi ***stalking\_notifications\_for\_hosts=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Optionen legen global für alle Kontakte fest, ob NAME-ICINGA
Benachrichtigungen für "stalked" Hosts oder Services ausführt. Das
\$NOTIFICATION\_TYPE\$-Makro wird um den Typ "STALKING" erweitert.

> **Note**
>
> Solange keine stalking\_options beim Host/Service definiert sind,
> haben diese Optionen keine Auswirkungen.

-   0 = Benachrichtigungen deaktivieren (Default)

-   1 = Benachrichtigungen aktivieren

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.6.

**Ruhezeit zwischen Prüfungen** (Inter-Check Sleep Time)

  ------ -----------------------------------------------------------------
  Format **sleep\_time=\<seconds\>**
  :      

  Beispi ***sleep\_time=1***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Anzahl von Sekunden, die NAME-ICINGA "schlafen" wird, bevor
es in der Planungswarteschlange (scheduling queue) nach weiteren
auszuführenden Host- oder Service-Prüfungen schaut. Beachten Sie, dass
NAME-ICINGA nur schlafen wird, nachdem es anstehende Service-Prüfungen
erledigt hat, die in Verzug geraten waren.

**Verzögerungsmethode für Service-Prüfungen** (Service Inter-Check Delay
Method)

  ------ -----------------------------------------------------------------
  Format **service\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**
  :      

  Beispi ***service\_inter\_check\_delay\_method=s***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen die Kontrolle darüber, wie Service-Prüfungen
anfänglich in der Planungswarteschlange "ausgebreitet" werden. Die
Verwendung einer "schlauen" Verzögerungsberechnung (der Standard)
veranlasst NAME-ICINGA, ein durchschnittliches Prüfintervall zu
berechnen und die anfänglichen Prüfungen aller Services über dieses
Intervall zu verteilen, um dadurch CPU-Lastspitzen zu eliminieren. Keine
Verzögerung zu benutzen wird *nicht* empfohlen, weil es dafür sorgt,
dass die Ausführung aller Service-Prüfungen zur gleichen Zeit geplant
wird. Das bedeutet, dass Sie generell hohe CPU-Spitzen haben werden,
wenn die Services alle parallel ausgeführt werden. Mehr Informationen
dazu, wie die Verzögerung von Service-Prüfungen die Planung dieser
Prüfungen beeinflusst, finden Sie [hier](#serviceintercheckdelay). Die
Werte sind wie folgt:

-   n = keine (none) Verzögerung benutzen - planen, dass alle
    Service-Prüfungen sofort ausgeführt werden (d.h. zur gleichen Zeit!)

-   d = eine "dumme" (dumb) Verzögerung von einer Sekunde zwischen
    Service-Prüfungen benutzen

-   s = eine "schlaue" (smart) Verzögerungsberechnung verwenden, um die
    Service-Prüfungen gleichmäßig zu verteilen (Default)

-   x.xx = eine benutzerdefinierte Verzögerung von x.xx Sekunden
    zwischen den Prüfungen benutzen

**maximale Service-Prüfungsverteilung** (Maximum Service Check Spread)

  ------ -----------------------------------------------------------------
  Format **max\_service\_check\_spread=\<minutes\>**
  :      

  Beispi ***max\_service\_check\_spread=30***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die maximale Anzahl in Minuten fest vom
NAME-ICINGA-Start bis zur Ausführung aller (regelmäßig geplanten)
Service-Prüfungen. Diese Option wird automatisch die
[Verzögerungsmethode für
Service-Prüfungen](#configmain-service_inter_check_delay_method)
anpassen (falls notwendig), um sicherzustellen, dass die anfänglichen
Prüfungen aller Services in dem Zeitrahmen stattfinden, den Sie angeben.
Generell wird diese Optionen keine Auswirkung auf die Planung von
Service-Prüfungen haben, wenn die Planungsinformationen mit Hilfe der
[use\_retained\_scheduling\_info](#configmain-use_retained_scheduling_info)-Option
aufbewahrt werden. Standardwert ist **30** (Minuten).

**Service-Verschachtelungsfaktor** (Service Interleave Factor)

  ------ -----------------------------------------------------------------
  Format **service\_interleave\_factor=\<s|x\>**
  :      

  Beispi ***service\_interleave\_factor=s***
  el:    
  ------ -----------------------------------------------------------------

Diese Variable legt fest, wie Service-Prüfungen verschachtelt werden.
Verschachtelung erlaubt eine gleichmäßigere Verteilung von
Service-Prüfungen, reduzierte Last auf entfernten Hosts und schnellere
Erkennung von Host-Problemen. Das Setzen des Wertes auf 1 ist
gleichbedeutend mit keiner Verschachtelung der Service-Prüfungen (so
arbeiteten die NAME-ICINGA-Version bis 0.0.5). Setzen Sie diesen Wert
auf **s** (schlau/smart) für die automatische Berechnung, solange Sie
keinen bestimmten Grund für die Änderung haben. Der beste Weg zum
Verständnis, wie Verschachtelung funktioniert, ist der Blick auf das
[status CGI](#cgis-status_cgi) (detail view), während NAME-ICINGA
startet. Sie sollten sehen, dass die Service-Prüfergebnisse verteilt
werden, während sie auftauchen. Mehr Informationen dazu, wie
Verschachtelung funktioniert, finden Sie [hier](#serviceinterleaving).

-   *x* = eine Zahl gleich oder größer 1, die den zu benutzenden
    Verschachtelungsfaktor angibt. Ein Verschachtelungsfaktor von 1
    bedeutet keine Verschachtelung von Service-Prüfungen

-   s = eine "schlaue" (smart) Verschachtelungsberechnung benutzen
    (Default)

**maximale Anzahl gleichzeitiger Service-Prüfungen** (Maximum Concurrent
Service Checks)

  ------ -----------------------------------------------------------------
  Format **max\_concurrent\_checks=\<max\_checks\>**
  :      

  Beispi ***max\_concurrent\_checks=20***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen die Angabe der maximalen Anzahl von
Service-Prüfungen, die zu irgendeiner Zeit gleichzeitig ausgeführt
werden. Das Angeben eines Wertes von 1 verhindert grundsätzlich die
Ausführung von parallelen Service-Prüfungen. Der Wert 0 (der Standard)
sorgt dafür, dass es keine Beschränkung der Anzahl von gleichzeitig
ausgeführten Service-Prüfungen gibt. Sie müssen den Wert auf der Basis
der Systemressourcen anpassen, die Ihr NAME-ICINGA-Rechner zur Verfügung
stellt, da er direkt die maximale Last des System beeinflusst
(Prozessorauslastung, Speicher, usw.). Mehr Informationen dazu, wie
viele parallele Prüfungen Sie zulassen sollten, finden Sie
[hier](#maxconcurrentchecks).

**Prüfergebnis-Erntefrequenz** (Check Result Reaper Frequency)

  ------ -----------------------------------------------------------------
  Format **check\_result\_reaper\_frequency=\<frequency\_in\_seconds\>**
  :      

  Beispi ***check\_result\_reaper\_frequency=5***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen die Kontrolle über die Frequenz *in Sekunden*
der Prüfergebnis-"Ernte"-Ereignisse. "Ernte"-Ereignisse verarbeiten die
Ergebnisse von Host- und Service-Prüfungen, die beendet wurden. Diese
Ereignisse bilden den Kern der Überwachungslogik von NAME-ICINGA.

**maximale Prüfergebnis-Erntezeit** (Maximum Check Result Reaper Time)

  ------ -----------------------------------------------------------------
  Format **max\_check\_result\_reaper\_time=\<seconds\>**
  :      

  Beispi ***max\_check\_result\_reaper\_time=30***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen die Kontrolle der maximalen Zeit *in
Sekunden*, die Host- und Service-Prüfergebnis-"Ernte"-Ereignisse laufen
dürfen. "Ernte"-Ereignisse verarbeiten die Ergebnisse von Host- und
Service-Prüfungen, die beendet sind. Wenn es eine Menge von Ergebnissen
zu verarbeiten gibt, können Ernte-Ereignisse lange brauchen, um zu
enden, was die pünktliche Ausführung von neuen Host- und
Service-Prüfungen verzögern könnte. Diese Variable erlaubt Ihnen die
Begrenzung der Zeit, die ein einzelnes Ernte-Ereignis laufen darf, bevor
es die Kontrolle an andere Teile der NAME-ICINGA-Überwachungslogik
zurückgibt.

**Prüfergebnis-Pfad** (Check Result Path)

  ------ -----------------------------------------------------------------
  Format **check\_result\_path=\<path\>**
  :      

  Beispi ***check\_result\_path=/var/spool/nagios/checkresults***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, welches Verzeichnis NAME-ICINGA benutzen wird,
um temporär Host- und Service-Prüfergebnisse zu speichern, bevor sie
verarbeitet werden. Diese Verzeichnis sollte nicht benutzt werden, um
andere Dateien dort zu speichern, weil NAME-ICINGA dieses Verzeichnis
periodisch von alten Dateien säubern wird (mehr Informationen dazu
finden Sie bei der
[max\_check\_result\_file\_age](#configmain-max_check_result_file_age)-Option).

Anmerkung: stellen Sie sicher, dass nur eine einzelne
NAME-ICINGA-Instanz Zugriff auf den Prüfergebnispfad hat. Wenn mehrere
NAME-ICINGA-Instanzen Zugriff auf das gleiche Verzeichnis haben, werden
Sie Probleme bekommen, weil Prüfergebnisse von der falschen
NAME-ICINGA-Instanz verarbeitet wurden!

**maximales Alter der Prüfergebnisdatei** (Max Check Result File Age)

  ------ -----------------------------------------------------------------
  Format **max\_check\_result\_file\_age=\<seconds\>**
  :      

  Beispi ***max\_check\_result\_file\_age=3600***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt das maximale Alter in Sekunden fest, die Daten aus den
Prüfergebnisdateien im
[check\_result\_path](#configmain-check_result_path)-Verzeichnis als
gültig angesehen werden. Prüfergebnisdateien, die älter als dieser
Schwellwert sind, werden von NAME-ICINGA gelöscht und die darin
enthaltenen Daten werden nicht verarbeitet. Durch die Angabe eines
Wertes von Null (0) bei dieser Option wird NAME-ICINGA alle
Prüfergebnisdateien verarbeiten - selbst wenn sie älter als Ihre
Hardware sind :-).

**Verzögerungsmethode für Host-Prüfungen** (Host Inter-Check Delay
Method)

  ------ -----------------------------------------------------------------
  Format **host\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**
  :      

  Beispi ***host\_inter\_check\_delay\_method=s***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen die Kontrolle darüber, wie Host-Prüfungen,
*die für eine regelmäßige Prüfung geplant sind*, anfänglich in der
Planungswarteschlange "ausgebreitet" werden. Die Verwendung einer
"schlauen" Verzögerungsberechnung (der Standard) veranlasst NAME-ICINGA,
ein durchschnittliches Prüfintervall zu berechnen und die anfänglichen
Prüfungen aller Hosts über dieses Intervall zu verteilen, um dadurch
CPU-Lastspitzen zu eliminieren. Keine Verzögerung zu benutzen wird
generell *nicht* empfohlen, weil es dafür sorgt, dass die Ausführung
aller Host-Prüfungen zur gleichen Zeit geplant wird. Mehr Informationen
dazu, wie die Verzögerung von Host-Prüfungen die Planung dieser
Prüfungen beeinflusst, finden Sie [hier](#serviceintercheckdelay). Die
Werte sind wie folgt:

-   n = keine (none) Verzögerung benutzen - planen, dass alle
    Host-Prüfungen sofort ausgeführt werden (d.h. zur gleichen Zeit!)

-   d = eine "dumme" (dumb) Verzögerung von einer Sekunde zwischen
    Host-Prüfungen benutzen

-   s = eine "schlaue" (smart) Verzögerungsberechnung verwenden, um die
    Host-Prüfungen gleichmäßig zu verteilen (Default)

-   x.xx = eine benutzerdefinierte Verzögerung von x.xx Sekunden
    zwischen den Prüfungen benutzen

**maximale Host-Prüfungsverteilung** (Maximum Host Check Spread)

  ------ -----------------------------------------------------------------
  Format **max\_host\_check\_spread=\<minutes\>**
  :      

  Beispi ***max\_host\_check\_spread=30***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die maximale Anzahl in Minuten fest vom
NAME-ICINGA-Start bis zur Ausführung aller (regelmäßig geplanten)
Host-Prüfungen. Diese Option wird automatisch die [Verzögerungsmethode
für Host-Prüfungen](#configmain-host_inter_check_delay_method) anpassen
(falls notwendig), um sicherzustellen, dass die anfänglichen Prüfungen
aller Hosts in dem Zeitrahmen stattfinden, den Sie angeben. Generell
wird diese Optionen keine Auswirkung auf die Planung von Host-Prüfungen
haben, wenn die Planungsinformationen mit Hilfe der
[use\_retained\_scheduling\_info](#configmain-use_retained_scheduling_info)-Option
aufbewahrt werden. Standardwert ist **30** (Minuten).

**Zeitintervalllänge** (Timing Interval Length)

  ------ -----------------------------------------------------------------
  Format **interval\_length=\<seconds\>**
  :      

  Beispi ***interval\_length=60***
  el:    
  ------ -----------------------------------------------------------------

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

  ------ -----------------------------------------------------------------
  Format **auto\_reschedule\_checks=\<0/1\>**
  :      

  Beispi ***auto\_reschedule\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA versucht, aktive Host- und
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

  ------ -----------------------------------------------------------------
  Format **auto\_rescheduling\_interval=\<seconds\>**
  :      

  Beispi ***auto\_rescheduling\_interval=30***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wie oft (in Sekunden) NAME-ICINGA versuchen
wird, automatisch Prüfungen erneut einzuplanen. Diese Option ist nur
wirksam, wenn die
[auto\_reschedule\_checks](#configmain-auto_reschedule_checks)-Option
aktiviert ist. Standard ist 30 Sekunden.

**WARNUNG:** DIES IST EIN EXPERIMENTELLES FEATURE UND KÖNNTE IN DER
ZUKUNFT ENTFERNT WERDEN. DIE AKTIVIERUNG DIESER OPTION KANN DIE LEISTUNG
REDUZIEREN - STATT SIE ZU ERHÖHEN - WENN SIE UNGEEIGNET BENUTZT WIRD!

**automatisches Wiedereinplanungsfenster** (Auto-Rescheduling Window)

  ------ -----------------------------------------------------------------
  Format **auto\_rescheduling\_window=\<seconds\>**
  :      

  Beispi ***auto\_rescheduling\_window=180***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt das Zeit-"Fenster" fest (in Sekunden), auf das
NAME-ICINGA blickt, wenn es automatisch Prüfungen erneut einplant. Nur
Host- und Service-Prüfungen, die in den nächsten X Sekunden (festgelegt
durch diese Variable) stattfinden, werden erneut eingeplant. Diese
Option ist nur wirksam, wenn die
[auto\_reschedule\_checks](#configmain-auto_reschedule_checks)-Option
aktiviert ist. Standard ist 180 Sekunden (3 Minuten).

**WARNING:** DIES IST EIN EXPERIMENTELLES FEATURE UND KÖNNTE IN DER
ZUKUNFT ENTFERNT WERDEN. DIE AKTIVIERUNG DIESER OPTION KANN DIE LEISTUNG
REDUZIEREN - STATT SIE ZU ERHÖHEN - WENN SIE UNGEEIGNET GENUTZT WIRD!

**Option aggressive Host-Prüfung** (Aggressive Host Checking Option)

  ------ -----------------------------------------------------------------
  Format **use\_aggressive\_host\_checking=\<0/1\>**
  :      

  Beispi ***use\_aggressive\_host\_checking=0***
  el:    
  ------ -----------------------------------------------------------------

NAME-ICINGA versucht, schlau zu sein, wie und wann es den Status von
Hosts prüft. Im Allgemeinen wird die Deaktivierung dieser Option
NAME-ICINGA dazu veranlassen, einige schlauere Entscheidungen zu treffen
und Hosts ein bisschen schneller zu prüfen. Die Aktivierung dieser
Option wird den Zeitaufwand zur Prüfung von Hosts erhöhen, aber es mag
die Zuverlässigkeit ein wenig steigern. Solange Sie keine Probleme damit
haben, dass NAME-ICINGA die Erholung eines Hosts nicht korrekt erkennt,
würden wir empfehlen, diese Option **nicht** zu aktivieren.

-   0 = keine aggressive Host-Prüfung benutzen (Default)

-   1 = aggressive Host-Prüfung benutzen

**Option passive Host-Prüfung übersetzen** (Translate Passive Host
Checks Option)

  ------ -----------------------------------------------------------------
  Format **translate\_passive\_host\_checks=\<0/1\>**
  :      

  Beispi ***translate\_passive\_host\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA DOWN/UNREACHABLE-Ergebnisse von
passiven Host-Prüfungen in ihre "korrekten" Zustände vom Standpunkt der
lokalen NAME-ICINGA-Instanz aus übersetzt. Dies kann sehr nützlich in
verteilten und Failover-Umgebungen sein. Mehr Informationen zur
Übersetzung von passiven Prüfergebnissen finden Sie
[hier](#passivestatetranslation).

-   0 = Prüfübersetzung deaktivieren (Default)

-   1 = Prüfübersetzung aktivieren

**Option passive Host-Prüfungen sind SOFT** (Passive Host Checks Are
SOFT Option)

  ------ -----------------------------------------------------------------
  Format **passive\_host\_checks\_are\_soft=\<0/1\>**
  :      

  Beispi ***passive\_host\_checks\_are\_soft=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA [passive
Host-Prüfungen](#passivechecks) als HARD- oder SOFT-Zustände behandelt.
Per Default wird ein passives Prüfergebnis einen Host in einen
[HARD-Status](#statetypes) setzen. Sie können dieses Verhalten durch
aktivieren dieser Option verändern.

-   0 = passive Host-Prüfungen sind HARD (Default)

-   1 = passive Host-Prüfungen sind SOFT

**Option vorausschauende Host-Abhängigkeitsprüfung** (Predictive Host
Dependency Checks Option)

  ------ -----------------------------------------------------------------
  Format **enable\_predictive\_host\_dependency\_checks=\<0/1\>**
  :      

  Beispi ***enable\_predictive\_host\_dependency\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA vorausschauende Prüfungen von
Hosts ausführen soll, von denen andere abhängig sind (wie in
[Host-Abhängigkeiten](#objectdefinitions-hostdependency) definiert) für
einen bestimmten Host, dessen Zustand wechselt. Vorausschauende
Prüfungen helfen dabei, die Abhängigkeitslogik so genau wie möglich zu
machen. Mehr Informationen darüber, wie vorausschauende Prüfungen
arbeiten, finden Sie [hier](#dependencychecks).

-   0 = vorausschauende Prüfungen deaktivieren

-   1 = vorausschauende Prüfungen aktivieren (Default)

**Option vorausschauende Service-Abhängigkeitsprüfung** (Predictive
Service Dependency Checks Option)

  ------ -----------------------------------------------------------------
  Format **enable\_predictive\_service\_dependency\_checks=\<0/1\>**
  :      

  Beispi ***enable\_predictive\_service\_dependency\_checks=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA vorausschauende Prüfungen von
Services ausführen soll, von denen andere abhängig sind (wie in
[Service-Abhängigkeiten](#objectdefinitions-hostdependency) definiert)
für einen bestimmten Service, dessen Zustand wechselt. Vorausschauende
Prüfungen helfen dabei, die Abhängigkeitslogik so genau wie möglich zu
machen. Mehr Informationen darüber, wie vorausschauende Prüfungen
arbeiten, finden Sie [hier](#dependencychecks).

-   0 = vorausschauende Prüfungen deaktivieren

-   1 = vorausschauende Prüfungen aktivieren (Default)

**Horizont für zwischengespeicherte Host-Prüfungen** (Cached Host Check
Horizon)

  ------ -----------------------------------------------------------------
  Format **cached\_host\_check\_horizon=\<seconds\>**
  :      

  Beispi ***cached\_host\_check\_horizon=15***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die maximale Zeit (in Sekunden) fest, die der Zustand
einer vorherigen Host-Prüfung als aktuell angesehen wird.
Zwischengespeicherte Host-Zustände (von Host-Prüfungen, die aktueller
sind als die in diesem Wert angegebene Zeit) können die Leistung von
Host-Prüfungen immens steigern. Ein zu hoher Wert für diese Option kann
in (vorübergehend) ungenauen Host-Zuständen resultieren, während ein
niedriger Wert zu einem Leistungseinbruch bei Host-Prüfungen führen
kann. Benutzen Sie einen Wert von 0, wenn Sie die Zwischenspeicherung
von Host-Prüfungen deaktivieren wollen. Mehr Informationen zu
zwischengespeicherten Prüfungen finden Sie [hier](#cachedchecks).

**Horizont für zwischengespeicherte Service-Prüfungen** (Cached Service
Check Horizon)

  ------ -----------------------------------------------------------------
  Format **cached\_service\_check\_horizon=\<seconds\>**
  :      

  Beispi ***cached\_service\_check\_horizon=15***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die maximale Zeit (in Sekunden) fest, die der Zustand
einer vorherigen Service-Prüfung als aktuell angesehen wird.
Zwischengespeicherte Service-Zustände (von Service-Prüfungen, die
aktueller sind als die in diesem Wert angegebene Zeit) können die
Leistung von Service-Prüfungen steigern, wenn eine Menge von
[Service-Abhängigkeiten](#objectdefinitions-servicedependency) benutzt
werden. Ein zu hoher Wert für diese Option kann in (vorübergehend)
ungenauen Service-Zuständen resultieren, während ein niedriger Wert zu
einem Leistungseinbruch bei Service-Prüfungen führen kann. Benutzen Sie
einen Wert von 0, wenn Sie die Zwischenspeicherung von Service-Prüfungen
deaktivieren wollen. Mehr Informationen zu zwischengespeicherten
Prüfungen finden Sie [hier](#cachedchecks).

**Option Verbesserungen für große Installationen** (Large Installation
Tweaks Option)

  ------ -----------------------------------------------------------------
  Format **use\_large\_installation\_tweaks=\<0/1\>**
  :      

  Beispi ***use\_large\_installation\_tweaks=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob der NAME-ICINGA-Daemon verschiedene
Abkürzungen nimmt, um die Leistung zu steigern. Diese Abkürzungen
resultieren im Verlust einiger Features, aber große Installationen
werden wahrscheinlich einen hohen Nutzen davon haben. Mehr
Informationen, welche Optimierungen vorgenommen werden, wenn Sie diese
Option aktivieren, finden Sie [hier](#largeinstalltweaks).

-   0 = keine Verbesserungen verwenden (Default)

-   1 = Verbesserungen verwenden

**Kindprozess-Speicher-Option** (Child Process Memory Option)

  ------ -----------------------------------------------------------------
  Format **free\_child\_process\_memory=\<0/1\>**
  :      

  Beispi ***free\_child\_process\_memory=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA Speicher in Kindprozessen
freigibt, wenn sie vom Hauptprozess ge"fork()"ed werden. Per Default
gibt NAME-ICINGA den Speicher frei. Wenn allerdings die
[use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)-Option
aktiviert ist, wird der Speicher nicht freigegeben. Durch Definition
dieser Option in Ihrer Konfigurationsdatei sind Sie in der Lage, das
Verhalten einzustellen, das Sie möchten.

-   0 = Speicher nicht freigeben

-   1 = Speicher freigeben

**Kindprozesse zweimal "fork()"en**

  ------ -----------------------------------------------------------------
  Format **child\_processes\_fork\_twice=\<0/1\>**
  :      

  Beispi ***child\_processes\_fork\_twice=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA Kindprozesse zweimal "fork()"ed,
wenn es Host- und Service-Prüfungen ausführt. Per Default "fork()"ed
NAME-ICINGA zweimal. Wenn allerdings die
[use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)-Option
aktiviert ist, "fork()"ed NAME-ICINGA nur einmal. Durch Definition
dieser Option in Ihrer Konfigurationsdatei sind Sie in der Lage, das
Verhalten einzustellen, das Sie möchten.

-   0 = nur einmal "fork()"en

-   1 = zweimal "fork()"en

**Umgebungsmakros-Option**

  ------ -----------------------------------------------------------------
  Format **enable\_environment\_macros=\<0/1\>**
  :      

  Beispi ***enable\_environment\_macros=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA alle
Standard-[Makros](#macrolist) als Umgebungsvariablen für Prüfungen,
Benachrichtigungen, Eventhandler usw. zur Verfügung stellt. In großen
Installationen kann dies problematisch sein, weil es zusätzlichen
Speicher (und wichtiger) mehr CPU benötigt, um die Werte aller Makros zu
berechnen und sie der Umgebung zur Verfügung zu stellen.

-   0 = Makros nicht als Umgebungsvariablen verfügbar machen (Default)

-   1 = Makros als Umgebungsvariablen verfügbar machen

> **Note**
>
> Ab NAME-ICINGA 1.5 hat sich der Default geändert. Vorher war diese
> Direktive aktiviert, nun ist sie *deaktiviert*.

**Flattererkennungsoption**

  ------ -----------------------------------------------------------------
  Format **enable\_flap\_detection=\<0/1\>**
  :      

  Beispi ***enable\_flap\_detection=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA versucht festzustellen, ob Hosts
und Services "flattern". Flattern tritt auf, wenn ein Host oder Service
zu schnell zwischen verschiedenen Zuständen wechselt, was in einem
Bombardement von Benachrichtigungen resultiert. Wenn NAME-ICINGA
erkennt, dass ein Host oder Service flattert, wird es vorübergehend
Benachrichtigungen für diesen Host/Service unterdrücken, bis das
Flattern endet. Flattererkennung ist sehr experimentell zu diesem
Zeitpunkt, also benutzen Sie diese Option mit Vorsicht! Mehr
Informationen dazu, wie Flattererkennung und Behandlung funktionieren,
finden Sie [hier](#flapping). Anmerkung: Wenn Sie
[Statusaufbewahrung](#configmain-retain_state_information) aktiviert
haben, wird NAME-ICINGA diese Einstellung ignorieren, wenn es (erneut)
startet und die letzte bekannte Einstellung dieser Option nutzen (wie
sie in der [Statusaufbewahrungsdatei](#configmain-state_retention_file)
abgelegt ist), *es sei denn*, Sie haben die
[use\_retained\_program\_state](#configmain-use_retained_program_state)-Option
deaktiviert. Wenn Sie diese Option ändern möchten, während die
Statusaufbewahrung aktiviert ist (und die Option
[use\_retained\_program\_state](#configmain-use_retained_program_state)
aktiviert ist), müssen Sie den entsprechenden [externen
Befehl](#extcommands) benutzen oder sie über das Web-Interface ändern.

-   0 = Flattererkennung deaktivieren (Default)

-   1 = Flattererkennung aktivieren

**niedriger Service-Flatterschwellwert** (Low Service Flap Threshold)

  ------ -----------------------------------------------------------------
  Format **low\_service\_flap\_threshold=\<percent\>**
  :      

  Beispi ***low\_service\_flap\_threshold=25.0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option wird benutzt, um den niedrigen Schwellwert für die
Erkennung von Service-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie [hier](#flapping).

**hoher Service-Flatterschwellwert** (High Service Flap Threshold)

  ------ -----------------------------------------------------------------
  Format **high\_service\_flap\_threshold=\<percent\>**
  :      

  Beispi ***high\_service\_flap\_threshold=50.0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option wird benutzt, um den hohen Schwellwert für die Erkennung
von Service-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie [hier](#flapping).

**niedriger Host-Flatterschwellwert** (Low Host Flap Threshold)

  ------ -----------------------------------------------------------------
  Format **low\_host\_flap\_threshold=\<percent\>**
  :      

  Beispi ***low\_host\_flap\_threshold=25.0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option wird benutzt, um den niedrigen Schwellwert für die
Erkennung von Host-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie [hier](#flapping).

**hoher Host-Flatterschwellwert** (High Host Flap Threshold)

  ------ -----------------------------------------------------------------
  Format **high\_host\_flap\_threshold=\<percent\>**
  :      

  Beispi ***high\_host\_flap\_threshold=50.0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option wird benutzt, um den hohen Schwellwert für die Erkennung
von Host-Flattern zu setzen. Mehr Informationen dazu, wie
Flattererkennung und Behandlung funktionieren (und wie diese Option
Dinge beeinflusst), finden Sie [hier](#flapping).

**Soft-Statusabhängigkeitsoption** (Soft State Dependencies Option)

  ------ -----------------------------------------------------------------
  Format **soft\_state\_dependencies=\<0/1\>**
  :      

  Beispi ***soft\_state\_dependencies=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA Soft-Statusinformationen benutzen
soll, um [Host- und Serviceabhängigkeiten](#dependencies) zu prüfen.
Normalerweise wird NAME-ICINGA nur den letzten Hard-Status des Hosts
oder Service verwenden, wenn Abhängigkeiten geprüft werden. Wenn Sie
möchten, dass der letzte Zustand (unabhängig davon, ob es ein Soft- oder
Hard-[Zustandstyp](#statetypes) ist), dann aktivieren Sie diese Option.

-   0 = keine Soft-Status-Abhängigkeiten benutzen (Default)

-   1 = Soft-Status-Abhängigkeiten benutzen

**Schwellwert für die Abweichung von der Systemzeit** (Time Change
Threshold Option)

  ------ -----------------------------------------------------------------
  Format **time\_change\_threshold=(seconds)**
  :      

  Beispi ***time\_change\_threshold=900***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wann NAME-ICINGA auf festgestellte
System-Zeit-Abweichungen reagieren soll.

**Service-Prüfungs-Zeitüberschreitung** (Service Check Timeout)

  ------ -----------------------------------------------------------------
  Format **service\_check\_timeout=\<seconds\>**
  :      

  Beispi ***service\_check\_timeout=60***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die Service-Prüfungen laufen
dürfen. Wenn Prüfungen diese Grenze überschreiten, werden sie
abgebrochen (killed) und ein CRITICAL-Zustand wird zurückgeliefert.
Außerdem wird ein Fehler protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Plugins sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jede Service-Prüfung normalerweise innerhalb dieser Zeit beendet
ist. Wenn eine Service-Prüfung länger läuft, dann wird NAME-ICINGA diese
Prüfung abbrechen, weil es denkt, dass es sich um einen außer Kontrolle
geratenen Prozess handelt.

**Service-Prüfungs-Zeitüberschreitungs-Status**

  ------ -----------------------------------------------------------------
  Format **service\_check\_timeout\_state=\<c/w/u/o\>**
  :      

  Exampl ***service\_check\_timeout\_state=u***
  e:     
  ------ -----------------------------------------------------------------

Diese Option legt den Status fest den ein Service erhält, wenn er in
einen Timeout läuft. Er also nicht in der, mit service\_check\_timeout
definierten Zeit, eine Rückmeldung bekommt. Das kann sehr nützlich sein,
wenn eine Maschine gerade einen sehr hohen Load hat und der
Service-Check fehlschlägt und dann kein Critical-Alarm generiert werden
soll. Der Default-Wert wurde von service\_check\_timeout\_state=c zu
service\_check\_timeout\_state=u in NAME-ICINGA 1.0.1 geändert.

**Host-Prüfungs-Zeitüberschreitung** (Host Check Timeout)

  ------ -----------------------------------------------------------------
  Format **host\_check\_timeout=\<seconds\>**
  :      

  Beispi ***host\_check\_timeout=60***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die Host-Prüfungen laufen
dürfen. Wenn Prüfungen diese Grenze überschreiten, werden sie
abgebrochen (killed), ein CRITICAL-Zustand wird zurückgeliefert und der
Host als "DOWN" angesehen. Außerdem wird ein Fehler protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Plugins sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jede Host-Prüfung normalerweise innerhalb dieser Zeit beendet ist.
Wenn eine Host-Prüfung länger läuft, dann wird NAME-ICINGA diese Prüfung
abbrechen, weil es denkt, dass es sich um einen außer Kontrolle
geratenen Prozess handelt.

**Eventhandler-Zeitüberschreitung**

  ------ -----------------------------------------------------------------
  Format **event\_handler\_timeout=\<seconds\>**
  :      

  Beispi ***event\_handler\_timeout=60***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die
[Eventhandler](#eventhandlers) laufen dürfen. Wenn ein Eventhandler
diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

Es gibt oft eine weitverbreitete Verwirrung, was diese Option wirklich
tut. Es ist als allerletzter Versuch gedacht, wenn Befehle sich "daneben
benehmen" und nicht innerhalb einer bestimmten Zeit enden. Sie sollte
auf einen hohen Wert (z.B. 60 Sekunden oder mehr) gesetzt werden, so
dass jeder Eventhandler normalerweise innerhalb dieser Zeit beendet ist.
Wenn ein Eventhandler länger läuft, dann wird NAME-ICINGA diesen
Eventhandler abbrechen, weil es denkt, dass es sich um einen außer
Kontrolle geratenen Prozess handelt.

**Benachrichtigungs-Zeitüberschreitung**

  ------ -----------------------------------------------------------------
  Format **notification\_timeout=\<seconds\>**
  :      

  Beispi ***notification\_timeout=60***
  el:    
  ------ -----------------------------------------------------------------

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
NAME-ICINGA diesen Benachrichtigungsbefehl abbrechen, weil es denkt,
dass es sich um einen außer Kontrolle geratenen Prozess handelt.

**Zwangsverfolgungs-Service-Prozessor-Zeitüberschreitung** (Obsessive
Compulsive Service Processor Timeout)

  ------ -----------------------------------------------------------------
  Format **ocsp\_timeout=\<seconds\>**
  :      

  Beispi ***ocsp\_timeout=5***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die ein
[Zwangsverfolgungs-Service-Prozessor-Befehl](#configmain-ocsp_command)
(obsessive compulsive service processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Zwangsverfolgungs-Host-Prozessor-Zeitüberschreitung** (Obsessive
Compulsive Host Processor Timeout)

  ------ -----------------------------------------------------------------
  Format **ochp\_timeout=\<seconds\>**
  :      

  Beispi ***ochp\_timeout=5***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die ein
[Zwangsverfolgungs-Host-Prozessor-Befehl](#configmain-ochp_command)
(obsessive compulsive host processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Performance-Daten-Prozessorbefehls-Zeitüberschreitung** (Performance
Data Processor Command Timeout)

  ------ -----------------------------------------------------------------
  Format **perfdata\_timeout=\<seconds\>**
  :      

  Beispi ***perfdata\_timeout=5***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die maximale Zahl von Sekunden, die ein
[Host-Performance-Daten-Prozessorbefehl](#configmain-host_perfdata_command)
(host performance data processor command) oder
[Service-Performance-Daten-Prozessorbefehl](#configmain-service_perfdata_command)
(service performance data processor command) laufen darf. Wenn ein
Befehl diese Grenze überschreitet, wird er abgebrochen (killed) und eine
Warnung protokolliert.

**Verfolgung-von-Services-Option** (Obsess Over Services Option)

  ------ -----------------------------------------------------------------
  Format **obsess\_over\_services=\<0/1\>**
  :      

  Beispi ***obsess\_over\_services=1***
  el:    
  ------ -----------------------------------------------------------------

Dieser Wert legt fest, ob NAME-ICINGA Service-Prüfergebnisse "verfolgt"
(obsess) und den
[Zwangsverfolgungs-Service-Prozessorbefehl](#configmain-ocsp_command)
ausführt, den Sie angeben. Nun ja - ein komischer Name, aber das ist
alles, was Ethan Galstad eingefallen ist. Diese Option ist nützlich, um
[verteilte Überwachung](#distributed) durchzuführen. Wenn Sie keine
verteilte Überwachung machen, dann aktivieren Sie diese Option nicht.

-   0 = Services nicht verfolgen (Default)

-   1 = Services verfolgen

**Zwangsverfolgungs-Service-Prozessorbefehl** (Obsessive Compulsive
Service Processor Command)

  ------ -----------------------------------------------------------------
  Format **ocsp\_command=\<command\>**
  :      

  Beispi ***ocsp\_command=obsessive\_service\_handler***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen einen Befehl anzugeben, der nach *jeder*
Service-Prüfung ausgeführt wird, was bei [verteilter
Überwachung](#distributed) nützlich sein kann. Dieser Befehl wird nach
[Eventhandler](#eventhandlers)- oder
[Benachrichtigungs](#notifications)-Befehlen ausgeführt. Das
*command*-Argument ist der Kurzname einer
[command-Definition](#objectdefinitions-command), die Sie in Ihrer
Objektkonfigurationsdatei angeben. Die maximale Zeit, die dieser Befehl
laufen darf, wird mit der
[ocsp\_timeout](#configmain-ocsp_timeout)-Option kontrolliert. Mehr
Informationen zu verteilter Überwachung finden Sie [hier](#distributed).
Dieser Befehl wird nur ausgeführt, wenn die
[obsess\_over\_services](#configmain-obsess_over_services)-Option global
aktiviert ist und wenn die *obsess\_over\_service*-Direktive in der
[Service-Definition](#objectdefinitions-service) aktiviert ist.

**Verfolgung-von-Hosts-Option** (Obsess Over Hosts Option)

  ------ -----------------------------------------------------------------
  Format **obsess\_over\_hosts=\<0/1\>**
  :      

  Beispi ***obsess\_over\_hosts=1***
  el:    
  ------ -----------------------------------------------------------------

Dieser Wert legt fest, ob NAME-ICINGA Host-Prüfergebnisse "verfolgt"
(obsess) und den
[Zwangsverfolgungs-Host-Prozessorbefehl](#configmain-ocsp_command)
ausführt, den Sie angeben. Nun ja - ein komischer Name, aber das ist
alles, was Ethan Galstad eingefallen ist. Diese Option ist nützlich, um
[verteilte Überwachung](#distributed) durchzuführen. Wenn Sie keine
verteilte Überwachung machen, dann aktivieren Sie diese Option nicht.

-   0 = Hosts nicht verfolgen (Default)

-   1 = Hosts verfolgen

**Zwangsverfolgungs-Host-Prozessorbefehl** (Obsessive Compulsive Host
Processor Command)

  ------ -----------------------------------------------------------------
  Format **ochp\_command=\<command\>**
  :      

  Beispi ***ochp\_command=obsessive\_host\_handler***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt Ihnen einen Befehl anzugeben, der nach *jeder*
Host-Prüfung ausgeführt wird, was bei [verteilter
Überwachung](#distributed) nützlich sein kann. Dieser Befehl wird nach
[Eventhandler](#eventhandlers)- oder
[Benachrichtigungs](#notifications)-Befehlen ausgeführt. Das
*command*-Argument ist der Kurzname einer
[command-Definition](#objectdefinitions-command), die Sie in Ihrer
Objektkonfigurationsdatei angeben. Die maximale Zeit, die dieser Befehl
laufen darf, wird mit der
[ochp\_timeout](#configmain-ochp_timeout)-Option kontrolliert. Mehr
Informationen zu verteilter Überwachung finden Sie [hier](#distributed).
Dieser Befehl wird nur ausgeführt, wenn die
[obsess\_over\_hosts](#configmain-obsess_over_hosts)-Option global
aktiviert ist und wenn die *obsess\_over\_hosts*-Direktive in der
[Host-Definition](#objectdefinitions-service) aktiviert ist.

**Performance-Daten-Verarbeitungsoption** (Performance Data Processing
Option)

  ------ -----------------------------------------------------------------
  Format **process\_performance\_data=\<0/1\>**
  :      

  Beispi ***process\_performance\_data=1***
  el:    
  ------ -----------------------------------------------------------------

Dieser Wert legt fest, ob NAME-ICINGA [Performance-Daten](#perfdata) von
Host- und Service-Prüfungen verarbeitet.

-   0 = keine Performance-Daten verarbeiten (Default)

-   1 = Performance-Daten verarbeiten

**Host-Performance-Daten-Verarbeitungsbefehl** (Host Performance Data
Processing Command)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_command=\<command\>**
  :      

  Beispi ***host\_perfdata\_command=process-host-perfdata***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, einen Befehl anzugeben, der nach *jeder*
Host-Prüfung ausgeführt wird, um Host-[Performance-Daten](#perfdata) zu
verarbeiten, die von der Prüfung zurückgeliefert worden sein könnten.
Das *command*-Argument ist der Kurzname einer
[command-Definition](#objectdefinitions-command), die Sie in Ihrer
Objektkonfigurationsdatei angeben. Dieser Befehl wird nur ausgeführt,
wenn die
[process\_performance\_data](#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Host-Definition](#objectdefinitions-host) aktiviert ist.

**Service-Performance-Daten-Verarbeitungsbefehl** (Service Performance
Data Processing Command)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_command=\<command\>**
  :      

  Beispi ***service\_perfdata\_command=process-service-perfdata***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, einen Befehl anzugeben, der nach *jeder*
Service-Prüfung ausgeführt wird, um
Service-[Performance-Daten](#perfdata) zu verarbeiten, die von der
Prüfung zurückgeliefert worden sein könnten. Das *command*-Argument ist
der Kurzname einer [command-Definition](#objectdefinitions-command), die
Sie in Ihrer Objektkonfigurationsdatei angeben. Dieser Befehl wird nur
ausgeführt, wenn die
[process\_performance\_data](#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Service-Definition](#objectdefinitions-host) aktiviert ist.

**Host-Performance-Daten-Datei** (Host Performance Data File)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_file=\<file\_name\>**
  :      

  Beispi ***host\_perfdata\_file=URL-ICINGA-BASE/var/host-perfdata.dat***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, eine Datei anzugeben, in die nach jeder
Host-Prüfung [Performance-Daten](#perfdata) geschrieben werden. Daten
werden in die Performance-Datei geschrieben, wie es in der
[host\_perfdata\_file\_template](#configmain-host_perfdata_file_template)-Option
angegeben ist. Performance-Daten werden nur in diese Datei geschrieben,
wenn die
[process\_performance\_data](#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Host-Definition](#objectdefinitions-host) aktiviert ist.

**Service-Performance-Daten-Datei** (Service Performance Data File)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_file=\<file\_name\>**
  :      

  Beispi ***service\_perfdata\_file=URL-ICINGA-BASE/var/service-perfdata.d
  el:    at***
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, eine Datei anzugeben, in die nach jeder
Service-Prüfung [Performance-Daten](#perfdata) geschrieben werden. Daten
werden in die Performance-Datei geschrieben, wie es in der
[service\_perfdata\_file\_template](#configmain-service_perfdata_file_template)-Option
angegeben ist. Performance-Daten werden nur in diese Datei geschrieben,
wenn die
[process\_performance\_data](#configmain-process_performance_data)-Option
global aktiviert ist und wenn die *process\_perf\_data*-Direktive in der
[Service-Definition](#objectdefinitions-host) aktiviert ist.

**Host-Performance-Daten-Dateivorlage** (Host Performance Data File
Template)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_file\_template=\<template\>**
  :      

  Beispi ***host\_perfdata\_file\_template=[HOSTPERFDATA]\\t\$TIMET\$\\t\$
  el:    HOSTNAME\$\\
         \\
         \\t\$HOSTEXECUTIONTIME\$\\t\$HOSTOUTPUT\$\\t\$HOSTPERFDATA\$***
  ------ -----------------------------------------------------------------

Diese Option legt fest, welche (und wie) Daten in die
[Host-Performancedaten-Datei](#configmain-host_perfdata_file)
geschrieben werden. Diese Vorlage kann [Makros](#macros), Sonderzeichen
(\\t für Tabulator, \\r für Wagenrücklauf (carriage return), \\n für
Zeilenvorschub (newline)) und reinen Text enthalten. Nach jedem
Schreibvorgang wird ein Zeilenvorschub an die Performancedaten-Datei
angehängt.

**Service-Performance-Daten-Dateivorlage** (Service Performance Data
File Template)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_file\_template=\<template\>**
  :      

  Beispi ***service\_perfdata\_file\_template=[SERVICEPERFDATA]\\t\$TIMET\
  el:    $\\t\$HOSTNAME\$
         \\
         \\t\$SERVICEDESC\$\\t\$SERVICEEXECUTIONTIME\$\\t\$SERVICELATENCY\
         $\\t\$SERVICEOUTPUT\$\\t\$SERVICEPERFDATA\$***
  ------ -----------------------------------------------------------------

Diese Option legt fest, welche (und wie) Daten in die
[Service-Performancedaten-Datei](#configmain-service_perfdata_file)
geschrieben werden. Diese Vorlage kann [Makros](#macros), Sonderzeichen
(\\t für Tabulator, \\r für Wagenrücklauf (carriage return), \\n für
Zeilenvorschub (newline)) und reinen Text enthalten. Nach jedem
Schreibvorgang wird ein Zeilenvorschub an die Performancedaten-Datei
angehängt.

**Host-Performance-Daten-Dateimodus** (Host Performance Data File Mode)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_file\_mode=\<mode\>**
  :      

  Beispi ***host\_perfdata\_file\_mode=a***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wie die
[Host-Performance-Datendatei](#configmain-host_perfdata_file) geöffnet
wird. Solange die Datei keine "named pipe" ist, werden Sie diese
wahrscheinlich im append-Modus (anhängen) öffnen wollen.

-   a = Datei im append-Modus öffnen (Default)

-   w = Datei im Write-Modus öffnen

-   p = Datei im nicht-blockierenden Schreib-/Lesemodus öffnen
    (nützlich, wenn man in Pipes schreibt)

**Service-Performance-Daten-Dateimodus** (Service Performance Data File
Mode)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_file\_mode=\<mode\>**
  :      

  Beispi ***service\_perfdata\_file\_mode=a***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wie die
[Service-Performance-Datendatei](#configmain-service_perfdata_file)
geöffnet wird. Solange die Datei keine "named pipe" ist, werden Sie
diese wahrscheinlich im append-Modus (anhängen) öffnen wollen.

-   a = Datei im append-Modus öffnen (Default)

-   w = Datei im Write-Modus öffnen

-   p = Datei im nicht-blockierenden Schreib-/Lesemodus öffnen
    (nützlich, wenn man in Pipes schreibt)

**Host-Performance-Daten-Dateiverarbeitungsintervall** (Host Performance
Data File Processing Interval)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_file\_processing\_interval=\<seconds\>**
  :      

  Beispi ***host\_perfdata\_file\_processing\_interval=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, das Intervall (in Sekunden) anzugeben, in
dem die [Host-Performance-Daten-Datei](#configmain-host_perfdata_file)
mit dem
[Host-Performance-Daten-Dateiverarbeitungsbefehl](#configmain-host_perfdata_file_processing_command)
verarbeitet wird. Ein Wert von 0 gibt an, dass die
Performance-Daten-Datei nicht in regelmäßigen Intervallen verarbeiten
werden soll.

**Service-Performance-Daten-Dateiverarbeitungsintervall** (Service
Performance Data File Processing Interval)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_file\_processing\_interval=\<seconds\>**
  :      

  Beispi ***service\_perfdata\_file\_processing\_interval=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, das Intervall (in Sekunden) anzugeben, in
dem die
[Service-Performance-Daten-Datei](#configmain-service_perfdata_file) mit
dem
[Service-Performance-Daten-Dateiverarbeitungsbefehl](#configmain-service_perfdata_file_processing_command)
verarbeitet wird. Ein Wert von 0 gibt an, dass die
Performance-Daten-Datei nicht in regelmäßigen Intervallen verarbeiten
werden soll.

**Host-Performance-Daten-Dateiverarbeitungsbefehl** (Host Performance
Data File Processing Command)

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_file\_processing\_command=\<command\>**
  :      

  Beispi ***host\_perfdata\_file\_processing\_command=process-host-perfdat
  el:    a-file***
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, den Befehl anzugeben, der ausgeführt
werden soll, um die
[Host-Performance-Daten-Datei](#configmain-host_perfdata_file) zu
verarbeiten. Das *command*-Argument ist der Kurzname einer
[command-Definition](#objectdefinitions-command), die Sie in Ihrer
Objektkonfigurationsdatei angeben. Das Intervall, in dem dieser Befehl
ausgeführt wird, ist durch die
[host\_perfdata\_file\_processing\_interval](#configmain-host_perfdata_file_processing_interval)-Direktive
festgelegt.

**Service-Performance-Daten-Dateiverarbeitungsbefehl** (Service
Performance Data File Processing Command)

  ------ -----------------------------------------------------------------
  Format **service\_perfdata\_file\_processing\_command=\<command\>**
  :      

  Beispi ***service\_perfdata\_file\_processing\_command=process-service-p
  el:    erfdata-file***
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, den Befehl anzugeben, der ausgeführt
werden soll, um die
[Service-Performance-Daten-Datei](#configmain-service_perfdata_file) zu
verarbeiten. Das *command*-Argument ist der Kurzname einer
[command-Definition](#objectdefinitions-command), die Sie in Ihrer
Objektkonfigurationsdatei angeben. Das Intervall, in dem dieser Befehl
ausgeführt wird, ist durch die
[service\_perfdata\_file\_processing\_interval](#configmain-service_perfdata_file_processing_interval)-Direktive
festgelegt.

**verwaiste Service-Prüfungsoption** (Orphaned Service Check Option)

  ------ -----------------------------------------------------------------
  Format **check\_for\_orphaned\_services=\<0/1\>**
  :      

  Beispi ***check\_for\_orphaned\_services=1***
  el:    
  ------ -----------------------------------------------------------------

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
ist und NAME-ICINGA feststellt, dass eine bestimmte Service-Prüfung kein
Ergebnis geliefert hat, dann wird es einen Fehler protokollieren und die
Service-Prüfung erneut einplanen. Wenn Sie feststellen, dass
Service-Prüfungen anscheinend nie erneut eingeplant werden, dann
aktivieren Sie diese Option und schauen Sie nach Protokollmeldungen zu
verwaisten Services.

-   0 = nicht auf verwaiste Service-Prüfungen prüfen

-   1 = auf verwaiste Service-Prüfungen prüfen (Default)

**verwaiste Host-Prüfungsoption** (Orphaned Host Check Option)

  ------ -----------------------------------------------------------------
  Format **check\_for\_orphaned\_hosts=\<0/1\>**
  :      

  Beispi ***check\_for\_orphaned\_hosts=1***
  el:    
  ------ -----------------------------------------------------------------

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
NAME-ICINGA feststellt, dass eine bestimmte Host-Prüfung kein Ergebnis
geliefert hat, dann wird es einen Fehler protokollieren und die
Host-Prüfung erneut einplanen. Wenn Sie feststellen, dass Host-Prüfungen
anscheinend nie erneut eingeplant werden, dann aktivieren Sie diese
Option und schauen Sie nach Protokollmeldungen zu verwaisten Hosts.

-   0 = nicht auf verwaiste Host-Prüfungen prüfen

-   1 = auf verwaiste Host-Prüfungen prüfen (Default)

**Service-Frischeprüfungsoption** (Service Freshness Checking Option)

  ------ -----------------------------------------------------------------
  Format **check\_service\_freshness=\<0/1\>**
  :      

  Beispi ***check\_service\_freshness=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA regelmäßig die "Frische"
(freshness) von Service-Prüfungen prüft. Das Aktivieren dieser Option
ist nützlich, um sicherzustellen, dass [passive
Service-Prüfungen](#passivechecks) rechtzeitig empfangen werden. Mehr
Informationen zur Frische-Prüfung finden Sie [hier](#freshness).

-   0 = Service-Frische nicht prüfen

-   1 = Service-Frische prüfen (Default)

**Service-Frische-Prüfintervall** (Service Freshness Check Interval)

  ------ -----------------------------------------------------------------
  Format **service\_freshness\_check\_interval=\<seconds\>**
  :      

  Beispi ***service\_freshness\_check\_interval=60***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, wie oft (in Sekunden) NAME-ICINGA
regelmäßig die "Frische" (freshness) von Service-Prüfergebnissen prüfen
wird. Wenn Sie die Service-Frische-Prüfung (mit der
[check\_service\_freshness](#configmain-check_service_freshness)-Option)
deaktiviert haben, dann hat diese Option keine Auswirkungen. Mehr
Informationen zur Frische-Prüfung finden Sie [hier](#freshness).

**Host-Frischeprüfungsoption** (Host Freshness Checking Option)

  ------ -----------------------------------------------------------------
  Format **check\_host\_freshness=\<0/1\>**
  :      

  Beispi ***check\_host\_freshness=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob NAME-ICINGA regelmäßig die "Frische"
(freshness) von Host-Prüfungen prüft. Das Aktivieren dieser Option ist
nützlich, um sicherzustellen, dass [passive
Host-Prüfungen](#passivechecks) rechtzeitig empfangen werden. Mehr
Informationen zur Frische-Prüfung finden Sie [hier](#freshness).

-   0 = Host-Frische nicht prüfen (Default)

-   1 = Host-Frische prüfen

**Host-Frische-Prüfintervall** (Host Freshness Check Interval)

  ------ -----------------------------------------------------------------
  Format **host\_freshness\_check\_interval=\<seconds\>**
  :      

  Beispi ***host\_freshness\_check\_interval=60***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, wie oft (in Sekunden) NAME-ICINGA
regelmäßig die "Frische" (freshness) von Host-Prüfergebnissen prüfen
wird. Wenn Sie die Host-Frische-Prüfung (mit der
[check\_host\_freshness](#configmain-check_host_freshness)-Option)
deaktiviert haben, dann hat diese Option keine Auswirkungen. Mehr
Informationen zur Frische-Prüfung finden Sie [hier](#freshness).

**zusätzliche Frische-Latenzschwellwert-Option** (Additional Freshness
Threshold Latency Option)

  ------ -----------------------------------------------------------------
  Format **additional\_freshness\_latency=\<\#\>**
  :      

  Beispi ***additional\_freshness\_latency=15***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die Anzahl von Sekunden fest, die NAME-ICINGA zu jedem
Host- oder Service-Frischeschwellwert hinzurechnet, den es automatisch
berechnet (d.h., die nicht explizit durch den Benutzer angegeben
wurden). Mehr Informationen zur Frische-Prüfung finden Sie
[hier](#freshness).

**Lokation des P1.pl Perl-Skriptes** (P1.PL File Location)

  ------ -----------------------------------------------------------------
  Format **p1\_file=@P1FILELOC@/p1.pl**
  :      
  ------ -----------------------------------------------------------------

Diese Option gibt den Speicherort des p1.pl Perl-Skriptes an das vom
eingebetteten Perl- Interpreter genutzt wird. Diese Option ist aktiv
wenn Sie NAME-ICINGA mit eingebetteten Perl- Interpreter compiliert
haben.

**eingebetteter-Perl-Interpreter-Option** (Embedded Perl Interpreter
Option)

  ------ -----------------------------------------------------------------
  Format **enable\_embedded\_perl=\<0/1\>**
  :      

  Beispi ***enable\_embedded\_perl=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, ob der eingebettete Perl-Interpreter auf
programmweiter Basis aktiviert ist. NAME-ICINGA muss mit Unterstützung
für eingebettetes Perl kompiliert sein, damit diese Option eine
Auswirkung hat. Mehr Informationen zum eingebauten Perl-Interpreter
finden Sie [hier](#embeddedperl).

> **Note**
>
> Ab NAME-ICINGA 1.5 hat sich der Default geändert. Vorher war diese
> Direktive aktiviert, nun ist sie *deaktiviert*.

**Option implizite Nutzung des eingebetteten Perl-Interpreters**
(Embedded Perl Implicit Use Option)

  ------ -----------------------------------------------------------------
  Format **use\_embedded\_perl\_implicitly=\<0/1\>**
  :      

  Beispi ***use\_embedded\_perl\_implicitly=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Einstellung legt fest, ob der eingebettete Perl-Interpreter für
Perl-Plugins/Scripte benutzt werden soll, die ihn nicht explizit
aktiviert/deaktiviert haben. NAME-ICINGA muss mit Unterstützung für
eingebettetes Perl kompiliert sein, damit diese Option eine Auswirkung
hat. Mehr Informationen zum eingebauten Perl-Interpreter finden Sie
[hier](#embeddedperl).

**Datumformat** (Date Format)

  ------ -----------------------------------------------------------------
  Format **date\_format=\<option\>**
  :      

  Beispi ***date\_format=us***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen anzugeben, welche Art von
Datums-/Zeitformat NAME-ICINGA im Web-Interface und in den
Datums-/Zeit-[Makros](#macros) benutzen soll. Mögliche Optionen
(zusammen mit einer Beispielausgabe) umfassen u.a.:

  ------------------------ ------------------------ ------------------------
  **Option**               **Ausgabeformat**        **Beispielausgabe**
  us                       MM-DD-YYYY HH:MM:SS      06-30-2002 03:15:00
  euro                     DD-MM-YYYY HH:MM:SS      30-06-2002 03:15:00
  iso8601                  YYYY-MM-DD HH:MM:SS      2002-06-30 03:15:00
  strict-iso8601           YYYY-MM-DDTHH:MM:SS      2002-06-30T03:15:00
  ------------------------ ------------------------ ------------------------

**Zeitzonen-Option** (Timezone Option)

  ------ -----------------------------------------------------------------
  Format **use\_timezone=\<tz\>**
  :      

  Beispi ***use\_timezone=US/Mountain***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, die Standard-Zeitzone zu überschreiben,
in der die NAME-ICINGA-Instanz läuft. Das ist nützlich, wenn Sie mehrere
NAME-ICINGA-Instanzen haben, die auf dem gleichen Server laufen, aber
mit verschiedenen lokalen Zeiten verbunden sind. Wenn nichts angegeben
ist, wird NAME-ICINGA die Zeitzone des Rechners benutzen.

![](../images/note.gif) Anmerkung: wenn Sie diese Option nutzen, um eine
eigene Zeitzone anzugeben, müssen Sie auch die
NAME-APACHE-Konfigurationsdirektiven für die CGIs auf die Zeitzone
ändern, die Sie haben möchten. Beispiel:

\<Directory "URL-ICINGA-BASE/sbin/"\>

SetEnv TZ "US/Mountain"

...

\</Directory\>

> **Note**
>
> Abhängig von Ihrem Betriebssystem kann es sein, dass Sie vor der
> Zeitzone einen Doppelpunkt einfügen müssen, damit es wie gewünscht
> funktioniert
>
> `use_timezone=:US/Mountain`

**Illegale Zeichen für Objektnamen** (Illegal Object Name Characters)

  ------ -----------------------------------------------------------------
  Format **illegal\_object\_name\_chars=\<chars...\>**
  :      

  Beispi ***illegal\_object\_name\_chars=\`\~!\$%\^&\*"|'\<\>?,()=***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, illegale Zeichen anzugeben, die nicht in
Host-Namen, Service-Beschreibungen oder Namen anderer Objektarten
benutzt werden können. NAME-ICINGA gestattet Ihnen, die meisten Zeichen
in Objektdefinitionen zu benutzen, aber wir raten Ihnen, die im Beispiel
gezeigten Zeichen nicht zu nutzen. Wenn Sie es dennoch tun, können Sie
Probleme im Web-Interface, in Benachrichtigungsbefehlen usw. bekommen.

**illegale Zeichen für Makroausgaben** (Illegal Macro Output Characters)

  ------ -----------------------------------------------------------------
  Format **illegal\_macro\_output\_chars=\<chars...\>**
  :      

  Beispi ***illegal\_macro\_output\_chars=\`\~\$&"|'\<\>***
  el:    
  ------ -----------------------------------------------------------------

Diese Option erlaubt es Ihnen, illegale Zeichen anzugeben, die aus
[Makros](#macros) entfernt werden, bevor diese in Benachrichtigungen,
Eventhandlern und anderen Befehlen benutzt werden. Dies betrifft AUCH
Makros, die in Service- oder Host-Prüfbefehlen benutzt werden. Sie
können sich entscheiden, die Zeichen im Beispiel nicht zu entfernen,
aber wir raten Ihnen, das nicht zu tun. Einige dieser Zeichen werden von
der Shell interpretiert (z.B. der "Backtick") und können zu
Sicherheitsproblemen führen. Die folgenden Makros werden von den Zeichen
gereinigt, die Sie angeben:

**\$HOSTOUTPUT\$**, **\$HOSTPERFDATA\$**, **\$HOSTACKAUTHOR\$**,
**\$HOSTACKCOMMENT\$**, **\$SERVICEOUTPUT\$**, **\$SERVICEPERFDATA\$**,
**\$SERVICEACKAUTHOR\$**, und **\$SERVICEACKCOMMENT\$**

**Option Behalten von unbekannten Makros**

  ------ -----------------------------------------------------------------
  Format **keep\_unknown\_macros=\<0/1\>**
  :      

  Beispi ***keep\_unknown\_macros=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option kann verwendet werden, um unbekannte Makros in der Ausgabe
zu belassen, z.B. check\_proc -C \$foo\$, verbleibt in der
Kommandozeile. Die Shell versucht \$foo zu interpretieren und belässt
ein einzelnes \$- Zeichen in der Ausgabe. Ab NAME-ICINGA 1.8 werden
solche unbekannten Makros aus der Ausgabe gelöscht. Siehe auch
[\#2291](https://dev.icinga.org/issues/2291)für weitere Informationen.
Um das alte Verhalten wieder herzustellen muss diese Option aktiviert
werden.

**Option Anpassung regulärer Ausdrücke** (Regular Expression Matching
Option)

  ------ -----------------------------------------------------------------
  Format **use\_regexp\_matching=\<0/1\>**
  :      

  Beispi ***use\_regexp\_matching=0***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, ob verschiedene Direktiven in Ihren
[Objektdefinitionen](#configobject) als reguläre Ausdrücke verarbeitet
werden. Mehr Informationen dazu, wie das funktioniert, finden Sie
[hier](#objecttricks).

-   0 = keine angepassten regulären Ausdrücke benutzen (Default)

-   1 = angepasste reguläre Ausdrücke benutzen

**Option wahre reguläre Ausdrucksanpassung** (True Regular Expression
Matching Option)

  ------ -----------------------------------------------------------------
  Format **use\_true\_regexp\_matching=\<0/1\>**
  :      

  Beispi ***use\_true\_regexp\_matching=0***
  el:    
  ------ -----------------------------------------------------------------

Wenn Sie reguläre Ausdrücke von verschiedenen Objektdirektiven mit der
[use\_regexp\_matching](#configmain-use_regexp_matching)-Option
aktiviert haben, dann wird diese Option festlegen, wann Objektdirektiven
als reguläre Ausdrücke behandelt werden. Wenn diese Option deaktiviert
ist (der Standard), dann werden Direktiven nur dann als reguläre
Ausdrücke behandelt, wenn sie **\***, **?**, ***\$,* +** oder **\\.**
enthalten (POSIX ERE). Wenn diese Option aktiviert ist, werden alle
entsprechenden Direktiven als reguläre Ausdrücke behandelt - seien Sie
vorsichtig bei der Aktivierung! Mehr Informationen darüber, wie das
funktioniert, finden Sie [hier](#objecttricks).

-   0 = keine Anpassung wahrer regulärer Ausdrücke benutzen (Default)

-   1 = Anpassung wahrer regul¨rer Ausdrücke benutzen

**Administrator-e-Mail-Adresse** (Administrator Email Address)

  ------ -----------------------------------------------------------------
  Format **admin\_email=\<email\_address\>**
  :      

  Beispi ***admin\_email=root@localhost.localdomain***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die e-Mail-Adresse des Administrators der lokalen Maschine
(d.h. die, auf der NAME-ICINGA läuft). Dieser Wert kann mit Hilfe des
**\$ADMINEMAIL\$**-[Makros](#macros) in Benachrichtigungsbefehlen
benutzt werden.

**Administrator-Pager** (Administrator Pager)

  ------ -----------------------------------------------------------------
  Format **admin\_pager=\<pager\_number\_or\_pager\_email\_gateway\>**
  :      

  Beispi ***admin\_pager=pageroot@localhost.localdomain***
  el:    
  ------ -----------------------------------------------------------------

Dies ist die Pager-Nummer (oder die des Pager-e-Mail-Gateways) des
Administrators der lokalen Maschine (d.h. die, auf der NAME-ICINGA
läuft). Die Pager-Nummer/Adresse kann mit Hilfe des
**\$ADMINPAGER\$**-[Makros](#macros) in Benachrichtigungsbefehlen
benutzt werden.

**Daemon Core Dump Option**

  ------ -----------------------------------------------------------------
  Format **daemon\_dumps\_core=\<0/1\>**
  :      

  Beispi ***daemon\_dumps\_core=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Direktive bestimmt ob es NAME-ICINGA, wenn es als Daemon gestartet
wird, erlaubt ist Core Dumps zu erstellen. Dies kann im Fehlerfall sehr
hilfsreich sein, allerdings garantiert das Aktivieren dieser Option
nicht, dass auch wirklich ein Core Dump erstellt wird.

-   0 = Keine Core Dumps (Default)

-   1 = Erlaube Core Dumps

**Ereignisvermittler-Optionen** (Event Broker Options)

  ------ -----------------------------------------------------------------
  Format **event\_broker\_options=\<\#\>**
  :      

  Beispi ***event\_broker\_options=-1***
  el:    
  ------ -----------------------------------------------------------------

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

  ------ -----------------------------------------------------------------
  Format **broker\_module=\<modulepath\> [moduleargs]**
  :      

  Beispi ***broker\_module=URL-ICINGA-BASE/lib/idomod.so
  el:    cfg\_file=URL-ICINGA-BASE/etc/idomod.cfg***
  ------ -----------------------------------------------------------------

Diese Option wird benutzt, um ein Ereignisvermittler-Modul anzugeben,
das beim NAME-ICINGA-Start geladen werden soll. Benutzen Sie mehrere
Direktiven, wenn Sie mehrere Module laden wollen. An das Modul zu
übergebende Argumente werden durch ein Leerzeichen vom Pfad des Moduls
getrennt.

!!! WARNUNG !!!

Überschreiben Sie KEINE Module, während sie von NAME-ICINGA genutzt
werden, oder NAME-ICINGA wird mit einem SEGFAULT-Feuerwerk abstürzen.
Dies ist ein Fehler/eine Begrenzung entweder in dlopen(), dem Kernel,
und/oder dem Filesystem. Und vielleicht NAME-ICINGA...

Der korrekte/sichere Weg, ein Modul zu aktualisieren, ist eine der
folgenden Methoden:

1.  stoppen Sie NAME-ICINGA, ersetzen Sie das Modul und starten Sie
    NAME-ICINGA erneut

2.  während NAME-ICINGA läuft... löschen Sie die originale Moduldatei,
    schieben Sie die neue Moduldatei an den richtigen Platz und starten
    Sie NAME-ICINGA erneut

**Debug-Datei** (Debug File)

  ------ -----------------------------------------------------------------
  Format **debug\_file=\<file\_name\>**
  :      

  Beispi ***debug\_file=URL-ICINGA-BASE/var/nagios.debug***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wohin NAME-ICINGA Debugging-Informationen
schreiben soll. Welche Informationen (falls überhaupt) geschrieben
werden, wird durch die [debug\_level](#configmain-debug_level)- und
[debug\_verbosity](#configmain-debug_verbosity)-Optionen festgelegt. Sie
können die Debug-Datei automatisch rotieren lassen, wenn sie eine
bestimmte Größe überschreitet, die Sie über die
[max\_debug\_file\_size](#configmain-max_debug_file_size)-Option
festlegen können.

**Debug-Stufe** (Debug Level)

  ------ -----------------------------------------------------------------
  Format **debug\_level=\<\#\>**
  :      

  Beispi ***debug\_level=24***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, welche Arten von Informationen NAME-ICINGA in
das [debug\_file](#configmain-debug_file) schreiben soll. Dieser Wert
ist ein logisches ODER der nachfolgenden Werte:

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

  ------ -----------------------------------------------------------------
  Format **debug\_verbosity=\<\#\>**
  :      

  Beispi ***debug\_verbosity=1***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt fest, wie viel Debugging-Informationen NAME-ICINGA in
das [debug\_file](#configmain-debug_file) schreiben soll.

-   0 = grundlegende Informationen

-   1 = detailliertere Informationen (Default)

-   2 = sehr detaillierte Informationen

**maximale Debug-Dateigröße** (Maximum Debug File Size)

  ------ -----------------------------------------------------------------
  Format **max\_debug\_file\_size=\<\#\>**
  :      

  Beispi ***max\_debug\_file\_size=1000000***
  el:    
  ------ -----------------------------------------------------------------

Diese Option legt die maximale Größe (in Bytes) der
[Debug-Datei](#configmain-debug_file) fest. Wenn die Datei die Größe
überschreitet, dann wird ".old" als Erweiterung angehängt. Wenn bereits
eine Datei mit der ".old"-Erweiterung existiert, wird diese gelöscht.
Das stellt sicher, dass Ihr Plattenplatz nicht außer Kontrolle gerät,
wenn Sie NAME-ICINGA debuggen.

**Ereignis-Profiling**

  ------ -----------------------------------------------------------------
  Format **event\_profiling\_enabled=\<0/1\>**
  :      

  Exampl ***event\_profiling\_enabled=1***
  e:     
  ------ -----------------------------------------------------------------

Diese Option aktiviert oder deaktiviert die Statistik für Ereignisse und
deren Ausführungsdauer. Diese Option ist für Solaris mit gcc3 nicht
verfügbar.

**Leere Hostgruppenzuordnung erlauben**

  ------ -----------------------------------------------------------------
  Format **allow\_empty\_hostgroup\_assignment=\<0|1\>**
  :      

  Beispi ***allow\_empty\_hostgroup\_assignment=1***
  el:    
  ------ -----------------------------------------------------------------

Diese boolesche Option legt fest, ob Services, Host-Abhängigkeiten oder
Service-Abhängigkeiten, die leeren Hostgruppen zuordnet sind
(Hostgruppen ohne Host-Member), NAME-ICINGA beim Start (oder bei der
Konfigurationsprüfung) mit einem Fehler abbrechen lassen oder nicht. Das
Default-Verhalten, wenn die Option nicht in der Hauptkonfigurationsdatei
vorhanden ist (oder auf "0" gesetzt ist), besteht darin, dass
NAME-ICINGA mit einem Fehler abbricht, wenn Services,
Host-Abhängigkeiten oder Service-Abhängigkeiten, mit Hostgruppen
verbunden sind, denen in der hostgroup-Definition keine Host-Member
zugeordnet sind.

Aktivieren dieser Option kann sinnvoll sein, wenn:

-   Konfigurationdateien oder vorgespeicherte Objektdateien an viele
    NAME-ICINGA-Poller verteilt werden.

-   Automation benutzt wird, um einen "Baum" mit
    NAME-ICINGA-Konfigurationsdateien zu erzeugen.

-   es einen Satz von Services, Host-Abhängigkeiten oder
    Service-Abhängigkeiten gibt, der von Administrationen verwaltet
    werden, be dem Benutzer der Einfachheit halber Hosts über die
    Hostgruppenzugehörigkeit hinzufügen können (z.B. eine Suite von
    Prüfungen, die mit einem entfernten Überwachungsagenten verbunden
    sind), wobei es aber keine Garantie dafür gibt, dass die Benutzer
    die Services verwenden, die mit der Hostgruppe verbunden sind, oder
    dass die Hosts existieren (z.B. ein entfernter Agent, dessen Hosts
    mit der Zeit stillgelegt werden).

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.3.

**Leere Performance-Ergebnisse verarbeiten**

  ------ -----------------------------------------------------------------
  Format **host\_perfdata\_process\_empty\_results=\<0|1\>**
  :      
         **service\_perfdata\_process\_empty\_results=\<0|1\>**

  Beispi ***host\_perfdata\_process\_empty\_results=1***
  el:    
         ***service\_perfdata\_process\_empty\_results=1***
  ------ -----------------------------------------------------------------

Diese Optionen legen fest, ob der Core leere
Performance-Daten-Ergebnisse verarbeiten soll oder nicht. Dies wird für
verteilte Überwachung benötigt und ist per Default aktiviert. Wenn Sie
keine leeren Performance-Daten benötigen - und ein paar CPU-Zyklen bei
der Berechnung von Makros sparen wollen - dann können Sie diese Optionen
abschalten. Seien Sie vorsichtig! Werte: 1 = aktiviert, 0 = deaktiviert.

> **Note**
>
> Diese Optionen sind verfügbar ab NAME-ICINGA 1.4

**Anzahl von Einträgen in Check-Result-Liste begrenzen**

  ------ -----------------------------------------------------------------
  Format **max\_check\_result\_list\_items=\<n\>**
  :      

  Beispi ***max\_check\_result\_list\_items=1024***
  el:    
  ------ -----------------------------------------------------------------

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

> **Note**
>
> Diese Option ist verfügbar ab NAME-ICINGA 1.8

Konfiguration
Optionen der Hauptkonfigurationsdatei
log\_file=
Log-Datei
cfg\_file=
Objektkonfigurationsdatei
cfg\_dir=
Objektkonfigurationsverzeichnis
object\_cache\_file=
Objekt-Cache-Datei
precached\_object\_file=
vorgespeicherte Objektdatei
resource\_file=
Ressource-Datei
temp\_file=
temporäre Datei
temp\_path=
temporärer Pfad
status\_file=
Status-Datei
status\_log=
Statusprotokoll
status\_update\_interval=
Statusdatei-Aktualisierungsintervall
icinga\_user=
NAME-ICINGA Benutzer
icinga\_group=
NAME-ICINGA Gruppe
enable\_notifications=
Benachrichtigungsoption
execute\_service\_checks=
ausführen von Service-Prüfungen
accept\_passive\_service\_checks=
akzeptieren von passiven Service-Prüfungen
execute\_host\_checks=
ausführen von Host-Prüfungen
accept\_passive\_host\_checks=
akzeptieren von passiven Hostprüfungen
enable\_event\_handlers=
aktivieren von Event-Handlern
log\_rotation\_method=
Protokoll-Rotationsmethode
log\_archive\_path=
Protokollarchiv-Pfad
use\_daemon\_log=
Protokollierungs-Daemon
check\_external\_commands=
prüfen von externen Befehlen
command\_check\_interval=
Prüfintervall externe Befehle
command\_file=
Datei für (externe) Befehle
external\_command\_buffer\_slots=
Buffer slots für externe Befehle
lock\_file=
Sperrdatei
retain\_state\_information=
aufbewahren von Statusinformationen
state\_retention\_file=
Statusaufbewahrungsdatei
retention\_update\_interval=
Aufbewahrungs-Aktualisierungsintervall
use\_retained\_program\_state=
benutzen des aufbewahrten Programmzustands
dump\_retained\_host\_service\_states\_to\_neb=
Weitergabe von Statusinformation an die Neb-Module
retained\_scheduling\_info=
benutzen von aufbewahrten Planungsinformationen
retained\_host\_attribute\_mask=
aufbewahrte Host-Attributmaske
retained\_service\_attribute\_mask=
aufbewahrte Service-Attributmaske
retained\_process\_host\_attribute\_mask=
aufbewahrte "Process Host"-Attributmaske
retained\_process\_attribute\_mask=
aufbewahrte Prozess-Attributmaske
retained\_contact\_host\_attribute\_mask=
aufbewahrte "Contact Host"-Attributmaske
retained\_contact\_service\_attribute\_mask=
aufbewahrte "Contact Service"-Attributmaske
use\_syslog=
Syslog-Protokollierung
use\_syslog\_local\_facility=
Syslog-Local-Facility-Protokollierung
syslog\_local\_facility=
Syslog-Local-Facility-Wert
log\_notifications=
Benachrichtigungsprokotollierung
log\_service\_retries=
protokollieren Service-Prüfungswiederholungen
log\_host\_retries=
protokollieren Host-Prüfungswiederholungen
log\_event\_handlers=
protokollieren Eventhandler
log\_initial\_states=
protokollieren initiale Zustände
log\_external\_commands=
protokollieren externe Befehle
log\_passive\_checks=
protokollieren passive Prüfungen
global\_host\_event\_handler=
globaler Host-Eventhandler
global\_service\_event\_handler=
globaler Service-Eventhandler
sleep\_time=
Ruhezeit zwischen Prüfungen
service\_inter\_check\_delay\_method=
Verzögerungsmethode für Service-Prüfungen
max\_service\_check\_spread=
maximaler Zeitraum bei Service-Verteilung
service\_interleave\_factor=
Service-Verschachtelungsfaktor
max\_concurrent\_checks=
maximale Anzahl gleichzeitiger Service-Prüfungen
check\_result\_reaper\_frequency=
Prüfungsergebniserntefrequenz
max\_check\_result\_reaper\_time=
maximale Prüfergebnis-Erntezeit
check\_result\_path=
Prüfergebnispfad
max\_check\_result\_file\_age=
max. Alter von Prüfergebnisdateien
host\_inter\_check\_delay\_method=
Verzögerungsmethode bei Host-Prüfungen
max\_host\_check\_spread=
maximaler Zeitrau, bei Host-Verteilung
interval\_length=
Intervalllänge
auto\_reschedule\_checks=
Auto-Rescheduling Option
auto\_rescheduling\_interval=
Auto-Rescheduling
auto\_rescheduling\_windows=
Auto-Rescheduling Window
use\_aggressive\_host\_checking=
Aggressive Host-Prüfung
translage\_passive\_host\_checks=
übersetzen von passiven Host-Prüfergebnissen
passive\_host\_checks\_are\_soft=
passive Host-Prüfungen sind SOFT
enable\_predictive\_host\_dependency\_checks=
vorausschauende Host-Abhängigkeiten
enable\_predictive\_service\_dependency\_checks=
voraussschauende Service-Abhängigkeiten
cached\_host\_check\_horizon=
Cached Host Check Horizon
cached\_service\_check\_horizon=
Cached Service Check
use\_large\_installation\_tweaks=
Large Installation Tweaks
free\_child\_process\_memory=
Child Process Memory
child\_processes\_fork\_twice=
Child Processes Fork
enable\_environment\_macros=
Environment Macros Option
enable\_flap\_detection=
Flattererkennung
low\_service\_flap\_threshold=
niedriger Schwellwert Service-Flattern
high\_service\_flap\_threshold=
hoher Schwellwert Service-Flattern
low\_host\_flap\_threshold=
niedriger Schwellwert Host-Flattern
high\_host\_flap\_threshold=
hoher Schwellwert Host-Flattern
soft\_state\_dependencies=
Soft-Status-Abhängigkeiten
time\_change\_threshold=
Systemzeitabweichung- Schwellenwert
service\_check\_timeout=
Service-Prüfungs-Zeitüberschreitung
service\_check\_timeout\_state=
Service-Prüfungs-Timeout-Status
host\_check\_timeout=
Host-Prüfungs-Zeitüberschreitung
event\_handler\_timeout=
Eventhandler-Zeitüberschreitung
notification\_timeout=
Benachrichtigungs-Zeitüberschreitung
ocsp\_timeout=
Obsessive Compulsive Service Processor
ochp\_timeout=
Obsessive Compulsive Host Processor
perfdata\_timeout=
Performance-Daten-Verarbeitungsbefehl
obsess\_over\_services=
Obsess Over Services Option
ocsp\_command=
Obsessive Compulsive Service Processor
obsess\_over\_hosts=
Obsess Over Hosts Option
ochp\_command=
Obsessive Compulsive Host Processor
process\_performance\_data=
Performance-Daten-Verarbeitung
host\_perfdata\_command=
Host-Performance-Daten-Verarbeitung
service\_perfdata\_command=
Service-Performance-Daten-Verarbeitung
host\_perfdata\_file=
Host-Performance-Daten-Datei
service\_perfdata\_file=
Service-Performance-Daten-Datei
host\_perfdata\_file\_template=
Vorlage Host-Performance-Daten-Datei
service\_perfdata\_file\_template=
Vorlage Service-Performance-Daten-Datei
host\_perfdata\_file\_mode=
Modus Host-Performance-Daten-Datei
service\_perfdata\_file\_mode=
Modus Service-Performance-Daten-Datei
host\_perfdata\_file\_processing\_interval=
Verarbeitungsintervall Host-Performance-Daten-Datei
service\_perfdata\_file\_processing\_interval=
Verarbeitungsintervall Service-Performance-Daten-Datei
host\_perfdata\_file\_processing\_command=
Verarbeitungsbefehl Host-Performance-Daten-Datei
service\_perfdata\_file\_processing\_command=
Verarbeitungsbefehl Service-Performance-Daten-Datei
check\_for\_orphaned\_services=
verwaiste Service-Prüfungen
check\_for\_orphaned\_hosts=
verwaiste Host-Prüfungen
check\_service\_freshness=
Service-Frischeprüfung
service\_freshness\_check\_interval=
Intervall Service-Frischeprüfung
check\_host\_freshness=
Host-Frischeprüfung
host\_freshness\_check\_interval=
Intervall Host-Frischeprüfung
additional\_freshness\_latency=
zusätzliche Frische-Verschiebung
p1\_file\_location=
P1.PL Perl Skript Lokation
enabled\_embedded\_perl=
eingebauter Perl-Interpreter
use\_embedded\_perl\_implicitly=
implizite Benutzung von Embedded Perl
date\_format=
Datumsformat
use\_timezone=
Zeitzone
illegal\_object\_name\_chars=
Illegale Objektnamen
illegal\_macro\_output\_chars=
Illegale Makroausgabe
keep\_unknown\_macros=
Unbekannte Makros
use\_regexp\_matching=
Regular Expression Matching
use\_true\_regexp\_matching=
True Regular Expression Matching
admin\_email=
Administrator-e-Mail-Adresse
admin\_pager=
Administrator-Pager
daemon\_dumps\_core=
Daemon Core Dumps
event\_broker\_options=
Eventbroker-Optionen
broker\_module=
Eventbroker-Module
debug\_file=
Debug-Datei
debug\_level=
Debug-Level
debug\_verbosity=
Debug-Ausführlichkeit
max\_debug\_file\_size=
max. Debug-Dateigröße
event\_profiling\_enabled=
Event Profiling Aktiviert
allow\_empty\_hostgroup\_assignment=
Leere Hostgruppenzuordnung erlauben
host\_perfdata\_process\_empty\_results
Leere Host-Performance-Daten-Ergebnisse verarbeiten
service\_perfdata\_process\_empty\_results
Leere Service-Performance-Daten-Ergebnisse verarbeiten
max\_check\_result\_list\_items
Anzahl von Einträgen in Check-Result-Liste begrenzen
