 ![Icinga](../images/logofullsize.png "Icinga") 

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



### 11.1.2. Plugin-Überblick

Scripts und ausführbare Programme müssen (mindestens) zwei Dinge tun, um
als Icinga-Plugins zu funktionieren:



Die inneren Abläufe Ihres Plugins sind für Icinga unwichtig. Ihr Plugin
könnte den Zustand eines TCP-Ports prüfen, eine Datenbankabfrage
durchführen, den freien Plattenplatz ermitteln oder was immer benötigt
wird, um etwas zu prüfen. Die Einzelheiten hängen davon ab, was zu

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



























Mit Blick auf mehrere Zeilen Ausgaben haben Sie die folgenden
Möglichkeiten, Performance-Daten zurückzuliefern:





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


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
