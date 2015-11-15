![Icinga](../images/logofullsize.png "Icinga")

5.8. Statustypen

[Zurück](passivechecks.md) 

Kapitel 5. Die Grundlagen

 [Weiter](timeperiods.md)

* * * * *

5.8. Statustypen
----------------

5.8.1. [Einführung](statetypes.md#introduction)

5.8.2. [Service- und
Host-Prüfungswiederholungen](statetypes.md#checkretries)

5.8.3. [Soft-Zustände](statetypes.md#softretries)

5.8.4. [Hard-Zustände](statetypes.md#hoststates)

5.8.5. [Beispiel](statetypes.md#example)

### 5.8.1. Einführung

Der aktuelle Status von überwachten Services und Host wird durch zwei
Komponenten ermittelt:

-   den Status des Service oder Host (d.h. OK, WARNING, UP, DOWN, etc.)

-   den *Typ* des Zustands, in dem der Service oder Host ist

Es gibt zwei Statustypen in Icinga: SOFT- und HARD-Zustände. Diese
Statustypen sind ein wichtiger Teil der Überwachungslogik, da sie zur
Ermittlung dienen, wann
[Eventhandler](eventhandlers.md "7.3. Eventhandler") ausgeführt und
[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")
zuerst versandt werden.

Dieses Dokument beschreibt den Unterschied zwischen SOFT- und
HARD-Zuständen, wann sie auftreten und was passiert, wenn sie auftreten.

### 5.8.2. Service- und Host-Prüfungswiederholungen

Um falsche Alarme bei vorübergehenden Problemen zu verhindern, erlaubt
Ihnen Icinga zu definieren, wie oft ein Service oder Host (erneut)
geprüft werden soll, bevor es als "echtes" Problem angesehen werden
soll. Dies wird durch die *max\_check\_attempts*-Option in den Host- und
Service-Definitionen kontrolliert. Zu verstehen, wie Hosts und Services
(erneut) geprüft werden, um festzustellen, ob ein echtes Problem
besteht, ist wichtig zum Verstehen, wie Statustypen arbeiten.

### 5.8.3. Soft-Zustände

Soft-Zustände treten in den folgenden Situationen auf...

-   wenn ein Host- oder Service-Prüfungsergebnis in einem nicht-OK oder
    nicht-UP-Status resultiert und die Service-Prüfung noch nicht so oft
    (erneut) durchgeführt wurde, wie es in der
    *max\_check\_attempts*-Direktive der Service- oder Host-Definition
    angegeben wurde. Das wird als Soft-Error bezeichnet.

-   wenn sich ein Service oder Host von einem Soft-Error erholt. Das
    wird als Soft-Recovery angesehen.

Die folgenden Dinge passieren, wenn bei Hosts oder Services
SOFT-Zustandsänderungen auftreten:

-   der SOFT-Status wird protokolliert.

-   Eventhandler werden zur Behandlung von SOFT-Zuständen ausgeführt

SOFT-Zustände werden nur protokolliert, wenn Sie die
[log\_service\_retries](configmain.md#configmain-log_service_retries)-
oder die
[log\_host\_retries](configmain.md#configmain-log_host_retries)-Option
in Ihrer Hauptkonfigurationsdatei aktiviert haben.

Das einzig Wichtige, was bei einem Soft-Zustand passiert, ist die
Ausführung von Eventhandlern. Eventhandler zu benutzen kann insbesondere
dann nützlich sein, wenn Sie versuchen wollen, proaktiv ein Problem zu
lösen, bevor es sich in einen HARD-Zustand verwandelt. Die
[\$HOSTSTATETYPE\$](macrolist.md#macrolist-hoststatetype)- oder
[\$SERVICESTATETYPE\$](macrolist.md#macrolist-servicestatetype)-Makros
werden den Wert "*SOFT*" haben, wenn Eventhandler ausgeführt werden, was
es Ihren Eventhandlern erlaubt zu wissen, wann sie fehlerbehebende
Aktionen vornehmen sollen. Mehr Informationen zu Eventhandlern finden
Sie [hier](eventhandlers.md "7.3. Eventhandler").

### 5.8.4. Hard-Zustände

Hard-Zustände treten für Hosts und Services in den folgenden Situationen
auf...

-   wenn ein Host- oder Service-Prüfungsergebnis in einem nicht-OK oder
    nicht-UP-Status resultiert und die Prüfung bereits so oft (erneut)
    durchgeführt wurde, wie es in der *max\_check\_attempts*-Direktive
    der Service- oder Host-Definition angegeben wurde. Das wird als
    Hard-Error bezeichnet.

-   wenn ein Host oder Service von einem Hard-Error-Zustand in einen
    anderen Fehlerzustand wechselt (z.B. von WARNING nach CRITICAL).

-   wenn eine Service-Prüfung in einem nicht-OK-Status resultiert und
    der zugehörige Host entweder DOWN oder UNREACHABLE ist.

-   wenn ein Host oder Service sich von einem Hard-Error-Zustand erholt.
    Dies wird als Hard-Recovery angesehen.

-   wenn eine [passive
    Host-Prüfung](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
    empfangen wird. Passive Host-Prüfungen werden als HARD angesehen,
    wenn nicht die
    [passive\_host\_checks\_are\_soft](configmain.md#configmain-passive_host_checks_are_soft)-Option
    aktiviert ist.

Die folgenden Dinge passieren, wenn bei Hosts oder Services
HARD-Zustandsänderungen auftreten:

-   der HARD-Status wird protokolliert.

-   Eventhandler werden zur Behandlung von HARD-Zuständen ausgeführt.

-   Kontakte werden über das Host- oder Service-Problem bzw. die
    Erholung informiert.

Die [\$HOSTSTATETYPE\$](macrolist.md#macrolist-hoststatetype) oder
[\$SERVICESTATETYPE\$](macrolist.md#macrolist-servicestatetype)-Makros
werden den Wert "*HARD*" haben, wenn Eventhandler ausgeführt werden, was
es Ihren Eventhandlern erlaubt zu wissen, wann sie fehlerbehebende
Aktionen vornehmen sollen. Mehr Informationen zu Eventhandlern finden
Sie [hier](eventhandlers.md "7.3. Eventhandler").

### 5.8.5. Beispiel

Hier ist ein Beispiel, wie Statustypen ermittelt werden, wenn
Statusänderungen auftreten und wann Eventhandler ausgeführt und
Benachrichtigungen versandt werden. Die nachfolgende Tabelle zeigt
aufeinander folgende Prüfungen eines Service. Der Service hat einen
*max\_check\_attempts*-Wert von 3.

**Zeit**

**Prüfung \#**

**Status**

**Statustyp**

**Statuswechsel**

**Anmerkungen**

0

1

OK

HARD

Nein

Initialer Zustand des Service

1

1

CRITICAL

SOFT

Ja

erstes Erkennen eines nicht-OK-Zustandes. Eventhandler wird ausgeführt.

2

2

WARNING

SOFT

Ja

Service bleibt in einem nicht-OK-Zustand. Eventhandler wird ausgeführt.

3

3

CRITICAL

HARD

Ja

"max\_check\_attempts" wurde erreicht, deshalb geht der Service in einen
HARD-Zustand. Eventhandler wird ausgeführt und eine Benachrichtigung
versandt. Die Check-Anzahl wird auf 1 zurückgesetzt, sofort nachdem dies
passiert.

4

1

WARNING

HARD

Ja

Service wechselt in einen HARD-WARNING-Status. Eventhandler wird
ausgeführt und eine Problembenachrichtigung versandt.

5

1

WARNING

HARD

Nein

Service stabilisiert sich zu einem HARD-Problemzustand. Abhängig vom
Benachrichtigungsintervall für den Service wird ggf. eine weitere
Benachrichtigung verschickt.

6

1

OK

HARD

Ja

Service erfährt eine HARD-Recovery. Eventhandler wird ausgeführt und
eine Erholungs-Benachrichtigung wird versandt.

7

1

OK

HARD

Nein

Service ist weiterhin OK.

8

1

UNKNOWN

SOFT

Ja

Für den Service wird ein Wechsel zu einem SOFT nicht-OK-Zustand
festgestellt. Eventhandler wird ausgeführt.

9

2

OK

SOFT

Ja

Service erfährt eine SOFT-Recovery. Eventhandler wird ausgeführt, aber
keine Benachrichtigung versandt, weil dies kein "echtes" Problem war.
Der Statustyp wird auf HARD gesetzt und die Check-Anzahl auf 1
zurückgesetzt, sofort nachdem dies passiert.

10

1

OK

HARD

Nein

Service stabilisiert sind zu einem OK-Status.

* * * * *

  ------------------------------------------ -------------------------- -----------------------------
  [Zurück](passivechecks.md)               [Nach oben](ch05.md)      [Weiter](timeperiods.md)
  5.7. Passive Prüfungen (Passive Checks)    [Zum Anfang](index.md)    5.9. Zeitfenster
  ------------------------------------------ -------------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
