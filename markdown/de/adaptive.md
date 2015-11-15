![Icinga](../images/logofullsize.png "Icinga")

7.19. Adaptive Überwachung

[Zurück](embeddedperl.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](dependencychecks.md)

* * * * *

7.19. Adaptive Überwachung
--------------------------

7.19.1. [Einführung](adaptive.md#introduction)

7.19.2. [Was kann verändert werden?](adaptive.md#changed)

7.19.3. [Externe Befehle für adaptive
Überwachung](adaptive.md#extcommandsadaptive)

### 7.19.1. Einführung

Icinga erlaubt Ihnen, verschiedene Befehle und Host- und
Service-Prüfattribute während der Laufzeit zu verändern. Wir bezeichnen
diese Möglichkeit als "adaptive Überwachung". Bitte beachten Sie, dass
diese adaptiven Überwachungs-Features in Icinga wahrscheinlich von 99%
aller Benutzer nicht genutzt werden, aber sie erlauben Ihnen einige
nette Dinge.

### 7.19.2. Was kann verändert werden?

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

### 7.19.3. Externe Befehle für adaptive Überwachung

Um globale oder Host- bzw. Service-spezifische Attribute während der
Laufzeit zu ändern, müssen Sie über das [external command
file](configmain.md#configmain-command_file) den entsprechenden
[externen Befehl](extcommands.md "7.1. Externe Befehle") an Icinga
senden. Eine vollständige Liste von externen Befehlen, die zur adaptiven
Überwachung benutzt werden können, finden Sie in der [Liste der externen
Befehle"](extcommands2.md "7.2. Liste der externen Befehle").

![](../images/note.gif) Anmerkungen:

-   Bei der Änderung von Prüfbefehlen, Prüfzeitfenstern oder
    Eventhandler-Befehlen ist es wichtig anzumerken, dass die neuen
    Werte für diese Optionen vor dem Neustart von Icinga definiert
    werden müssen. Jede Anfrage, die einen Befehl oder ein Zeitfenster
    auf einen Wert ändert, der beim Start nicht definiert war, wird
    ignoriert.

-   Sie können Befehlsparameter zusammen mit dem tatsächlichen
    Befehlsnamen angeben - trennen Sie einfach die einzelnen Parameter
    vom Befehlsnamen (und voneinander) durch Ausrufezeichen (!). Mehr
    Informationen, wie Parameter in Befehlsdefinitionen während der
    Laufzeit verarbeitet werden, finden Sie in der Dokumentation zu
    [Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten").

* * * * *

  ------------------------------------------------ -------------------------- -----------------------------------------------
  [Zurück](embeddedperl.md)                      [Nach oben](ch07.md)      [Weiter](dependencychecks.md)
  7.18. Benutzen des Embedded Perl Interpreters    [Zum Anfang](index.md)    7.20. Vorausschauende Abhängigkeitsprüfungen
  ------------------------------------------------ -------------------------- -----------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
