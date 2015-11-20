 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.21. Zwischengespeicherte Prüfungen
------------------------------------

7.21.1. [Einführung](cachedchecks.md#introduction)

7.21.2. [Nur für Prüfungen nach
Bedarf](cachedchecks.md#ondemandchecks)

7.21.3. [Wie Zwischenspeicherung arbeitet](cachedchecks.md#howitworks)

7.21.4. [Was dies wirklich bedeutet](cachedchecks.md#whatthismeans)

7.21.5. [Konfigurationsvariablen](cachedchecks.md#configvars)

7.21.6. [Zwischenspeichereffektivität
optimieren](cachedchecks.md#optimizeeffectiveness)

### 7.21.1. Einführung

![](../images/cachedchecks1.png)

Die Leistung der Überwachungslogik von Icinga kann mit Hilfe von
zwischengespeicherten Prüfungen (cached checks) nennenswert gesteigert
werden. Zwischengespeicherte Prüfungen erlauben es Icinga, auf die
Ausführung einer Host- oder Service-Prüfung zu verzichten, wenn es
feststellt, dass ein recht aktuelles Prüfergebnis ausreicht.

### 7.21.2. Nur für Prüfungen nach Bedarf

Regelmäßig eingeplante Host- und Service-Prüfungen werden keine
Leistungssteigerung durch zwischengespeicherte Prüfungen erfahren.
Zwischengespeicherte Prüfungen sind nur sinnvoll zur Steigerung von
Host- und Service-Prüfungen nach Bedarf. Geplante Prüfungen sorgen
dafür, dass Host- und Service-Zustände regelmäßig aktualisiert werden,
was in der Zukunft dazu führen kann, dass die Ergebnisse als
zwischengespeicherte Prüfungen genutzt werden können.

Zur Erinnerung: Host-Prüfungen nach Bedarf treten auf...




und Service-Prüfungen nach Bedarf treten auf...


![](../images/note.gif) Hinweis: Solange Sie keinen Gebrauch von
Service-Abhängigkeiten machen, wird Icinga nicht in der Lage sein,
zwischengespeicherte Prüfungen zur Leistungssteigerung von
Zwischengespeicherte Host-Prüfungen sorgen für große
Leistungssteigerungen und jeder sollte dort einen Vorteil sehen.

### 7.21.3. Wie Zwischenspeicherung arbeitet

![](../images/cachedchecks.png)

Wenn Icinga eine Host- oder Service-Prüfung nach Bedarf durchführen
muss, wird es eine Festlegung treffen, ob es ein zwischengespeichertes
Ergebnis benutzen kann oder ob es wirklich eine Prüfung durchführen
muss. Es tut dies, indem es schaut, ob die letzte Prüfung für den Host
oder Service innerhalb der letzten X Minuten erfolgte, wobei X der
zwischengespeicherte Host- oder Service-Horizont ist.

Wenn die letzte Prüfung innerhalb des Zeitfensters erfolgte, das durch
die cached-check-horizon-Variable angegeben ist, wird Icinga das
Ergebnis der letzen Host- oder Service-Prüfung nutzen und *nicht* eine
neue Prüfung ausführen. Wenn der Host oder Service noch nicht geprüft
wurde oder die letzte Prüfung außerhalb des
cached-check-horizon-Zeitfensters liegt, wird Icinga durch ein Plugin
eine neue Host- oder Service-Prüfung durchführen.

### 7.21.4. Was dies wirklich bedeutet

Icinga führt Prüfungen nach Bedarf durch, weil es den aktuellen Status
eines Hosts oder Service *in diesem Moment* wissen muss. Durch die
Nutzung von zwischengespeicherten Prüfungen lassen Sie Icinga glauben,
dass die kürzlichen Prüfungsergebnisse für die Ermittlung des aktuellen
Zustands von Hosts "gut genug" sind und dass es nicht hergehen muss und
erneut den Zustand für den Host oder Service prüfen muss.

Die cached-check-horizon-Variable teilt Icinga mit, wie aktuell
Prüfergebnisse sein müssen, um zuverlässig den jetzigen Status eines
Hosts oder Services darzustellen. Bei einem cached-check-horizon-Wert
von 30 Sekunden sagen Sie Icinga, dass die Prüfung des Zustands eines
Host innerhalb der letzten 30 Sekunden erfolgt sein muss, um noch als
aktueller Zustand dieses Hosts angesehen zu werden.

Die Anzahl von zwischengespeicherten Prüfergebnissen, die Icinga nutzen
kann, im Verhältnis zu der Anzahl von Prüfungen nach Bedarf, kann als
die cached-check "Treffer"-Rate bezeichnet werden. Durch die Erhöhung
des cached-check-horizon-Wertes bis zum regulären Prüfintervall des
Hosts können Sie theoretisch eine Trefferrate von 100% erreichen. In
diesem Fall würden alle Prüfungen nach Bedarf zwischengespeicherte
Prüfergebnisse benutzen. Was für eine Leistungssteigerung! Aber ist es
das wirklich? Wahrscheinlich nicht.

Die Zuverlässigkeit von zwischengespeicherten Prüfergebnissen nimmt mit
der Zeit ab. Höhere Trefferraten erfordern, dass vorherige
Prüfergebnisse für längere Zeit als "gültig" angesehen werden. Dinge
können sich schnell in jedem Netzwerk-Szenario ändern, und es gibt keine
Garantie dafür, dass es bei einem Server auf einmal brennt, der vor 30
Sekunden fehlerfrei funktionierte. Das ist der Kompromiss:
Zuverlässigkeit gegen Geschwindigkeit. Wenn der
cached-check-horizon-Wert groß ist, riskieren Sie, dass Sie
unzuverlässige Prüfergebnisse in der Überwachungslogik haben.

Icinga wird letztendlich den korrekten Status aller Hosts und Services
ermitteln, so dass es lediglich für eine kurze Zeit mit inkorrekten
Informationen arbeitet, selbst wenn sich die zwischengespeicherten
Prüfergebnisse als unzuverlässig herausstellen sollten. Selbst kurze
Zeiten von unzuverlässigen Statusinformationen können sich für Admins
als Ärgernis erweisen, wenn sie Benachrichtigungen über Probleme
bekommen, die nicht länger existieren.

Es gibt keinen Standard-cached-check-horizon-Wert oder keine
Trefferrate, die für jeden Icinga-Benutzer akzeptierbar wäre. Einige
Leute möchten einen kleines horizon-Zeitfenster und eine niedrige
Trefferrate während andere ein größeres Zeitfenster und eine höhere
Trefferrate bevorzugen (mit einer kleineren Zuverlässigkeitsrate).
Einige Leute möchten vielleicht ganz auf zwischengespeicherte Prüfungen
verzichten, um eine hundertprozentige Zuverlässigkeitsrate zu erhalten.
Verschiedene horizon-Zeitfenster auszuprobieren und ihren Einfluss auf
die Zuverlässigkeit von Statusinformationen zu sehen ist vielleicht das
einzige Bedürfnis, das ein einzelner Benutzer hat, um den "richtigen"
Wert für seine Situation zu finden.

### 7.21.5. Konfigurationsvariablen

Die folgenden Variablen legen die Zeitfenster fest, in denen ein
vorangegangenes Prüfergebnis als ein zwischengespeichertes Prüfergebnis
genutzt werden kann:



### 7.21.6. Zwischenspeichereffektivität optimieren

Um den größten Nutzen aus zwischengespeicherten Prüfungen zu ziehen,
sollten Sie:




Sie können regelmäßige Prüfungen für Ihre Hosts durch einen größeren
Wert als 0 in der *check\_interval*-Option in Ihren
[Host-Definitionen](objectdefinitions.md#objectdefinitions-host)
einplanen. Wenn Sie das tun, sollten Sie die
*max\_check\_attempts*-Option auf einen Wert größer als 1 setzen, oder
es wird ein Performance-Problem geben. Das potenzielle
Performance-Problem ist
[hier](hostchecks.md "5.4. Host-Prüfungen (Host checks)") genauer
beschrieben.

![](../images/perfdata_cached2.png)

Ein guter Weg, um den richtigen Wert für die
cached-check-horizon-Optionen zu ermitteln, besteht im Vergleich der
Anzahl von Prüfungen nach Bedarf gegen die Anzahl, in denen
zwischengespeicherte Ergebnisse benutzt werden. Das
[icingastats](icingastats.md "8.6. Nutzung des Icingastats-Utilitys")-Dienstprogramm
kann Informationen über zwischengespeicherte Prüfungen erzeugen, die
dann mit
[PNP4Nagios](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios")
dargestellt werden können. Ein Beispiel-Diagramm, das
zwischengespeicherte Prüfungen gegen solche nach Bedarf darstellt, sehen
Sie oben.

Bei der Testumgebung, aus der dieser Graph stammt, gab es...




Das Diagramm zeigt, wie viele regelmäßig geplante Host-Prüfungen im
Vergleich zu zwischengespeicherten Host-Prüfungen erfolgt sind. In
diesem Beispiel wurden alle fünf Minuten ein Durchschnitt von 77
Host-Prüfungen durchgeführt. 59 von diesen (76%) sind Prüfungen nach
Bedarf.

Es zeigt auch, wie viele zwischengespeicherte Host-Prüfungen während der
Zeit aufgetreten sind. In diesem Beispiel waren es im Durchschnitt 21
Host-Prüfungen alle fünf Minuten.

Erinnern Sie sich, dass zwischengespeicherte Prüfungen nur für Prüfungen
nach Bedarf verfügbar sind. Basierend auf den 5-Minuten- Durchschnitten
der Graphen sehen wir, dass Icinga in 21 von 59 Fällen ein
zwischengespeichertes Ergebnis benutzen kann, wenn Prüfungen nach Bedarf
auszuführen sind. Das scheint nicht viel zu sein, aber diese Graphen
stellen eine kleine Überwachungsumgebung dar. Bedenken Sie, dass 21 von
59 fast 36% sind und Sie können sich vorstellen, wie dies die
Host-Prüf-Performance in großen Umgebungen steigern kann. Der
Prozentsatz könnte größer sein, wenn der Wert der
cached\_host\_check\_horizon-Variablen erhöht wird, aber das würde die
Zuverlässigkeit der zwischengespeicherten Host-Statusinformation
verringern.

Sobald Sie ein paar Stunden oder Tage mit PNP4Nagios-Graphen haben,
sollten Sie sehen, wie viele Host- und Service-Prüfungen mit Hilfe von
Plugins ausgeführt werden gegen die, die zwischengespeicherte
Prüfergebnisse benutzen. Nutzen Sie diese Informationen, um die
cached-check-horizon-Variablen entsprechend für Ihre Situation
anzupassen. Überwachen Sie weiterhin die PNP4Nagios-Graphen, um zu
sehen, wie die Änderung der horizon-Variablen die zwischengespeicherten
Prüf-Statistiken beeinflusst. Ändern und wiederholen Sie, falls
erforderlich.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
