Service-Prüfungen (Service Checks)
==================================

Einführung
----------

Die grundlegenden Tätigkeiten von Service-Prüfungen werden hier
beschrieben...

Wann werden Service-Prüfungen durchgeführt?
-------------------------------------------

Services werden durch den NAME-ICINGA-Daemon geprüft

-   in regelmäßigen Intervallen, wie sie durch die *check\_interval* und
    *retry\_interval*-Optionen in Ihren
    [Service-Definitionen](#objectdefinitions-service) festgelegt sind.

-   nach Bedarf bei [vorausschauende
    Host-Abhängigkeitsprüfungen](#dependencychecks).

Prüfungen nach Bedarf werden als Teil der [vorausschauenden
Service-Abhängigkeitsprüfung](#dependencychecks)s-Logik durchgeführt.
Diese Prüfungen helfen sicherzustellen, dass die Abhängigkeitslogik so
genau wie möglich ist. Falls Sie die
[Service-Abhängigkeiten](#objectdefinitions-servicedependency) nicht
nutzen, wird NAME-ICINGA keine Service-Prüfungen nach Bedarf
durchführen.

**zwischengespeicherte Service-Prüfungen** (cached service checks)

Die Performance von Service-Prüfungen nach Bedarf kann signifikant durch
den Einsatz von "cached checks" erhöht werden, die es NAME-ICINGA
erlauben, auf eine Service-Prüfung zu verzichten, wenn es feststellt,
dass ein relativ frisches Prüfungsergebnis genügt. Cached checks werden
nur dann einen Performance-Gewinn ergeben, wenn Sie
[Service-Abhängigkeiten](#objectdefinitions-servicedependency) nutzen.
Mehr Informationen zu "cached checks" finden Sie [hier](#cachedchecks).

Abhängigkeiten und Prüfungen
----------------------------

Sie können
[Service-Ausführungs-Abhängigkeiten](#objectdefinitions-servicedependency)
definieren, die NAME-ICINGA von der Statusprüfung eines Service abhalten
in Abhängigkeit vom Status ein oder mehrerer anderer Services. Mehr
Informationen zu Abhängigkeiten finden Sie [hier](#dependencies).

Parallelisierung von Service-Prüfungen
--------------------------------------

Geplante Service-Prüfungen laufen parallel. Wenn NAME-ICINGA eine
geplante Service-Prüfung ausführt, wird es die Service-Prüfung
veranlassen und dann zu anderen Arbeiten zurückkehren (Host-Prüfungen
ausführen, etc.). Die Service-Prüfung läuft in einem Kind-Prozess, der
vom Haupt-NAME-ICINGA-Prozess aufgerufen wird ("fork()ed"). Wenn die
Service-Prüfung beendet ist, wird der Kind-Prozess den
Haupt-NAME-ICINGA-Prozess (seinen Eltern-Prozess) über das Ergebnis
informieren. Der Haupt-NAME-ICINGA-Prozess wird dann das
Prüfungsergebnis behandeln und geeignete Aktionen durchführen
(Eventhandler starten, Benachrichtigungen senden, usw.).

Service-Prüfungen nach Bedarf laufen ebenfalls parallel, falls
notwendig. Wie bereits vorher erwähnt kann NAME-ICINGA auf die
eigentliche Ausführung einer Service-Prüfung nach Bedarf verzichten,
wenn es das gespeicherte Ergebnis einer relativ frischen Service-Prüfung
benutzen kann.

Service-Zustände
----------------

Services, die geprüft werden, können in einem von vier unterschiedlichen
Zuständen sein

-   OK

-   WARNING

-   UNKNOWN

-   CRITICAL

Service-Statusermittlung
------------------------

Service-Prüfungen werden mit Hilfe von [Plugins](#plugins) durchgeführt,
die den Status OK, WARNING, UNKNOWN oder CRITICAL zurückliefern können.
Diese Return-Codes der Plugins werden direkt in die Service-Zustände
übersetzt. Beispielsweise wird das WARNING-Ergebnis eines Plugins zu
einem WARNING-Status eines Service führen.

Service-Statusänderungen
------------------------

Wenn NAME-ICINGA den Status von Services prüft, ist es in der Lage
festzustellen, wenn ein Service zwischen OK-, WARNING-, UNKNOWN- und
CRITICAL-Zuständen wechselt und geeignete Maßnahmen ergreifen. Diese
Zustandsänderungen resultieren in verschiedenen
[Statustypen](#statetypes) (HARD oder SOFT), was zum Auslösen von
[Eventhandlern](#eventhandlers) und dem Versenden von
[Benachrichtigungen](#notifications) führen kann.
Service-Statusänderungen können auch zum Auslösen von
[Host-Prüfungen](#hostchecks) nach Bedarf führen. Das Erkennen und
Behandeln von Statusänderungen ist das, worum es sich bei NAME-ICINGA
handelt.

Wenn Service-Statusänderungen zu oft erfolgen, werden sie als
"flatternd" (flapping) angesehen. NAME-ICINGA kann erkennen, wenn
Services anfangen zu flattern, und kann Benachrichtigungen unterdrücken,
bis das Flattern stoppt und sich der Service-Status stabilisiert. Mehr
Informationen über die Erkennungslogik des Flatterns finden Sie
[hier](#flapping).

Service-Prüfungen
