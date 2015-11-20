 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.11. Bereitschafts-Rotation
----------------------------

7.11.1. [Einführung](oncallrotation.md#introduction)

7.11.2. [Szenario 1: Urlaub und
Wochenenden](oncallrotation.md#holidaysweekends)

7.11.3. [Szenario 2: Abwechselnde
Tage](oncallrotation.md#alternatingdays)

7.11.4. [Szenario 3: Abwechselnde
Wochen](oncallrotation.md#alternatingweeks)

7.11.5. [Szenario 4: Urlaubstage](oncallrotation.md#vacationdays)

7.11.6. [Andere Szenarien](oncallrotation.md#others)

### 7.11.1. Einführung

![](../images/objects-contacts.png)

![](../images/objects-timeperiods.png)

Admins müssen oft genug Pager, Mobiltelefonanrufe usw. beantworten, wenn
sie es am wenigsten gebrauchen können. Keiner mag es, morgens um 4 Uhr
geweckt zu werden. Allerdings ist es oft besser, das Problem mitten in
der Nacht zu lösen als den Zorn eines unglücklichen Chefs zu spüren,
wenn Sie am nächsten Morgen um 9 Uhr ins Büro kommen.

Für die glücklichen Admins, die ein Team von Gurus haben, die die
Verantwortlichkeiten bei der Beantwortung von Alarmen teilen können,
gibt es oft Bereitschaftspläne. Mehrere Admins werden oft abwechselnd
Benachrichtigungen an Wochenenden, Nächten, Urlauben usw.
entgegennehmen.

Wir werden Ihnen zeigen, wie Sie
[Zeitfenster](timeperiods.md "5.9. Zeitfenster")-Definitionen
erstellen können, die die meisten Bereitschafts-Benachrichtigungen
behandeln werden. Diese Definitionen werden keine menschlichen Dinge
berücksichtigen, die unweigerlich auftreten werden (Admins, die sich
krank melden, Tausch von Schichten, oder Pager, die ins Wasser fallen),
aber sie werden es Ihnen erlauben, eine grundlegende Struktur in Ihre
Aufteilung zu bringen, die für die meiste Zeit funktionieren wird.

### 7.11.2. Szenario 1: Urlaub und Wochenenden

Icinga-Alarmen. John erhält alle Benachrichtigungen an Wochentagen (und
der Wochenenden und Urlaube. Glücklicher Bob. Hier nun, wie Sie diese
Art der Rotation mit Zeitfenstern definieren...

Definieren Sie zuerst ein Zeitfenster, das Bereiche für Urlaube enthält:

</code></pre> 
 define timeperiod{
</code></pre>

Als nächstes definieren Sie ein Zeitfenster für Johns
Bereitschaftszeiten, das die Wochentage und Nächte während der Woche
enthält, aber die Daten/Zeiten im Urlaubs-Zeitfenster ausschließt:

</code></pre> 
 define timeperiod{
</code></pre>

Sie können nun dieses Zeitfenster in Johns Kontaktdefinition
referenzieren:

</code></pre> 
 define contact{
</code></pre>

Definieren Sie ein neues Zeitfenster für Bobs Bereitschaftszeiten, das
die Wochenenden und die Daten/Zeiten der o.g. holiday-Zeitfenster
enthält:

</code></pre> 
 define timeperiod{
</code></pre>

Sie können nun auf dieses Zeitfenster in Bobs Kontaktdefinition
referenzieren:

</code></pre> 
 define contact{
</code></pre>

### 7.11.3. Szenario 2: Abwechselnde Tage

In diesem Szenario wechseln sich John und Bob täglich mit der
Wochenenden, Wochentage oder Urlaub handelt.

Definieren Sie ein Zeitfenster, wann John Benachrichtigungen erhalten
soll. Angenommen, der heutige Tage ist der 1. August 2009 und John
beginnt heute mit der Bearbeitung von Benachrichtigungen, dann würde die
Definition wie folgt aussehen:

</code></pre> 
 define timeperiod{
</code></pre>

Nun definieren Sie ein Zeitfenster, wann Bob Benachrichtigungen erhalten
soll. Bob erhält Benachrichtigungen an den Tagen, an denen John keine
erhält, also beginnt seine erste Bereitschaft morgen (2. August 2009).

</code></pre> 
 define timeperiod{
</code></pre>

Nun müssen Sie diese Zeitfenster-Definitionen in den Kontaktdefinitionen
von John und Bob referenzieren.

</code></pre> 
 define contact{
</code></pre>

</code></pre> 
 define contact{
</code></pre>

### 7.11.4. Szenario 3: Abwechselnde Wochen

In diesem Szenario wechseln sich John und Bob jede Woche mit der
Bearbeitung von Alarmen ab. John bearbeitet Alarme von Montag bis
Sonntag in der einen Woche und Bob bearbeitet Alarme in den nächsten
sieben Tagen. Dies wiederholt sich immer wieder.

Definieren Sie ein Zeitfenster, wann John Benachrichtigungen erhalten
soll. Angenommen, heute ist Montag, der 27. Juli 2009 und John
bearbeitet Benachrichtigungen in dieser Woche (beginnend mit heute),
würde die Definition wie folgt aussehen:

</code></pre> 
 define timeperiod{
</code></pre>

Nun definieren Sie ein Zeitfenster, wann Bob Benachrichtigungen erhalten
soll. Bob erhält Benachrichtigungen in den Wochen, in denen John keine
bekommt, also startet seine erste Bereitschaft am nächsten Montag (3.
August 2009).

</code></pre> 
 define timeperiod{
</code></pre>

Nun müssen Sie diese Zeitfenster-Definitionen in den Kontaktdefinitionen
von John und Bob referenzieren.

</code></pre> 
 define contact{
</code></pre>

</code></pre> 
 define contact{
</code></pre>

### 7.11.5. Szenario 4: Urlaubstage

In diesem Szenario bearbeitet John Benachrichtigungen an allen Tagen
außer an denen, an denen er frei hat. Er hat frei an einigen festen
Tagen im Monat ebenso wie an einigen geplanten Urlaubszeiten. Bob
bearbeitet Benachrichtigungen, wenn John Urlaub hat oder nicht im Büro
ist.

Definieren Sie zuerst ein Zeitfenster, das die Bereiche für Johns
Urlaubstage und freie Tage enthält:

</code></pre> 
 define timeperiod{
</code></pre>

Als nächstes definieren Sie ein Zeitfenster für Johns
Bereitschaftszeiten, das die Daten/Zeiten im o.g. Zeitfenster
ausschließt:

</code></pre> 
 define timeperiod{
</code></pre>

Sie können nun dieses Zeitfenster in Johns Kontaktdefinition
referenzieren:

</code></pre> 
 define contact{
</code></pre>

Definieren Sie ein neues Zeitfenster für Bobs Bereitschaftszeiten, das
die Zeiten von Johns Abwesenheiten enthält:

</code></pre> 
 define timeperiod{
</code></pre>

Sie können nun dieses Zeitfenster in Bobs Kontaktdefinition
referenzieren:

</code></pre> 
 define contact{
</code></pre>

### 7.11.6. Andere Szenarien

Es gibt eine Menge von anderen
Bereitschafts-Benachrichtigungs-Szenarien, die Sie haben könnten. Die
Datumsausschluss-Direktive in den
[Zeitfenster-Definitionen](objectdefinitions.md#objectdefinitions-timeperiod)
ist in der Lage, die meisten Datums- und Zeitbereiche abzubilden, die
Sie brauchen könnten, also betrachten Sie die verschiedenen Formate, die
Sie benutzen können. Wenn Sie einen Fehler bei der Erstellung von
Zeitfenster-Definitionen machen, dann sollten Sie darauf achten, jemand
anderem mehr Bereitschaftszeit zu geben. :-)

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
