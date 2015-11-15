![Icinga](../images/logofullsize.png "Icinga")

3.4. Objektdefinitionen

[Zurück](configobject.md) 

Kapitel 3. Icinga konfigurieren

 [Weiter](customobjectvars.md)

* * * * *

3.4. Objektdefinitionen
-----------------------

3.4.1. [Host-Definition](objectdefinitions.md#host)

3.4.2. [Hostgruppen-Definition](objectdefinitions.md#hostgroup)

3.4.3. [Service-Definition](objectdefinitions.md#service)

3.4.4. [Servicegruppen-Definition](objectdefinitions.md#servicegroup)

3.4.5. [Kontakt-Definition](objectdefinitions.md#contact)

3.4.6. [Kontaktgruppen-Definition](objectdefinitions.md#contactgroup)

3.4.7. [Zeitfenster-Definition
(timeperiod)](objectdefinitions.md#timeperiod)

3.4.8. [Befehls-Definition (command)](objectdefinitions.md#command)

3.4.9. [Service-Abhängigkeits-Definition
(servicedependency)](objectdefinitions.md#servicedepdency)

3.4.10.
[Serviceeskalations-Definition](objectdefinitions.md#serviceescalation)

3.4.11. [Host-Abhängigkeits-Definition
(hostdependency)](objectdefinitions.md#hostdependency)

3.4.12.
[Host-Eskalations-Definition](objectdefinitions.md#hostescalation)

3.4.13. [erweiterte Hostinformations-Definition
(hostextinfo)](objectdefinitions.md#hostextinfo)

3.4.14. [erweiterte Serviceinformations-Definition
(serviceextinfo)](objectdefinitions.md#serviceextinfo)

3.4.15. [Module-Definition](objectdefinitions.md#module)

**Einführung**

Eine der Möglichkeiten des Objektkonfigurationsformats von Icinga
besteht darin, dass Sie Objektkonfigurationsdefinitionen erstellen
können, die Eigenschaften von anderen Objektdefinitionen erben. Eine
Erklärung, wie Objektvererbung funktioniert, finden Sie
[hier](objectinheritance.md "7.26. Objektvererbung"). Wir empfehlen
Ihnen dringend, dass Sie sich mit Objektvererbung beschäftigen, nachdem
Sie die folgende Dokumentation überflogen haben, weil sie Ihnen die
Arbeit bei der Erstellung und Wartung der Objektdefinitionen viel
einfacher macht. Lesen Sie außerdem die
[Objekt-Tricks](objecttricks.md "7.27. Zeitsparende Tricks für Objektdefinitionen"),
die Ihnen Abkürzungsmöglichkeiten für andernfalls langwierige
Konfigurationsaufgaben bieten.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie Konfigurationsdateien anlegen und/oder editieren, dann behalten
Sie das Folgende im Hinterkopf:

1.  Zeilen, die mit einem '\#'-Zeichen beginnen, werden als Kommentare
    angesehen und nicht verarbeitet

2.  Direktivennamen sind "case-sensitive", die Beachtung von Groß- und
    Kleinschreibung ist wichtig!

3.  Zeichen nach einem Semikolon (;) in Konfigurationszeilen werden als
    Kommentar angesehen und deshalb nicht verarbeitet

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte vermeiden Sie die Verwendung von Sonderzeichen in den
Objektdefinitionen.

**Anmerkungen zur Aufbewahrung** (Retention Notes)

Es ist wichtig anzumerken, dass einige Direktiven in Host-, Service- und
Kontaktdefinitionen möglicherweise keine Wirkung zeigen, wenn Sie diese
in den Konfigurationsdateien ändern. Objektdirektiven, die dieses
Verhalten zeigen, sind mit einem Stern gekennzeichnet
([\*](objectdefinitions.md#objectdefinitions-retention_notes)). Der
Grund für dieses Verhalten liegt darin, dass Icinga Werte in der
[Statusaufbewahrungsdatei](configmain.md#configmain-state_retention_file)
denen aus den Konfigurationsdateien vorzieht, wenn Sie
[Statusaufbewahrung](configmain.md#configmain-retain_state_information)
auf programmweiter Basis aktiviert haben *und* den Wert der Direktive
während der Laufzeit mit einem [externen
Befehl](configmain.md#configmain-check_external_commands) geändert
haben.

Ein Weg, um dieses Problem zu umgehen, ist das Deaktivieren der
Aufbewahrung von nicht-Statusinformationen mit Hilfe der
*retain\_nonstatus\_information*-Direktive in den Host-, Service- und
Kontaktdefinitionen. Durch das Deaktivieren dieser Direktive wird Icinga
dazu veranlasst, beim (Neu-)Start die initialen Werte für diese
Direktiven aus Ihren Konfigurationsdateien zu nehmen, statt die aus der
Statusaufbewahrungsdatei zu verwenden.

**Beispielkonfigurationsdatei**

![[Anmerkung]](../images/note.png)

Anmerkung

Beispielobjektkonfigurationsdateien werden im
*/usr/local/icinga/etc/*-Verzeichnis installiert, wenn Sie der
[Schnellstart-Anleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
gefolgt sind.

Falls Sie ein Paket installiert haben, dann fehlen die Beispieldateien
möglicherweise. Sie finden den Inhalt
[hier](sample-config.md "13.1. Beispielkonfigurationsdateien und Definitionen")
zum Nachschlagen.

**Objekttypen**

[Host-Definitionen](objectdefinitions.md#objectdefinitions-host)

[Hostgruppen-Definitionen](objectdefinitions.md#objectdefinitions-hostgroup)

[Service-Definitionen](objectdefinitions.md#objectdefinitions-service)

[Servicegruppen-Definitionen](objectdefinitions.md#objectdefinitions-servicegroup)

[Kontakt-Definitionen](objectdefinitions.md#objectdefinitions-contact)

[Kontaktgruppen-Definitionen](objectdefinitions.md#objectdefinitions-contactgroup)

[Zeitfenster-Definitionen](objectdefinitions.md#objectdefinitions-timeperiod)

[Befehlsdefinitionen](objectdefinitions.md#objectdefinitions-command)

[Service-Abhängigkeitsdefinitionen](objectdefinitions.md#objectdefinitions-servicedependency)

[Service-Eskalationsdefinitionen](objectdefinitions.md#objectdefinitions-serviceescalation)

[Host-Abhängigkeitsdefinitionen](objectdefinitions.md#objectdefinitions-hostdependency)

[Host-Eskalationsdefinitionen](objectdefinitions.md#objectdefinitions-hostescalation)

[erweiterte
Host-Informationsdefinitionen](objectdefinitions.md#objectdefinitions-hostextinfo)

[erweiterte
Service-Informationsdefinitionen](objectdefinitions.md#objectdefinitions-serviceextinfo)

### 3.4.1. Host-Definition

![[Anmerkung]](../images/note.png)

Anmerkung

vrml\_image und 3d\_coords sind veraltet seit 1.8 und gehörten zur
entfernten 3d Statusmap.

*Beschreibung:*

Eine Host-Definition wird benutzt, um einen Server, eine Workstation,
ein Gerät usw. zu definieren, die sich in Ihrem Netzwerk befinden.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.
Lesen Sie auf jeden Fall die Anmerkungen zur "address"-, "contacts"- und
"contact\_groups"-Direktive .

define host{

host\_name

host\_name

alias

alias

display\_name

display\_name

address

address

address6

address6

parents

host\_names

hostgroups

hostgroup\_names

check\_command

command\_name

initial\_state

[o,d,u]

max\_check\_attempts

\#

check\_interval

\#

retry\_interval

\#

active\_checks\_enabled

[0/1]

passive\_checks\_enabled

[0/1]

check\_period

timeperiod\_name

obsess\_over\_host

[0/1]

check\_freshness

[0/1]

freshness\_threshold

\#

event\_handler

command\_name

event\_handler\_enabled

[0/1]

low\_flap\_threshold

\#

high\_flap\_threshold

\#

flap\_detection\_enabled

[0/1]

flap\_detection\_options

[o,d,u,n]

failure\_prediction\_enabled

[0/1]

process\_perf\_data

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

contacts

contacts

contact\_groups

contact\_groups

notification\_interval

\#

first\_notification\_delay

\#

notification\_period

timeperiod\_name

notification\_options

[d,u,r,f,s,n]

notifications\_enabled

[0/1]

stalking\_options

[o,d,u,n]

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

statusmap\_image

image\_file

2d\_coords

x\_coord,y\_coord

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define host{
        host_name                       bogus-router
        alias                           Bogus Router #1
        address                         192.168.1.254
        parents                         server-backbone
        check_command                   check-host-alive
        check_interval                  5
        retry_interval                  1
        max_check_attempts              5
        check_period                    24x7
        process_perf_data               0
        retain_nonstatus_information    0
        contact_groups                  router-admins
        notification_interval           30
        notification_period             24x7
        notification_options            d,u,r
        }
~~~~

*Beschreibung der Direktiven:*

**host\_name**:

Diese Direktive wird benutzt, um einen Kurznamen zu definieren, der den
Host identifiziert. Er wird in Hostgruppen- und Service-Definitionen
benutzt, um auf diesen bestimmten Host zu verweisen. Hosts können
mehrere Services haben (die überwacht werden), die mit ihm verbunden
sind.

**alias**:

Diese Direktive wird benutzt, um einen längeren Namen oder eine
Beschreibung zu definieren, der/die den Host identifiziert. Er/sie wird
angeboten, damit Sie den Host einfacher identifizieren können. Bei
korrekter Anwendung wird das
\$HOSTALIAS\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diesen Alias/diese Beschreibung enthalten.

**address**:

Diese Direktive wird benutzt, um die Adresse des Hosts zu definieren.
Normalerweise ist dies die IP-Adresse des Hosts, obwohl es eigentlich
alles sein kann, was Sie wollen (solange es genutzt werden kann, um den
Status des Hosts zu prüfen). Sie können einen vollqualifizierten
Domänennamen (FQDN) statt einer IP-Adresse benutzen, um den Host zu
identifizieren, aber wenn keine DNS-Dienste verfügbar sind, kann dies zu
Problemen führen. Bei korrekter Anwendung wird das
\$HOSTADDRESS\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diese Adresse enthalten. **Anmerkung:** Wenn Sie keine Adress-Direktive
in einer Host-Definition benutzen, wird der Name des Hosts statt der
Adresse benutzt. Trotzdem ein Wort der Warnung: wenn DNS ausfällt,
werden die meisten Ihrer Service-Prüfungen fehlschlagen, weil die
Plugins nicht in der Lage sind, den Host-Namen aufzulösen.

**address6**:

Diese Direktive wird benutzt, um eine zweite Adresse des Hosts zu
definieren. Normalerweise ist dies die IPv6-Adresse des Hosts, obwohl es
eigentlich alles sein kann, was Sie wollen (solange es genutzt werden
kann, um den Status des Hosts zu prüfen). Sie können einen
vollqualifizierten Domänennamen (FQDN) statt einer IP-Adresse benutzen,
um den Host zu identifizieren, aber wenn keine DNS-Dienste verfügbar
sind, kann dies zu Problemen führen. Bei korrekter Anwendung wird das
\$HOSTADDRESS6\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diese Adresse enthalten. **Anmerkung:** Wenn Sie keine Adress6-Direktive
in einer Host-Definition benutzen, wird der Name des Hosts statt der
Adresse benutzt. Trotzdem ein Wort der Warnung: wenn DNS ausfällt,
werden die meisten Ihrer Service-Prüfungen fehlschlagen, weil die
Plugins nicht in der Lage sind, den Host-Namen aufzulösen.

**display\_name**:

Diese Direktive wird benutzt, um einen alternativen Namen zu definieren,
der im Web-Interface für den Host angezeigt wird. Wenn nicht angegeben,
wird statt dessen der Wert der *host\_name*-Direktive benutzt.

**parents**:

Diese Direktive wird benutzt, um eine Komma-separierte Liste von
Kurznamen der "Eltern"-Hosts dieses bestimmten Hosts zu definieren.
Eltern-Hosts sind typischerweise Router, Switches, Firewalls usw. Ein
Router, Switch usw., der am nächsten zum entfernten Host ist, wird als
"Eltern" dieses Hosts angesehen. Lesen Sie weitere Informationen im
Dokument "Festlegen des Zustands und der Erreichbarkeit von
Netzwerk-Hosts", das Sie
[hier](networkreachability.md "5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts")
finden. Wenn dieser Host im gleichen Netzwerksegment wie der
überwachende Host ist (ohne dazwischen liegende Router usw.), wird der
Host als im lokalen Netzwerk befindlich angesehen und hat deshalb keinen
Eltern-Host. Lassen Sie diesen Wert leer, wenn der Host keinen
Eltern-Host hat (d.h. wenn er im gleichen Segment wie der Icinga-Host
ist). Die Reihenfolge, in der Sie Eltern-Hosts angeben, hat keinen
Einfluss darauf, wie Dinge überwacht werden.

**hostgroups**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-hostgroup)
anzugeben, zu dem/denen der Host gehört. Mehrere Hostgruppen werden
durch Kommata von einander getrennt. Diese Direktive kann als
Alternative (oder zusätzlich) zur *members*-Direktive in den
[hostgroup](objectdefinitions.md#objectdefinitions-hostgroup)-Definitionen
genutzt werden.

**check\_command**:

Diese Direktive wird benutzt, um den *Kurznamen* des
[Befehls](objectdefinitions.md#objectdefinitions-command) anzugeben,
mit dem geprüft wird, ob der Host funktioniert oder nicht.
Typischerweise wird dieser Befehl versuchen, den Host per "ping" zu
prüfen, ob er "lebt". Der Befehl muss den Status OK (0) zurückliefern,
denn sonst wird Icinga annehmen, dass der Host "down" ist. Wenn Sie
diesen Wert leer lassen, wird der Host *nicht* aktiv geprüft. Dadurch
wird Icinga höchstwahrscheinlich annehmen, dass der Host "up" ist (und
ihn ggf. als "PENDING" im Web-Interface anzeigen). Das ist nützlich,
wenn Sie Drucker oder andere Geräte überwachen, die regelmäßig
ausgeschaltet werden. Die maximale Zeit, die der Prüfbefehl laufen darf,
wird durch die
[host\_check\_timeout](configmain.md#configmain-host_check_timeout)-Option
kontrolliert.

**initial\_state**:

Als Default nimmt Icinga an, dass sich alle Hosts im UP-Zustand
befinden, wenn es startet. Sie können mit dieser Direktive den initialen
Zustand eines Hosts übersteuern. Gültige Optionen sind: **o** = UP,
**d** = DOWN und **u** = UNREACHABLE. Default: o.

**max\_check\_attempts**:

Diese Direktive wird benutzt, um zu definieren, wie oft Icinga den
Host-Prüfbefehl wiederholt, wenn er einen anderen als einen OK-Zustand
zurückliefert. Bei einem Wert von 1 wird Icinga einen Alarm generieren,
ohne den Host erneut zu prüfen. Anmerkung: wenn Sie den Zustand des
Hosts nicht prüfen wollen, müssen Sie den Wert trotzdem mindestens auf 1
setzen. Lassen Sie die *check\_command*-Option leer, um die Host-Prüfung
zu umgehen.

**check\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten" zwischen
regelmäßig geplanten Prüfungen zu definieren. Solange Sie die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
mit einem Default-Wert von 60 nicht verändert haben, wird diese Zahl
Minuten bedeuten. Mehr Informationen zu diesem Wert finden Sie in der
[check
scheduling](checkscheduling.md "7.23. Service- und Host-Prüfungsplanung")-Dokumentation.
Fließkommazahlen sind erlaubt. Default: 5.

**retry\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten" zu
definieren, die zwischen erneuten Überprüfungen gewartet werden sollen.
Erneute Überprüfungen für den Host werden mit dem Wiederholungsintervall
eingeplant, wenn dieser in einen nicht-UP-Zustand gewechselt ist. Sobald
der Host **max\_check\_attempts**-Mal ohne eine Zustandsänderung geprüft
wurde, wird die Planung zum "normalen" Wert zurückkehren, der durch den
**check\_interval**-Wert angegeben wird. Solange Sie die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
mit einem Default-Wert von 60 nicht verändert haben, wird diese Zahl
Minuten bedeuten. Mehr Informationen zu diesem Wert finden Sie in der
[check
scheduling](checkscheduling.md "7.23. Service- und Host-Prüfungsplanung")-Dokumentation.
Fließkommazahlen sind erlaubt. Default: 1.

**active\_checks\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob aktive Prüfungen
(entweder regelmäßig geplant oder nach Bedarf) für diesen Host aktiviert
sind oder nicht. Werte: 0 = keine aktiven Host-Prüfungen, 1 = aktive
Host-Prüfungen. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[execute\_host\_checks](configmain.md#configmain-execute_host_checks)=0.

**passive\_checks\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob passive Prüfungen für
diesen Host aktiviert sind oder nicht. Werte: 0 = passive Host-Prüfungen
deaktivieren, 1 = passive Host-Prüfungen aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[accept\_passive\_host\_checks](configmain.md#configmain-accept_passive_host_checks)=0.

**check\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem aktive Prüfungen für diesen Host ausgeführt werden.

**obsess\_over\_host \***:

Diese Direktive legt fest, ob Prüfungen für den Host über
[ochp\_command](configmain.md#configmain-ochp_command) "verfolgt"
werden sollen. Default: 1.

**check\_freshness \***:

Diese Direktive wird benutzt, um festzulegen, ob
[Frische-Prüfungen](freshness.md "7.5. Service- und Host-Frische-Prüfungen")
(freshness checks) für diesen Host aktiviert sind oder nicht. Werte: 0 =
Frische-Prüfungen deaktivieren, 1 = Frische-Prüfungen aktivieren.
Default: 0.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_freshness](configmain.md#configmain-check_host_freshness)=0.

**freshness\_threshold**:

Diese Direktive wird benutzt, um den Frische-Schwellwert (freshness
threshold) (in Sekunden) für diesen Host festzulegen. Wenn Sie einen
Wert von Null für diese Direktive setzen, wird Icinga automatisch einen
Frische-Schwellwert festlegen. Default: 0.

**event\_handler**:

Diese Direktive wird benutzt, um den *Kurznamen* des
[Befehls](objectdefinitions.md#objectdefinitions-command) anzugeben,
der jedes Mal ausgeführt werden soll, sobald ein Statuswechsel für den
Host erkannt wird (d.h. er "down" geht oder sich wieder erholt). Lesen
Sie die Dokumentation zu
[Eventhandlern](eventhandlers.md "7.3. Eventhandler") für eine
detailliertere Erklärung, wie Scripte zur Behandlung von Ereignissen
geschrieben werden. Die maximale Zeit, die ein Eventhandler-Befehl
dauern darf, wird durch die
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)-Option
kontrolliert.

**event\_handler\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob der Eventhandler für
diesen Host aktiviert ist oder nicht. Werte: 0 = Host-Eventhandler
deaktivieren, 1 = Host-Eventhandler aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)=0.

**low\_flap\_threshold**:

Diese Direktive wird benutzt, um den unteren
Zustandsänderungsschwellwert zu definieren, der in der Flattererkennung
für diesen Host benutzt wird. Mehr Informationen zur Flattererkennung
finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Wenn Sie diese Direktive auf 0 setzen, wird der programmweite Wert aus
der
[low\_host\_flap\_threshold](configmain.md#configmain-low_host_flap_threshold)-Direktive
benutzt. Default: 0.

**high\_flap\_threshold**:

Diese Direktive wird benutzt, um den oberen Zustandsänderungsschwellwert
zu definieren, der in der Flattererkennung für diesen Host benutzt wird.
Mehr Informationen zur Flattererkennung finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Wenn Sie diese Direktive auf 0 setzen, wird der programmweite Wert aus
der
[high\_host\_flap\_threshold](configmain.md#configmain-high_host_flap_threshold)-Direktive
benutzt. Default: 0.

**flap\_detection\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob Flattererkennung für
diesen Host aktiviert ist. Mehr Informationen zur Flattererkennung
finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Werte: 0 = Host-Flattererkennung deaktivieren, 1 = Host-Flattererkennung
aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_flap\_detection](configmain.md#configmain-enable_flap_detection)=0.

**flap\_detection\_options**:

Diese Direktive wird benutzt, um festzulegen, welche Host-Zustände die
[Flattererkennungslogik](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
für diesen Host benutzen wird. Gültige Optionen sind Kombinationen von
einem oder mehreren folgender Werte: **o** = UP-Zustände, **d** =
DOWN-Zustände, **u** = UNREACHABLE-Zustände. Default: o,d,u.

**failure\_prediction\_enabled**:

Diese Direktive wird benutzt, um festzulegen, ob Fehlervorhersage für
diesen Host aktiviert ist. Werte: 0 = Fehlervorhersage deaktivieren, 1 =
Fehlervorhersage aktivieren. Default: 1.

**process\_perf\_data \***:

Diese Direktive wird benutzt, um festzulegen, ob die Verarbeitung von
Performance-Daten für diesen Host aktiviert ist. Werte: 0 = Verarbeitung
von Performance-Daten deaktiviert, 1 = Verarbeitung von
Performance-Daten aktiviert. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[process\_performance\_data](configmain.md#configmain-process_performance_data)=0.

**retain\_status\_information**:

Diese Direktive wird benutzt, um festzulegen, ob zustandsbezogene
Informationen zu diesem Host über Programmneustarts hinweg aufbewahrt
wird. Das ist nur sinnvoll, wenn Sie Statusaufbewahrung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von Statusinformationen
deaktivieren, 1 = Aufbewahrung von Statusinformationen aktivieren.
Default: 1.

**retain\_nonstatus\_information**:

Diese Direktive wird benutzt, um festzulegen, ob nicht-zustandsbezogene
Informationen zu diesem Host über Programmneustarts hinweg aufbewahrt
wird. Das ist nur sinnvoll, wenn Sie Statusaufbewahrung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von nicht-Statusinformationen
deaktivieren, 1 = Aufbewahrung von nicht-Statusinformationen aktivieren.
Default: 1.

**contacts**:

Dies ist eine Liste der *Kurznamen* der
[Kontakte](objectdefinitions.md#objectdefinitions-contact), die über
Probleme (oder Erholungen) dieses Hosts informiert werden sollen.
Mehrere Kontakte werden jeweils durch ein Komma voneinander getrennt.
Nützlich, wenn Benachrichtigungen nur an ein paar Leute gehen sollen und
Sie dafür keine
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)
definieren wollen. Sie müssen mindestens einen Kontakt oder eine
Kontaktgruppe in jeder Host-Definition angeben, andernfalls wird nie
jemand benachrichtigt.

**contact\_groups**:

Dies ist eine Liste der *Kurznamen* der
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup),
die über Probleme (oder Erholungen) dieses Hosts informiert werden
sollen. Mehrere Kontaktgruppen werden durch ein Komma voneinander
getrennt. Sie müssen mindestens einen Kontakt oder eine Kontaktgruppe in
jeder Host-Definition angeben, andernfalls wird nie jemand
benachrichtigt.

**notification\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten"
anzugeben, die gewartet werden soll, bevor ein Kontakt erneut darüber
informiert werden soll, dass dieser Host *immer noch* "down" oder
unerreichbar ist. Solange Sie nicht die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
auf einen anderen als den Standardwert von 60 verändert haben, bedeutet
diese Zahl Minuten. Wenn Sie diesen Wert auf 0 setzen, wird Icinga die
Kontakte *nicht* erneut über Probleme dieses Hosts informieren - nur
eine Problembenachrichtigung wird versandt. Fließkommazahlen sind
erlaubt. Default: 30.

**first\_notification\_delay**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten"
anzugeben, die gewartet werden soll, bevor die erste
Problembenachrichtigung versandt wird, wenn dieser Host in einen
nicht-UP-Zustand wechselt. Solange Sie nicht die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
auf einen anderen als den Standardwert von 60 verändert haben, bedeutet
diese Zahl Minuten. Wenn Sie diesen Wert auf 0 setzen, wird Icinga
sofort Benachrichtigungen versenden. Fließkommazahlen sind erlaubt.
Default: 0.

**notification\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem Benachrichtigungen zu Ereignissen dieses Hosts an
Kontakte versandt werden. Wenn ein Host zu einer Zeit "down" geht,
unerreichbar wird oder sich wieder erholt, die nicht in diesem
Zeitfenster liegt, werden keine Benachrichtigungen versandt.

**notification\_options**:

Diese Direktive wird benutzt, um festzulegen, wann Benachrichtigungen
für diesen Host versandt werden. Gültige Optionen sind eine Kombination
von einem oder mehreren folgender Werte: **d** = Benachrichtigungen bei
einem DOWN-Zustand versenden, **u** = Benachrichtigungen bei einem
UNREACHABLE-Zustand versenden, **r** = Benachrichtigungen bei Erholungen
(OK-Zustand) versenden, **f** = Benachrichtigungen versenden, wenn der
Host mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört und **s** = Benachrichtigungen versenden, wenn eine
[geplante Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten")
anfängt oder aufhört. Wenn Sie **n** (none) als Option angeben, werden
keine Host-Benachrichtigungen versandt. Wenn Sie keine
Benachrichtigungsoptionen angeben, geht Icinga davon aus, dass Sie
Benachrichtigungen zu allen möglichen Zuständen haben möchten. Beispiel:
wenn Sie **d,r** in diesem Feld angeben, werden Benachrichtigungen nur
dann versandt, wenn der Host in einen DOWN-Zustand geht und sich wieder
von einem DOWN-Zustand erholt. Default: d,u,r,f,s.

**notifications\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob Benachrichtigungen für
diesen Host aktiviert sind oder nicht. Werte: 0 =
Host-Benachrichtigungen deaktivieren, 1 = Host-Benachrichtigungen
aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_notifications](configmain.md#configmain-enable_notifications)=0.

**stalking\_options**:

Diese Direktive legt fest, für welche Host-Zustände "Verfolgung"
(stalking) aktiviert ist. Gültige Optionen sind eine Kombination von
einem oder mehreren folgender Werte: **o** = verfolgen von UP-Zuständen,
**d** = verfolgen von DOWN-Zuständen und **u** = verfolgen von
UNREACHABLE-Zuständen. Mehr Informationen zur Statusverfolgung finden
Sie [hier](stalking.md "7.14. Status Stalking"). Default: o,d,u.

**notes**:

Diese Direktive wird benutzt, um optional einen Text mit Informationen
zu diesem Host anzugeben. Wenn Sie hier Anmerkungen angeben, werden Sie
diese in der [extended information](cgis.md#cgis-extinfo_cgi)-CGI
sehen (wenn Sie Informationen zu dem entsprechenden Host ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL anzugeben, der
verwendet werden kann, um weitere Informationen zu diesem Host zu
liefern. Wenn Sie einen URL angeben, werden Sie ein rotes
Verzeichnis-Icon in den CGIs sehen (wenn Sie Host-Informationen
betrachten), das auf den URL verweist, den Sie hier angeben. Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich sein,
wenn Sie detaillierte Informationen zu diesem Host,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

**action\_url**:

Diese Direktive wird benutzt, um einen optionalen URL anzugeben, der
verwendet werden kann, um weitere Aktionen für diesen Host zu
ermöglichen. Wenn Sie einen URL angeben, werden Sie einen roten "Klecks"
in den CGIs sehen (wenn Sie Host-Informationen betrachten). Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*).

![[Anmerkung]](../images/note.png)

Anmerkung

Es ist möglich, mehrere URLs für action|notes\_url bei Host- und
Service-Objektdefinitionen zu anzugeben. Die Syntax ist wie folgt:

~~~~ {.programlisting}
notes_url|action_url 'ersteURL' 'zweiteURL' 'dritteURL'
~~~~

~~~~ {.programlisting}
notes_url|action_url nureineURL
~~~~

Bitte achten Sie darauf, dass mehrere URLs auch gleichzeitig mehrere
Icon-Bilder bedeuten. Diese sind hartkodiert, so dass z.B.
action|notes.gif zu 1-action|1-notes.gif wird. Stellen Sie sicher, dass
diese vorhanden sind. Die letzte URL kann ohne singlequotes angegeben
werden und wird dann wie eine einzelne URL betrachtet und verweist auf
das normale Icon (action.gif).

**icon\_image**:

Diese Variable wird benutzt, um den Namen eines GIF-, PNG oder
JPG-Images anzugeben, das mit diesem Host verbunden werden soll. Dieses
Bild wird an verschiedenen Stellen in den CGIs angezeigt. Das Bild wird
am besten aussehen, wenn es 40x40 Pixel groß ist. Bilder für Hosts
werden im **logos/**-Unterverzeichnis Ihres HTML-Images-Verzeichnis
gesucht (d.h. */usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

Diese Variable wird benutzt, um eine optionale Zeichenkette anzugeben,
die für den ALT-Tag des Bildes benutzt wird, das durch das
*\<icon\_image\>*-Argument angegeben wurde.

**statusmap\_image**:

Diese Variable wird benutzt, um den Namen eines Bildes anzugeben, das
mit diesem Host im [statusmap](cgis-statusmap_cgi)-CGI verbunden werden
soll. Sie können ein JPG-, PNG- oder GIF-Bild angeben, aber wir würden
zu einem Bild im GD2-Format raten, weil andere Bildformate zu hohen
CPU-Belastungen führen können, wenn die Statusmap generiert wird.
PNG-Bilder können mit Hilfe des **pngtogd2**-Utilitys (das in Thomas
Boutell's [gd library](http://www.boutell.com/gd/) enthalten ist) ins
GD2-Format umgewandelt werden. Die GD2-Bilder werden im
*unkomprimierten* Format erstellt, um die CPU-Belastung zu minimieren,
während das Statusmap-CGI das Netzwerkkartenbild erstellt. Das Bild wird
am besten aussehen, wenn es 40x40 Pixel groß ist. Sie können diese
Option leer lassen, wenn Sie das Statusmap-CGI nicht nutzen. Bilder für
Hosts werden im **logos/**-Unterverzeichnis Ihres
HTML-Images-Verzeichnis gesucht (d.h.
*/usr/local/icinga/share/images/logos*).

**2d\_coords**:

Diese Variable wird benutzt, um Koordinaten anzugeben, wenn der Host im
[statusmap](cgis.md#cgis-statusmap_cgi)-CGI gezeichnet wird.
Koordinaten sollen in positiven Ganzzahlen angegeben werden, weil sie
physischen Pixeln im generierten Bild entsprechen. Der Ursprung (0,0)
für die Zeichnung ist die linke, obere Ecke des Bildes, das sich in die
positive X-Richtung (nach rechts) und in die positive Y-Richtung (nach
unten) erstreckt. Die Größe der Icons ist normalerweise etwa 40x40 Pixel
(Text benötigt etwas mehr Platz). Die Koordinaten, die Sie angeben,
beziehen sich auf die linke, obere Ecke des Icons. Anmerkung: Machen Sie
sich keine Sorgen über die maximalen X- und Y-Koordinaten, die Sie
benutzen können. Das CGI wird automatisch die maximale Größe des zu
erstellenden Bildes aufgrund der größten X- und Y-Koordinaten festlegen,
die Sie angegeben haben.

### 3.4.2. Hostgruppen-Definition

*Beschreibung:*

Eine Hostgruppen-Definition wird benutzt, um einen oder mehrere Hosts zu
gruppieren, um die Konfiguration mit
[Objekt-Tricks](objecttricks.md "7.27. Zeitsparende Tricks für Objektdefinitionen")
zu vereinfachen oder für Anzeigezwecke in den
[CGIs](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define hostgroup{

hostgroup\_name

hostgroup\_name

alias

alias

members

hosts

hostgroup\_members

hostgroups

notes

note\_string

notes\_url

url

action\_url

url

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define hostgroup{
        hostgroup_name          novell-servers
        alias                   Novell Servers
        members                 netware1,netware2,netware3,netware4
        }
~~~~

*Beschreibung der Direktiven:*

**hostgroup\_name**:

Diese Direktive wird benutzt, um einen Kurznamen zu definieren, der die
Hostgruppe identifiziert.

**alias**:

Diese Direktive wird benutzt, um einen längeren Namen oder eine
Beschreibung zu definieren, der die Hostgruppen identifiziert. Er/sie
wird angeboten, damit Sie eine bestimmte Hostgruppe einfacher
identifizieren können.

**members**:

Dies ist eine Liste von *Kurznamen* der
[Hosts](objectdefinitions.md#objectdefinitions-host), die in dieser
Gruppe enthalten sein sollen. Mehrere Hostnamen sollten jeweils durch
Komma von einander getrennt werden. Diese Direktive kann als Alternative
(oder als Zusatz) zu der *hostgroups*-Direktive in den
[Host-Definitionen](objectdefinitions.md#objectdefinitions-host)
verwendet werden.

**hostgroup\_members**:

Diese optionale Direktive kann genutzt werden, um Hosts aus anderen
"sub"-Hostgruppen in diese Hostgruppe aufzunehmen. Geben Sie eine
komma-separierte Liste von Kurznamen anderer Hostgruppen an, deren
Mitglieder in diese Gruppe aufgenommen werden sollen.

**notes**:

Diese Direktive wird benutzt, um optional einen Text mit Informationen
zu dieser Hostgruppe anzugeben. Wenn Sie hier Anmerkungen angeben,
werden Sie diese in der [extended
information](cgis.md#cgis-extinfo_cgi)-CGI sehen (wenn Sie
Informationen zu der entsprechenden Hostgruppe ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL anzugeben, der
verwendet werden kann, um weitere Informationen zu dieser Hostgruppe zu
liefern. Wenn Sie einen URL angeben, werden Sie ein rotes
Verzeichnis-Icon in den CGIs sehen (wenn Sie Hostgruppen-Informationen
betrachten), das auf den URL verweist, den Sie hier angeben. Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich sein,
wenn Sie detaillierte Infomationen zu dieser Hostgruppe,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

**action\_url**:

Diese Direktive wird benutzt, um einen optionalen URL anzugeben, der
verwendet werden kann, um weitere Aktionen für diese Hostgruppe zu
ermöglichen. Wenn Sie einen URL angeben, werden Sie einen roten "Klecks"
in den CGIs sehen (wenn Sie Hostgruppen-Informationen betrachten). Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*).

### 3.4.3. Service-Definition

*Beschreibung:*

Eine Service-Definition wird benutzt, um einen "Service" zu
identifizieren, der auf einem Host läuft. Der Begriff "Service" wird
sehr locker benutzt. Es kann sich um einen realen Service auf einem Host
handeln (POP, SMTP, HTTP, etc.) oder eine andere Art von Metrik, die mit
dem Host verbunden ist (Antwort auf einen Ping, Anzahl der angemeldeten
Benutzer, freier Plattenplatz usw.). Die verschiedenen Parameter einer
Service-Definition sind nachfolgend dargestellt.

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass einige Direktiven ggf. von der Host-Definition
geerbt werden. Details finden Sie unter [implizite
Vererbung](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implizite Vererbung").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.
Lesen Sie auf jeden Fall die Anmerkungen zur "contacts"- und
"contact\_groups"-Direktive.

define service{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

service\_description

service\_description

display\_name

display\_name

servicegroups

servicegroup\_names

is\_volatile

[0|1|2]

check\_command

command\_name

initial\_state

[o,w,u,c]

max\_check\_attempts

\#

check\_interval

\#

retry\_interval

\#

active\_checks\_enabled

[0/1]

passive\_checks\_enabled

[0/1]

check\_period

timeperiod\_name

obsess\_over\_service

[0/1]

check\_freshness

[0/1]

freshness\_threshold

\#

event\_handler

command\_name

event\_handler\_enabled

[0/1]

low\_flap\_threshold

\#

high\_flap\_threshold

\#

flap\_detection\_enabled

[0/1]

flap\_detection\_options

[o,w,c,u,n]

failure\_prediction\_enabled

[0/1]

process\_perf\_data

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

notification\_interval

\#

first\_notification\_delay

\#

notification\_period

timeperiod\_name

notification\_options

[w,u,c,r,f,s,n]

notifications\_enabled

[0/1]

contacts

contacts

contact\_groups

contact\_groups

stalking\_options

[o,w,u,c,n]

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define service{
        host_name               linux-server
        service_description     check-disk-sda1
        check_command           check-disk!/dev/sda1
        max_check_attempts      5
        check_interval          5
        retry_interval          3
        check_period            24x7
        notification_interval   30
        notification_period     24x7
        notification_options    w,c,r
        contact_groups          linux-admins
        }
~~~~

*Beschreibung der Direktiven:*

**host\_name**:

Diese Direktive wird benutzt, um den *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, auf
denen der Service "läuft" bzw. mit dem/denen er verbunden ist. Mehrere
Hosts sind jeweils durch Komma von einander zu trennen.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-hostgroup)
anzugeben, auf der/denen der Service "läuft" bzw. mit der/denen er
verbunden ist. Mehrere Hostgruppen werden durch Kommata von einander
getrennt. Der hostgroup\_name kann anstatt oder zusätzlich zur
host\_name-Direktive benutzt werden.

**service\_description**:

Diese Direktive wird benutzt, um eine Beschreibung des Service zu
definieren, die Leerzeichen, Bindestriche und Doppelpunkte enthalten
kann (Semikolon, Apostroph und Fragezeichen sollten vermieden werden).
Keine zwei Services des gleichen Hosts können die gleiche Beschreibung
haben. Services werden eindeutig durch die *host\_name* und
*service\_description*-Direktiven identifiziert.

**display\_name**:

Diese Direktive wird benutzt, um einen alternativen Namen zu definieren,
der im Web-Interface für diesen Service angezeigt wird. Falls nicht
angegeben, wird der Wert aus der *service\_description*-Direktive
benutzt. Anmerkung: Die CGIs bis einschließlich Icinga 1.0.1 nutzen
diese Option nicht.

**servicegroups**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Servicegruppe(n)](objectdefinitions.md#objectdefinitions-servicegroup)
anzugeben, zu der/denen der Service gehört. Mehrere Servicegruppen
werden durch Kommata von einander getrennt. Diese Direktive kann als
Alternative (oder zusätzlich) zur *members*-Direktive in den
[servicegroup](objectdefinitions.md#objectdefinitions-servicegroup)-Definitionen
genutzt werden.

**is\_volatile**:

Diese Direktive wird benutzt, um zu kennzeichnen, dass der Service
"sprunghaft" (volatile) ist. Services sind normalerweise *nicht*
sprunghaft. Mehr Informationen zu sprunghaften Services und wie sie sich
von normalen Services unterscheiden, finden Sie
[hier](volatileservices.md "7.4. sprunghafte Services"). Werte: 0 =
Service ist nicht sprunghaft, 1 = Service ist sprunghaft, 2 = Service
ist sprunghaft, respektiert aber die Einstellung der Direktive
notification\_interval bei erneuten Benachrichtigungen (Option "2" gibt
es seit Icinga 1.0.2). Default: 0.

**check\_command**:

Diese Direktive wird benutzt, um den *Kurznamen* des
[Befehls](objectdefinitions.md#objectdefinitions-command) anzugeben,
mit dem der Zustand des Service geprüft wird. Die maximale Zeit, die der
Prüfbefehl laufen darf, wird durch die
[service\_check\_timeout](configmain.md#configmain-service_check_timeout)-Option
kontrolliert.

**initial\_state**:

Als Default nimmt Icinga an, dass sich alle Services im OK-Zustand
befinden, wenn es startet. Sie können mit dieser Direktive den initialen
Zustand eines Service übersteuern. Gültige Optionen sind: **o** = OK,
**w** = WARNING, *u* = UNKNOWN und **c** = CRITICAL. Default: o.

**max\_check\_attempts**:

Diese Direktive wird benutzt, um zu definieren, wie oft Icinga den
Service-Prüfbefehl wiederholt, wenn er einen anderen als einen
OK-Zustand zurückliefert. Bei einem Wert von 1 wird Icinga einen Alarm
generieren, ohne den Service erneut zu prüfen.

**check\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten" zwischen
"regulär" geplanten Prüfungen zu definieren. "Reguläre" Prüfungen sind
solche, die stattfinden, wenn sich der Service in einem OK-Zustand
befindet oder wenn sich der Service in einem nicht-OK-Zustand befindet,
aber mehr als **max\_check\_attempts**-mal erneut geprüft wurde. Solange
Sie die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
mit einem Default-Wert von 60 nicht verändert haben, wird diese Zahl
Minuten bedeuten. Mehr Informationen zu diesem Wert finden Sie in der
[check
scheduling](checkscheduling.md "7.23. Service- und Host-Prüfungsplanung")-Dokumentation.
Fließkommazahlen sind erlaubt. Default: 5.

**retry\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten" zu
definieren, die zwischen erneuten Überprüfungen des Service gewartet
werden sollen. Erneute Überprüfungen für Services werden mit dem
Wiederholungsintervall eingeplant, wenn diese in einen nicht-OK-Zustand
gewechselt sind. Sobald der Service **max\_check\_attempts**-Mal ohne
eine Zustandsänderung geprüft wurde, wird die Planung zum "normalen"
Wert zurückkehren, der durch den **check\_interval**-Wert angegeben
wird. Solange Sie die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
mit einem Default-Wert von 60 nicht verändert haben, wird diese Zahl
Minuten bedeuten. Mehr Informationen zu diesem Wert finden Sie in der
[check
scheduling](checkscheduling.md "7.23. Service- und Host-Prüfungsplanung")-Dokumentation.
Fließkommazahlen sind erlaubt. Default: 1.

**active\_checks\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob aktive Prüfungen
(entweder regelmäßig geplant oder nach Bedarf) für diesen Service
aktiviert sind oder nicht. Werte: 0 = keine aktiven Service-Prüfungen, 1
= aktive Service-Prüfungen. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[execute\_service\_checks](configmain.md#configmain-execute_service_checks)=0.

**passive\_checks\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob passive Prüfungen für
diesen Service aktiviert sind oder nicht. Werte: 0 = passive
Service-Prüfungen deaktivieren, 1 = passive Service-Prüfungen
aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)=0.

**check\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem aktive Prüfungen für diesen Service ausgeführt werden.

**obsess\_over\_service \***:

Diese Direktive legt fest, ob Prüfungen für den Service über
[ocsp\_command](configmain.md#configmain-ocsp_command) "verfolgt"
werden sollen. Default: 1.

**check\_freshness \***:

Diese Direktive wird benutzt, um festzulegen, ob
[Frische-Prüfungen](freshness.md "7.5. Service- und Host-Frische-Prüfungen")
(freshness checks) für diesen Service aktiviert sind oder nicht. Werte:
0 = Frische-Prüfungen deaktivieren, 1 = Frische-Prüfungen aktivieren.
Default: 0.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_freshness](configmain.md#configmain-check_service_freshness)=0.

**freshness\_threshold**:

Diese Direktive wird benutzt, um den Frische-Schwellwert (freshness
threshold) (in Sekunden) für diesen Service festzulegen. Wenn Sie einen
Wert von Null für diese Direktive setzen, wird Icinga automatisch einen
Frische-Schwellwert festlegen. Default: 0.

**event\_handler**:

Diese Direktive wird benutzt, um den *Kurznamen* des
[Befehls](objectdefinitions.md#objectdefinitions-command) anzugeben,
der jedes Mal ausgeführt werden soll, sobald ein Statuswechsel für den
Service erkannt wird (d.h. er in einen nicht-OK-Zustand geht oder sich
wieder erholt). Lesen Sie die Dokumentation zu
[Eventhandlern](eventhandlers.md "7.3. Eventhandler") für eine
detailliertere Erklärung, wie Scripte zur Behandlung von Ereignissen
geschrieben werden. Die maximale Zeit, die ein Eventhandler-Befehl
dauern darf, wird durch die
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)-Option
kontrolliert.

**event\_handler\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob der Eventhandler für
diesen Service aktiviert ist oder nicht. Werte: 0 = Service-Eventhandler
deaktivieren, 1 = Service-Eventhandler aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)=0.

**low\_flap\_threshold**:

Diese Direktive wird benutzt, um den unteren
Zustandsänderungsschwellwert zu definieren, der in der Flattererkennung
für diesen Service benutzt wird. Mehr Informationen zur Flattererkennung
finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Wenn Sie diese Direktive auf 0 setzen, wird der programmweite Wert aus
der
[low\_service\_flap\_threshold](configmain.md#configmain-low_service_flap_threshold)-Direktive
benutzt. Default: 0.

**high\_flap\_threshold**:

Diese Direktive wird benutzt, um den oberen Zustandsänderungsschwellwert
zu definieren, der in der Flattererkennung für diesen Service benutzt
wird. Mehr Informationen zur Flattererkennung finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Wenn Sie diese Direktive auf 0 setzen, wird der programmweite Wert aus
der
[high\_service\_flap\_threshold](configmain.md#configmain-high_service_flap_threshold)-Direktive
benutzt. Default: 0.

**flap\_detection\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob Flattererkennung für
diesen Service aktiviert ist. Mehr Informationen zur Flattererkennung
finden Sie
[hier](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").
Werte: 0 = Service-Flattererkennung deaktivieren, 1 =
Service-Flattererkennung aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_flap\_detection](configmain.md#configmain-enable_flap_detection)=0.

**flap\_detection\_options**:

Diese Direktive wird benutzt, um festzulegen, welche Service-Zustände
die
[Flattererkennungslogik](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
für diesen Service benutzen wird. Gültige Optionen sind Kombinationen
von einem oder mehreren folgender Werte: **o** = OK-Zustände, **w** =
WARNING-Zustände, **c** = CRITICAL-Zustände, **u** = UNKNOWN-Zustände.
Default: o,w,u,c.

**failure\_prediction\_enabled**:

Diese Direktive wird benutzt, um festzulegen, ob Fehlervorhersage für
diesen Service aktiviert ist. Werte: 0 = Fehlervorhersage deaktivieren,
1 = Fehlervorhersage aktivieren.

**process\_perf\_data \***:

Diese Direktive wird benutzt, um festzulegen, ob die Verarbeitung von
Performance-Daten für diesen Service aktiviert ist. Werte: 0 =
Verarbeitung von Performance-Daten deaktiviert, 1 = Verarbeitung von
Performance-Daten aktiviert. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[process\_performance\_data](configmain.md#configmain-process_performance_data)=0.

**retain\_status\_information**:

Diese Direktive wird benutzt, um festzulegen, ob zustandsbezogene
Informationen zu diesem Service über Programmneustarts hinweg aufbewahrt
werden. Das ist nur sinnvoll, wenn Sie Statusaufbewahrung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von Statusinformationen
deaktivieren, 1 = Aufbewahrung von Statusinformationen aktivieren.
Default: 1.

**retain\_nonstatus\_information**:

Diese Direktive wird benutzt, um festzulegen, ob nicht-zustandsbezogene
Informationen zu diesem Service über Programmneustarts hinweg aufbewahrt
werden. Das ist nur sinnvoll, wenn Sie Status-Beibehaltung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von nicht-Statusinformationen
deaktivieren, 1 = Aufbewahrung von nicht-Statusinformationen aktivieren.
Default: 1.

**notification\_interval**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten"
anzugeben, die gewartet werden soll, bevor ein Kontakt erneut darüber
informiert werden soll, dass dieser Service *immer noch* in einem
nicht-OK-Zustand ist. Solange Sie nicht die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
auf einen anderen als den Standardwert von 60 verändert haben, bedeutet
diese Zahl Minuten. Wenn Sie diesen Wert auf 0 setzen, wird Icinga die
Kontakte *nicht* erneut über Probleme dieses Service informieren - nur
eine Problembenachrichtigung wird versandt. Fließkommazahlen sind
erlaubt. Default: 30.

**first\_notification\_delay**:

Diese Direktive wird benutzt, um die Anzahl von "Zeiteinheiten"
anzugeben, die gewartet werden soll, bevor die erste
Problembenachrichtigung versandt wird, wenn dieser Service in einen
nicht-OK-Zustand wechselt. Solange Sie nicht die
[interval\_length](configmain.md#configmain-interval_length)-Direktive
auf einen anderen als den Standardwert von 60 verändert haben, bedeutet
diese Zahl Minuten. Wenn Sie diesen Wert auf 0 setzen, wird Icinga
sofort Benachrichtigungen versenden. Fließkommazahlen sind erlaubt.
Default: 0.

**notification\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem Benachrichtigungen zu Ereignissen dieses Service an
Kontakte versandt werden. Zu Zeiten, die nicht in diesem Zeitfenster
liegen, werden keine Benachrichtigungen versandt.

**notification\_options**:

Diese Direktive wird benutzt, um festzulegen, wann Benachrichtigungen
für diesen Service versandt werden. Gültige Optionen sind eine
Kombination von einem oder mehreren folgender Werte: **w** =
Benachrichtigungen bei einem WARNING-Zustand versenden, **u** =
Benachrichtigungen bei einem UNKNOWN-Zustand versenden, **r** =
Benachrichtigungen bei Erholungen (OK-Zustand) versenden, **f** =
Benachrichtigungen versenden, wenn der Service mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört und **s** = Benachrichtigungen versenden, wenn eine
[geplante Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten")
anfängt oder aufhört. Wenn Sie **n** (none) als Option angeben, werden
keine Service-Benachrichtigungen versandt. Wenn Sie keine
Benachrichtigungsoptionen angeben, geht Icinga davon aus, dass Sie
Benachrichtigungen zu allen möglichen Zuständen haben möchten. Beispiel:
wenn Sie **w,r** in diesem Feld angeben, werden Benachrichtigungen nur
dann versandt, wenn der Service in einen WARNING-Zustand geht und sich
wieder von einem WARNING-Zustand erholt. Default: u,w,c,r,f,s.

**notifications\_enabled \***:

Diese Direktive wird benutzt, um festzulegen, ob Benachrichtigungen für
diesen Service aktiviert sind oder nicht. Werte: 0 =
Service-Benachrichtigungen deaktivieren, 1 = Service-Benachrichtigungen
aktivieren. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_notifications](configmain.md#configmain-enable_notifications)=0.

**contacts**:

Dies ist eine Liste der *Kurznamen* der
[Kontakte](objectdefinitions.md#objectdefinitions-contact), die über
Probleme (oder Erholungen) dieses Service informiert werden sollen.
Mehrere Kontakte werden jeweils durch Kommata voneinander getrennt.
Nützlich, wenn Benachrichtigungen nur an ein paar Leute gehen sollen und
Sie dafür keine
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)
definieren wollen. Sie müssen mindestens einen Kontakt oder eine
Kontaktgruppe in jeder Service-Definition angeben, andernfalls wird nie
jemand benachrichtigt.

**contact\_groups**:

Dies ist eine Liste der *Kurznamen* der
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup),
die über Probleme (oder Erholungen) dieses Service informiert werden
sollen. Mehrere Kontaktgruppen werden durch Kommata voneinander
getrennt. Sie müssen mindestens einen Kontakt oder eine Kontaktgruppe in
jeder Service-Definition angeben, andernfalls wird nie jemand
benachrichtigt.

**stalking\_options**:

Diese Direktive legt fest, für welche Service-Zustände "Verfolgung"
(stalking) aktiviert ist. Gültige Optionen sind eine Kombination von
einem oder mehreren folgender Werte: **o** = verfolgen von OK-Zuständen,
**w** = verfolgen von WARNING-Zuständen, **c** = verfolgen von
CRITICAL-Zuständen und **u** = verfolgen von UNKNOWN-Zuständen. Mehr
Informationen zur Statusverfolgung finden Sie
[hier](stalking.md "7.14. Status Stalking"). Default: n.

**notes**:

Diese Direktive wird benutzt, um optional einen Text mit Informationen
zu diesem Service anzugeben. Wenn Sie hier Anmerkungen angeben, werden
Sie diese in der [extended information](cgis.md#cgis-extinfo_cgi)-CGI
sehen (wenn Sie Informationen zu dem entsprechenden Service ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL anzugeben, der
benutzt werden kann, um weitere Informationen zu diesem Service zu
liefern. Wenn Sie einen URL angeben, werden Sie ein rotes
Verzeichnis-Icon in den CGIs sehen (wenn Sie Service-Informationen
betrachten), das auf den URL verweist, den Sie hier angeben. Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich sein,
wenn Sie detaillierte Informationen zu diesem Service,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

**action\_url**:

Diese Direktive wird benutzt, um einen optionalen URL anzugeben, der
benutzt werden kann, um weitere Aktionen für diesen Service zu
ermöglichen. Wenn Sie einen URL angeben, werden Sie einen roten "Klecks"
in den CGIs sehen (wenn Sie Host-Informationen betrachten). Jeder
gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen, wird
der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*).

![[Anmerkung]](../images/note.png)

Anmerkung

Es ist möglich, mehrere URLs für action|notes\_url bei Host- und
Service-Objektdefinitionen anzugeben. Die Syntax ist wie folgt:

~~~~ {.programlisting}
notes_url|action_url 'ersteURL' 'zweiteURL' 'dritteURL'
~~~~

~~~~ {.programlisting}
notes_url|action_url nureineURL
~~~~

Bitte achten Sie darauf, dass mehrere Urls auch gleichzeitig mehrere
Icon-Bilder bedeuten. Diese sind hartkodiert, so dass z.B.
action|notes.gif zu 1-action|1-notes.gif wird. Stellen Sie sicher, dass
diese vorhanden sind. Die letzte URL kann ohne singlequotes angegeben
werden und wird dann wie eine einzelne URL betrachtet und verweist auf
das normale Icon (action.gif).

**icon\_image**:

Diese Variable wird benutzt, um den Namen eines GIF-, PNG oder
JPG-Images anzugeben, das mit diesem Service verbunden werden soll.
Dieses Bild wird an verschiedenen Stellen in den CGIs angezeigt. Das
Bild wird am besten aussehen, wenn es 40x40 Pixel groß ist. Bilder für
Services werden im **logos/**-Unterverzeichnis Ihres
HTML-Images-Verzeichnis gesucht (d.h.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

Diese Variable wird benutzt, um eine optionale Zeichenkette anzugeben,
die für den ALT-Tag des Bildes benutzt wird, das durch das
*\<icon\_image\>*-Argument angegeben wurde.

### 3.4.4. Servicegruppen-Definition

*Beschreibung:*

Eine Servicegruppen-Definition wird benutzt, um einen oder mehrere
Services zu gruppieren, um die Konfiguration mit
[Objekt-Tricks](objecttricks.md "7.27. Zeitsparende Tricks für Objektdefinitionen")
zu vereinfachen oder für Anzeigezwecke in den
[CGIs](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define servicegroup{

servicegroup\_name

servicegroup\_name

alias

alias

members

services

servicegroup\_members

servicegroups

notes

note\_string

notes\_url

url

action\_url

url

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define servicegroup{
        servicegroup_name       dbservices
        alias                   Database Services
        members                 ms1,SQL Server,ms1,SQL Server Agent,ms1,SQL DTC
        }
~~~~

*Beschreibung der Direktiven:*

**servicegroup\_name**:

Diese Direktive wird benutzt, um einen Kurznamen zu definieren, der die
Servicegruppe identifiziert.

**alias**:

Diese Direktive wird benutzt, um einen längeren Namen oder eine
Beschreibung zu definieren, der die Servicegruppen identifiziert. Er/sie
wird angeboten, damit Sie ein bestimmte Servicegruppe einfacher
identifizieren können.

**members**:

Dies ist eine Liste von *Kurznamen* der
[Services](objectdefinitions.md#objectdefinitions-service) (und der
Namen der entsprechenden Hosts), die in dieser Gruppe enthalten sein
sollen. Host- und Service-Namen sollten jeweils durch Komma von einander
getrennt werden. Diese Direktive kann als Alternative (oder als Zusatz)
zu der *servicegroups*-Direktive in den
[Service-Definitionen](objectdefinitions.md#objectdefinitions-service)
verwendet werden. Das Format der member-Direktive ist wie folgt
(beachten Sie, dass ein Host-Name einem Service-Namen/einer
Service-Beschreibung vorangestellt werden muss):

members=\<host1\>,\<service1\>,\<host2\>,\<service2\>,...,\<host*n*\>,\<service*n*\>

Es ist möglich, "\*" als Wildcard für alle Hosts zu benutzen. Bitte
beachten Sie, dass es NICHT möglich ist, Hosts oder Service über ein
vorangestelltes "!" auszuschließen.

**servicegroup\_members**:

Diese optionale Direktive kann genutzt werden, um Services aus anderen
"sub"-Servicegruppen in diese Servicegruppe aufzunehmen. Geben Sie eine
komma-separierte Liste von Kurznamen anderer Servicegruppen an, deren
Mitglieder in diese Gruppe aufgenommen werden sollen.

**notes**:

Diese Direktive wird benutzt, um optional einen Text mit Informationen
zu dieser Servicegruppe anzugeben. Wenn Sie hier Anmerkungen angeben,
werden Sie diese in der [extended
information](cgis.md#cgis-extinfo_cgi)-CGI sehen (wenn Sie
Informationen zu der entsprechenden Servicegruppe ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL anzugeben, der
benutzt werden kann, um weitere Informationen zu dieser Servicegruppe zu
liefern. Wenn Sie einen URL angeben, werden Sie ein rotes
Verzeichnis-Icon in den CGIs sehen (wenn Sie
Servicegruppen-Informationen betrachten), das auf den URL verweist, den
Sie hier angeben. Jeder gültige URL kann benutzt werden. Wenn Sie
relative Pfade benutzen, wird der Basis-Pfad der gleiche sein, der
benutzt wird, um auf die CGIs zuzugreifen (d.h. */cgi-bin/icinga/*).
Dies kann sehr nützlich sein, wenn Sie detaillierte Infomationen zu
dieser Servicegruppe, Notfallkontaktmethoden usw. für anderes
Support-Personal zur Verfügung stellen wollen.

**action\_url**:

Diese Direktive wird benutzt, um einen optionalen URL anzugeben, der
benutzt werden kann, um weitere Aktionen für diese Servicegruppe zu
ermöglichen. Wenn Sie einen URL angeben, werden Sie einen roten "Klecks"
in den CGIs sehen (wenn Sie Servicegruppen-Informationen betrachten).
Jeder gültige URL kann benutzt werden. Wenn Sie relative Pfade benutzen,
wird der Basis-Pfad der gleiche sein, der benutzt wird, um auf die CGIs
zuzugreifen (d.h. */cgi-bin/icinga/*).

### 3.4.5. Kontakt-Definition

*Beschreibung:*

Eine Kontakt-Definition wird benutzt, um jemanden zu identifizieren, der
im Falle eines Problems in Ihrem Netzwerk informiert werden soll. Die
verschiedenen Parameter einer Kontakt-Definition werden nachfolgend
beschrieben.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define contact{

contact\_name

contact\_name

alias

alias

contactgroups

contactgroup\_names

host\_notifications\_enabled

[0/1]

service\_notifications\_enabled

[0/1]

host\_notification\_period

timeperiod\_name

service\_notification\_period

timeperiod\_name

host\_notification\_options

[d,u,r,f,s,n]

service\_notification\_options

[w,u,c,r,f,s,n]

host\_notification\_commands

command\_name

service\_notification\_commands

command\_name

email

email\_address

pager

pager\_number or pager\_email\_gateway

address*x*

additional\_contact\_address

can\_submit\_commands

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define contact{
        contact_name                    jdoe
        alias                           John Doe
        host_notifications_enabled      1
        service_notifications_enabled   1
        service_notification_period     24x7
        host_notification_period        24x7
        service_notification_options    w,u,c,r
        host_notification_options       d,u,r
        service_notification_commands   notify-by-email
        host_notification_commands      host-notify-by-email
        email                           jdoe@localhost.localdomain
        pager                           555-5555@pagergateway.localhost.localdomain
        address1                        xxxxx.xyyy@icq.com
        address2                        555-555-5555
        can_submit_commands             1
        }
~~~~

*Beschreibung der Direktiven:*

**contact\_name**:

Diese Direktive wird benutzt, um einen Kurznamen zu definieren, der den
Kontakt identifiziert. Er wird in
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)-Definitionen
benutzt. Bei korrekter Anwendung wird das
\$CONTACTNAME\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diesen Wert enthalten.

**alias**:

Diese Direktive wird benutzt, um einen längeren Namen oder eine
Beschreibung zu definieren, der/die den Kontakt identifiziert. Bei
korrekter Anwendung wird das
\$CONTACTALIAS\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diesen Alias/diese Beschreibung enthalten. Falls nicht angegeben, wird
der *contact\_name* als Alias verwendet.

**contactgroups**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Kontaktgruppe(n)](objectdefinitions.md#objectdefinitions-contactgroup)
anzugeben, zu dem/denen der Kontakt gehört. Mehrere Kontaktgruppen
werden durch Kommata von einander getrennt. Diese Direktive kann als
Alternative (oder zusätzlich) zur *members*-Direktive in den
[contactgroup](objectdefinitions.md#objectdefinitions-contactgroup)-Definitionen
genutzt werden.

**host\_notifications\_enabled**:

Diese Direktive wird benutzt, um festzulegen, ob der Kontakt
Benachrichtigungen über Host-Probleme und Erholungen bekommt. Werte: 0 =
keine Benachrichtigungen versenden, 1 = Benachrichtigungen versenden.
Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_notifications](configmain.md#configmain-enable_notifications)=0.

**service\_notifications\_enabled**:

Diese Direktive wird benutzt, um festzulegen, ob der Kontakt
Benachrichtigungen über Service-Probleme und Erholungen bekommt. Werte:
0 = keine Benachrichtigungen versenden, 1 = Benachrichtigungen
versenden. Default: 1.

![[Anmerkung]](../images/note.png)

Anmerkung

Der Wert hat keine Auswirkung, wenn
[enable\_notifications](configmain.md#configmain-enable_notifications)=0.

**host\_notification\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem der Kontakt über Host-Probleme oder Erholungen
informiert wird. Sie können dies als "Bereitschafts"-Zeiten dieses
Kontakts für Host-Benachrichtigungen ansehen. Lesen Sie die
Dokumentation zu [Zeitfenstern](timeperiods.md "5.9. Zeitfenster"), um
mehr Informationen darüber zu erhalten, wie diese funktionieren und
welche potenziellen Probleme durch unsachgemäßen Gebrauch entstehen
können.

**service\_notification\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem der Kontakt über Service-Probleme oder Erholungen
informiert wird. Sie können dies als "Bereitschafts"-Zeiten dieses
Kontakts für Service-Benachrichtigungen ansehen. Lesen Sie die
Dokumentation zu [Zeitfenstern](timeperiods.md "5.9. Zeitfenster"), um
mehr Informationen darüber zu erhalten, wie diese funktionieren und
welche potenziellen Probleme durch unsachgemäßen Gebrauch entstehen
können.

**host\_notification\_commands**:

Diese Direktive wird benutzt, um *Kurznamen* von
[Befehlen](objectdefinitions.md#objectdefinitions-command) anzugeben,
die zur Benachrichtigung von Kontakten über *Host*-Probleme oder
Erholungen benutzt werden. Mehrere Benachrichtigungsbefehle sollten
durch Kommata von einander getrennt werden. Alle
Benachrichtigungsbefehle werden ausgeführt, wenn der Kontakt informiert
werden muss. Die maximale Zeit, die der Benachrichtigungsbefehl laufen
darf, wird durch die
[notification\_timeout](configmain.md#configmain-notification_timeout)-Option
kontrolliert.

**host\_notification\_options**:

Diese Direktive wird benutzt, um die Host-Zustände festzulegen, bei
denen Benachrichtigungen an den Kontakt versandt werden. Gültige
Optionen sind eine Kombination von einem oder mehreren folgender Werte:
**d** = Benachrichtigungen bei einem DOWN-Zustand versenden, **u** =
Benachrichtigungen bei einem UNREACHABLE-Zustand versenden, **r** =
Benachrichtigungen bei Erholungen (UP-Zustand) versenden, **f** =
Benachrichtigungen versenden, wenn der Host mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört und **s** = Benachrichtigungen versenden, wenn eine
[geplante Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten")
anfängt oder aufhört. Wenn Sie **n** (none) als Option angeben, werden
keine Host-Benachrichtigungen versandt. Default: **n**.

**service\_notification\_options**:

Diese Direktive wird benutzt, um die Service-Zustände festzulegen, bei
denen Benachrichtigungen an den Kontakt versandt werden. Gültige
Optionen sind eine Kombination von einem oder mehreren folgender Werte:
**w** = Benachrichtigungen bei einem WARNING-Zustand versenden,**c** =
Benachrichtigungen bei einem CRITICAL-Zustand versenden, **u** =
Benachrichtigungen bei einem UNKNOWN-Zustand versenden, **r** =
Benachrichtigungen bei Erholungen (OK-Zustand) versenden, **f** =
Benachrichtigungen versenden, wenn der Service mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört und **s** = Benachrichtigungen versenden, wenn eine
[geplante Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten")
anfängt oder aufhört. Wenn Sie **n** (none) als Option angeben, werden
keine Service-Benachrichtigungen versandt. Default: **n**.

**service\_notification\_commands**:

Diese Direktive wird benutzt, um *Kurznamen* von
[Befehlen](objectdefinitions.md#objectdefinitions-command) anzugeben,
die zur Benachrichtigung von Kontakten über *Service*-Probleme oder
Erholungen benutzt werden. Mehrere Benachrichtigungsbefehle sollten
durch Kommata von einander getrennt werden. Alle
Benachrichtigungsbefehle werden ausgeführt, wenn der Kontakt informiert
werden muss. Die maximale Zeit, die der Benachrichtigungsbefehl laufen
darf, wird durch die
[notification\_timeout](configmain.md#configmain-notification_timeout)-Option
kontrolliert.

**email**:

Diese Direktive wird benutzt, um ein e-Mail-Adresse für den Kontakt zu
definieren. Abhängig von Ihren Benachrichtigungsbefehlen kann sie
benutzt werden, um eine Alarm-Mail an den Kontakt zu versenden. Bei
korrekter Anwendung wird das
\$CONTACTEMAIL\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diesen Wert enthalten.

**pager**:

Diese Direktive wird benutzt, um eine Pager-Nummer für den Kontakt zu
definieren. Sie kann auch eine e-Mail-Adresse eines Pager-Gateways (z.B.
pagejoe@pagenet.com) sein. Abhängig von Ihren Benachrichtigungsbefehlen
kann sie benutzt werden, um eine Alarm-Page an den Kontakt zu versenden.
Bei korrekter Anwendung wird das
\$CONTACTPAGER\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
diesen Wert enthalten.

**addressx**:

Adress-Direktiven werden benutzt, um zusätzliche "Adressen" für den
Kontakt zu definieren. Diese Adressen können alles sein -
Mobiltelefonnummern, Instant-Messaging-Adressen usw. Abhängig von Ihren
Benachrichtigungsbefehlen kann sie benutzt werden, um einen Alarm an den
Kontakt zu versenden. Bis zu sechs Adressen können mit Hilfe dieser
Direktiven definiert werden (*address1* bis *address6*). Das
\$CONTACTADDRESS*x*\$-[Makro](macros.md "5.2. Makros verstehen und wie sie arbeiten")
wird diesen Wert enthalten.

**can\_submit\_commands**:

Diese Direktive wird benutzt, um festzulegen, ob dieser Kontakt über die
CGIs [externe Befehle](extcommands.md "7.1. Externe Befehle") an
Icinga erteilen kann. Werte: 0 = dem Kontakt die Erteilung von Befehlen
verweigern, 1 = dem Kontakt die Erteilung von Befehlen erlauben.

**retain\_status\_information**:

Diese Direktive wird benutzt, um festzulegen, ob zustandsbezogene
Informationen zu diesem Kontakt über Programmneustarts hinweg aufbewahrt
wird. Das ist nur sinnvoll, wenn Sie Statusaufbewahrung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von Statusinformationen
deaktivieren, 1 = Aufbewahrung von Statusinformationen aktivieren.
Default: 1.

**retain\_nonstatus\_information**:

Diese Direktive wird benutzt, um festzulegen, ob nicht-zustandsbezogene
Informationen zu diesem Kontakt über Programmneustarts hinweg aufbewahrt
wird. Das ist nur sinnvoll, wenn Sie Statusaufbewahrung über die
[retain\_state\_information](configmain.md#configmain-retain_state_information)-Direktive
aktiviert haben. Werte: 0 = Aufbewahrung von nicht-Statusinformationen
deaktivieren, 1 = Aufbewahrung von nicht-Statusinformationen aktivieren.
Default: 1.

### 3.4.6. Kontaktgruppen-Definition

*Beschreibung:*

Eine Kontaktgruppen-Definition wird benutzt, um einen oder mehrere
[Kontakte](objectdefinitions.md#objectdefinitions-contact) zu
gruppieren, um
Alarm-/Erholungs-[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")
zu versenden.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define contactgroup{

contactgroup\_name

contactgroup\_name

alias

alias

members

contacts

contactgroup\_members

contactgroups

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define contactgroup{
        contactgroup_name       novell-admins
        alias                   Novell Administrators
        members                 jdoe,rtobert,tzach
        }
~~~~

*Beschreibung der Direktiven:*

**contactgroup\_name**:

Diese Direktive wird benutzt, um einen Kurznamen zu definieren, der die
Kontaktgruppe identifiziert.

**alias**:

Diese Direktive wird benutzt, um einen längeren Namen oder eine
Beschreibung zu definieren, der die Kontaktgruppe identifiziert.

**members**:

Dies ist eine Liste von *Kurznamen* der
[Kontakte](objectdefinitions.md#objectdefinitions-contact), die in
dieser Gruppe enthalten sein sollen. Mehrere Kontaktnamen sollten
jeweils durch Komma von einander getrennt werden. Diese Direktive kann
als Alternative (oder als Zusatz) zu der *contactgroups*-Direktive in
den
[Kontakt-Definitionen](objectdefinitions.md#objectdefinitions-contact)
verwendet werden.

**contactgroup\_members**:

Diese optionale Direktive kann genutzt werden, um Kontakte aus anderen
"sub"-Kontaktgruppen in diese Kontaktgruppe aufzunehmen. Geben Sie eine
komma-separierte Liste von Kurznamen anderer Kontaktgruppen an, deren
Mitglieder in diese Gruppe aufgenommen werden sollen.

### 3.4.7. Zeitfenster-Definition (timeperiod)

*Beschreibung:*

Ein Zeitfenster ist eine Liste von Zeiten an verschiedenen Tagen, die
als "gültige" Zeiten für Benachrichtigungen und Service-Prüfungen
angesehen werden. Es besteht aus Zeitbereichen für jeden Tag der Woche.
Verschiedene Ausnahmen zu den normalen wöchentlichen Zeiten werden
unterstützt, u.a.: bestimmte Wochentage, bestimmte Tage eines Monats,
Tage eines bestimmten Monats und Kalendertage.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define timeperiod{

timeperiod\_name

timeperiod\_name

alias

alias

[weekday]

timeranges

[exception]

timeranges

exclude

[timeperiod1,timeperiod2,...,timeperiodn]

   

}

*Beispiel-Definitionen:*

~~~~ {.screen}
 define timeperiod{
        timeperiod_name         nonworkhours
        alias                   Non-Work Hours
        sunday                  00:00-24:00                     ; jeder Sonntag jeder Woche
        monday                  00:00-09:00,17:00-24:00         ; jeder Montag jeder Woche
        tuesday                 00:00-09:00,17:00-24:00         ; jeder Dienstag jeder Woche
        wednesday               00:00-09:00,17:00-24:00         ; jeder Mittwoch jeder Woche
        thursday                00:00-09:00,17:00-24:00         ; jeder Donnerstag jeder Woche
        friday                  00:00-09:00,17:00-24:00         ; jeder Freitag jeder Woche
        saturday                00:00-24:00                     ; jeder Samstag jeder Woche
        }
 define timeperiod{
        timeperiod_name         misc-single-days
        alias                   Misc Single Days
        1999-01-28              00:00-24:00             ; 28. Januar 1999
        monday 3                00:00-24:00             ; 3. Montag im Monat
        day 2                   00:00-24:00             ; 2. Tag im Monat
        february 10             00:00-24:00             ; 10. Februar im Jahr
        february -1             00:00-24:00             ; letzter Tag im Februar
        friday -2               00:00-24:00             ; vorletzer Freitag im Monat
        thursday -1 november    00:00-24:00             ; letzter Donnerstag im November
        }
 define timeperiod{
        timeperiod_name         misc-date-ranges
        alias                   Misc Date Ranges
        2007-01-01 - 2008-02-01         00:00-24:00             ; 1. Januar 2007 bis zum 1. Februar 2008
        monday 3 - thursday 4           00:00-24:00             ; 3. Montag bis 4. Donnerstag
        day 1 - 15                      00:00-24:00             ; 1. bis 15. Tag
        day 20 - -1                     00:00-24:00             ; 20. Tag bis Monatsende
        july 10 - 15                    00:00-24:00             ; 10. - 15. Juli
        april 10 - may 15               00:00-24:00             ; 10. April bis zum 15. Mai
        tuesday 1 april - friday 2 may  00:00-24:00             ; 1. Dienstag im April
                                                                ; bis zum 2. Freitag im Mai
        }
 define timeperiod{
        timeperiod_name         misc-skip-ranges
        alias                   Misc Skip Ranges
        2007-01-01 - 2008-02-01 / 3             00:00-24:00     ; jeder dritte Tag vom 1. Januar 2008 bis zum 1. Februar 2008
        2008-04-01 / 7                          00:00-24:00     ; jeder 7. Tag ab dem 1. April 2008 (ohne Endedatum)
        monday 3 - thursday 4 / 2               00:00-24:00     ; jeder zweite Tag vom 3. Montag bis zum 4. Donnerstag des Monats
        day 1 - 15 / 5                          00:00-24:00     ; jeder 5. Tag vom 1. bis zum 15. Tag des Monats
        july 10 - 15 / 2                        00:00-24:00     ; jeder zweite Tag vom 10. Juli bis zum 15.Juli
        tuesday 1 april - friday 2 may / 6      00:00-24:00     ; jeder sechste Tag vom 1. Dienstag im April 
                                                                ; bis zum 2. Freitag im Mai
        }
~~~~

*Beschreibung der Direktiven:*

**timeperiod\_name**:

Diese Direktive ist der Kurzname, der benutzt wird, um das Zeitfenster
zu identifizieren.

**alias**:

Diese Direktive ist ein längerer Name oder eine Beschreibung zur
Identifizierung des Zeitfensters.

**[weekday]**:

Die Wochentags-Direktiven ("*sunday*" bis "*saturday*") sind
komma-separierte Listen von Zeitbereichen, die "gültige" Zeiten für
einen bestimmten Tag der Woche sind. Beachten Sie, dass es sieben
verschiedene Tage gibt, für die Sie Zeitbereiche angeben können
("Sunday" bis "Saturday"). Jeder Zeitbereich hat die Form
**HH:MM-HH:MM**, wobei die Stunden in einem 24-Stunden-Format angegeben
werden. Wenn Sie einen kompletten Tag aus dem Zeitfenster ausschließen
wollen, dann geben Sie ihn einfach nicht an.

**[exception]**:

Sie können verschiedene Arten von Ausnahmen zum Standard-Wochentagsplan
angeben. Ausnahmen können eine Reihe von verschiedenen Formen annehmen,
u.a. einzelne Tage eines bestimmten oder jeden Monats, einzelne
Wochentage eines Monats oder einzelner Kalenderdaten. Sie können auch
einen Bereich von Tagen/Daten und sogar bestimmte Intervalle
überspringen, um Funktionalitäten wie "alle drei Tage zwischen diesen
Daten" zu erreichen. Statt alle möglichen von Ausnahmen anzugeben,
zeigen wir Ihnen anhand der o.g. Beispieldefinitionen, was möglich ist.
:-) Wochentage und verschiedene Arten von Ausnahmen haben alle
verschiedene Vorrangebenen, so dass es wichtig ist zu verstehen, wie sie
sich gegenseitig beeinflussen. Mehr Informationen dazu finden Sie in der
Dokumentation zu [Zeitfenstern](timeperiods.md "5.9. Zeitfenster").

**exclude**:

Diese Direktive wird benutzt, um die Kurznamen von anderen Zeitfenstern
abzugeben, deren Zeitbereiche in diesem Zeitfenster ausgeschlossen
werden sollen. Mehrere Zeitfensternamen sind durch Kommata von einander
zu trennen.

### 3.4.8. Befehls-Definition (command)

*Beschreibung:*

Eine Befehls-Definition ist genau das. Sie definiert einen Befehl.
Befehle, die definiert werden können, umfassen u.a. Service-Prüfungen,
Host-Benachrichtigungen und Host-Eventhandler. Befehls-Definitionen
können
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten")
enthalten, aber Sie müssen sicherstellen, dass Sie nur solche Makros
verwenden, die unter den gegebenen Umständen "gültig" sind. Mehr
Informationen dazu, welche Makros verfügbar und wann sie "gültig" sind,
finden Sie
[hier](macros.md "5.2. Makros verstehen und wie sie arbeiten"). Die
verschiedenen Argumente einer Befehls-Definition sehen Sie nachfolgend.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define command{

command\_name

command\_name

command\_line

command\_line

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define command{
        command_name    check_pop
        command_line    /usr/local/icinga/libexec/check_pop -H $HOSTADDRESS$    
        }
~~~~

*Beschreibung der Direktiven:*

**command\_name**:

Diese Direktive ist der Kurzname, der zur Identifizierung des Befehls
benutzt wird. Er wird u.a. in
[Kontakt](objectdefinitions.md#objectdefinitions-contact)-,
[Host](objectdefinitions.md#objectdefinitions-host)- und
[Service](objectdefinitions.md#objectdefinitions-service)-Definitionen
(in notification-, check-, und event handler-Direktiven) verwendet.

**command\_line**:

Diese Direktive wird benutzt, um zu definieren, was wirklich durch
Icinga ausgeführt wird, wenn der Befehl für Service- oder
Host-Prüfungen, Benachrichtigungen oder
[Eventhandler](eventhandlers.md "7.3. Eventhandler") benutzt wird. Vor
der Ausführung der Kommandozeile werden alle gültigen
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten") durch
die entsprechenden Werte ersetzt. Lesen Sie die Dokumentation, um
festzustellen, welche verschiedenen Makros Sie benutzen können. Beachten
Sie, dass die Kommandozeile *nicht* von Anführungszeichen eingeschlossen
wird. Achten Sie auch darauf, dass Sie bei der Übergabe eines
Dollarzeichens (\$) ein weiteres Dollarzeichen zur Maskierung benutzen
müssen (aus bar\$foo muss bar\$\$foo werden).

**ANMERKUNG**: Sie dürfen kein **Semikolon** (;) in der
*command\_line*-Direktive einsetzen, weil alles danach als Kommentar
angesehen wird. Sie können diese Begrenzung umgehen, indem Sie eines der
[**\$USER\$**](macrolist.md#macrolist-user) -Makros in Ihrem [resource
file](configmain.md#configmain-resource_file) mit einem Semikolon
füllen und dann in der *command\_line*-Direktive auf das entsprechende
\$USER\$-Makro verweisen.

Wenn Sie während der Laufzeit Parameter an Befehle übergeben wollen,
können Sie die [**\$ARGn\$**-Makros](macrolist.md#macrolist-arg) in
der *command\_line*-Direktive der Befehlsdefinition benutzen und in den
Objektdefinitions-Direktiven (Host-Prüfbefehl, Service-Eventhandler,
usw.), die auf den Befehl verweisen, einzelne Argumente durch
Ausrufezeichen (!) vom Befehlsnamen (und von einander) trennen. Mehr
Informationen, wie Argumente in Befehlsdefinitionen während der Laufzeit
verarbeitet werden, finden Sie in der Dokumentation zu
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten").

### 3.4.9. Service-Abhängigkeits-Definition (servicedependency)

*Beschreibung:*

Service-Abhängigkeiten sind ein fortgeschrittenes Feature von Icinga,
das es Ihnen erlaubt, Benachrichtungen und aktive Prüfungen von Services
in Abhängigkeit vom Status eines oder mehrerer Services zu unterdrücken.
Service-Abhängigkeiten sind optional und zielen hauptsächlich auf
fortgeschrittene Benutzer mit komplizierten Überwachungsumgebungen. Mehr
Informationen, wie Service-Abhängigkeiten arbeiten (lesen Sie dies!),
finden Sie
[hier](dependencies.md "7.13. Host- und Service-Abhängigkeiten").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.
Trotz allem müssen Sie mindestens ein Kriterium angeben, damit die
Definition von Nutzen ist.

define servicedependency{

dependent\_host\_name

host\_name

dependent\_hostgroup\_name

hostgroup\_name

dependent\_servicegroup\_name

servicegroup\_name

dependent\_service\_description

service\_description

host\_name

host\_name

hostgroup\_name

hostgroup\_name

service\_description

service\_description

inherits\_parent

[0/1]

execution\_failure\_criteria

[o,w,u,c,p,n]

notification\_failure\_criteria

[o,w,u,c,p,n]

dependency\_period

timeperiod\_name

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define servicedependency{
        host_name                       WWW1
        service_description             Apache Web Server
        dependent_host_name             WWW1
        dependent_service_description   Main Web Site
        execution_failure_criteria      n
        notification_failure_criteria   w,u,c
        }
~~~~

*Beschreibung der Direktiven:*

**dependent\_host**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, auf
dem der *abhängige* Service "läuft" oder mit dem er verbunden ist.
Mehrere Hosts werden durch Kommata von einander getrennt. Bleibt die
Direktive leer, so kann dadurch eine ["same
host"-Abhängigkeit](objecttricks.md#objecttricks-same_host_dependency)
erstellt werden.

**dependent\_hostgroup**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-hostgroup)
anzugeben, auf der/denen der *abhängige* Service "läuft" oder mit dem er
verbunden ist. Mehrere Hostgruppen werden durch Kommata von einander
getrennt. Die dependent\_hostgroup-Direktive kann statt der (oder
zusätzlich zur) dependent\_host-Direktive benutzt werden.

**dependent\_servicegroup**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Servicegruppe(n)](objectdefinitions.md#objectdefinitions-servicegroup)
anzugeben, zu der/denen die *abhängigen* Services gehören. Mehrere
Servicegruppen werden durch Kommata voneinander getrennt.

**dependent\_service\_description**:

Diese Direktive wird benutzt, um die *Beschreibung* des *abhängigen*
[Service](objectdefinitions.md#objectdefinitions-service) anzugeben.

**host\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, auf
dem/denen der Service "läuft" oder mit dem/denen er verbunden ist, von
dem "es" *abhängt* (auch als Master-Service bezeichnet). Mehrere Hosts
werden durch Kommata von einander getrennt.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-host)
anzugeben, auf der/denen der Service "läuft" oder mit der/denen er
verbunden ist, von dem "es" *abhängt* (auch als Master-Service
bezeichnet). Mehrere Hostgruppen werden durch Kommata von einander
getrennt. Der hostgroup\_name kann statt oder zusätzlich zur
host\_name-Direktive benutzt werden.

**service\_description**:

Diese Direktive wird benutzt, um die *Beschreibung* des
[Service](objectdefinitions.md#objectdefinitions-service) anzugeben,
von dem "es" *abhängt* (auch als Master-Service bezeichnet).

**inherits\_parent**:

Diese Direktive gibt an, ob die abhängige Definition Abhängigkeiten von
dem Service erbt, von dem sie *abhängt* (auch als Master-Service
bezeichnet). In anderen Worten, wenn der Master-Service von anderen
Services abhängt und eine der Abhängigkeiten fehlschlägt, dann wird auch
diese Abhängigkeit fehlschlagen. Default: 0.

**execution\_failure\_criteria**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann der
abhängige Service *nicht* aktiv geprüft werden soll. Wenn der
Master-Service in einem der Zustände ist, die wir angeben, wird der
*abhängige* Service nicht aktiv geprüft. Gültige Optionen sind eine
Kombination von einem oder mehreren folgender Werte (mehrere Werte
werden durch Kommata von einander getrennt): **o** = fehlschlagen bei
einem OK-Zustand, **w** = fehlschlagen bei einem WARNING-Zustand, **u**
= fehlschlagen bei einem UNKNOWN-Zustand, **c** = fehlschlagen bei einem
CRITICAL-Zustand und **p** = fehlschlagen bei einem PENDING-Zustand
(d.h. der Service wurde bisher noch nie geprüft). Wenn Sie **n** (none)
als Option angeben, wird die Ausführungsabhängigkeit nie fehlschlagen
und die Prüfungen des abhängigen Service werden immer erfolgen (falls
andere Bedingungen das erlauben). Beispiel: wenn Sie **o,c,u** in diesem
Feld angeben, dann wird der *abhängige* Service nicht aktiv geprüft,
wenn der *Master*-Service sich in einem OK-, CRITICAL- oder
UNKNOWN-Zustand befindet.

**notification\_failure\_criteria**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann *keine*
Benachrichtigungen für den abhängigen Service versandt werden sollen.
Wenn der Master-Service in einem der Fehler-Zustände ist, die wir
angeben, werden keine Benachrichtigungen für den *abhängigen* Service an
die Kontakte versandt. Gültige Optionen sind eine Kombination von einem
oder mehreren folgender Werte: **o** = fehlschlagen bei einem
OK-Zustand, **w** = fehlschlagen bei einem WARNING-Zustand, **u** =
fehlschlagen bei einem UNKNOWN-Zustand, **c** = fehlschlagen bei einem
CRITICAL-Zustand und **p** = fehlschlagen bei einem PENDING-Zustand
(d.h. der Service wurde bisher noch nie geprüft). Wenn Sie **n** (none)
als Option angeben, wird die Benachrichtigungsabhängigkeit nie
fehlschlagen und die Benachrichtungen für den abhängigen Service werden
immer erfolgen. Beispiel: wenn Sie **w** in diesem Feld angeben, dann
werden die Benachrichtigungen für den *abhängigen* Service nicht
versandt, wenn der *Master*-Service sich in einem WARNING-Zustand
befindet.

**dependency\_period**:

Diese Direktive wird benutzt, um den Kurznamen eines
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in welchem diese Abhängigkeit gültig ist. Wenn diese
Direktive nicht angegeben wird, ist die Abhängigkeit zu allen Zeiten
gültig.

### 3.4.10. Serviceeskalations-Definition

*Beschreibung:*

Serviceeskalationen sind *komplett optional* und werden benutzt, um
Benachrichtigungen für einen bestimmten Service zu eskalieren. Mehr
Informationen, wie Eskalationen arbeiten, finden Sie
[hier](escalations.md "7.9. Benachrichtigungseskalationen").

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass einige Direktiven ggf. von der Host-Definition
geerbt werden. Details finden Sie unter [implizite
Vererbung](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implizite Vererbung").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define serviceescalation{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

servicegroup\_name

servicegroup\_name

service\_description

service\_description

contacts

contacts

contact\_groups

contactgroup\_name

first\_notification

\#

last\_notification

\#

notification\_interval

\#

escalation\_period

timeperiod\_name

escalation\_options

[w,u,c,r]

escalation\_condition

\<condition\> ( [ & / | ] \<condition\> )\*

first\_warning\_notification

\#

last\_warning\_notification

\#

first\_critical\_notification

\#

last\_critical\_notification

\#

first\_unknown\_notification

\#

last\_unknown\_notification

\#

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define serviceescalation{
        host_name               nt-3
        service_description     Processor Load
        first_notification      4
        last_notification       0
        notification_interval   30
        contact_groups          all-nt-admins,themanagers
        }
~~~~

*Beschreibung der Direktiven:*

**host\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, für
den die
[Service](objectdefinitions.md#objectdefinitions-service)-Eskalation
gilt oder mit dem/denen er verbunden ist.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppen](objectdefinitions.md#objectdefinitions-hostgroup)
anzugeben, für den die
[Service](objectdefinitions.md#objectdefinitions-service)-Eskalation
gilt oder mit der/denen er verbunden ist. Mehrere Hostgruppen werden
durch Kommata von einander getrennt. Der hostgroup\_name kann statt oder
zusätzlich zur host\_name-Direktive benutzt werden.

**servicegroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Servicegruppen](objectdefinitions.md#objectdefinitions-servicegroup)
anzugeben, für den die
[Service](objectdefinitions.md#objectdefinitions-service)-Eskalation
gilt oder mit der/denen er verbunden ist. Mehrere Servicegruppen werden
durch Kommata von einander getrennt. Der servicegroup\_name kann statt
oder zusätzlich zur service\_name-Direktive benutzt werden.

**service\_description**:

Diese Direktive wird benutzt, um die *Beschreibung* des
[Service](objectdefinitions.md#objectdefinitions-service) zu
identifizieren, auf den die Eskalation zutreffen soll.

**first\_notification**:

Diese Direktive ist eine Zahl, die die *erste* Benachrichtigung angibt,
für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert auf 3
setzen, dann wird diese Eskalation nur dann benutzt, wenn der Service
lang genug in einem nicht-OK-Zustand ist, damit eine dritte
Benachrichtigung versandt wird.

**last\_notification**:

Diese Direktive ist eine Zahl, die die *letzte* Benachrichtigung angibt,
für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert auf 5
setzen, dann wird diese Eskalation nicht benutzt, wenn mehr als fünf
Benachrichtigungen für den Service versandt werden. Wenn der Wert auf
Null gesetzt wird, wird dieser Eskalationseintrag immer benutzt
(unabhängig davon, wie viele Benachrichtigungen versandt werden.)

**contacts**:

Dies ist eine Liste von *Kurznamen* der
[Kontakte](objectdefinitions.md#objectdefinitions-contact), die
informiert werden sollen, wenn es Probleme (oder Erholungen) für diesen
Service gibt. Mehrere Kontakte werden durch Kommata von einander
getrennt. Das ist nützlich, wenn Sie Benachrichtigungen nur an ein paar
Leute verschicken wollen und keine
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)
definieren wollen. Sie müssen mindestens einen Kontakt oder eine
Kontaktgruppe in jeder Serviceeskalations-Definition angeben.

**contact\_groups**:

Dies ist eine Liste von *Kurznamen* der
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contact), die
informiert werden sollen, wenn die Service-Benachrichtigung eskaliert.
Mehrere Kontaktgruppen werden durch Kommata von einander getrennt. Sie
müssen mindestens einen Kontakt oder eine Kontaktgruppe in jeder
Serviceeskalations-Definition angeben.

**notification\_interval**:

Diese Direktive wird benutzt, um das Intervall festzulegen, in dem
Benachrichtigungen versandt werden, wenn diese Eskalation gültig ist.
Wenn Sie einen Wert von 0 für dieses Intervall angeben, wird Icinga die
erste Benachrichtigung versenden, wenn diese Eskalation gültig wird,
dann aber verhindern, dass weitere Benachrichtigungen versandt werden.
Benachrichtigungen werden wieder versandt, bis sich der Host erholt.
Dies ist nützlich, wenn Sie nach einer bestimmten Zeit keine weiteren
Benachrichtigungen versenden wollen. Anmerkung: Wenn mehrere
Eskalationseinträge eines Hosts für ein oder mehr
Benachrichtigungsbereiche überlappen, wird das kürzeste
Benachrichtigungsintervall aller Eskalationseinträge benutzt.

**escalation\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem diese Eskalation gültig ist. Wenn diese Direktive
nicht angegeben wird, ist diese Eskalation zu allen Zeiten gültig.

**escalation\_options**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann diese
Service-Eskalation benutzt wird. Diese Eskalation wird nur benutzt, wenn
der Service in einem der Zustände ist, die in dieser Direktive angeben
werden. Wenn diese Direktive nicht in einer Service-Eskalation angegeben
wird, ist die Eskalation für alle Service-Zustände gültig. Gültige
Optionen sind eine Kombination von einem oder mehreren folgender Werte:
**r** = eskalieren bei einem OK-(Erholungs)-Zustand, **w** = eskalieren
bei einem WARNING-Zustand, **u** = eskalieren bei einem UNKNOWN-Zustand,
und **c** = eskalieren bei einem CRITICAL-Zustand. Beispiel: wenn Sie
**w** in diesem Feld angeben, dann wird die Eskalation nur benutzt, wenn
sich der Service in einem WARNING-Zustand befindet. Default: w,u,c,r.

**escalation\_condition**:

Nähere Einzelheiten finden Sie
[hier](escalation_condition.md "7.10. Eskalations-Bedingung").

**first\_warning\_notification**:

Diese Direktive ist eine Zahl, die die *erste* WARNING-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 3 setzen, dann wird diese Eskalation nur dann benutzt, wenn der
Service lang genug in einem nicht-OK-Zustand ist, damit eine dritte
WARNING-Benachrichtigung versandt wird.

**last\_warning\_notification**:

Diese Direktive ist eine Zahl, die die *letzte* WARNING-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 5 setzen, dann wird diese Eskalation nicht benutzt, wenn mehr als
fünf WARNING-Benachrichtigungen für den Service versandt werden. Wenn
der Wert auf Null gesetzt wird, wird dieser Eskalationseintrag immer
benutzt (unabhängig davon, wie viele Benachrichtigungen versandt
werden).

**first\_critical\_notification**:

Diese Direktive ist eine Zahl, die die *erste* CRITICAL-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 3 setzen, dann wird diese Eskalation nur dann benutzt, wenn der
Service lang genug in einem nicht-OK-Zustand ist, damit eine dritte
CRITICAL-Benachrichtigung versandt wird.

**last\_critical\_notification**:

Diese Direktive ist eine Zahl, die die *letzte*
CRITICAL-Benachrichtigung angibt, für die diese Eskalation gilt. Wenn
Sie beispielsweise den Wert auf 5 setzen, dann wird diese Eskalation
nicht benutzt, wenn mehr als fünf CRITICAL-Benachrichtigungen für den
Service versandt werden. Wenn der Wert auf Null gesetzt wird, wird
dieser Eskalationseintrag immer benutzt (unabhängig davon, wie viele
Benachrichtigungen versandt werden).

**first\_unknown\_notification**:

Diese Direktive ist eine Zahl, die die *erste* UNKNOWN-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 3 setzen, dann wird diese Eskalation nur dann benutzt, wenn der
Service lang genug in einem nicht-OK-Zustand ist, damit eine dritte
UNKNOWN-Benachrichtigung versandt wird.

**last\_unknown\_notification**:

Diese Direktive ist eine Zahl, die die *letzte* UNKNOWN-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 5 setzen, dann wird diese Eskalation nicht benutzt, wenn mehr als
fünf UNKNOWN-Benachrichtigungen für den Service versandt werden. Wenn
der Wert auf Null gesetzt wird, wird dieser Eskalationseintrag immer
benutzt (unabhängig davon, wie viele Benachrichtigungen versandt
werden).

### 3.4.11. Host-Abhängigkeits-Definition (hostdependency)

*Beschreibung:*

Host-Abhängigkeiten sind ein fortgeschrittenes Feature von Icinga, das
es Ihnen erlaubt, Benachrichtungen von Hosts in Abhängigkeit vom Status
eines oder mehrerer Hosts zu unterdrücken. Host-Abhängigkeiten sind
optional und zielen hauptsächlich auf fortgeschrittene Benutzer mit
komplizierten Überwachungsumgebungen. Mehr Informationen, wie
Host-Abhängigkeiten arbeiten (lesen Sie dies!), finden Sie
[hier](dependencies.md "7.13. Host- und Service-Abhängigkeiten").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define hostdependency{

dependent\_host\_name

host\_name

dependent\_hostgroup\_name

hostgroup\_name

host\_name

host\_name

hostgroup\_name

hostgroup\_name

inherits\_parent

[0/1]

execution\_failure\_criteria

[o,d,u,p,n]

notification\_failure\_criteria

[o,d,u,p,n]

dependency\_period

timeperiod\_name

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define hostdependency{
        host_name                       WWW1
        dependent_host_name             DBASE1
        notification_failure_criteria   d,u
        }
~~~~

*Beschreibung der Direktiven:*

**dependent\_host\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
*abhängigen*[Hosts](objectdefinitions.md#objectdefinitions-host) zu
identifizieren. Mehrere Hosts werden durch Kommata von einander
getrennt.

**dependent\_hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
*abhängigen*[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-host)
zu identifizieren. Mehrere Hostgruppen werden durch Kommata von einander
getrennt. Der dependent\_hostgroup\_name kann statt oder zusätzlich zur
dependent\_host\_name-Direktive benutzt werden.

**host\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, von
dem "es" *abhängt* (auch als Master-Host bezeichnet). Mehrere Hosts
werden durch Kommata von einander getrennt.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppe(n)](objectdefinitions.md#objectdefinitions-host)
anzugeben, von dem "es" *abhängt* (auch als Master-Host bezeichnet).
Mehrere Hostgruppen werden durch Kommata von einander getrennt. Der
hostgroup\_name kann statt oder zusätzlich zur host\_name-Direktive
benutzt werden.

**inherits\_parent**:

Diese Direktive gibt an, ob die abhängige Definition Abhängigkeiten von
dem Host erbt, von dem sie *abhängt* (auch als Master-Host bezeichnet).
In anderen Worten, wenn der Master-Host von anderen Hosts abhängt und
eine der Abhängigkeiten fehlschlägt, dann wird auch diese Abhängigkeit
fehlschlagen. Default: 0.

**execution\_failure\_criteria**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann der
abhängige Host *nicht* aktiv geprüft werden soll. Wenn der Master-Host
in einem der Zustände ist, die wir angeben, wird der *abhängige* Host
nicht aktiv geprüft. Gültige Optionen sind eine Kombination von einem
oder mehreren folgender Werte (mehrere Werte werden durch Kommata von
einander getrennt): **o** = fehlschlagen bei einem UP-Zustand, **u** =
fehlschlagen bei einem UNREACHABLE-Zustand und **p** = fehlschlagen bei
einem PENDING-Zustand (d.h. der Host wurde bisher noch nie geprüft).
Wenn Sie **n** (none) als Option angeben, wird die
Ausführungsabhängigkeit nie fehlschlagen und die Prüfungen des
abhängigen Host werden immer erfolgen (falls andere Bedingungen das
erlauben). Beispiel: wenn Sie **u,d** in diesem Feld angeben, dann wird
der *abhängige* Host nicht aktiv geprüft, wenn der *Master*-Service sich
in einem UNREACHABLE- oder DOWN-Zustand befindet.

**notification\_failure\_criteria**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann *keine*
Benachrichtigungen für den abhängigen Host versandt werden sollen. Wenn
der Master-Host in einem der Fehler-Zustände ist, die wir angeben,
werden keine Benachrichtigungen für den *abhängigen* Host an die
Kontakte versandt. Gültige Optionen sind eine Kombination von einem oder
mehreren folgender Werte: **o** = fehlschlagen bei einem UP-Zustand,
**d** = fehlschlagen bei einem DOWN-Zustand, **u** = fehlschlagen bei
einem UNREACHABLE-Zustand, und **p** = fehlschlagen bei einem
PENDING-Zustand (d.h. der Host wurde bisher noch nie geprüft). Wenn Sie
**n** (none) als Option angeben, wird die Benachrichtigungsabhängigkeit
nie fehlschlagen und die Benachrichtungen für den abhängigen Host werden
immer erfolgen. Beispiel: wenn Sie **d** in diesem Feld angeben, dann
werden die Benachrichtigungen für den *abhängigen* Host nicht versandt,
wenn der *Master*-Host sich in einem DOWN-Zustand befindet.

**dependency\_period**:

Diese Direktive wird benutzt, um den Kurznamen eines
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in welchem diese Abhängigkeit gültig ist. Wenn diese
Direktive nicht angegeben wird, ist die Abhängigkeit zu allen Zeiten
gültig.

### 3.4.12. Host-Eskalations-Definition

*Beschreibung:*

Host-Eskalationen sind *komplett optional* und werden benutzt, um
Benachrichtigungen für einen bestimmten Host zu eskalieren. Mehr
Informationen, wie Eskalationen arbeiten, finden Sie
[hier](escalations.md "7.9. Benachrichtigungseskalationen").

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass einige Direktiven ggf. von der Host-Definition
geerbt werden. Details finden Sie unter [implizite
Vererbung](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implizite Vererbung").

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define hostescalation{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

contacts

contacts

contact\_groups

contactgroup\_name

first\_notification

\#

last\_notification

\#

notification\_interval

\#

escalation\_period

timeperiod\_name

escalation\_options

[d,u,r]

escalation\_condition

\<condition\> ( [ & / | ] \<condition\> )\*

first\_down\_notification

\#

last\_down\_notification

\#

first\_unreachable\_notification

\#

last\_unreachable\_notification

\#

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define hostescalation{
        host_name               router-34
        first_notification      5
        last_notification       8
        notification_interval   60
        contact_groups          all-router-admins
        }
~~~~

*Beschreibung der Direktiven:*

**host\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) anzugeben, für
den die Eskalation gilt.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppen](objectdefinitions.md#objectdefinitions-host) anzugeben,
für den die Eskalation gilt. Mehrere Hostgruppen werden durch Kommata
von einander getrennt. Wenn diese Direktive benutzt wird, trifft die
Eskalation auf alle Hosts zu, die Mitglied der angegebenen Hostgruppe(n)
sind.

**first\_notification**:

Diese Direktive ist eine Zahl, die die *erste* Benachrichtigung angibt,
für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert auf 3
setzen, dann wird diese Eskalation nur dann benutzt, wenn der Host lang
genug "down" oder unerreichbar ist, damit eine dritte Benachrichtigung
versandt wird.

**last\_notification**:

Diese Direktive ist eine Zahl, die die *letzte* Benachrichtigung angibt,
für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert auf 5
setzen, dann wird diese Eskalation nicht benutzt, wenn mehr als fünf
Benachrichtigungen für den Host versandt werden. Wenn der Wert auf Null
gesetzt wird, wird dieser Eskalationseintrag immer benutzt (unabhängig
davon, wie viele Benachrichtigungen versandt werden.)

**contacts**:

Dies ist eine Liste von *Kurznamen* der
[Kontakte](objectdefinitions.md#objectdefinitions-contact), die
informiert werden sollen, wenn es Probleme (oder Erholungen) für diesen
Host gibt. Mehrere Kontakte werden durch Kommata von einander getrennt.
Das ist nützlich, wenn Sie Benachrichtigungen nur an ein paar Leute
verschicken wollen und keine
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)
definieren wollen. Sie müssen mindestens einen Kontakt oder eine
Kontaktgruppe in jeder Hosteskalations-Definition angeben.

**contact\_groups**:

Dies ist eine Liste von *Kurznamen* der
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contact), die
informiert werden sollen, wenn die Host-Benachrichtigung eskaliert.
Mehrere Kontaktgruppen werden durch Kommata von einander getrennt. Sie
müssen mindestens einen Kontakt oder eine Kontaktgruppe in jeder
Hosteskalations-Definition angeben.

**notification\_interval**:

Diese Direktive wird benutzt, um das Intervall festzulegen, in dem
Benachrichtigungen versandt werden, wenn diese Eskalation gültig ist.
Wenn Sie einen Wert von 0 für dieses Intervall angeben, wird Icinga die
erste Benachrichtigung versenden, wenn diese Eskalation gültig wird,
dann aber verhindern, dass weitere Benachrichtigungen versandt werden.
Benachrichtigungen werden wieder versandt, bis sich der Host erholt.
Dies ist nützlich, wenn Sie nach einer bestimmten Zeit keine weiteren
Benachrichtigungen versenden wollen. Anmerkung: Wenn mehrere
Eskalationseinträge eines Hosts für ein oder mehr
Benachrichtungsbereiche überlappen, wird das kürzeste
Benachrichtigungsintervall aller Eskalationseinträge benutzt.

**escalation\_period**:

Diese Direktive wird benutzt, um den Kurznamen des
[Zeitfensters](objectdefinitions.md#objectdefinitions-timeperiod)
anzugeben, in dem diese Eskalation gültig ist. Wenn diese Direktive
nicht angegeben wird, ist diese Eskalation zu allen Zeiten gültig.

**escalation\_options**:

Diese Direktive wird benutzt, um die Kriterien festzulegen, wann diese
Host-Eskalation benutzt wird. Diese Eskalation wird nur benutzt, wenn
der Host in einem der Zustände ist, die in dieser Direktive angeben
werden. Wenn diese Direktive nicht in einer Host-Eskalation angegeben
wird, ist die Eskalation für alle Host-Zustände gültig. Gültige Optionen
sind eine Kombination von einem oder mehreren folgender Werte: **r** =
eskalieren bei einem UP-(Erholungs)-Zustand, **d** = eskalieren bei
einem DOWN-Zustand und **u** = eskalieren bei einem UNREACHABLE-Zustand.
Beispiel: wenn Sie **d** in diesem Feld angeben, dann wird die
Eskalation nur benutzt, wenn sich der Host in einem DOWN-Zustand
befindet. Default: d,u,r.

**escalation\_condition**:

Nähere Einzelheiten finden Sie
[hier](escalation_condition.md "7.10. Eskalations-Bedingung").

**first\_down\_notification**:

Diese Direktive ist eine Zahl, die die *erste* DOWN-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 3 setzen, dann wird diese Eskalation nur dann benutzt, wenn der Host
lang genug "down" ist, damit eine dritte Benachrichtigung versandt wird.

**last\_down\_notification**:

Diese Direktive ist eine Zahl, die die *letzte* DOWN-Benachrichtigung
angibt, für die diese Eskalation gilt. Wenn Sie beispielsweise den Wert
auf 5 setzen, dann wird diese Eskalation nicht benutzt, wenn mehr als
fünf Benachrichtigungen für den Host versandt werden. Wenn der Wert auf
Null gesetzt wird, wird dieser Eskalationseintrag immer benutzt
(unabhängig davon, wie viele Benachrichtigungen versandt werden).

**first\_unreachable\_notification**:

Diese Direktive ist eine Zahl, die die *erste*
UNREACHABLE-Benachrichtigung angibt, für die diese Eskalation gilt. Wenn
Sie beispielsweise den Wert auf 3 setzen, dann wird diese Eskalation nur
dann benutzt, wenn der Host lang genug unerreichbar ist, damit eine
dritte Benachrichtigung versandt wird.

**last\_unreachable\_notification**:

Diese Direktive ist eine Zahl, die die *letzte*
UNREACHABLE-Benachrichtigung angibt, für die diese Eskalation gilt. Wenn
Sie beispielsweise den Wert auf 5 setzen, dann wird diese Eskalation
nicht benutzt, wenn mehr als fünf Benachrichtigungen für den Host
versandt werden. Wenn der Wert auf Null gesetzt wird, wird dieser
Eskalationseintrag immer benutzt (unabhängig davon, wie viele
Benachrichtigungen versandt werden).

### 3.4.13. erweiterte Hostinformations-Definition (hostextinfo)

*Beschreibung:*

Einträge für erweiterte Hostinformationen sind grundsätzlich dazu
gedacht, die Ausgaben der [status](cgis.md#cgis-status_cgi)-,
[statusmap](cgis.md#cgis-statusmap_cgi)- und
[extinfo](cgis.md#cgis-extinfo_cgi)-CGIs schöner aussehen zu lassen.
Sie haben keinen Einfluss auf die Überwachung und sind vollständig
optional.

![](../images/tip.gif) Hinweis: Alle Direktiven der erweiterten
Hostinformations-Definition sind auch in den
[Host-Definitionen](objectdefinitions.md#objectdefinitions-host)
verfügbar. Dadurch können Sie entscheiden, die nachstehenden Direktiven
in Ihren Host-Definitionen zu benutzen, wenn es Ihre Konfigurationen
vereinfacht. Separate erweiterte Hostinformations-Definitionen werden
weiterhin unterstützt, um Rückwärtskompatibilität zu gewährleisten.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.
Trotz allem müssen Sie mindestens ein Kriterium angeben, damit die
Definition von Nutzen ist.

define hostextinfo{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

statusmap\_image

image\_file

2d\_coords

x\_coord,y\_coord

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define hostextinfo{
        host_name       netware1
        notes           This is the primary Netware file server
        notes_url       http://webserver.localhost.localdomain/hostinfo.pl?host=netware1
        icon_image      novell40.png 
        icon_image_alt  IntranetWare 4.11
        statusmap_image novell40.gd2
        2d_coords       100,250
        3d_coords       100.0,50.0,75.0
        }
~~~~

*Variablenbeschreibungen:*

**host\_name**:

Diese Variable wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) zu
identifizieren, mit dem/denen diese Daten verbunden sind.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppen](objectdefinitions.md#objectdefinitions-host) anzugeben,
für den diese Definition gilt. Mehrere Hostgruppen werden durch Kommata
von einander getrennt. Wenn diese Direktive benutzt wird, trifft die
Definition auf alle Hosts zu, die Mitglied der angegebenen Hostgruppe(n)
sind.

**notes**:

Diese Direktive wird benutzt, um eine optionale Zeichenkette mit
Anmerkungen zu definieren, die den Host betreffen. Wenn Sie hier eine
Anmerkung angeben, werden Sie diese im [extended
Information](cgis.md#cgis-extinfo_cgi)-CGI sehen (wenn Sie
Informationen zu dem bestimmten Host ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL zu definieren, der
mehr Informationen zu diesem Host bereitstellt. Wenn Sie einen URL
angeben, werden Sie im [extended
information](cgis.md#cgis-extinfo_cgi)-CGI einen Link namens "Extra
Host Notes" sehen (wenn Sie Informationen zu dem bestimmten Host
ansehen). Jeder gültige URL kann benutzt werden. Wenn Sie relative Pfade
benutzen, wird der Basis-Pfad der gleiche sein, der benutzt wird, um auf
die CGIs zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich
sein, wenn Sie detaillierte Informationen zu diesem Host,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

**action\_url**:

Diese Variable wird benutzt, um einen optionalen URL zu definieren, der
mehr Aktionen für diesen Host bereitstellt. Wenn Sie einen URL angeben,
werden Sie im [extended information](cgis.md#cgis-extinfo_cgi)-CGI
einen Link namens "Extra Host Notes" sehen (wenn Sie Informationen zu
dem bestimmten Host ansehen). Jeder gültige URL kann benutzt werden.
Wenn Sie relative Pfade benutzen, wird der Basis-Pfad der gleiche sein,
der benutzt wird, um auf die CGIs zuzugreifen (d.h. */cgi-bin/icinga/*).
Dies kann sehr nützlich sein, wenn Sie detaillierte Informationen zu
diesem Host, Notfallkontaktmethoden usw. für anderes Support-Personal
zur Verfügung stellen wollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Es ist möglich, mehrere URLs für action|notes\_url bei Host- und
Service-Objektdefinitionen anzugeben. Die Syntax ist wie folgt:

~~~~ {.programlisting}
notes_url|action_url 'ersteURL' 'zweiteURL' 'dritteURL'
~~~~

~~~~ {.programlisting}
notes_url|action_url nureineURL
~~~~

Bitte achten Sie darauf, dass mehrere URLs auch gleichzeitig mehrere
Icon-Bilder bedeuten. Diese sind hartkodiert, so dass z.B.
action|notes.gif zu 1-action|1-notes.gif wird. Stellen Sie sicher, dass
diese vorhanden sind. Die letzte URL kann ohne singlequotes angegeben
werden und wird dann, wie eine einzelne URL betrachtet und verweist auf
das normale Icon (action.gif).

**icon\_image**:

Diese Variable wird benutzt, um den Namen eines GIF-, PNG- oder
JPG-Images anzugeben, das mit diesem Host verbunden werden soll. Dieses
Bild wird in den [status](cgis.md#cgis-status_cgi)- und [extended
information](cgis.md#cgis-extinfo_cgi)-CGIs angezeigt. Das Bild wird
am besten aussehen, wenn es 40x40 Pixel groß ist. Bilder für Hosts
werden im **logos/**-Unterverzeichnis Ihres HTML-Images-Verzeichnis
gesucht (d.h. */usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

Diese Variable wird benutzt, um eine optionale Zeichenkette anzugeben,
die für den ALT-Tag des Bildes benutzt wird, das durch das
*\<icon\_image\>*-Argument angegeben wurde. Das ALT-Tag wird in den
[status](cgis.md#cgis-status_cgi)-, [extended
information](cgis.md#cgis-extinfo_cgi)- und
[statusmap](cgis.md#cgis-statusmap_cgi)-CGIs benutzt.

**statusmap\_image**:

Diese Variable wird benutzt, um den Namen eines Bildes anzugeben, das
mit diesem Host im [statusmap](cgis-statusmap_cgi)-CGI verbunden werden
soll. Sie können ein JPG-, PNG- oder GIF-Bild angeben, aber wir würden
zu einem Bild im GD2-Format raten, weil andere Bildformate zu hohen
CPU-Belastungen führen können, wenn die Statusmap generiert wird.
PNG-Bilder können mit Hilfe des **pngtogd2**-Utilitys (das in Thomas
Boutell's [gd library](http://www.boutell.com/gd/) enthalten ist) ins
GD2-Format umgewandelt werden. Die GD2-Bilder werden im
*unkomprimierten* Format erstellt, um die CPU-Belastung zu minimieren,
während das Statusmap-CGI das Netzwerkkartenbild erstellt. Das Bild wird
am besten aussehen, wenn es 40x40 Pixel groß ist. Sie können diese
Option leer lassen, wenn Sie das Statusmap-CGI nicht nutzen. Bilder für
Hosts werden im **logos/**-Unterverzeichnis Ihres
HTML-Images-Verzeichnis gesucht (d.h.
*/usr/local/icinga/share/images/logos*).

**2d\_coords**:

Diese Variable wird benutzt, um Koordinaten anzugeben, wenn der Host im
[statusmap](cgis.md#cgis-statusmap_cgi)-CGI gezeichnet wird.
Koordinaten sollen in positiven Ganzzahlen angegeben werden, weil sie
physischen Pixeln im generierten Bild entsprechen. Der Ursprung (0,0)
für die Zeichnung ist die linke, obere Ecke des Bildes, das sich in die
positive X-Richtung (nach rechts) und in die positive Y-Richtung (nach
unten) erstreckt. Die Größe der Icons ist normalerweise etwa 40x40 Pixel
(Text benötigt etwas mehr Platz). Die Koordinaten, die Sie angeben,
beziehen sich auf die linke, obere Ecke des Icons. Anmerkung: Machen Sie
sich keine Sorgen über die maximalen X- und Y-Koordinaten, die Sie
benutzen können. Das CGI wird automatisch die maximale Größe des zu
erstellenden Bildes aufgrund der größten X- und Y-Koordinaten festlegen,
die Sie angegeben haben.

### 3.4.14. erweiterte Serviceinformations-Definition (serviceextinfo)

*Beschreibung:*

Einträge für erweiterte Serviceinformationen sind grundsätzlich dazu
gedacht, die Ausgaben der [status](cgis.md#cgis-status_cgi)- und
[extinfo](cgis.md#cgis-extinfo_cgi)-CGIs schöner aussehen zu lassen.
Sie haben keinen Einfluss auf die Überwachung und sind vollständig
optional.

![](../images/tip.gif) Hinweis: Alle Direktiven der erweiterten
Serviceinformations-Definition sind auch in den
[Service-Definitionen](objectdefinitions.md#objectdefinitions-service)
verfügbar. Dadurch können Sie entscheiden, die nachstehenden Direktiven
in Ihren Service-Definitionen zu benutzen, wenn es Ihre Konfigurationen
vereinfacht. Separate erweiterte Serviceinformations-Definitionen werden
weiterhin unterstützt, um Rückwärtskompatibilität zu gewährleisten.

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.
Trotz allem müssen Sie mindestens ein Kriterium angeben, damit die
Definition von Nutzen ist.

define serviceextinfo{

host\_name

host\_name

service\_description

service\_description

hostgroup\_name

hostgroup\_name

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

   

}

*Beispieldefinition:*

~~~~ {.screen}
 define serviceextinfo{
        host_name               linux2
        service_description     Log Anomalies
        notes                   Security-related log anomalies on secondary Linux server
        notes_url               http://webserver.localhost.localdomain/serviceinfo.pl?host=linux2&service=Log+Anomalies
        icon_image              security.png 
        icon_image_alt          Security-Related Alerts
        }
~~~~

*Variablenbeschreibungen:*

**host\_name**:

Diese Variable wird benutzt, um den/die *Kurznamen* des/der
[Hosts](objectdefinitions.md#objectdefinitions-host) zu
identifizieren, mit dem/denen der Service verbunden sind.

**service\_description**:

Diese ist die Beschreibung des
[Service](objectdefinitions.md#objectdefinitions-service), mit
dem/denen diese Daten verbunden sind.

**hostgroup\_name**:

Diese Direktive wird benutzt, um den/die *Kurznamen* der
[Hostgruppen](objectdefinitions.md#objectdefinitions-host) anzugeben,
für den diese Definition gilt. Mehrere Hostgruppen werden durch Kommata
von einander getrennt. Wenn diese Direktive benutzt wird, trifft die
Definition auf alle Hosts zu, die Mitglied der angegebenen Hostgruppe(n)
sind.

**notes**:

Diese Direktive wird benutzt, um eine optionale Zeichenkette mit
Anmerkungen zu definieren, die den Service betreffen. Wenn Sie hier eine
Anmerkung angeben, werden Sie diese im [extended
Information](cgis.md#cgis-extinfo_cgi)-CGI sehen (wenn Sie
Informationen zu dem bestimmten Service ansehen).

**notes\_url**:

Diese Variable wird benutzt, um einen optionalen URL zu definieren, der
mehr Informationen zu diesem Service bereitstellt. Wenn Sie einen URL
angeben, werden Sie im [extended
information](cgis.md#cgis-extinfo_cgi)-CGI einen Link namens "Extra
Service Notes" sehen (wenn Sie Informationen zu dem bestimmten Service
ansehen). Jeder gültige URL kann benutzt werden. Wenn Sie relative Pfade
benutzen, wird der Basis-Pfad der gleiche sein, der benutzt wird, um auf
die CGIs zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich
sein, wenn Sie detaillierte Informationen zu diesem Host,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

**action\_url**:

Diese Variable wird benutzt, um einen optionalen URL zu definieren, der
mehr Aktionen für diesen Service bereitstellt. Wenn Sie einen URL
angeben, werden Sie im [extended
information](cgis.md#cgis-extinfo_cgi)-CGI einen Link namens "Extra
Service Notes" sehen (wenn Sie Informationen zu dem bestimmten Service
ansehen). Jeder gültige URL kann benutzt werden. Wenn Sie relative Pfade
benutzen, wird der Basis-Pfad der gleiche sein, der benutzt wird, um auf
die CGIs zuzugreifen (d.h. */cgi-bin/icinga/*). Dies kann sehr nützlich
sein, wenn Sie detaillierte Informationen zu diesem Host,
Notfallkontaktmethoden usw. für anderes Support-Personal zur Verfügung
stellen wollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Es ist möglich, mehrere URLs für action|notes\_url bei Host- und
Service-Objektdefinitionen anzugeben. Die Syntax ist wie folgt:

~~~~ {.programlisting}
notes_url|action_url 'ersteURL' 'zweiteURL' 'dritteURL'
~~~~

~~~~ {.programlisting}
notes_url|action_url nureineURL
~~~~

Bitte achten Sie darauf, dass mehrere Urls auch gleichzeitig mehrere
Icon-Bilder bedeuten. Diese sind hartkodiert, so dass z.B.
action|notes.gif zu 1-action|1-notes.gif wird. Stellen Sie sicher, dass
diese vorhanden sind. Die letzte URL kann ohne singlequotes angegeben
werden und wird dann wie eine einzelne URL betrachtet und verweist auf
das normale Icon (action.gif).

**icon\_image**:

Diese Variable wird benutzt, um den Namen eines GIF-, PNG- oder
JPG-Images anzugeben, das mit diesem Service verbunden werden soll.
Dieses Bild wird in den [status](cgis.md#cgis-status_cgi)- und
[extended information](cgis.md#cgis-extinfo_cgi)-CGIs angezeigt. Das
Bild wird am besten aussehen, wenn es 40x40 Pixel groß ist. Bilder für
Service werden im **logos/**-Unterverzeichnis Ihres
HTML-Images-Verzeichnis gesucht (d.h.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

Diese Variable wird benutzt, um eine optionale Zeichenkette anzugeben,
die für den ALT-Tag des Bildes benutzt wird, das durch das
*\<icon\_image\>*-Argument angegeben wurde. Das ALT-Tag wird in den
[status](cgis.md#cgis-status_cgi)-, [extended
information](cgis.md#cgis-extinfo_cgi)- und
[statusmap](cgis.md#cgis-statusmap_cgi)-CGIs benutzt.

### 3.4.15. Module-Definition

*Beschreibung:*

Eine Module-Definition wird benutzt, um Informationen zu einem Modul
anzugeben. Sie kann anstatt eines broker\_module-Eintrags in der
Hauptkonfigurationsdatei verwendet werden und ist deshalb flexibler (Sie
können cfg\_file/cfg\_dir-Einträge benutzen, um sie einzuschließen).

*Definition:*

Anmerkung: "Direktiven" werden benötigt, die anderen sind optional.

define module{

module\_name

module name

path

path

args

arguments

module\_type

neb

}

*Beispieldefinitionen:*

~~~~ {.screen}
 define module{
        module_name    ido_mod
        path           /usr/local/icinga/lib/idomod.so
        module_type    neb
        args           config_file=/usr/local/icinga/etc/idomod.cfg
        }
~~~~

Basierend auf der
[MKLiveStatus](http://mathias-kettner.de/checkmk_livestatus.md)-Dokumentation
könnte die module-Definition wie folgt aussehen:

~~~~ {.screen}
 define module{
        module_name    mklivestatus
        path           /usr/local/lib/mk-livestatus/livestatus.o
        module_type    neb
        args           /var/lib/nagios/rw/live
        }
~~~~

*Beschreibung der Direktiven:*

**module\_name**:

Diese Direktive legt den eindeutigen Namen des Moduls fest, so dass Sie
den Modulnamen nicht mehrfach vergeben können. Die Direktive ist
notwendig, anderenfalls wird die Konfiguration nicht akzeptiert und das
Modul nicht geladen.

**module\_type**:

Diese optionale Direktive gibt den Typ des Moduls an, z.B. 'neb' für
Eventbroker-Module. Diese Direktive gedacht, um weitere Filterung beim
Laden des Moduls zu erlauben.

**path**:

Diese notwendige Direktive gibt den kompletten Pfad des zu ladenden
Moduls an. Bei Eventbroker-Modulen wie z.B. idomod muss der Benutzer des
Icinga-Prozesses berechtigt sein, das Modul lesen und ausführen zu
dürfen.

**args**:

Diese Direktive definiert optionale Argumente, die an das Modul
übergeben werden. idomod benötigt config\_file=.../idomod.cfg während
andere Module ihre eigene Syntax haben. Der Wert der Direktive wird als
Argument-String an den Eventbroker-Modul-Lader übergeben, wenn es als
neb-Modul benutzt wird.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Nutzung von Templates sollte möglich sind, aber das wurde noch nicht
ausgiebig mit Icinga 1.4 getestet.

* * * * *

  ------------------------------------- -------------------------- ----------------------------------------
  [Zurück](configobject.md)           [Nach oben](ch03.md)      [Weiter](customobjectvars.md)
  3.3. Überblick Objektkonfiguration    [Zum Anfang](index.md)    3.5. Maßgeschneiderte Objektvariablen
  ------------------------------------- -------------------------- ----------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
