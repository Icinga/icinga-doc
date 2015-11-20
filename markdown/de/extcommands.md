 ![Icinga](../images/logofullsize.png "Icinga") 

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





### 7.1.3. Wann prüft Icinga auf externe Befehle?



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

</code></pre> 
</code></pre>

...wobei *Zeit* die Zeit (im *time\_t*-Format) ist, zu der die externe
Applikation den externen Befehl an das Command-File geschickt hat. Die
Werte für die *Befehls-ID* und die *Befehlsargumente* hängen davon ab,
welcher Befehl an Icinga geschickt wird.

#### 7.1.5.1. External Commands Liste

Eine komplette Liste der Befehle, die benutzt werden können, finden Sie
in der [Liste der externen
Befehle](extcommands2.md "7.2. Liste der externen Befehle").

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
