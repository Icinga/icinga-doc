 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.5. Service-Prüfungen (Service Checks)
---------------------------------------

5.5.1. [Einführung](servicechecks.md#introduction)

5.5.2. [Wann werden Service-Prüfungen
durchgeführt?](servicechecks.md#when)

5.5.3. [Abhängigkeiten und
Prüfungen](servicechecks.md#dependencieschecks)

5.5.4. [Parallelisierung von
Service-Prüfungen](servicechecks.md#parallelization)

5.5.5. [Service-Zustände](servicechecks.md#servicestates)

5.5.6.
[Service-Statusermittlung](servicechecks.md#servicestatedetermination)

5.5.7.
[Service-Statusänderungen](servicechecks.md#servicestatechanges)

5.5.8. [Service-Zustand ist
"stale"](servicechecks.md#servicestatestale)

### 5.5.1. Einführung

Die grundlegenden Tätigkeiten von Service-Prüfungen werden hier
beschrieben...

### 5.5.2. Wann werden Service-Prüfungen durchgeführt?

Services werden durch den Icinga-Daemon geprüft



Prüfungen nach Bedarf werden als Teil der [vorausschauenden
Service-Abhängigkeitsprüfung](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")s-Logik
durchgeführt. Diese Prüfungen helfen sicherzustellen, dass die
Abhängigkeitslogik so genau wie möglich ist. Falls Sie die
[Service-Abhängigkeiten](objectdefinitions.md#objectdefinitions-servicedependency)
nicht nutzen, wird Icinga keine Service-Prüfungen nach Bedarf
durchführen.

**zwischengespeicherte Service-Prüfungen** (cached service checks)

Die Performance von Service-Prüfungen nach Bedarf kann signifikant durch
den Einsatz von "cached checks" erhöht werden, die es Icinga erlauben,
auf eine Service-Prüfung zu verzichten, wenn es feststellt, dass ein
relativ frisches Prüfungsergebnis genügt. Cached checks werden nur dann
einen Performance-Gewinn ergeben, wenn Sie
[Service-Abhängigkeiten](objectdefinitions.md#objectdefinitions-servicedependency)
nutzen. Mehr Informationen zu "cached checks" finden Sie
[hier](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen").

### 5.5.3. Abhängigkeiten und Prüfungen

Sie können
[Service-Ausführungs-Abhängigkeiten](objectdefinitions.md#objectdefinitions-servicedependency)
definieren, die Icinga von der Statusprüfung eines Service abhalten in
Abhängigkeit vom Status ein oder mehrerer anderer Services. Mehr
Informationen zu Abhängigkeiten finden Sie
[hier](dependencies.md "7.13. Host- und Service-Abhängigkeiten").

### 5.5.4. Parallelisierung von Service-Prüfungen

Geplante Service-Prüfungen laufen parallel. Wenn Icinga eine geplante
Service-Prüfung ausführt, wird es die Service-Prüfung veranlassen und
dann zu anderen Arbeiten zurückkehren (Host-Prüfungen ausführen, etc.).
Die Service-Prüfung läuft in einem Kind-Prozess, der vom
Haupt-Icinga-Prozess aufgerufen wird ("fork()ed"). Wenn die
Service-Prüfung beendet ist, wird der Kind-Prozess den
Haupt-Icinga-Prozess (seinen Eltern-Prozess) über das Ergebnis
informieren. Der Haupt-Icinga-Prozess wird dann das Prüfungsergebnis
behandeln und geeignete Aktionen durchführen (Eventhandler starten,
Benachrichtigungen senden, usw.).

Service-Prüfungen nach Bedarf laufen ebenfalls parallel, falls
notwendig. Wie bereits vorher erwähnt kann Icinga auf die eigentliche
Ausführung einer Service-Prüfung nach Bedarf verzichten, wenn es das
gespeicherte Ergebnis einer relativ frischen Service-Prüfung benutzen
kann.

### 5.5.5. Service-Zustände

Services, die geprüft werden, können in einem von vier unterschiedlichen
Zuständen sein





### 5.5.6. Service-Statusermittlung

Service-Prüfungen werden mit Hilfe von
[Plugins](plugins.md "5.1. Icinga Plugins") durchgeführt, die den
Status OK, WARNING, UNKNOWN oder CRITICAL zurückliefern können. Diese
Return-Codes der Plugins werden direkt in die Service-Zustände
übersetzt. Beispielsweise wird das WARNING-Ergebnis eines Plugins zu
einem WARNING-Status eines Service führen.

### 5.5.7. Service-Statusänderungen

Wenn Icinga den Status von Services prüft, ist es in der Lage
festzustellen, wenn ein Service zwischen OK-, WARNING-, UNKNOWN- und
CRITICAL-Zuständen wechselt und geeignete Maßnahmen ergreifen. Diese
Zustandsänderungen resultieren in verschiedenen
[Statustypen](statetypes.md "5.8. Statustypen") (HARD oder SOFT), was
zum Auslösen von [Eventhandlern](eventhandlers.md "7.3. Eventhandler")
und dem Versenden von
[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")
führen kann. Service-Statusänderungen können auch zum Auslösen von
[Host-Prüfungen](hostchecks.md "5.4. Host-Prüfungen (Host checks)")
nach Bedarf führen. Das Erkennen und Behandeln von Statusänderungen ist
das, worum es sich bei Icinga handelt.

Wenn Service-Statusänderungen zu oft erfolgen, werden sie als
"flatternd" (flapping) angesehen. Icinga kann erkennen, wenn Services
anfangen zu flattern, und kann Benachrichtigungen unterdrücken, bis das
Flattern stoppt und sich der Service-Status stabilisiert. Mehr
Informationen über die Erkennungslogik des Flatterns finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

### 5.5.8. Service-Zustand ist "stale"

Eine Erklärung finden Sie unter ["Frische-Prüfungen /
freshness"](freshness.md#stale "7.5.5. "Check results ... are stale. Forcing an immediate check ...").

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
