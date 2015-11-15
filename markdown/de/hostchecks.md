![Icinga](../images/logofullsize.png "Icinga")

5.4. Host-Prüfungen (Host checks)

[Zurück](macrolist.md) 

Kapitel 5. Die Grundlagen

 [Weiter](servicechecks.md)

* * * * *

5.4. Host-Prüfungen (Host checks)
---------------------------------

5.4.1. [Einführung](hostchecks.md#introduction)

5.4.2. [Wann werden Host-Prüfungen
durchgeführt?](hostchecks.md#whenrun)

5.4.3. [zwischengespeicherte Host-Prüfungen (cached host
checks)](hostchecks.md#caching)

5.4.4. [Abhängigkeiten und
Prüfungen](hostchecks.md#dependencieschecks)

5.4.5. [Parallelisierung von
Host-Prüfungen](hostchecks.md#parallelization)

5.4.6. [Host-Zustände](hostchecks.md#hoststates)

5.4.7. [Host-Statusermittlung](hostchecks.md#hoststatedetermination)

5.4.8. [Host-Statusänderungen](hostchecks.md#hoststatechanges)

### 5.4.1. Einführung

Die grundlegenden Tätigkeiten von Host-Prüfungen werden hier
beschrieben...

### 5.4.2. Wann werden Host-Prüfungen durchgeführt?

Hosts werden durch den Icinga-Daemon geprüft

-   in regelmäßigen Intervallen, wie sie durch die *check\_interval* und
    *retry\_interval*-Optionen in Ihren
    [Host-Definitionen](objectdefinitions.md#objectdefinitions-host)
    festgelegt sind.

-   nach Bedarf, wenn ein mit dem Host verbundener Service den Status
    wechselt.

-   nach Bedarf als Teil der
    [Host-Verfügbarkeit](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")s-Logik.

-   nach Bedarf bei [vorausschauenden
    Host-Abhängigkeitsprüfungen](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen").

Regelmäßige Host-Prüfungen sind optional. Wenn Sie die
*check\_interval*-Option in Ihrer Host-Definition auf Null (0) setzen,
wird Icinga keine Host-Prüfungen auf planmäßiger Basis durchführen. Es
wird jedoch weiterhin nach Bedarf Prüfungen für den Host durchführen für
andere Teile der Überwachungslogik.

Prüfungen nach Bedarf werden gemacht, wenn ein mit dem Host verbundener
Service den Status wechselt, denn Icinga muss wissen, ob auch der Host
den Status gewechselt hat. Services, die den Status wechseln, sind oft
ein Indikator dafür, dass auch der Host den Status gewechselt hat. Wenn
beispielsweise der mit einem Host verbundene HTTP-Service den Status von
CRITICAL auf OK gewechselt hat, kann das bedeuten, dass der Host gerade
einen Reboot beendet hat und nun wieder verfügbar ist.

Host-Prüfungen nach Bedarf werden auch als Teil der
[Host-Erreichbarkeit](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")
erledigt. Icinga ist so konstruiert, dass Netzwerkausfälle so schnell
wie möglich erkannt werden und zwischen DOWN- und UNREACHABLE-Zuständen
unterschieden werden kann. Das sind sehr unterschiedliche Zustände und
es kann dem Admin helfen, schnell die Ursache für einen Netzwerkausfall
zu finden.

Prüfungen nach Bedarf werden auch als Teil der [vorausschauenden
Host-Abhängigkeitsprüfung](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")s-Logik
durchgeführt.

### 5.4.3. zwischengespeicherte Host-Prüfungen (cached host checks)

Die Performance von Host-Prüfungen nach Bedarf kann signifikant durch
den Einsatz von "cached checks" erhöht werden, die es Icinga erlauben,
auf eine Host-Prüfung zu verzichten, wenn es feststellt, dass ein
relativ frisches Prüfungsergebnis genügt. Mehr Informationen zu "cached
checks" finden Sie
[hier](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen").

### 5.4.4. Abhängigkeiten und Prüfungen

Sie können
[Host-Ausführungs-Abhängigkeiten](objectdefinitions.md#objectdefinitions-hostdependency)
definieren, die Icinga von der Statusprüfung eines Hosts abhalten in
Abhängigkeit vom Status ein oder mehrerer anderer Hosts. Mehr
Informationen zu Abhängigkeiten finden Sie
[hier](dependencies.md "7.13. Host- und Service-Abhängigkeiten").

### 5.4.5. Parallelisierung von Host-Prüfungen

Geplante Host-Prüfungen laufen parallel. Wenn Icinga eine geplante
Host-Prüfung ausführt, wird es die Host-Prüfung veranlassen und dann zu
anderen Arbeiten zurückkehren (Service-Prüfungen ausführen, etc.). Die
Host-Prüfung läuft in einem Kind-Prozess, der vom Haupt-Icinga-Prozess
aufgerufen wird ("fork()ed"). Wenn die Host-Prüfung beendet ist, wird
der Kind-Prozess den Haupt-Icinga-Prozess (seinen Eltern-Prozess) über
das Ergebnis informieren. Der Haupt-Icinga-Prozess wird dann das
Prüfungsergebnis behandeln und geeignete Aktionen durchführen
(Eventhandler starten, Benachrichtigungen senden, usw.).

Host-Prüfungen nach Bedarf laufen ebenfalls parallel, falls notwendig.
Wie bereits vorher erwähnt kann Icinga auf die eigentliche Ausführung
einer Host-Prüfung nach Bedarf verzichten, wenn es das gespeicherte
Ergebnis einer relativ frischen Host-Prüfung benutzen kann.

Wenn Icinga die Ergebnisse von geplanten und nach Bedarf ausgeführten
Host-Prüfungen verarbeitet, kann es (zusätzliche) Prüfungen anderer
Hosts veranlassen. Diese Prüfungen können aus zwei Gründen veranlasst
werden: [vorausschauende
Abhängigkeitsprüfungen](dependencychecks.md "7.20. Vorausschauende Abhängigkeitsprüfungen")
und um den Status des Hosts mit Hilfe von
[Netzwerk-Erreichbarkeit](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")s-Logik
festzustellen. Die zusätzlichen Prüfungen werden normalerweise parallel
ausgeführt. Allerdings gibt es eine große Ausnahme, der Sie sich bewusst
sein sollten, da sie einen negativen Einfluss auf die Performance haben
kann...

![](../images/note.gif) Hosts, deren *max\_check\_attempts*-Wert auf
**1** gesetzt sind, können schwerwiegende Performance-Probleme
verursachen. Der Grund? Wenn Icinga den richtigen Status mit Hilfe der
[Netzwerk-Erreichbarkeit](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")s-Logik
ermitteln muss (um zu sehen, ob sie DOWN oder UNREACHABLE sind), muss es
**aufeinanderfolgende** Prüfungen für alle direkten Eltern des Hosts
starten. Um es noch einmal zu wiederholen, diese Prüfungen laufen
*nacheinander* statt parallel, also kann es zu einem
Performance-Einbruch kommen. Aus diesem Grund würden wir empfehlen, dass
Sie immer einen Wert größer als 1 für die
*max\_check\_attempts*-Direktiven in Ihren Host-Definitionen benutzen.

### 5.4.6. Host-Zustände

Hosts, die geprüft werden, können in einem von drei unterschiedlichen
Zuständen sein

-   UP

-   DOWN

-   UNREACHABLE

### 5.4.7. Host-Statusermittlung

Host-Prüfungen werden mit Hilfe von
[Plugins](plugins.md "5.1. Icinga Plugins") durchgeführt, die den
Status OK, WARNING, UNKNOWN oder CRITICAL zurückliefern können. Wie
übersetzt Icinga diese Return-Codes der Plugins in die Host-Zustände UP,
DOWN oder UNREACHABLE? Wir werden sehen...

Die nachfolgende Tabelle zeigt, wie sich die Return-Codes von Plugins
mit vorläufigen Host-Zuständen decken. Einige Nachbearbeitung (die
später beschrieben wird) ergibt den endgültigen Host-Zustand.

**Plugin-Ergebnis**

**vorläufiger Host-Zustand**

OK

UP

WARNING

UP oder DOWN^\*^

UNKNOWN

DOWN

CRITICAL

DOWN

![](../images/note.gif) Anmerkung: Das Ergebnis WARNING bedeutet
normalerweise, dass der Host UP ist. Trotzdem werden WARNING-Ergebnisse
so interpretiert, dass der Host DOWN ist, wenn die
[use\_aggressive\_host\_checking](configmain.md#configmain-use_aggressive_host_checking)-Option
aktiviert ist.

Wenn der vorläufige Host-Status DOWN ist, wird Icinga versuchen
festzustellen, ob der Host wirklich DOWN ist oder UNREACHABLE. Die
Unterscheidung zwischen den Host-Zuständen DOWN und UNREACHABLE ist
wichtig, weil es Admins erlaubt, die Grundursache von Netzwerkausfällen
schneller zu ermitteln. Die folgende Tabelle zeigt, wie Icinga eine
endgültige Zustandsermittlung basierend auf dem Zustand der Eltern des
Hosts durchführt. Die Eltern eines Hosts werden in der
*parents*-Direktive der Host-Definition festgelegt.

**vorläufiger Host-Zustand**

**Zustand Host-Eltern**

**endgültiger Host-Zustand**

DOWN

mindestens ein Elternteil ist UP

DOWN

DOWN

alle Eltern sind entweder DOWN oder UNREACHABLE

UNREACHABLE

Mehr Informationen, wie Icinga zwischen DOWN- und UNREACHABLE-Zuständen
unterscheidet, finden Sie
[hier](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts").

### 5.4.8. Host-Statusänderungen

Wie Ihnen wahrscheinlich bereits bewusst ist, bleiben Hosts nicht immer
in einem Zustand. Dinge gehen kaputt, Patches werden eingespielt und
Server müssen neu gestartet werden. Wenn Icinga den Status von Hosts
prüft, ist es in der Lage festzustellen, wenn ein Host zwischen UP-,
DOWN- und UNREACHABLE-Zuständen wechselt und geeignete Maßnahmen
ergreifen. Diese Zustandsänderungen resultieren in verschiedenen
[Statustypen](statetypes.md "5.8. Statustypen") (HARD oder SOFT), was
zum Auslösen von [Eventhandlern](eventhandlers.md "7.3. Eventhandler")
und dem Versenden von
[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")
führen kann. Das Erkennen und Behandeln von Statusänderungen ist das,
worum es sich bei Icinga handelt.

Wenn Host-Statusänderungen zu oft erfolgen, werden sie als "flatternd"
(flapping) angesehen. Ein gutes Beispiel für einen flatternden Host wäre
ein Server, der spontan jedes Mal neu startet, sobald das Betriebssystem
lädt. Das ist immer ein spaßiges Szenario, mit dem man sich befassen
muss. Icinga kann erkennen, wenn Hosts anfangen zu flattern, und kann
Benachrichtigungen unterdrücken, bis das Flattern stoppt und sich der
Host-Status stabilisiert. Mehr Informationen über die Erkennungslogik
des Flatterns finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

* * * * *

  --------------------------------- -------------------------- ------------------------------------------
  [Zurück](macrolist.md)          [Nach oben](ch05.md)      [Weiter](servicechecks.md)
  5.3. Standard-Makros in Icinga    [Zum Anfang](index.md)    5.5. Service-Prüfungen (Service Checks)
  --------------------------------- -------------------------- ------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
