Host-Prüfungen (Host checks)
============================

Einführung
----------

Die grundlegenden Tätigkeiten von Host-Prüfungen werden hier
beschrieben...

Wann werden Host-Prüfungen durchgeführt?
----------------------------------------

Hosts werden durch den NAME-ICINGA-Daemon geprüft

-   in regelmäßigen Intervallen, wie sie durch die *check\_interval* und
    *retry\_interval*-Optionen in Ihren
    [Host-Definitionen](#objectdefinitions-host) festgelegt sind.

-   nach Bedarf, wenn ein mit dem Host verbundener Service den Status
    wechselt.

-   nach Bedarf als Teil der
    [Host-Verfügbarkeit](#networkreachability)s-Logik.

-   nach Bedarf bei [vorausschauenden
    Host-Abhängigkeitsprüfungen](#dependencychecks).

Regelmäßige Host-Prüfungen sind optional. Wenn Sie die
*check\_interval*-Option in Ihrer Host-Definition auf Null (0) setzen,
wird NAME-ICINGA keine Host-Prüfungen auf planmäßiger Basis durchführen.
Es wird jedoch weiterhin nach Bedarf Prüfungen für den Host durchführen
für andere Teile der Überwachungslogik.

Prüfungen nach Bedarf werden gemacht, wenn ein mit dem Host verbundener
Service den Status wechselt, denn NAME-ICINGA muss wissen, ob auch der
Host den Status gewechselt hat. Services, die den Status wechseln, sind
oft ein Indikator dafür, dass auch der Host den Status gewechselt hat.
Wenn beispielsweise der mit einem Host verbundene HTTP-Service den
Status von CRITICAL auf OK gewechselt hat, kann das bedeuten, dass der
Host gerade einen Reboot beendet hat und nun wieder verfügbar ist.

Host-Prüfungen nach Bedarf werden auch als Teil der
[Host-Erreichbarkeit](#networkreachability) erledigt. NAME-ICINGA ist so
konstruiert, dass Netzwerkausfälle so schnell wie möglich erkannt werden
und zwischen DOWN- und UNREACHABLE-Zuständen unterschieden werden kann.
Das sind sehr unterschiedliche Zustände und es kann dem Admin helfen,
schnell die Ursache für einen Netzwerkausfall zu finden.

Prüfungen nach Bedarf werden auch als Teil der [vorausschauenden
Host-Abhängigkeitsprüfung](#dependencychecks)s-Logik durchgeführt.

zwischengespeicherte Host-Prüfungen (cached host checks)
--------------------------------------------------------

Die Performance von Host-Prüfungen nach Bedarf kann signifikant durch
den Einsatz von "cached checks" erhöht werden, die es NAME-ICINGA
erlauben, auf eine Host-Prüfung zu verzichten, wenn es feststellt, dass
ein relativ frisches Prüfungsergebnis genügt. Mehr Informationen zu
"cached checks" finden Sie [hier](#cachedchecks).

Abhängigkeiten und Prüfungen
----------------------------

Sie können
[Host-Ausführungs-Abhängigkeiten](#objectdefinitions-hostdependency)
definieren, die NAME-ICINGA von der Statusprüfung eines Hosts abhalten
in Abhängigkeit vom Status ein oder mehrerer anderer Hosts. Mehr
Informationen zu Abhängigkeiten finden Sie [hier](#dependencies).

Parallelisierung von Host-Prüfungen
-----------------------------------

Geplante Host-Prüfungen laufen parallel. Wenn NAME-ICINGA eine geplante
Host-Prüfung ausführt, wird es die Host-Prüfung veranlassen und dann zu
anderen Arbeiten zurückkehren (Service-Prüfungen ausführen, etc.). Die
Host-Prüfung läuft in einem Kind-Prozess, der vom
Haupt-NAME-ICINGA-Prozess aufgerufen wird ("fork()ed"). Wenn die
Host-Prüfung beendet ist, wird der Kind-Prozess den
Haupt-NAME-ICINGA-Prozess (seinen Eltern-Prozess) über das Ergebnis
informieren. Der Haupt-NAME-ICINGA-Prozess wird dann das
Prüfungsergebnis behandeln und geeignete Aktionen durchführen
(Eventhandler starten, Benachrichtigungen senden, usw.).

Host-Prüfungen nach Bedarf laufen ebenfalls parallel, falls notwendig.
Wie bereits vorher erwähnt kann NAME-ICINGA auf die eigentliche
Ausführung einer Host-Prüfung nach Bedarf verzichten, wenn es das
gespeicherte Ergebnis einer relativ frischen Host-Prüfung benutzen kann.

Wenn NAME-ICINGA die Ergebnisse von geplanten und nach Bedarf
ausgeführten Host-Prüfungen verarbeitet, kann es (zusätzliche) Prüfungen
anderer Hosts veranlassen. Diese Prüfungen können aus zwei Gründen
veranlasst werden: [vorausschauende
Abhängigkeitsprüfungen](#dependencychecks) und um den Status des Hosts
mit Hilfe von [Netzwerk-Erreichbarkeit](#networkreachability)s-Logik
festzustellen. Die zusätzlichen Prüfungen werden normalerweise parallel
ausgeführt. Allerdings gibt es eine große Ausnahme, der Sie sich bewusst
sein sollten, da sie einen negativen Einfluss auf die Performance haben
kann...

![](../images/note.gif) Hosts, deren *max\_check\_attempts*-Wert auf
**1** gesetzt sind, können schwerwiegende Performance-Probleme
verursachen. Der Grund? Wenn NAME-ICINGA den richtigen Status mit Hilfe
der [Netzwerk-Erreichbarkeit](#networkreachability)s-Logik ermitteln
muss (um zu sehen, ob sie DOWN oder UNREACHABLE sind), muss es
**aufeinanderfolgende** Prüfungen für alle direkten Eltern des Hosts
starten. Um es noch einmal zu wiederholen, diese Prüfungen laufen
*nacheinander* statt parallel, also kann es zu einem
Performance-Einbruch kommen. Aus diesem Grund würden wir empfehlen, dass
Sie immer einen Wert größer als 1 für die
*max\_check\_attempts*-Direktiven in Ihren Host-Definitionen benutzen.

Host-Zustände
-------------

Hosts, die geprüft werden, können in einem von drei unterschiedlichen
Zuständen sein

-   UP

-   DOWN

-   UNREACHABLE

Host-Statusermittlung
---------------------

Host-Prüfungen werden mit Hilfe von [Plugins](#plugins) durchgeführt,
die den Status OK, WARNING, UNKNOWN oder CRITICAL zurückliefern können.
Wie übersetzt NAME-ICINGA diese Return-Codes der Plugins in die
Host-Zustände UP, DOWN oder UNREACHABLE? Wir werden sehen...

Die nachfolgende Tabelle zeigt, wie sich die Return-Codes von Plugins
mit vorläufigen Host-Zuständen decken. Einige Nachbearbeitung (die
später beschrieben wird) ergibt den endgültigen Host-Zustand.

  ------------ ------------------------------------------------------------
  **Plugin-Erg **vorläufiger Host-Zustand**
  ebnis**      

  OK           UP

  WARNING      UP oder DOWN^\*^

  UNKNOWN      DOWN

  CRITICAL     DOWN
  ------------ ------------------------------------------------------------

![](../images/note.gif) Anmerkung: Das Ergebnis WARNING bedeutet
normalerweise, dass der Host UP ist. Trotzdem werden WARNING-Ergebnisse
so interpretiert, dass der Host DOWN ist, wenn die
[use\_aggressive\_host\_checking](#configmain-use_aggressive_host_checking)-Option
aktiviert ist.

Wenn der vorläufige Host-Status DOWN ist, wird NAME-ICINGA versuchen
festzustellen, ob der Host wirklich DOWN ist oder UNREACHABLE. Die
Unterscheidung zwischen den Host-Zuständen DOWN und UNREACHABLE ist
wichtig, weil es Admins erlaubt, die Grundursache von Netzwerkausfällen
schneller zu ermitteln. Die folgende Tabelle zeigt, wie NAME-ICINGA eine
endgültige Zustandsermittlung basierend auf dem Zustand der Eltern des
Hosts durchführt. Die Eltern eines Hosts werden in der
*parents*-Direktive der Host-Definition festgelegt.

  ------------------ ---------------------------------------- ------------
  **vorläufiger      **Zustand Host-Eltern**                  **endgültige
  Host-Zustand**                                              r
                                                              Host-Zustand
                                                              **

  DOWN               mindestens ein Elternteil ist UP         DOWN

  DOWN               alle Eltern sind entweder DOWN oder      UNREACHABLE
                     UNREACHABLE                              
  ------------------ ---------------------------------------- ------------

Mehr Informationen, wie NAME-ICINGA zwischen DOWN- und
UNREACHABLE-Zuständen unterscheidet, finden Sie
[hier](#networkreachability).

Host-Statusänderungen
---------------------

Wie Ihnen wahrscheinlich bereits bewusst ist, bleiben Hosts nicht immer
in einem Zustand. Dinge gehen kaputt, Patches werden eingespielt und
Server müssen neu gestartet werden. Wenn NAME-ICINGA den Status von
Hosts prüft, ist es in der Lage festzustellen, wenn ein Host zwischen
UP-, DOWN- und UNREACHABLE-Zuständen wechselt und geeignete Maßnahmen
ergreifen. Diese Zustandsänderungen resultieren in verschiedenen
[Statustypen](#statetypes) (HARD oder SOFT), was zum Auslösen von
[Eventhandlern](#eventhandlers) und dem Versenden von
[Benachrichtigungen](#notifications) führen kann. Das Erkennen und
Behandeln von Statusänderungen ist das, worum es sich bei NAME-ICINGA
handelt.

Wenn Host-Statusänderungen zu oft erfolgen, werden sie als "flatternd"
(flapping) angesehen. Ein gutes Beispiel für einen flatternden Host wäre
ein Server, der spontan jedes Mal neu startet, sobald das Betriebssystem
lädt. Das ist immer ein spaßiges Szenario, mit dem man sich befassen
muss. NAME-ICINGA kann erkennen, wenn Hosts anfangen zu flattern, und
kann Benachrichtigungen unterdrücken, bis das Flattern stoppt und sich
der Host-Status stabilisiert. Mehr Informationen über die
Erkennungslogik des Flatterns finden Sie [hier](#flapping).

Host-Prüfungen
