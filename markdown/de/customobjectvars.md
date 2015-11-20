 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

3.5. Maßgeschneiderte Objektvariablen
-------------------------------------

3.5.1. [Einführung](customobjectvars.md#introduction)

3.5.2. [Grundlagen zu maßgeschneiderten
Variablen](customobjectvars.md#basicscustomvars)

3.5.3. [Beispiele](customobjectvars.md#examples)

3.5.4. [maßgeschneiderte Variablen als
Makros](customobjectvars.md#customvarsasmacros)

3.5.5. [maßgeschneiderte Variablen und
Vererbung](customobjectvars.md#inheritancecustomvars)

### 3.5.1. Einführung

Benutzer fragen oft nach neuen Variablen in Host-, Service- und
Kontaktdefinitionen. Dazu gehören Variablen für die SNMP-Community,
MAC-Adressen, AIM-Benutzernamen, Skype-Nummern und Straßennamen. Die
Liste ist endlos. Das Problem, was wir darin sehen ist, dass Icinga
weniger generisch und mehr infrastrukturspezifisch wird. Icinga war dazu
gedacht, flexibel zu sein, was bedeutet, dass die Dinge in einer
generischen Art und Weise geplant waren. Host-Definitionen in Icinga zum
Beispiel haben eine generische "address"-Variable, die alles von einer
was immer für die Umgebung des Benutzers angemessen ist.

Trotzdem muss es eine Methode für Administratoren geben, in ihrer
Icinga-Konfiguration Informationen zu ihren Infrastrukturkomponenten zu
speichern, ohne anderen einen Satz von speziellen Variablen aufzubürden.
Icinga versucht dieses Problem zu lösen, indem es Benutzern erlaubt,
maßgeschneiderte Variablen in ihren Objektdefinitionen anzugeben.
Maßgeschneiderte Variablen erlauben es Benutzern, zusätzliche
Eigenschaften in ihren Host-, Service- und Kontaktdefinitionen anzugeben
und ihre Werte in Benachrichtigungen, Eventhandlern sowie Host- und
Service-Prüfungen zu benutzen.

### 3.5.2. Grundlagen zu maßgeschneiderten Variablen

Es gibt ein paar wichtige Dinge, die Sie bei maßgeschneiderten Variablen
beachten sollten:





![[Wichtig]](../images/important.png)

Wichtig

Maßgeschneiderte Variablen werden erst *zur Laufzeit* ersetzt, weder bei
der Überprüfungsphase (icinga -v icinga.cfg) noch während des
Icinga-Startprozesses, so dass das Platzieren in Host-Namen,
Service-Beschreibungen oder verschiedenen anderen Stellen der
Objektdefinition während der Überprüfung zu einer Fehlermeldung ähnlich
führt. Das Ändern der Direktive "illegal\_object\_name\_chars" wird
*nicht* das Problem lösen.

### 3.5.3. Beispiele

Hier ein Beispiel, wie maßgeschneiderte Variablen in verschiedenen Arten
von Objektdefinitionen definiert werden können:

<pre><code>
 define host{
 define service{
 define contact{
</code></pre>

### 3.5.4. maßgeschneiderte Variablen als Makros

Maßgeschneiderte Variablen können über
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten") oder
Umgebungsvariablen in Scripts und Programmen eingesetzt werden, die
Icinga für Prüfungen, Benachrichtigungen usw. ausführt.

Um Namenskonflikte zwischen maßgeschneiderten Variablen aus
verschiedenen Objektarten zu verhindern, stellt Icinga "\_HOST",
"\_SERVICE" oder "\_CONTACT" an den Anfang von maßgeschneiderten Host-,
Service- oder Kontaktvariablennamen in Makros und Umgebungsvariablen.
Die folgende Tabelle zeigt die entsprechenden Namen für maßgeschneiderte
Variablen, die im obigen Beispiel definiert wurden.

**Objekttyp**

**Variablenname**

**Makroname**

**Umgebungsvariable**

Host

MAC\_ADDRESS

\$\_HOSTMAC\_ADDRESS\$

ICINGA\_\_HOSTMAC\_ADDRESS

Host

RACK\_NUMBER

\$\_HOSTRACK\_NUMBER\$

ICINGA\_\_HOSTRACK\_NUMBER

Service

SNMP\_COMMUNITY

\$\_SERVICESNMP\_COMMUNITY\$

ICINGA\_\_SERVICESNMP\_COMMUNITY

Service

TECHCONTACT

\$\_SERVICETECHCONTACT\$

ICINGA\_\_SERVICETECHCONTACT

Contact

AIM\_USERNAME

\$\_CONTACTAIM\_USERNAME\$

ICINGA\_\_CONTACTAIM\_USERNAME

Contact

YAHOOID

\$\_CONTACTYAHOOID\$

ICINGA\_\_CONTACTYAHOOID

### 3.5.5. maßgeschneiderte Variablen und Vererbung

Maßgeschneiderte Objektvariablen werden genau wie Standard-Host-,
Service- oder Kontaktvariablen
[vererbt](objectinheritance.md "7.26. Objektvererbung").

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
