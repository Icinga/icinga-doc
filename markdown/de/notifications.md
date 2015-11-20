 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.11. Benachrichtigungen
------------------------

5.11.1. [Einführung](notifications.md#introduction)

5.11.2. [Wann erfolgen Benachrichtigungen?](notifications.md#when)

5.11.3. [Wer wird benachrichtigt?](notifications.md#who)

5.11.4. [Welche Filter müssen durchlaufen werden, damit
Benachrichtigungen versandt werden?](notifications.md#whatfilters)

5.11.5. [Programmweite Filter:](notifications.md#programwidefilters)

5.11.6. [Service- und
Host-Filter:](notifications.md#servicehostfilters)

5.11.7. [Kontakt-Filter:](notifications.md#contactfilters)

5.11.8. [Benachrichtigungs-Methoden](notifications.md#methods)

5.11.9. [Benachrichtigungstyp-Makro](notifications.md#typemacro)

5.11.10. [Hilfreiche Quellen](notifications.md#helpfulresources)

### 5.11.1. Einführung

![](../images/objects-contacts.png)

Es gab eine Menge Fragen, wie genau Benachrichtigungen arbeiten. Wir
werden versuchen, genau zu erklären, wann und wie Host- und
Service-Benachrichtigungen versandt werden und ebenso, wer sie bekommt.

Benachrichtigungs-Eskalationen werden
[hier](escalations.md "7.9. Benachrichtigungseskalationen")
beschrieben.

### 5.11.2. Wann erfolgen Benachrichtigungen?

Die Entscheidung, Benachrichtigungen zu senden, wird in der Service- und
Host-Prüflogik getroffen. Die Ermittlung, ob eine Benachrichtigung
versandt wird oder nicht, erfolgt nur dann, wenn eine Host- oder
Service-Prüfung zu dieser Benachrichtigung verarbeitet wird. Es reicht
nicht, dass die in der Direktive \<notification\_interval\> angegebene
Zeit seit der letzten Benachrichtigung vergangen ist. Host- und
Service-Benachrichtigungen erfolgen in den folgenden Fällen...



### 5.11.3. Wer wird benachrichtigt?

Jede Host- und Service-Definition hat eine \<*contact\_groups*\>-Option,
die angibt, welche Kontaktgruppen Benachrichtigungen für bestimmte Hosts
oder Services erhalten. Kontaktgruppen können ein oder mehrere einzelne
Kontakte enthalten.

Wenn Icinga eine Host- oder Service-Benachrichtigung versendet, wird es
jeden Kontakt informieren, der Mitglied in einer der Kontaktgruppen ist,
die in der \<*contactgroups*\>-Option der Service-Definition angegeben
ist. Icinga bemerkt, wenn ein Kontakt Mitglied von mehr als einer
Kontaktgruppe ist und entfernt mehrfache Kontaktbenachrichtigungen,
bevor es irgendetwas tut.

### 5.11.4. Welche Filter müssen durchlaufen werden, damit Benachrichtigungen versandt werden?

Nur weil Benachrichtigungen für einen Host- oder Service versandt werden
müssen, bedeutet das nicht, dass irgendein Kontakt informiert wird. Es
gibt mehrere Filter, die potenzielle Benachrichtungen durchlaufen
müssen, bevor sie als würdig genug angesehen werden, um versandt zu
werden. Lassen Sie uns einen genaueren Blick auf die Filter werfen, die
zu durchlaufen sind...

### 5.11.5. Programmweite Filter:

Der erste Filter, den Benachrichtigungen durchlaufen müssen, ist ein
Test, ob Benachrichtigungen auf einer programmweiten Basis aktiviert
sind. Dies wird ursprünglich durch die
[enable\_notifications](configmain.md#configmain-enable_notifications)-Option
in der Hauptkonfigurationsdatei festgelegt, kann aber während der
Laufzeit über das Web-Interface verändert werden. Falls
Benachrichtigungen auf programmweiter Basis deaktiviert sind, werden
sie auf programmweiter Basis aktiviert sind, müssen weitere Tests
durchlaufen werden...

### 5.11.6. Service- und Host-Filter:

Der erste Filter für Host- oder Service-Benachrichtigungen ist eine
Prüfung, ob sich der Host oder Service in einer [geplanten
Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten") (downtime)
befindet. Falls es eine geplante Ausfallzeit ist, **wird niemand
informiert**. Wenn es keine Ausfallzeit ist, geht es weiter zum nächsten
Filter. Als kleine Randnotiz: Service-Benachrichtigungen werden
unterdrückt, falls sich der mit ihnen verbundene Host in einer geplanten
Ausfallzeit befindet.

Der zweite Filter für Host- oder Service-Benachrichtigungenen ist eine
Prüfung, ob der Host oder Service
[flattert](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
(wenn Sie Flatter-Erkennung aktiviert haben). Falls der Service oder
Host gerade flattert, **wird niemand informiert**. Andernfalls geht es
weiter zum nächsten Filter.

Der dritte für Hosts oder Services zu durchlaufende Filter sind die
[Host](objectdefinitions.md#objectdefinitions-host)- oder
[Service](objectdefinitions.md#objectdefinitions-service)-spezifischen
Benachrichtigungsoptionen (sh. Links bzw. nachfolgende Tabelle). Jede
Service-Definition enthält Optionen, die festlegen, ob Benachrichtungen
für Warnungen, kritische Zustände oder Erholungen versandt werden oder
nicht. Ähnlich ist es bei Hosts, wo festgelegt wird, ob
Benachrichtigungen versandt werden, wenn der Host down geht,
unerreichbar wird oder sich wieder erholt. Falls die Host- oder
Service-Benachrichtigungen diese Optionen nicht passieren, **wird
niemand informiert**. Wenn sie die Optionen durchlaufen, geht es zum
nächsten Filter... Anmerkung: Benachrichtigungen über Host- oder
Service-Erholungen werden nur dann versandt, wenn auch eine
Benachrichtigung über das ursprüngliche Problem versandt wurde. Es ist
nicht sinnvoll, eine Benachrichtigung über eine Erholung zu bekommen,
wenn Sie nicht wussten, dass ein Problem existiert.

Option

Bedeutung der Host-Benachrichtigungsoption

d

Benachrichtigungen bei einem DOWN-Zustand versenden

u

Benachrichtigungen bei einem UNREACHABLE-Zustand versenden

r

Benachrichtigungen bei Erholungen (OK-Zustand) versenden

f

Benachrichtigungen versenden, wenn der Host mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört

s

Benachrichtigungen versenden, wenn eine [geplante
Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten") anfängt oder
aufhört

n

Es werden keine Benachrichtungen versandt, **egal wie die anderen
Optionen aussehen mögen**

Option

Bedeutung der Service-Benachrichtigungsoption

w

Benachrichtigungen bei einem WARNING-Zustand versenden

c

Benachrichtigungen bei einem CRITICAL-Zustand versenden

u

Benachrichtigungen bei einem UNKNOWN-Zustand versenden

r

Benachrichtigungen bei Erholungen (OK-Zustand) versenden

f

Benachrichtigungen versenden, wenn der Service mit
[Flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")
anfängt bzw. aufhört

s

Benachrichtigungen versenden, wenn eine [geplante
Ausfallzeit](downtime.md "7.16. Geplante Ausfallzeiten") anfängt oder
aufhört

n

Es werden keine Benachrichtungen versandt, **egal wie die anderen
Optionen aussehen mögen**

Der vierte Host- oder Service-Filter, der durchlaufen werden muss, ist
der Zeitfenster-Test. Jede Host- und Service-Definition hat eine
\<*notification\_period*\>-Option, die angibt, welches Zeitfenster
gültige Benachrichtigungszeiten für den Host oder Service enthält. Wenn
die Zeit der Benachrichtigung nicht in einen gültigen Bereich des
Zeitfensters fällt, **wird niemand informiert**. Wenn sie in einen
gültigen Bereich fällt, geht es zum nächsten Filter... Anmerkung: falls
der Zeitfenster-Filter nicht erfolgreich durchlaufen wird, plant Icinga
die nächste Benachrichtigung für den Host oder Service (falls er sich in
einem nicht-OK-Status befindet) für die nächste verfügbare gültige Zeit
im Zeitfenster. Dies stellt sicher, dass der Kontakt so früh wie möglich
über Probleme informiert wird, wenn die nächste gültige Zeit erreicht
wird.

Der letzte Satz von Host- oder Service-Filter ist abhängig von zwei
Dingen: (1) zu einem Zeitpunkt in der Vergangenheit wurde bereits eine
Benachrichtigung über ein Problem mit dem Host oder Service versandt und
(2) blieb der Host oder Service im gleichen nicht-OK-Zustand, der zur
Zeit der Benachrichtigung vorlag. Wenn diese beiden Kriterien zutreffen,
wird Icinga prüfen und sicherstellen, dass die seit der letzten
Benachrichtigung vergangene Zeit den in der Option
\<*notification\_interval*\> angegebenen Wert in der Host- oder
Service-Definition erreicht oder übertrifft. Falls nicht genug Zeit seit
der letzten Benachrichtigung vergangen ist, **wird niemand
benachrichtigt**. Wenn entweder genug Zeit seit der letzten
Benachrichtigung vergangen ist oder die beiden Kriterien dieses Filters
erfüllt wurden, wird die Benachrichtigung versandt. Ob sie tatsächlich
an einzelne Kontakte versandt wird, hängt von einem weiteren Satz von
Filtern ab...

### 5.11.7. Kontakt-Filter:

An diesem Punkt hat die Benachrichtigung die programmweiten und alle
Host- und Service-Filter durchlaufen und Icinga beginnt, [alle
betroffenen Leute zu
informieren](objectdefinitions.md#objectdefinitions-contact). Bedeutet
dies, dass jeder Kontakt die Benachrichtigung erhalten wird? Nein. Jeder
Kontakt hat seinen eigenen Satz von Filtern, den die Benachrichtigung
passieren muss. Anmerkung: Kontaktfilter sind spezifisch für jeden
Kontakt und beeinflussen nicht, ob andere Kontakte Benachrichtigungen
erhalten oder nicht.

Der erste zu passierende Filter für jeden Kontakt sind die
Benachrichtigungsoptionen. Jede Kontaktdefinition enthält Optionen, die
festlegen, ob Service-Benachrichtigungen für Warning- und
Critital-Zustände und Erholungen versandt werden können. Jede
Kontakt-Definition enthält auch Optionen, die festlegen, ob
Host-Benachrichtigungen versandt werden, wenn der Host "down" geht,
unerreichbar wird oder sich erholt. Falls die Host- oder
Service-Benachrichtigung diese Optionen nicht passieren kann, **wird der
Kontakt nicht informiert**. Wenn es diese Optionen passiert, wird die
Benachrichtigung an den nächsten Filter weitergereicht... Anmerkung:
Benachrichtigungen über die Erholung von Host oder Service werden nur
dann versandt, wenn eine Benachrichtigung für das ursprüngliche Problem
versandt wurde. Es ist sinnlos, eine Benachrichtigung über eine Erholung
zu versenden, wenn Sie nicht wussten, dass ein Problem existiert...

Der letzte zu passierende Filter für jeden Kontakt ist der
Zeitfenster-Test. Jede Kontaktdefinition hat eine
\<*notification\_period*\>-Option, die angibt, welches Zeitfenster
gültige Benachrichtigungszeiten für den Kontakt enthält. Wenn die Zeit,
in der die Benachrichtigung erstellt wird, nicht in ein gültiges
Zeitfenster fällt, **wird der Kontakt nicht informiert**. Wenn sie in
ein gültiges Zeitfenster fällt, wird der Kontakt informiert!

### 5.11.8. Benachrichtigungs-Methoden

Icinga kann Sie über Probleme und Erholungen auf vielfältige Weise
informieren: Pager, Handy, e-Mail, SMS, Audio-Hinweis usw. Wie
Benachrichtigungen versandt werden, hängt von den
[Benachrichtigungs-Befehlen](objectdefinitions.md#objectdefinitions-command)
ab, die in Ihren
[Objekt-Definitionsdateien](config.md "3.1. Konfigurationsüberblick")
definiert werden.

![](../images/note.gif) Anmerkung: Wenn Sie Icinga nach den
[Schnellstart-Anleitungen](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
installieren, sollte es zum Versand von e-Mail-Benachrichtigungen
konfiguriert sein. Sie können die benutzten e-Mail-Befehle ansehen,
indem Sie den Inhalt der Datei
*/usr/local/icinga/etc/objects/commands.cfg* betrachten.

Spezielle Benachrichtigungs-Methoden (Paging usw.) sind nicht direkt in
den Icinga-Code integriert, denn es ist nicht sinnvoll. Der "Kern" von
Icinga ist nicht als eierlegene Wollmilchsau gedacht. Wenn
Service-Prüfungen im Icinga-Kern enthalten wären, hätten Benutzer große
Schwierigkeiten, neue Prüfmethoden hinzuzufügen, bestehende Prüfungen zu
modifizieren usw. Benachrichtigungen arbeiten in ähnlicher Weise. Es
gibt tausend verschiedene Wege, Benachrichtigungen zu versenden und es
gibt bereits viele Pakete, die die schmutzige Arbeit tun, also warum das
Rad neu erfinden und sich dann auf einen Fahrrad-Reifen beschränken? Es
ist viel einfacher, ein externes Gebilde (das kann ein einfaches Script
sein oder ein ausgewachsenes Message-System) die ganze Arbeit tun zu
lassen. Einige Message-Pakete, die Benachrichtigungen für Pager und
Handys verarbeiten können, sind weiter unten aufgeführt.

### 5.11.9. Benachrichtigungstyp-Makro

Wenn Sie Benachrichtigungs-Befehle erstellen, müssen Sie beachten, um
welchen Typ von Benachrichtigung es sich handelt. Das Makro
[\$NOTIFICATIONTYPE\$](macrolist.md#macrolist-notificationtype)
enthält eine Zeichenkette, die genau das angibt. Die nachfolgende
Tabelle zeigt die möglichen Werte und deren entsprechende
Beschreibungen:

**Wert**

**Beschreibung**

PROBLEM

Ein Host oder Service hat gerade einen Problemzustand erreicht (oder ist
noch in einem). Wenn dies eine Service-Benachrichtigung ist, bedeutet
das, dass der Service in einem WARNING-, UNKNOWN- oder CRITICAL-Zustand
ist. Wenn dies eine Host-Benachrichtigung ist, bedeutet das, dass der
Host in einem DOWN- oder UNREACHABLE-Zustand ist.

RECOVERY

Ein Service oder Host hat sich erholt. Wenn dies eine
Service-Benachrichtigung ist, bedeutet es, dass der Service gerade
wieder in einen OK-Zustand zurückgekehrt ist. Wenn dies eine
Host-Benachrichtigung ist, bedeutet das, dass der Host gerade wieder in
einen UP-Zustand zurückgekehrt ist.

ACKNOWLEDGEMENT

Diese Benachrichtigung ist eine Bestätigung für ein Host- oder
Service-Problem. Bestätigungen werden von Kontakten für diesen Host oder
Service über das Web-Interface ausgelöst.

FLAPPINGSTART

Der Host oder Service hat gerade angefangen zu
[flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

FLAPPINGSTOP

Der Host oder Service hat gerade aufgehört zu
[flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern").

FLAPPINGDISABLED

Der Host oder Service hat gerade aufgehört zu
[flattern](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern"),
weil die Flatter-Erkennung deaktiviert wurde.

DOWNTIMESTART

Der Host oder Service hat gerade ein [geplante
Downtime](downtime.md "7.16. Geplante Ausfallzeiten") begonnen.
Weitere Benachrichtigungen werden unterdrückt.

DOWNTIMEEND

Der Host oder Service hat gerade eine [geplante
Downtime](downtime.md "7.16. Geplante Ausfallzeiten") beendet.
Benachrichtungen über Probleme werden wieder versandt.

DOWNTIMECANCELLED

Die Phase der [geplanten
Downtime](downtime.md "7.16. Geplante Ausfallzeiten") für den Host
oder Service wurde gerade annulliert. Benachrichtungen über Probleme
werden wieder versandt.

### 5.11.10. Hilfreiche Quellen

Es gibt viele Wege, wie Sie Icinga konfigurieren können, damit
Benachrichtigungen versandt werden. Sobald Sie dies tun, müssen Sie
notwendige Software installieren und Benachrichtigungs-Befehle
konfigurieren, bevor Sie diese benutzen können. Hier sind nur ein paar
mögliche Benachrichtigungs-Methoden:








Im Grunde genommen kann alles, was Sie von einer Kommandozeile aus tun
können, so angepasst werden, dass Sie es in einem
Benachrichtigungs-Befehl nutzen können.

Wenn Sie nach einer Alternative suchen, um Meldungen per e-Mail an Ihren
Pager oder Ihr Handy zu versenden, sollten Sie diese Pakete
ausprobieren. Sie können in Verbindung mit Icinga dazu benutzt werden,
Benachrichtigungen über ein Modem zu versenden, wenn ein Problem
auftritt. Auf diese Weise müssen Sie sich nicht auf e-Mail verlassen, um
Benachrichtigungen zu versenden (bedenken Sie, dass e-Mail ggf.
\*nicht\* funktioniert, wenn es ein Netzwerk-Problem gibt). Wir haben
diese Pakete nicht selbst ausprobiert, aber andere haben von
erfolgreichem Einsatz berichtet...




Wenn Sie eine nicht-traditionelle Methode für Benachrichtigungen
ausprobieren möchten, können Sie ggf. Audio-Hinweise nutzen. Wenn Sie
Audio-Hinweise auf dem Überwachungs-Rechner (mit synthetischer Stimme)
abspielen möchten, probieren Sie
[Festival](http://www.cstr.ed.ac.uk/projects/festival/). Wenn Sie den
Überwachungs-Rechner lieber in Ruhe lassen und Audio-Hinweise auf einem
anderen Rechner abspielen möchten, dann sehen Sie sich die Projekte
[Network Audio System (NAS)](http://radscan.com/nas.md) und
[rplay](http://rplay.doit.org/) an.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
