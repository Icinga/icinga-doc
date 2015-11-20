 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.3. Eventhandler
-----------------

7.3.1. [Einführung](eventhandlers.md#introduction)

7.3.2. [Wann werden Eventhandler
ausgeführt?](eventhandlers.md#execution)

7.3.3. [Eventhandler-Typen](eventhandlers.md#idp12970304)

7.3.4. [Eventhandler aktivieren](eventhandlers.md#enable)

7.3.5.
[Eventhandler-Ausführungsreihenfolge](eventhandlers.md#executionorder)

7.3.6. [Eventhandler-Kommandos
schreiben](eventhandlers.md#writingcommands)

7.3.7. [Berechtigungen für
Eventhandler-Befehle](eventhandlers.md#commandpermissions)

7.3.8. [Service Event Handler
Beispiel](eventhandlers.md#serviceeventhandlerexample)

### 7.3.1. Einführung

![](../images/eventhandlers.png)

Eventhandler sind optionale Systemkommandos (Scripts oder Programme),
die gestartet werden, wenn ein Host- oder Service-Zustandswechsel
stattfindet. Sie werden auf dem System ausgeführt, auf dem die Prüfung
eingeplant (initiiert) wurde.

Ein einleuchtender Einsatz von Eventhandlern ist die Möglichkeit von
Icinga, proaktiv Probleme zu beheben, bevor jemand benachrichtigt wird.
Einige andere Anwendungsmöglichkeiten für Eventhandler umfassen:






\* Strom durch ein automatisiertes Script bei einem Host aus- und
einzuschalten, der Probleme hat, sollte wohlüberlegt sein. Betrachten
Sie sorgfältig die möglichen Konsequenzen, bevor Sie automatische
Reboots implementieren. :-)

### 7.3.2. Wann werden Eventhandler ausgeführt?

Eventhandler werden ausgeführt, wenn ein Service oder Host




SOFT- und HARD-Zustände sind ausführlich
[hier](statetypes.md "5.8. Statustypen") beschrieben.

### 7.3.3. Eventhandler-Typen

Es gibt unterschiedliche Typen von optionalen Eventhandlern, die Sie
definieren können, um Host- und Statuswechsel zu behandeln:





Globale Host- und Service-Eventhandler werden für *jeden* auftretenden
Host- oder Service-Zustandswechsel durchgeführt, direkt vor einem
möglichen Host- oder Service-spezifischen Eventhandler. Sie können
globale Host- oder Service-spezifische Eventhandler durch die
[global\_host\_event\_handler](configmain.md#configmain-global_host_event_handler)
und
[global\_service\_event\_handler](configmain.md#configmain-global_service_event_handler)-Optionen
in der Hauptkonfigurationsdatei angeben.

Einzelne Hosts und Service können ihre eigenen Eventhandler haben, die
ausgeführt werden, um Statuswechsel zu behandeln. Sie können einen
auszuführenden Eventhandler durch die *event\_handler*-Direktive in
Ihren [Host](objectdefinitions.md#objectdefinitions-host)- oder
[Service](objectdefinitions.md#objectdefinitions-service)-Definitionen
angeben. Diese Host- und Service-spezifischen Eventhandler werden direkt
nach dem (optionalen) globalen Host- oder Service-Eventhandler
ausgeführt.

### 7.3.4. Eventhandler aktivieren

Eventhandler können durch die
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)-Direktive
in Ihrer Hauptkonfigurationsdatei programmweit aktiviert oder
deaktiviert werden.

Host- und Service-spezifische Eventhandler werden durch die
*event\_handler\_enabled*-Direktive in Ihrer
[Host](objectdefinitions.md#objectdefinitions-host)- oder
[Service](objectdefinitions.md#objectdefinitions-service)-Definition
aktiviert oder deaktiviert. Host- und Service-spezifische Eventhandler
werden nicht ausgeführt, wenn die globale
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)-Option
deaktiviert ist.

### 7.3.5. Eventhandler-Ausführungsreihenfolge

Wie bereits erwähnt werden globale Host- und Service-Eventhandler direkt
vor Host- oder Service-spezifischen Eventhandlern ausgeführt.

Eventhandler werden bei HARD-Problemen und Erholungszuständen direkt
nach dem Versand von Benachrichtigungen ausgeführt.

### 7.3.6. Eventhandler-Kommandos schreiben

Eventhandler werden wahrscheinlich Shell- oder Perl-Scripte sein, aber
es ist jede Art von ausführbarer Datei denkbar, die von der
Kommandozeile aus lauffähig ist. Die Scripte sollten mindestens die
folgenden
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten") als
Argumente nutzen:

Für Services:
[**\$SERVICESTATE\$**](macrolist.md#macrolist-servicestate) ,
[**\$SERVICESTATETYPE\$**](macrolist.md#macrolist-servicestatetype) ,
[**\$SERVICEATTEMPT\$**](macrolist.md#macrolist-serviceattempt)

Für Hosts: [**\$HOSTSTATE\$**](macrolist.md#macrolist-hoststate) ,
[**\$HOSTSTATETYPE\$**](macrolist.md#macrolist-hoststatetype) ,
[**\$HOSTATTEMPT\$**](macrolist.md#macrolist-hostattempt)

Die Scripte sollten die Werte der übergebenen Parameter untersuchen und
darauf basierend notwendige Aktionen ausführen. Der beste Weg, die
Funktionsweise von Eventhandlern zu verstehen, ist der Blick auf ein
Beispiel. Glücklicherweise finden Sie eins
[hier](eventhandlers.md#serviceeventhandlerexample "7.3.8. Service Event Handler Beispiel").

![](../images/tip.gif) Hinweis: Zusätzliche Eventhandler-Scripte finden
Sie im *contrib/eventhandlers/*-Unterverzeichnis der
Icinga-Distribution. Einige dieser Beispiel-Scripts demonstrieren die
Benutzung von [externen
Befehlen](extcommands.md "7.1. Externe Befehle"), um
[redundante](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")
und [verteilte](distributed.md "7.6. Verteilte Überwachung")
Überwachungsumgebungen zu implementieren.

### 7.3.7. Berechtigungen für Eventhandler-Befehle

Eventhandler werden normalerweise mit den gleichen Berechtigungen
ausgeführt wie der Benutzer, der Icinga auf Ihrer Maschine ausführt.
Dies kann ein Problem darstellen, wenn Sie einen Eventhandler schreiben
möchten, der Systemdienste neu startet, da generell root-Rechte benötigt
werden, um diese Aufgaben zu erledigen.

Idealerweise sollten Sie den Typ von Eventhandler einschätzen und dem
Icinga-Benutzer gerade genug Berechtigungen gewähren, damit er die
notwendigen Systembefehle ausführen kann. Vielleicht möchten Sie
[sudo](http://www.courtesan.com/sudo/sudo.md) ausprobieren, um das zu
erreichen.

### 7.3.8. Service Event Handler Beispiel

Das folgende Beispiel geht davon aus, dass Sie den HTTP-Server auf der
lokalen Maschine überwachen und *restart-httpd* als den
Eventhandler-Befehl für die HTTP-Service-Definition angegeben haben.
Außerdem nehmen wir an, dass Sie die Option *max\_check\_attempts* für
den Service auf einen Wert von 4 oder höher gesetzt haben (d.h., der
Service wird viermal geprüft, bevor angenommen wird, dass es ein
richtiges Problem gibt). Eine gekürzte Service-Definition könnte wie
folgt aussehen...

 define service{
</code></pre>

Sobald der Service mit einem Eventhandler definiert wird, müssen wir
diesen Eventhandler als Befehlsfolge definieren. Eine Beispieldefinition
für *restart-httpd* sehen Sie nachfolgend. Beachten Sie die Makros in
sind wichtig!

 define command{
</code></pre>

Lassen Sie uns nun das Eventhandler-Script schreiben (das ist das
*/usr/local/icinga/libexec/eventhandlers/restart-httpd*-Script).

#!/bin/sh
#
# Eventhandler-Script für den Restart des Web-Servers auf der lokalen Maschine
#
# Anmerkung: Dieses Script wird den Web-Server nur dann restarten, wenn der Service
# In welchem Status befindet sich der Service?
case "$1" in
OK)
WARNING)
UNKNOWN)
CRITICAL)
esac
exit 0
</code></pre>

Das mitgelieferte Beispiel-Script wird versuchen, den Web-Server auf der
lokalen Maschine in zwei Fällen zu restarten:



Das Script sollte theoretisch den Web-Server restarten und das Problem
beheben, bevor der Service in einen "Hard"-Problemzustand wechselt, aber
wir stellen eine Absicherung bereit, falls es nicht das erste Mal
funktioniert. Es ist anzumerken, dass der Eventhandler nur einmal
ausgeführt wird, wenn der Service in einen HARD-Zustand wechselt. Das
hält Icinga davon ab, das Script zum Restart des Web-Servers wiederholt
auszuführen, wenn der Service in einem HARD-Problemzustand bleibt. Das
wollen Sie nicht. :-)

Das ist alles! Eventhandler sind ziemlich einfach zu schreiben und zu
implementieren, also versuchen Sie es und sehen, was Sie tun können.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
