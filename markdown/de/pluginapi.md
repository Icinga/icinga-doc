![Icinga](../images/logofullsize.png "Icinga")

11.1. Nagios Plugin API

[Zurück](ch11.md) 

Kapitel 11. Entwicklung

 [Weiter](epnplugins.md)

* * * * *

11.1. Nagios Plugin API
-----------------------

11.1.1. [Andere Ressourcen](pluginapi.md#otherresources)

11.1.2. [Plugin-Überblick](pluginapi.md#overview)

11.1.3. [Return-Code](pluginapi.md#returncode)

11.1.4. [Spezifikation der Plugin-Ausgabe(n)](pluginapi.md#outputspec)

11.1.5. [Plugin-Beispielausgaben](pluginapi.md#outputexamples)

11.1.6. [Längenbeschränkungen von
Plugin-Ausgaben](pluginapi.md#outputlengthrestrictions)

11.1.7. [Beispiele](pluginapi.md#examples)

11.1.8. [Perl-Plugins](pluginapi.md#perlplugins)

### 11.1.1. Andere Ressourcen

Wenn Sie planen, Ihren eigenen Plugins für Icinga zu schreiben, dann
besuchen Sie folgende Ressourcen:

-   Die offizielle [Monitoring Plugins
    Projekt-Website](https://www.monitoring-plugins.org)

-   Die offiziellen [Monitoring Plugins
    Entwicklungsrichtlinien](https://www.monitoring-plugins.org/doc/guidelines.md)

### 11.1.2. Plugin-Überblick

Scripts und ausführbare Programme müssen (mindestens) zwei Dinge tun, um
als Icinga-Plugins zu funktionieren:

-   mit einem von verschiedenen möglichen Return-Codes enden

-   mindestens eine Zeile Textausgabe an STDOUT zurückliefern

Die inneren Abläufe Ihres Plugins sind für Icinga unwichtig. Ihr Plugin
könnte den Zustand eines TCP-Ports prüfen, eine Datenbankabfrage
durchführen, den freien Plattenplatz ermitteln oder was immer benötigt
wird, um etwas zu prüfen. Die Einzelheiten hängen davon ab, was zu
prüfen ist - das liegt an Ihnen.

### 11.1.3. Return-Code

Icinga ermittelt den Zustand eines Hosts oder Service über die
Auswertung des Return-Codes des Plugins. Die folgenden Tabellen zeigen
eine Liste von gültigen Return-Codes zusammen mit ihren entsprechenden
Service- oder Host-Zuständen.

**Plugin Return-Code**

**Service-Zustand**

**Host-Zustand**

0

OK

UP

1

WARNING

UP oder DOWN/UNREACHABLE\*

2

CRITICAL

DOWN/UNREACHABLE

3

UNKNOWN

DOWN/UNREACHABLE

![](../images/note.gif) Anmerkung: Wenn die
[use\_aggressive\_host\_checking](configmain.md#configmain-use_aggressive_host_checking)-Option
aktiviert ist, dann ergibt ein Return-Code von 1 einen Host-Zustand
"DOWN" oder "UNREACHABLE". Andernfalls ergibt ein Return-Code von 1
einen Host-Zustand "UP". Der Prozess, durch den Icinga ermittelt, ob ein
Host DOWN oder UNREACHABLE ist, wird
[hier](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")
erklärt.

### 11.1.4. Spezifikation der Plugin-Ausgabe(n)

Als Minimum sollten Plugins mindestens eine Zeile Textausgabe
zurückliefern, es können aber auch mehrere Zeilen Ausgaben sein. Plugins
können zusätzlich Performance-Daten zurückliefern, die von externen
Applikationen verarbeitet werden können. Das grundlegende Format für
Plugin-Ausgaben ist wie folgt:

TEXT OUTPUT | OPTIONAL PERFDATA

LONG TEXT LINE 1

LONG TEXT LINE 2

...

LONG TEXT LINE N | PERFDATA LINE 2

PERFDATA LINE 3

...

PERFDATA LINE N

Die Performance-Daten (in orange dargestellt) sind optional. Wenn ein
Plugin Performance-Daten in der Ausgabe zurückliefert, dann müssen die
Performance-Daten von den anderen Textausgaben mit einem Pipe-Symbol (|)
getrennt werden. Zusätzliche Zeilen von langen Textausgaben (in blau
dargestellt) sind ebenso optional.

### 11.1.5. Plugin-Beispielausgaben

Nun ein paar Beispiele von möglichen Plugin-Ausgaben...

-   **Fall 1: Eine Zeile Ausgabe (nur Text)**

    Angenommen, wir haben ein Plugin, das eine Zeile ausgibt, dann sieht
    das wie folgt aus:

    DISK OK - free space: / 3326 MB (56%); Wenn dieses Plugin benutzt
    wurde, um eine Service-Prüfung durchzuführen, wird die gesamte Zeile
    der Ausgabe im
    [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)-Makro
    gespeichert.

-   **Fall 2: Eine Zeile Ausgabe (Text und Performance-Daten)**

    Ein Plugin kann optionale Performance-Daten zurückliefern, die von
    externen Applikationen benutzt werden. Um dies zu tun, müssen die
    Performance-Daten von der Textausgabe durch ein Pipe-Symbol (|) wie
    folgt getrennt werden:

    DISK OK - free space: / 3326 MB (56%); | /=2643MB;5948;5958;0;5968.
    Wenn dieses Plugin benutzt wurde, um eine Service-Prüfung
    durchzuführen, wird der rote Teil der Ausgabe (links vom
    Pipe-Symbol) im
    [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)-Makro
    und der orange Teil der Ausgabe (rechts vom Pipe-Symbol) im
    [\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)-Makro
    gespeichert.

-   **Fall 3: Mehrere Zeilen Ausgaben (Text und Performance-Daten)**

    Ein Plugin kann optional mehrere Zeilen von Text und
    Performance-Daten wie folgt zurückliefern:

    DISK OK - free space: / 3326 MB (56%);

     | /=2643MB;5948;5958;0;5968

    / 15272 MB (77%);

    /boot 68 MB (69%);

    /home 69357 MB (27%);

    /var/log 819 MB (84%); | /boot=68MB;88;93;0;98

    /home=69357MB;253404;253409;0;253414

    /var/log=818MB;970;975;0;980

    Wenn dieses Plugin benutzt wurde, um eine Service-Prüfung
    durchzuführen, wird der rote Teil der ersten Zeile der Ausgabe
    (links vom Pipe-Symbol) im
    [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)-Makro
    gespeichert. Der orange Teil der ersten und folgender Zeilen wird
    (durch Leerzeichen verbunden) im
    [\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)-Makro
    gespeichert. Der blaue Teil der zweiten bis fünften Zeile der
    Ausgabe wird (mit maskierten Newlines) verkettet und im
    [\$LONGSERVICEOUTPUT\$](macrolist.md#macrolist-longserviceoutput)-Makro
    gespeichert.

    Der endgültige Inhalt jedes Makros ist wie folgt:

    **Makro**

    **Wert**

    \$SERVICEOUTPUT\$

    DISK OK - free space: / 3326 MB (56%);

    \$SERVICEPERFDATA\$

    /=2643MB;5948;5958;0;5968 /boot=68MB;88;93;0;98 /home=69357MB;253404;253409;0;253414 /var/log=818MB;970;975;0;980

    \$LONGSERVICEOUTPUT\$

    / 15272 MB (77%);\\n/boot 68 MB (69%);\\n/var/log 819 MB (84%);

Mit Blick auf mehrere Zeilen Ausgaben haben Sie die folgenden
Möglichkeiten, Performance-Daten zurückzuliefern:

-   Sie können keinerlei Performance-Daten zurückliefern

-   Sie können nur in der ersten Zeile Performance-Daten zurückliefern

-   Sie können Performance-Daten in nachfolgenden Zeilen zurückliefern
    (nach der ersten)

-   Sie können Performance-Daten in der ersten und folgenden Zeilen
    zurückliefern (wie oben gezeigt)

### 11.1.6. Längenbeschränkungen von Plugin-Ausgaben

Icinga wird nur die ersten acht KB an Daten lesen, die ein Plugin
zurückliefert. Dies wird getan, um durchgedrehte Plugins davon
abzuhalten, Megabyte oder Gigabyte an Daten an Icinga zurückzuliefern.
Diese Beschränkung von acht KB kann einfach geändert werden, wenn Sie
das brauchen. Ändern Sie einfach den Wert der
MAX\_PLUGIN\_OUTPUT\_LENGTH-Definition in der
*include/nagios.h.in*-Datei der Source-Code-Distribution und
rekompilieren Sie Icinga. Wenn Sie die Kapazität von acht KB durch
Anpassung dieses Wertes ändern, dann stellen Sie sicht, dass Sie vor dem
Kompilieren auch den Wert von MAX\_EXTERNAL\_COMMAND\_LENGTH in
include/common.h erhöhen, damit Resultate von passiven Prüfungen in
dieser Länge durch das External Command File empfangen werden können.

### 11.1.7. Beispiele

Wenn Sie nach Beispiel-Plugins suchen, um sie zu studieren, würden wir
empfehlen, dass Sie die offiziellen Icinga-Plugins herunterladen und den
Code von verschiedenen C-, Perl- und Shell-Script-Plugins ansehen.
Informationen, wie Sie die offiziellen Plugins besorgen können, finden
Sie [hier](plugins.md "5.1. Icinga Plugins").

### 11.1.8. Perl-Plugins

Icinga bietet einen optionalen [eingebauten
Perl-Interpreter](embeddedperl.md "7.18. Benutzen des Embedded Perl Interpreters")
(embedded Perl interpreter), der die Ausführung von Perl-Plugins
beschleunigen kann. Mehr Informationen zur Entwicklung von Perl-Plugins
zur Nutzung mit dem eingebauten Perl-Interpreter finden Sie
[hier](embeddedperl.md "7.18. Benutzen des Embedded Perl Interpreters").

* * * * *

  -------------------------- -------------------------- -----------------------------------------------------------------
  [Zurück](ch11.md)        [Nach oben](ch11.md)      [Weiter](epnplugins.md)
  Kapitel 11. Entwicklung    [Zum Anfang](index.md)    11.2. Entwickeln von Plugins für die Nutzung mit Embedded Perl
  -------------------------- -------------------------- -----------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
