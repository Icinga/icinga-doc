 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.6. Aktive Prüfungen (Active Checks)
-------------------------------------

5.6.1. [Einführung](activechecks.md#introduction)

5.6.2. [Wie werden aktive Prüfungen
durchgeführt?](activechecks.md#performed)

5.6.3. [Wann werden aktive Prüfungen
ausgeführt?](activechecks.md#executed)

### 5.6.1. Einführung

Icinga ist in der Lage, Hosts und Services auf zwei Arten zu überwachen:
aktiv und passiv. Passive Prüfungen werden
[anderswo](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
beschrieben, so dass wir uns hier auf aktive Prüfungen konzentrieren.
Aktive Prüfungen sind die gebräuchlichste Methode zur Überwachung von
Hosts und Services. Die Hauptmerkmale von aktiven Prüfungen sind



![](../images/activechecks.png)

### 5.6.2. Wie werden aktive Prüfungen durchgeführt?

Aktive Prüfungen werden durch die Prüfungslogik im Icinga-Daemon
veranlasst. Wenn Icinga den Status eines Hosts oder Services prüfen
muss, wird es ein Plugin ausführen und die Informationen übergeben, was
geprüft werden soll. Das Plugin wird dann den Betriebszustand des Hosts
oder Service prüfen und die Ergebnisse an den Icinga-Daemon
zurückmelden. Icinga wird die Ergebnisse der Host- oder Service-Prüfung
verarbeiten und entsprechend notwendige Aktionen ausführen (z.B.
Benachrichtigungen versenden, Eventhandler ausfüren, usw.).

Mehr Informationen, wie Plugins arbeiten, finden Sie
[hier](plugins.md "5.1. Icinga Plugins").

### 5.6.3. Wann werden aktive Prüfungen ausgeführt?

Aktive Prüfungen werden ausgeführt



Regelmäßig geplante Prüfungen erfolgen in Intervallen, die den
Einstellungen in *check\_interval* oder *retry\_interval* in Ihren Host-
oder Service-Definitionen entsprechen, abhängig davon, in welchem
[Statustyp](statetypes.md "5.8. Statustypen") sich der Host oder
Service befindet.

Prüfungen nach Bedarf werden ausgeführt, wann immer Icinga die
Notwendigkeit sieht, die neuesten Statusinformationen über einen
bestimmten Host oder Service zu ermitteln. Wenn Icinga beispielsweise
die
[Erreichbarkeit](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")
eines Hosts feststellt, wird es oft Prüfungen von Eltern- und Kind-Hosts
durchführen, um den genauen Status eines bestimmten Netzwerk-Segments zu
ermitteln. Prüfungen nach Bedarf finden sich auch in der
[vorausschauenden
Abhängigkeitsprüfung](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")s-Logik,
um sicherzustellen, dass Icinga möglichst genaue Statusinformationen
hat.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
