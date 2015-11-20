 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.10. Eskalations-Bedingung
---------------------------

7.10.1. [Einleitung](escalation_condition.md#introduction)

7.10.2. [Syntax](escalation_condition.md#syntax)

7.10.3. [Beispiel](escalation_condition.md#example)

### 7.10.1. Einleitung

Sie können eine Eskalations-Bedingung definieren (ähnlich wie
escalation\_options [w,u,c,r]). Eine Eskalation mit einer definierten
Bedingung wird nur dann eskalieren, wenn der aktuelle Zustand eines
bestimmten Hosts/Services mit der angegebenen Bedingung übereinstimmt.
Ein mögliches Anwendungsbeispiel könnte das folgende Szenario sein:

Stellen Sie sich zwei verschiedene Eskalationen für den selben Service
*foo* vor. Eine soll nur dann eskalieren, wenn der Service *bar* OK ist,
die andere soll eskalieren, wenn *bar* CRITICAL oder WARNING ist. Nun
stellen Sie sich vor, dass *foo* der zentrale Service einer Firma ist
und der Administrator sofort reagieren muss, wenn der Service down ist.
*bar* könnte ein Service sein, der angibt, ob der Admin im Büro oder zu
Hause ist. Die Eskalation würde wie folgt reagieren:



Dies kann erreicht werden, ohne Icinga neu zu starten bzw. die
Konfiguration neu zu laden.

### 7.10.2. Syntax

Die Direktive escalation\_condition ist komplett optional und kann
sowohl für Host- als auch für Service-Eskalationen definiert werden. Die
Syntax lautet:

`escalation_condition <condition> ( [ & / | ] <condition> )`

wobei \<condition\> entweder `host hostname = [u,d,o]` oder

Wie Sie sehen können, akzeptiert escalation\_condition eine Liste von
einer oder mehreren Bedingungen, die durch "&" (logisches UND) oder "|"
(logisches ODER) getrennt sind. Die Bedeutungen von [w,u,c,o,d]
unterscheiden sich geringfügig von denen, die bei escalation\_options
benutzt werden:






### 7.10.3. Beispiel

</code></pre> 
define serviceescalation {
</code></pre>

Diese Beispiel-Eskalation würde eskalieren, wenn der HOST 'linux' DOWN
ist oder der Service 'linux.SSH' WARNING oder CRITICAL.

[ Thanks to: Vitali Voroth, DECOIT GmbH \* http://www.decoit.de ]

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
