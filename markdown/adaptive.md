Adaptive Überwachung
====================

Einführung
----------

NAME-ICINGA erlaubt Ihnen, verschiedene Befehle und Host- und
Service-Prüfattribute während der Laufzeit zu verändern. Wir bezeichnen
diese Möglichkeit als "adaptive Überwachung". Bitte beachten Sie, dass
diese adaptiven Überwachungs-Features in NAME-ICINGA wahrscheinlich von
99% aller Benutzer nicht genutzt werden, aber sie erlauben Ihnen einige
nette Dinge.

Was kann verändert werden?
--------------------------

Die folgenden Service-Prüfattribute können während der Laufzeit
verändert werden:

-   Prüfbefehl (und Befehlsparameter)

-   Prüfintervall

-   max. Prüfversuche

-   Prüfzeitfenster

-   Eventhandler-Befehl (und Befehlsparameter)

Die folgenden Host-Prüfattribute können während der Laufzeit verändert
werden:

-   Prüfbefehl (und Befehlsparameter)

-   Prüfintervall

-   max. Prüfversuche

-   Prüfzeitfenster

-   Eventhandler-Befehl (und Befehlsparameter)

Die folgenden globalen Attribute können während der Laufzeit verändert
werden:

-   Globaler Host-Eventhandler-Befehl (und Befehlsparameter)

-   Globaler Service-Eventhandler-Befehl (und Befehlsparameter)

Externe Befehle für adaptive Überwachung
----------------------------------------

Um globale oder Host- bzw. Service-spezifische Attribute während der
Laufzeit zu ändern, müssen Sie über das [external command
file](#configmain-command_file) den entsprechenden [externen
Befehl](#extcommands) an NAME-ICINGA senden. Eine vollständige Liste von
externen Befehlen, die zur adaptiven Überwachung benutzt werden können,
finden Sie in der [Liste der externen Befehle"](#extcommands2).

![](../images/note.gif) Anmerkungen:

-   Bei der Änderung von Prüfbefehlen, Prüfzeitfenstern oder
    Eventhandler-Befehlen ist es wichtig anzumerken, dass die neuen
    Werte für diese Optionen vor dem Neustart von NAME-ICINGA definiert
    werden müssen. Jede Anfrage, die einen Befehl oder ein Zeitfenster
    auf einen Wert ändert, der beim Start nicht definiert war, wird
    ignoriert.

-   Sie können Befehlsparameter zusammen mit dem tatsächlichen
    Befehlsnamen angeben - trennen Sie einfach die einzelnen Parameter
    vom Befehlsnamen (und voneinander) durch Ausrufezeichen (!). Mehr
    Informationen, wie Parameter in Befehlsdefinitionen während der
    Laufzeit verarbeitet werden, finden Sie in der Dokumentation zu
    [Makros](#macros).

Adaptive Überwachung
Externe Befehle (external commands)
