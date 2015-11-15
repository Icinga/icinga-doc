![Icinga](../images/logofullsize.png "Icinga")

7.1. Externe Befehle

[Zurück](ch07.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](extcommands2.md)

* * * * *

7.1. Externe Befehle
--------------------

7.1.1. [Einführung](extcommands.md#introduction)

7.1.2. [Externe Befehle aktivieren](extcommands.md#enable)

7.1.3. [Wann prüft Icinga auf externe
Befehle?](extcommands.md#whenchecked)

7.1.4. [Externe Befehle benutzen](extcommands.md#usage)

7.1.5. [Befehlsformat](extcommands.md#format)

### 7.1.1. Einführung

Icinga kann Befehle aus externen Applikationen verarbeiten
(einschließlich der CGIs) und verschiedene Aspekte seiner
Überwachungsfunktionen aufgrund der Befehle verändern, die es erhält.
Externe Applikationen können Befehle "einreichen", indem sie in das
[command file](configmain.md#configmain-command_file) schreiben, das
regelmäßig vom Icinga-Daemon verarbeitet wird.

![](../images/externalcommands.png)

### 7.1.2. Externe Befehle aktivieren

Damit Icinga externe Befehle verarbeitet, müssen Sie folgendes tun:

-   aktivieren Sie die Prüfung auf externe Befehle mit der
    [check\_external\_commands](configmain.md#configmain-check_external_commands)-Option.

-   setzen Sie die Wiederholrate von Befehlsprüfungen mit der
    [command\_check\_interval](configmain.md#configmain-command_check_interval)-Option.

-   definieren Sie den Ort des Command-File mit der
    [command\_file](configmain.md#configmain-command_file)-Option.

-   setzen Sie korrekte Berechtigungen für das Verzeichnis, welches das
    External-Command-File enthält, wie in der
    [Schnellstartanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
    beschrieben.

### 7.1.3. Wann prüft Icinga auf externe Befehle?

-   in regelmäßigen Intervallen, wie sie durch die Option
    [command\_check\_interval](configmain.md#configmain-command_check_interval)
    in der Hauptkonfigurationsdatei angegeben sind

-   direkt nachdem
    [Eventhandler](eventhandlers.md "7.3. Eventhandler") ausgeführt
    werden. Das passiert zusätzlich zum regelmäßigen Zyklus von externen
    Befehlsprüfungen und wird getan, um unverzügliche Aktivitäten zu
    ermöglichen, falls ein Eventhandler Befehle an Icinga schickt.

### 7.1.4. Externe Befehle benutzen

Externe Befehle können benutzt werden, um eine Reihe von Dingen zu
erreichen, während Icinga läuft. Beispiele dafür, was getan werden kann,
umfassen u.a. vorübergehend Benachrichtigungen für Services und Hosts zu
deaktivieren, vorübergehend Service-Prüfungen zu deaktivieren, sofortige
Service-Prüfungen zu erzwingen, Kommentare für Hosts und Services
hinzuzufügen usw.

### 7.1.5. Befehlsformat

7.1.5.1. [External Commands
Liste](extcommands.md#externalcommandslist)

Externe Befehle, die in das [command
file](configmain.md#configmain-command_file) geschrieben werden, haben
das folgende Format...

~~~~ {.screen}
 [ Zeit]  Befehls-ID; Befehlsargumente 
~~~~

...wobei *Zeit* die Zeit (im *time\_t*-Format) ist, zu der die externe
Applikation den externen Befehl an das Command-File geschickt hat. Die
Werte für die *Befehls-ID* und die *Befehlsargumente* hängen davon ab,
welcher Befehl an Icinga geschickt wird.

#### 7.1.5.1. External Commands Liste

Eine komplette Liste der Befehle, die benutzt werden können, finden Sie
in der [Liste der externen
Befehle](extcommands2.md "7.2. Liste der externen Befehle").

* * * * *

  ------------------------------------- -------------------------- ----------------------------------
  [Zurück](ch07.md)                   [Nach oben](ch07.md)      [Weiter](extcommands2.md)
  Kapitel 7. Fortgeschrittene Themen    [Zum Anfang](index.md)    7.2. Liste der externen Befehle
  ------------------------------------- -------------------------- ----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
