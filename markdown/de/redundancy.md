 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.7. Redundante und Failover-Netzwerk-Überwachung
-------------------------------------------------

7.7.1. [Einführung](redundancy.md#introduction)

7.7.2. [Voraussetzungen](redundancy.md#redprerequisites)

7.7.3. [Beispielscripts](redundancy.md#samplescripts)

Üverwachung](redundancy.md#redundantmonitoring)

Überwachung](redundancy.md#failovermonitoring)

### 7.7.1. Einführung

Dieser Abschnitt beschreibt einige Szenarien zum Implementieren von
redundanten Überwachungs-Hosts auf verschiedenen Arten von
Netzwerk-Layouts. Mit redundanten Hosts können Sie die Überwachung Ihres
Netzwerkes aufrecht erhalten, wenn der primäre Host, auf dem Icinga
läuft, ausfällt oder wenn Teile Ihres Netzwerkes unerreichbar werden.

**Anmerkung:** Wenn Sie gerade lernen, wie Icinga zu nutzen ist, würden
wir empfehlen, Redundanz so lange nicht zu implementieren, bis Sie mit
den
[Voraussetzungen](redundancy.md#redprerequisites "7.7.2. Voraussetzungen")
vertraut sind. Redundanz ist ein relativ komplexes Thema und es ist noch
schwieriger, es zu implementieren.

### 7.7.2. Voraussetzungen

Bevor Sie überhaupt daran denken können, Redundanz mit Icinga zu
implementieren, müssen Sie mit folgenden Dingen vertraut werden...





### 7.7.3. Beispielscripts

Jedes dieser Beispiel-Scripte, die wir in dieser Dokumentation benutzen,
finden Sie im *eventhandlers/*-Unterverzeichnis der Icinga-Distribution.
Vielleicht müssen Sie sie modifizieren, damit sie auf Ihrem System
funktionieren...


7.7.4.1. [Einführung](redundancy.md#redundantmonitoring-introduction)

7.7.4.2. [Ziele](redundancy.md#redundantmonitoring-goals)

7.7.4.3.
[Netzwork-Layout-Diagramm](redundancy.md#redundantmonitoring-networklayoutdiagram)

7.7.4.4. [anfängliche
Programmeinstellungen](redundancy.md#redundantmonitoring-initialprogramsettings)

7.7.4.5. [anfängliche
Konfiguration](redundancy.md#redundantmonitoring-initialconfig)

7.7.4.6.
[Eventhandler-Befehlsdefinitionen](redundancy.md#redundantmonitoring-eventhandlercmddefinition)

7.7.4.7.
[Eventhandler-Scripte](redundancy.md#redundantmonitoring-eventhandlerscript)

7.7.4.8. [Was tun sie für
uns](redundancy.md#redundantmonitoring-usage)

7.7.4.9.
[Zeitverzögerungen](redundancy.md#redundantmonitoring-timelags)

7.7.4.10.
[Spezialfälle](redundancy.md#redundantmonitoring-specialcases)

#### 7.7.4.1. Einführung

Dies ist eine einfache (und harmlose) Methode, redundante
Überwachungs-Hosts zu implementieren, und es wird nur gegen eine
begrenzte Anzahl von Ausfällen schützen. Komplexere Setups werden
benötigt, um intelligentere Redundanz, bessere Redundanz über
verschiedene Netzwerk-Segmente hinweg zu bieten.

#### 7.7.4.2. Ziele

Das Ziel dieser Art von Redundanz-Implementierung ist einfach. Sowohl
der "Master"- als auch der "Slave"-Host überwachen die gleichen Hosts
und Services auf dem Netzwerk. Unter normalen Umständen wird nur der
"Master"-Host Benachrichtigungen an Kontakte versenden. Wir wollen, dass
der "Slave"-Host die Benachrichtigung von Kontakten übernimmt, wenn:



#### 7.7.4.3. Netzwork-Layout-Diagramm

Das untenstehende Diagramm zeigt ein sehr simples Netzwerk-Setup. Bei
diesem Szenario nehmen wir an, dass auf den Hosts A und E Icinga läuft
und alle gezeigten Hosts überwacht werden. Host A ist der "Master"-Host
und Host E der "Slave"-Host.

![](../images/redundancy.png)

#### 7.7.4.4. anfängliche Programmeinstellungen

Auf dem Slave-Host (Host E) wird die ursprüngliche
[enable\_notifications](configmain.md#configmain-enable_notifications)-Direktive
deaktiviert, so dass dadurch der Versand von Host- oder
Service-Benachrichtigungen verhindert wird. Sie sollten auch
sicherstellen, dass die
[check\_external\_commands](configmain.md#configmain-check_external_commands)-Direktive
deaktiviert ist. Das war einfach genug...

#### 7.7.4.5. anfängliche Konfiguration

Als nächstes sollten wir die Unterschiede zwischen den
[Objekt-Konfigurationsdatei](configobject.md "3.3. Überblick Objektkonfiguration")
von Master- und Slave-Host(s) betrachten...

Wir gehen davon aus, dass Sie den Master-Host (Host A) so konfiguriert
haben, dass er alle Services auf den gezeigten Hosts des Diagramms
überwacht. Der Slave-Host (Host E) sollte die gleichen Hosts und
Services überwachen, mit folgenden Zusätzen in der
Konfigurationsdatei...




Es ist wichtig anzumerken, dass Host A (der Master-Host) keine Ahnung
von Host E (dem Slave-Host) hat. In diesem Szenario besteht ganz einfach
keine Notwendigkeit dazu. Natürlich können Sie von Host A Services auf
Host E überwachen, aber das hat nichts mit der Implementierung von
Redundanz zu tun...

#### 7.7.4.6. Eventhandler-Befehlsdefinitionen

Wir müssen kurz innehalten und beschreiben, wie die Befehlsdefinitionen
für die Eventhandler auf dem Slave-Host aussehen. Hier ist ein
Beispiel...

</code></pre> 
 define command{
 }
 define command{
 }
</code></pre>

Dies setzt voraus, dass Sie die Eventhandler-Scripte im Verzeichnis
*/usr/local/icinga/libexec/eventhandlers* abgelegt haben. Sie können sie
ablegen, wohin Sie wollen, aber dann müssen Sie die beigefügten
Beispiele anpassen.

#### 7.7.4.7. Eventhandler-Scripte

Okay, lassen Sie uns nun einen Blick darauf werden, wie die
Eventhandler-Scripte aussehen...

Host-Eventhandler (handle-master-host-event):

</code></pre> 
 #!/bin/sh
 # Only take action on hard host states...
 case "$2" in
 HARD)
 esac
 exit 0
</code></pre>

Service-Eventhandler (handle-master-proc-event):

</code></pre> 
 #!/bin/sh
 # Only take action on hard service states...
 case "$2" in
 HARD)
 esac
 exit 0
</code></pre>

#### 7.7.4.8. Was tun sie für uns

Auf dem Slave-Host (Host E) sind anfänglich die Benachrichtigungen
deaktiviert, so dass er keine Host- oder Service-Benachrichtigungen
versendet, solange der Icinga-Prozess auf dem Master-Host (Host A) noch
läuft.

Der Icinga-Prozess auf dem Slave-host (Host E) wird zum Master-Host,
wenn...



Wenn bei dem Icinga-Prozess auf dem Slave-Host (Host E)
Benachrichtigungen aktiviert sind, kann er Benachrichtigungen über
jegliche Host- und Service-Probleme und Erholungen versenden. An diesem
Punkt hat Host E die Verantwortlichkeiten über die Benachrichtigung von
Kontakten über Host- und Service-Probleme übernommen!

Der Icinga-Prozess auf Host E wird wieder zum Host-Slave, wenn...



Wenn bei dem Icinga-Prozess auf dem Slave-Host (Host E)
Benachrichtigungen deaktiviert sind, wird er keine Benachrichtigungen
mehr über Host- und Service-Probleme und Erholungen versenden. An diesem
Punkt hat Host E die Verantwortlichkeiten über die Benachrichtigung von
Kontakten über Host- und Service-Probleme an Host A übergeben. Alles ist
wieder so, als wir angefangen haben!

#### 7.7.4.9. Zeitverzögerungen

Redundanz bei Icinga ist in keinster Weise perfekt. Eins der
offenkundigeren Probleme ist die Verzögerung zwischen dem Ausfall von
Host A und der Übernahme durch Host E. Das ist bedingt durch folgende
Dinge...




Sie können diese Verzögerung minimieren durch...




Wenn sich Icinga auf Host A erholt, gibt es ebenfalls eine Verzögerung,
bevor Host E wieder zu einem Slave-Host wird. Das wird durch folgende
Dinge beeinflusst...



Die genaue Verzögerung zwischen dem Übergang der Verantwortlichkeiten
hängt davon ab, wieviele Services Sie definiert haben, dem Intervall, in
dem Services geprüft werden, und einer Menge pures Glück. Auf jeden
Falls ist es besser als nichts.

#### 7.7.4.10. Spezialfälle

Eins sollten Sie beachten: Wenn Host A "down" geht, werden bei Host E
die Benachrichtigungen aktiviert und er übernimmt die Verantwortung für
das Informieren der Kontakte bei Problemen. Wenn sich Host A wieder
erholt, werden bei Host E die Benachrichtigungen deaktiviert. Falls der
startet, gibt es eine Zeitspanne, während der keiner der beiden Hosts
die Kontakte über Probleme informiert! Glücklicherweise berücksichtigt
die Service-Prüflogik in Icinga diesen Umstand. Das nächste Mal, wenn
der Icinga-Prozess auf Host E den Status des Icinga-Prozesses auf Host A
prüft, wird er feststellen, dass dieser nicht läuft. Auf Host E werden
dann wieder die Benachrichtigungen aktiviert und er wird erneut die
Verantwortung für die Benachrichtigung der Kontakte übernehmen.

Der exakte Wert für die Zeit, während der keiner der Hosts das Netzwerk
überwacht, ist schwer zu ermitteln. Offensichtlich kann diese Zeit durch
die Erhöhung der Frequenz von Service-Prüfungen (auf Host E) für Host A
minimiert werden. Der Rest ist purer Zufall, aber die gesamte
"Blackout"-Zeit sollte nicht allzu hoch sein.


7.7.5.1. [Einführung](redundancy.md#failovermonitoring-introduction)

7.7.5.2. [Ziele](redundancy.md#failovermonitoring-goals)

7.7.5.3. [Initiale
Programm-Einstellungen](redundancy.md#failovermonitoring-initialprogramsettings)

7.7.5.4.
[Master-Prozess-Prüfungen](redundancy.md#failovermonitoring-masterprocesscheck)

7.7.5.5. [Zusätzliche
Themen](redundancy.md#failovermonitoring-additionalissues)

#### 7.7.5.1. Einführung

Failover-Überwachung ist ähnlich wie die redundante Überwachung (wie
beschrieben in [Szenario 1](redundancy.md#redundancy-scenario_1)).

#### 7.7.5.2. Ziele

Das grundlegende Ziel der Failover-Überwachung besteht darin, dass der
Icinga-Prozess auf dem Slave-Host untätig ist, während der
Icinga-Prozess auf dem Master-Host läuft. Wenn der Prozess auf dem
Master-Host stoppt (oder der Host "down" geht), übernimmt der
Icinga-Prozess auf dem Slave-Host die gesamte Überwachung.

Während es Ihnen die in [Szenario
1](redundancy.md#redundancy-scenario_1) beschriebene Methode erlaubt,
weiterhin Benachrichtigungen zu erhalten, wenn der Master-Host "down"
geht, gibt es einige Fallen. Das größte Problem besteht darin, dass der
Slave-Host die gleichen Hosts und Services wie der Master *zur gleichen
Zeit wie der Master* überwacht! Dies kann Probleme durch übermäßigen
Traffic und Load auf den überwachten Maschinen verursachen, wenn Sie
viele Services definiert haben. Hier nun, wie Sie das Problem umgehen
können.

#### 7.7.5.3. Initiale Programm-Einstellungen

Deaktivieren Sie aktive Service-Prüfungen und Benachrichtigungen auf dem
Slave-Host durch die
[execute\_service\_checks](configmain.md#configmain-execute_service_checks)-
und die
[enable\_notifications](configmain.md#configmain-enable_notifications)-Direktiven.
Dies wird den Slave-Host davon abhalten, Services und Hosts zu
überwachen und Benachrichtigungen zu versenden, während der
Icinga-Prozess auf dem Master-Host noch läuft. Stellen Sie außerdem
sicher, dass die
[check\_external\_commands](configmain.md#configmain-check_external_commands)-Direktive
auf dem Slave-Host aktiviert ist.

#### 7.7.5.4. Master-Prozess-Prüfungen

Setzen Sie einen cron-Job auf dem Slave-Host auf, der periodisch (sagen
wir jede Minute) läuft und den Status des Icinga-Prozesses auf dem
Master-Host (mit dem *check\_nrpe* auf dem Slave-Host und den [nrpe
daemon](addons.md#addons-nrpe) und *check\_nagios*-Plugins auf dem
Master-Host) prüft. Das Script sollte den Return-Code des
*check\_nrpe-Plugins* prüfen. Falls es einen nicht-OK-Status
zurückliefert, sollte das Script den entsprechenden Befehl an das
[external command file](configmain.md#configmain-command_file) senden,
um sowohl die Benachrichtigungen als auch die aktiven Service-Prüfungen
zu aktivieren. Falls das Plugin einen OK-Status zurückliefert, sollte
das Script Befehle an das external command file senden, um sowohl
Benachrichtigungen als auch aktive Prüfungen zu deaktivieren.

Auf diese Weise läuft jeweils nur ein Prozess, der Hosts und Services
prüft, was wesentlich effizienter ist als alles doppelt zu überwachen.

Auch von Interesse: Sie müssen *nicht* wie in [Szenario
1](redundancy.md#redundancy-scenario_1) beschrieben die Host- und
Service-Handler definieren, weil die Dinge anders behandelt werden.

#### 7.7.5.5. Zusätzliche Themen

An diesem Punkt haben Sie ein sehr einfaches Failover-Überwachungs-Setup
implementiert. Trotzdem gibt es einen weiteren Punkt, den Sie
berücksichtigen sollten, damit die Dinge besser laufen.

Das große Problem dabei, wie die Dinge bisher konfiguriert sind, besteht
darin, dass der Slave-Host nicht den aktuellen Status von Hosts und
Services kennt, wenn er die Überwachung übernimmt. Ein Weg, dieses
Problem zu lösen, ist es, die [ocsp
command](configmain.md#configmain-ocsp_command)-Option auf dem
Master-Host zu aktivieren und alle Service-Prüfergebnisse mit dem [nsca
Addon](addons.md#addons-nsca) an den Slave-Host zu schicken. Der
Slave-Host wird dann aktuelle Status-Informationen für alle Services
haben, wenn er die Überwachung übernimmt. Weil aktive Service-Prüfungen
auf dem Slave-Host nicht aktiviert sind, werden sie nicht ausgeführt.
Host-Prüfungen hingegen werden nach Bedarf ausgeführt. Das bedeutet,
dass sowohl Master- als auch Slave-Host Host-Prüfungen ausführen, wenn
sie benötigt werden, was kein Problem darstellen sollte, weil die
Mehrzahl der Überwachung Service-Prüfungen betrifft.

Das ist eigentlich alles, was das Setup betrifft.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
