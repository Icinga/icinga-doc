 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.12. Service- und Host-Gruppen überwachen
------------------------------------------

7.12.1. [Einführung](clusters.md#introduction)

7.12.2. [Angriffsplan](clusters.md#planofattack)

7.12.3. [Das check\_cluster-Plugin
benutzen](clusters.md#checkclusterplugin)

7.12.4. [Service-Cluster überwachen](clusters.md#serviceclusters)

7.12.5. [Host-Cluster überwachen](clusters.md#hostclusters)

### 7.12.1. Einführung

Einige Leute haben gefragt, wie man Gruppen (Cluster) von Hosts und
Services überwacht, also möchten wir hier schreiben, wie man das macht.
Es ist ziemlich geradeaus, also hoffentlich sind die Dinge einfach zu
verstehen...

Zuerst benötigen wir eine Definition, was wir mit "Cluster" meinen. Der
einfachste Weg, dies zu verstehen, ist mit einem Beispiel. Lassen Sie
uns annehmen, Ihr Unternehmen hat fünf Hosts, die redundante
DNS-Services für Ihr Unternehmen zur Verfügung stellt. Wenn einer
ausfällt, ist das keine große Katastrophe, weil die verbleibenden Server
weiterhin die Namensauflösung bereitstellen. Wenn Sie mit der
Überwachung der Verfügbarkeit der DNS-Server betraut sind, werden Sie
fünf Server überwachen wollen. Das ist das, was wir als
*Service*-Cluster ansehen würden. Der Service-Cluster besteht aus fünf
einzelnen DNS-Services, die Sie überwachen wollen. Obwohl Sie jeden
einzelnen Service überwachen wollen, wird Ihr Hauptaugenmerk eher auf
dem Gesamtstatus des DNS-Service-Clusters liegen als auf der
Verfügbarkeit eines einzelnen Service.

Wenn Ihre Organisation eine Gruppe von Hosts hat, die eine
Hochverfügbarkeitslösung darstellt, würden wir dies als *Host*-Cluster
bezeichnen. Wenn ein bestimmter Host ausfällt, wird ein anderer
einspringen, um die Aufgaben des ausgefallenen zu übernehmen. Als eine
Randbemerkung: Sehen Sie sich das [High-Availability Linux
Project](http://www.linux-ha.org/) für Informationen zur Redundanz von
Hosts und Services mit Linux an.

### 7.12.2. Angriffsplan

Es gibt mehrere Wege, wie Sie eventuell Service- oder Host-Gruppen
überwachen können. Wir werden die Methode beschreiben, von der wir
glauben, dass sie die Einfachste ist. Service- oder Host-Cluster
überwachen umfasst zwei Dinge:



Das Überwachen von einzelnen Host- oder Service-Cluster-Elementen ist
einfacher als Sie denken. Eigentlich tun Sie es wahrscheinlich schon.
Bei Service-Clustern sollten Sie sicherstellen, dass Sie jedes
Service-Element des Clusters überwachen. Wenn Sie ein Cluster aus fünf
DNS-Servern haben, dann stellen Sie sicher, dass Sie fünf einzelne
Service-Definitionen haben (z.B. mit dem *check\_dns*-Plugin). Bei
Host-Clustern stellen Sie sicher, dass Sie entsprechende
Host-Definitionen für jedes Mitglied des Clusters haben (Sie müssen auch
mindestens einen Service auf jedem Host überwachen). **Wichtig:** Sie
können die Benachrichtigungen für die einzelnen Cluster-Elemente
deaktivieren (Host- oder Service-Definitionen). Obwohl keine
Benachrichtigungen für die einzelnen Elemente versandt werden, bekommen
Sie trotzdem eine visuelle Anzeige des einzelnen Host- oder
Service-Zustands in der [Status CGI](cgis.md#cgis-status_cgi). Das ist
nützlich bei der genauen Erkennung der Quelle von Problemen im Cluster
in der Zukunft.

Die Überwachung des gesamten Clusters kann mit Hilfe der bereits im
Cache verfügbaren Ergebnisse der Cluster-Elemente erfolgen. Auch wenn
Sie alle Elemente des Clusters erneut prüfen könnten, um den
Cluster-Status zu ermitteln: warum sollten Sie Bandbreite und Ressourcen
vergeuden, wenn bereits die Ergebnisse im Cache vorliegen? Wo werden die
Ergebnisse abgelegt? Ergebnisse für Cluster-Elemente sind im
[Status-File](configmain.md#configmain-status_file) zu finden
(vorausgesetzt, dass Sie jedes Element überwachen). Das
*check\_cluster*-Plugin ist genau für den Zweck ausgelegt, um Host- und
Service-Zustände im Status-File zu prüfen. **Wichtig:** Auch wenn Sie
Benachrichtigungen für einzelne Elemente des Clusters nicht aktiviert
haben, möchten Sie sie vielleicht für den Gesamtstatus des Clusters
aktivieren.

### 7.12.3. Das check\_cluster-Plugin benutzen

Das check\_cluster-Plugin ist dafür ausgelegt, den Gesamtstatus eines
Host- oder Service-Clusters durch die Prüfung der Statusinformationen
jedes einzelnen Host- oder Service-Cluster-Elements zu ermitteln.

noch mehr... Das *check\_cluster*-Plugin finden Sie im
contrib-Verzeichnis der Monitoring Plugins unter
[https://www.monitoring-plugins.org/](https://www.monitoring-plugins.org).

### 7.12.4. Service-Cluster überwachen

Nehmen wir an, dass Sie drei DNS-Server haben, die redundante Dienste in
Ihrem Netzwerk bereitstellen. Zuerst müssen Sie jeden einzelnen
DNS-Server überwachen, bevor Sie sie als Cluster überwachen können. Wir
nehmen an, dass Sie bereits drei einzelne Services haben (die alle "DNS
Service" heißen), die mit Ihren DNS-Hosts verbunden sind ("host1",
"host2" und "host3" genannt).

Um die Services als einen Cluster zu überwachen, müssen Sie einen neuen
"Cluster"-Service erstellen. Bevor Sie das tun, sollten Sie ein
Service-Cluster-Prüfbefehl konfigurieren. Lassen Sie uns annehmen, dass
Sie einen Befehl namens *check\_service\_cluster* wie folgt definieren:

</code></pre> 
 define command{
</code></pre>

Nun müssen Sie den "Cluster"-Service erstellen und den
*check\_service\_cluster*-Befehl benutzen, den Sie gerade als
Cluster-Prüfbefehl erstellt haben. Das folgende Beispiel gibt einen
Hinweis, wie das zu tun ist. Es generiert einen CRITICAL-Alarm, wenn
zwei oder mehr Services im Cluster in einem nicht-OK-Zustand sind und
einen WARNING-Alarm, wenn nur einer der Services in einem
nicht-OK-Zustand ist. Wenn jedes der einzelnen Service-Mitglieder des
Clusters OK sind, wird auch die Cluster-Prüfung einen OK-Status
zurückliefern.

</code></pre> 
 define service{
</code></pre>

Es ist wichtig anzumerken, dass wir eine Komma-separierte Liste von
*on-demand*
Service-Zustands-[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
an das \$ARG4\$-Makro des Cluster-Prüfbefehls übergeben. Das ist
wichtig! Icinga wird diese On-Demand-Makros mit den aktuellen
Service-Status-IDs (numerischen Werten statt Zeichenketten) der
einzelnen Mitglieder des Clusters füllen.

### 7.12.5. Host-Cluster überwachen

Host-Cluster zu überwachen ist ziemlich ähnlich zur Überwachung von
Service-Clustern. Offenkundig besteht der Hauptunterschied darin, dass
Hosts überwacht werden und nicht Services. Um den Status eines
Host-Clusters zu überwachen, müssen Sie einen Service definieren, der
das *check\_cluster*-Plugin benutzt. Der Service sollte *nicht* mit
einem der Hosts im Cluster verbunden werden, weil dies Probleme mit
Benachrichtigungen für den Cluster erzeugt, wenn der Host "down" geht.
Eine gute Idee könnte es sein, den Service mit dem Host zu verbinden,
auf dem Icinga läuft. Wenn der Host, auf dem Icinga läuft, "down" geht,
dann funktioniert auch Icinga nicht mehr und dann können Sie auch nichts
mehr tun (es sei denn, Sie hätten eine [redundante
Host-Überwachung](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")
eingerichtet)...

Wie auch immer, lassen Sie uns annehmen, dass Sie einen
*check\_host\_cluster*-Befehl wie folgt definiert haben:

</code></pre> 
 define command{
</code></pre>

Sagen wir, dass Sie drei Hosts ("host1", "host2" und "host3" genannt) in
Ihrem Host-Cluster haben. Wenn Icinga einen WARNING-Alarm generieren
soll, wenn einer der Host im Cluster nicht UP ist bzw. einen
CRITICAL-Alarm, wenn zwei oder mehr Hosts nicht UP sind, dann sollte der
Service, um das Host-Cluster zu überwachen, ungefähr so aussehen:

</code></pre> 
 define service{
</code></pre>

Es ist wichtig anzumerken, dass wir eine Komma-separierte Liste von
*on-demand*
Host-Zustands-[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
an das \$ARG4\$-Makro des Cluster-Prüfbefehls übergeben. Das ist
wichtig! Icinga wird diese On-Demand-Makros mit den aktuellen
Host-Status-IDs (numerischen Werten statt Zeichenketten) der einzelnen
Mitglieder des Clusters füllen.

Das war's! Icinga wird regelmäßig den Status des Host-Clusters prüfen
und Benachrichtigungen an Sie versenden, wenn der Status nicht OK ist
(vorausgesetzt, dass Sie Benachrichtigungen für den Service aktiviert
haben). Beachten Sie, dass Sie höchstwahrscheinlich die
Benachrichtigungen in den einzelnen Host-Definitionen deaktivieren
werden, wenn der Host "down" geht. Denken Sie daran, dass Sie der Status
der einzelnen Hosts weniger interessiert als der Gesamtstatus des
Clusters. Abhängig von Ihrem Netzwerk-Layout und von dem, was Sie
erreichen wollen, möchten Sie vielleicht die Benachrichtigungen für
UNREACHABLE-Zustände bei den Host-Definitionen aktiviert lassen.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
