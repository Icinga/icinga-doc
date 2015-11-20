 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.26. Objektvererbung
---------------------

7.26.1.
[Einführung](objectinheritance.md#objectinheritance-introduction)

7.26.2. [Grundlagen](objectinheritance.md#objectinheritance-basics)

7.26.3. [Lokale Variablen gegenüber vererbten
Variablen](objectinheritance.md#objectinheritance-localvsinveritedvars)

7.26.4.
[Vererbungsverkettung](objectinheritance.md#objectinheritance-inheritancechaining)

7.26.5. [Unvollständige Objektdefinitionen als Vorlagen
nutzen](objectinheritance.md#objectinheritance-templates)

7.26.6. [eigene Objektvariablen (custom object
variables)](objectinheritance.md#objectinheritance-customobjectvariables)

7.26.7. [Vererbung für Zeichenketten-Werte
aufheben](objectinheritance.md#objectinheritance-cancel_string)

7.26.8. [additive Vererbung von
Zeichenketten-Werten](objectinheritance.md#objectinheritance-add_string)

7.26.9. [Implizite
Vererbung](objectinheritance.md#objectinheritance-implied_inheritance)

7.26.10. [implizite/additive Vererbung bei
Eskalationen](objectinheritance.md#objectinheritance-implied_escalations)

7.26.11. [Wichtige Werte (important
values)](objectinheritance.md#objectinheritance-important_values)

7.26.12. [Mehrere
Vererbungsquellen](objectinheritance.md#objectinheritance-multiple_templates)

7.26.13. [Vorrang bei mehreren
Vererbungsquellen](objectinheritance.md#objectinheritance-multipleinheritancesources)

### 7.26.1. Einführung

Dieses Dokument versucht Objektvererbung zu erklären und wie sie in
Ihren
[Objektdefinitionen](objectdefinitions.md "3.4. Objektdefinitionen")
genutzt werden kann.

Wenn Sie nach dem Lesen verwirrt sind, wie Rekursion und Vererbung
arbeiten, sollten Sie einen Blick in die
Beispielobjektkonfigurationsdateien in der Icinga-Distribution werfen.
Wenn das immer noch nicht hilft, dann senden Sie eine
(englischsprachige) e-Mail mit einer *detaillierten* Beschreibung Ihres
Problems an die *icinga-users*-Mailing-List.

### 7.26.2. Grundlagen

Es gibt drei Variablen in allen Objektdefinitionen, die Rekursion und
Vererbung beeinflussen. Sie sind wie folgt *"dargestellt"*:

 define someobjecttype{
</code></pre>

Die erste Variable heißt *name*. Das ist lediglich ein "Vorlagen"-Name
(template name), auf den in anderen Objektdefinitonen verwiesen wird, so
dass diese die Objekteigenschaften/Variablen erben. Vorlagennamen müssen
innerhalb der Objekte des gleichen Typs eindeutig sein, so dass Sie
nicht zwei oder mehr Host-Definitionen mit "hosttemplate" als Namen
haben können.

Die zweite Variable heißt *use*. Hier geben Sie den Namen der Vorlage
an, deren Eigenschaften/Variablen Sie erben möchten. Der Name, den Sie
für diese Variable angeben, muss als Vorlage definiert sein (mit Hilfe
der *name*-Variable).

Die dritte Variable heißt *register*. Diese Variable wird benutzt, um
anzuzeigen, ob die Objektdefinition "registriert" werden soll. Per
Default werden alle Objektdefinitionen registriert. Wenn Sie eine
partielle Objektdefinition als Vorlage nutzen, möchten Sie verhindern,
dass sie registriert wird (ein Beispiel dazu folgt). Die Werte sind wie
folgt: 0 = die Objektdefinition NICHT registrieren, 1 = die
Objektdefinition registrieren (das ist der Default). Diese Variable wird
NICHT vererbt, bei jeder als Vorlage genutzten (Teil-) Objektdefinition
muss explizit die *register*-Direktive auf *0* gesetzt werden. Dies
verhindert die Notwendigkeit, eine vererbte *register*-Direktive für
jedes zu registrierende Objekt mit einem Wert von *1* zu übersteuern.

### 7.26.3. Lokale Variablen gegenüber vererbten Variablen

Bei der Vererbung ist es wichtig zu wissen, dass "lokale"
Objektvariablen immer Vorrang vor Variablen aus der Vorlage haben.
Werfen Sie einen Blick auf das folgende Beispiel mit zwei
Host-Definitionen (nicht alle notwendigen Variablen sind dargestellt):

 define host{
 define host{
</code></pre>

Sie werden bemerken, dass die Definiton für den Host *bighost1* mit
Hilfe der Vorlage *hosttemplate1* definiert wurde. Die Definition für
Host *bighost2* nutzt die Definition von *bighost1* als Vorlagenobjekt.
Sobald Icinga diese Daten verarbeitet hat, wäre die resultierende
Definition von *bighost2* äquivalent zu dieser Definition:

 define host{
</code></pre>

Sie sehen, dass die *check\_command*- und
*notification\_options*-Variablen vom Vorlagenobjekt geerbt wurden (wo
Host *bighost1* definiert wird). Trotzdem wurden die *host\_name*- und
*check\_attempts*-Variablen nicht vom Vorlagenobjekt geerbt, weil sie
lokal definiert wurden. Erinnern Sie sich, dass von einem Vorlagenobjekt
geerbte Variablen von lokal definierten Variablen überschrieben werden.
Das sollte ein ziemlich einfach zu verstehendes Konzept sein.

![](../images/tip.gif) Hinweis: wenn Sie möchten, dass lokale
Zeichenketten-Variablen an geerbte Zeichenkettenwerte angehängt werden,
können Sie das tun. Lesen Sie [weiter
unten](objectinheritance.md#objectinheritance-add_string "7.26.8. additive Vererbung von Zeichenketten-Werten")
mehr darüber, wie das erreicht werden kann.

### 7.26.4. Vererbungsverkettung

Objekte können Eigenschaften/Variablen aus mehreren Ebenen von
Vorlagenobjekten erben. Nehmen Sie das folgende Beispiel:

 define host{
 define host{
 define host{
</code></pre>

Sie werden bemerken, dass die Definition von Host *bighost3* Variablen
von der Definition von *bighost2* erbt, die wiederum Variablen von der
Definition von Host *bighost1* erbt. Sobald Icinga diese
Konfigurationsdaten verarbeitet, sind die resultierenden Host-Definition
äquivalent zu den folgenden:

 define host{
 define host{
 define host{
</code></pre>

Es gibt keine eingebaute Beschränkung, wie "tief" Vererbung gehen kann,
aber Sie sollten sich vielleicht selbst auf ein paar Ebenen beschränken,
um die Übersicht zu behalten.

### 7.26.5. Unvollständige Objektdefinitionen als Vorlagen nutzen

Es ist möglich, unvollständige Objektdefinitionen als Vorlage für andere
Objektdefinitionen zu nutzen. Mit "unvollständiger" Definition meinen
wir, dass nicht alle benötigten Variablen in der Objektdefinition
angegeben wurden. Es mag komisch klingen, unvollständige Definitionen
als Vorlagen zu nutzen, aber es ist tatsächlich empfohlen, dies zu tun.
Warum? Nun, sie können als ein Satz von Defaults für alle anderen
Objektdefinitionen dienen. Nehmen Sie das folgende Beispiel:

 define host{
 define host{
 define host{
</code></pre>

Beachten Sie, dass die erste Host-Definition unvollständig ist, weil die
erforderliche *host\_name*-Variable fehlt. Wir müssen keinen Host-Namen
angeben, weil wir diese Definition als Vorlage nutzen wollen. Um Icinga
daran zu hindern, diese Definition als einen normalen Host anzusehen,
setzen wir die *register*-Variable auf 0.

Die Definitionen von *bighost1* und *bighost2* erben ihre Werte von der
generischen Host-Definition. Die einzige Variable, die überschrieben
wird, ist die *address*-Variable. Das bedeutet, dass beide Hosts exakt
die gleichen Eigenschaften haben, bis auf die *host\_name*- und
*address*-Variablen. Sobald Icinga die Konfigurationsdaten im Beispiel
verarbeitet, wären die resultierenden Host-Definitionen äquivalent zu
folgenden:

 define host{
 define host{
</code></pre>

Die Nutzung einer Vorlagendefinition für Default-Werte erspart Ihnen
mindestens eine Menge Tipparbeit. Es spart Ihnen auch eine Menge
Kopfschmerzen, wenn Sie später die Default-Werte von Variablen für eine
große Zahl von Hosts wollen.

### 7.26.6. eigene Objektvariablen (custom object variables)

Jede [eigene
Objektvariable](customobjectvars.md "3.5. Maßgeschneiderte Objektvariablen"),
die Sie in Ihren Host-, Service- oder Kontaktdefinitionen definieren,
wird wie jede andere Standardvariable vererbt. Nehmen Sie das folgende
Beispiel:

 define host{
 define host{
</code></pre>

Der Host *bighost1* wird die eigenen Host-Variablen *\_customvar1* und
*\_snmp\_community* von der *generichosttemplate*-Definition erben,
zusammen mit den entsprechenden Werten. Die daraus resultierende
Definition für *bighost1* sieht wie folgt aus:

 define host{
</code></pre>

### 7.26.7. Vererbung für Zeichenketten-Werte aufheben

In einigen Fällen möchten Sie vielleicht nicht, dass Ihre Host-,
Service- oder Kontakt-Definitionen Werte von Zeichenketten-Variablen aus
Vorlagen erben. Wenn das der Fall ist, können Sie "**null**" (ohne
Anführungszeichen) als den Wert der Variable, die Sie nicht erben
möchten. Nehmen Sie das folgende Beispiel:

 define host{
 define host{
</code></pre>

In diesem Fall wird der Host *bighost1* nicht den Wert der
*event\_handler*-Variable erben, die in der
*generichosttemplate*-Vorlage definiert ist. Die resultierende
Definition von *bighost1* sieht wie folgt aus:

 define host{
</code></pre>

### 7.26.8. additive Vererbung von Zeichenketten-Werten

Icinga gibt lokalen Variablen Vorrang vor Werten, die von Vorlagen
vererbt werden. In den meisten Fällen überschreiben lokale
Variablenwerte jene, die in Vorlagen definiert sind. In einigen Fällen
ist es sinnvoll, dass Icinga die Werte von geerbten *und* lokalen
Variablen gemeinsam nutzt.

Diese "additive Vererbung" kann durch Voranstellen eines Pluszeichens
(**+**) vor den lokalen Variablenwert erreicht werden. Dieses Feature
ist nur für Standard-Variablen verfügbar, die Zeichenketten-Werte
enthalten. Nehmen Sie das folgende Beispiel:

 define host{
 define host{
</code></pre>

In diesem Fall wird der *linuxserver1* den Wert der lokalen
*hostgroups*-Variablen dem der *generichosttemplate*-Vorlage hinzufügen.
Die resultierende Definition von *linuxserver1* sieht wie folgt aus:

 define host{
</code></pre>

### 7.26.9. Implizite Vererbung

Normalerweise müssen Sie entweder explizit den Wert einer erforderlichen
Variable in einer Objektdefinition angeben oder sie von einer Vorlage
erben. Es gibt ein paar Ausnahmen zu dieser Regel, in denen Icinga
annimmt, dass Sie einen Wert benutzen wollen, der statt dessen von einem
verbundenen Objekt kommt. Die Werte einiger Service-Variablen werden zum
Beispiel vom Host kopiert, mit dem der Service verbunden ist, wenn Sie
diese nicht anderweitig angeben.

Die folgende Tabelle führt die Objektvariablen auf, die implizit von
verbundenen Objekten vererbt werden, wenn Sie deren Werte nicht explizit
angeben oder sie von einer Vorlage erben.

**Objekttyp**

**Objektvariable**

**implizite Quelle**

**Services**

*contact\_groups*

*contact\_groups* in der verbundenen Host-Definition

*contacts*

*contacts* in der verbundenen Host-Definition

*notification\_interval*

*notification\_interval* in der verbundenen Host-Definition

*notification\_period*

*notification\_period* in der verbundenen Host-Definition

**Host Escalations**

*contact\_groups*

*contact\_groups* in der verbundenen Host-Definition

*contacts*

*contacts* in der verbundenen Host-Definition

*notification\_interval*

*notification\_interval* in der verbundenen Host-Definition

*escalation\_period*

*notification\_period* in der verbundenen Host-Definition

**Service Escalations**

*contact\_groups*

*contact\_groups* in der verbundenen Service-Definition

*contacts*

*contacts* in der verbundenen Service-Definition

*notification\_interval*

*notification\_interval* in der verbundenen Service-Definition

*escalation\_period*

*notification\_period* in der verbundenen Service-Definition

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Werte werden nur im Falle des Zustandswechsels eines Objekts
vererbt, so dass sich "in der verbundenen ... Definition" nur auf die
eine Host/Service-Kombination bezieht, die fehlschlägt/sich erholt,
obwohl es möglich ist, einen Service für ein oder mehrere Hostgruppen
auszuführen.

### 7.26.10. implizite/additive Vererbung bei Eskalationen

Service- und Host-Eskalationsdefinitionen können eine spezielle Regel
benutzen, die die Möglichkeiten von impliziter und additiver Vererbung
kombiniert. Wenn Eskalationen 1) nicht die Werte ihrer
*contact\_groups*- oder *contacts*-Direktiven von anderen
Eskalationsvorlagen erben und 2) ihre *contact\_groups*- oder
*contacts*-Direktiven mit einen Plus-Zeichen (+) beginnen, dann werden
die Werte der *contact\_groups* oder *contacts*-Direktiven der
entsprechenden Host- oder Service-Definitionen in der additiven
Vererbungslogik benutzt.

Verwirrt? Hier ein Beispiel:

 define host{
 define hostescalation{
</code></pre>

Das ist ein viel einfacheres Äquivalent zu:

 define hostescalation{
</code></pre>

### 7.26.11. Wichtige Werte (important values)

Service-Vorlagen können eine spezielle Regel benutzen, die ihrem
check\_command-Wert Vorrang gibt. Wenn das check\_command mit einem
Ausrufungszeichen (!) beginnt, dann wird das check\_command der Vorlage
als wichtig markiert und wird statt des im Service definierten
check\_command (dies ist der CSS-Syntax nachempfunden, die ! als
wichtiges Attribut benutzt).

Warum ist das nützlich? Es ist hauptsächlich dann sinnvoll, wenn ein
unterschiedliches check\_command für verteilte Systeme gesetzt wird. Sie
wollen vielleicht einen Frische-Schwellwert und ein check\_command
setzen, der den Service in einen fehlerhaften Status versetzt, aber das
funktioniert nicht mit dem normalen Vorlagensystem. Dieses
"wichtig"-Kennzeichen erlaubt es, das angepasste check\_command zu
schreiben, aber eine allgemeine verteilte Vorlage zu benutzen, die das
check\_command überlagert, wenn es auf dem zentralen Icinga-Server
eingesetzt wird.

Zum Beispiel:

# On master
define service {
# On slave
define service {
# Service definition, used by master and slave
define service {
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass nur eine Vererbungsebene bei diesen wichtigen
Werten möglich ist. Das bedeutet, dass Sie nicht das check\_command von
einer Vorlage zu einer weiteren und von dort zum Service vererben
können.

<pre><code>
</code></pre>

### 7.26.12. Mehrere Vererbungsquellen

Bisher haben alle Beispiele Objektdefinitionen gezeigt, die
Variablen/Werte von einer einzelnen Quelle erben. Sie können für
komplexere Konfigurationen auch Variablen/Werte von mehreren Quellen
erben, wie unten gezeigt.

 # Generic host template
 define host{
 # Development web server template
 define host{
 # Development web server
 define host{
</code></pre>

![](../images/multiple-templates1.png)

Im obigen Beispiel erbt *devweb1* Variablen/Werte von zwei Quellen:
*generic-host* und *development-server*. Sie werden bemerken, dass in
beiden Quellen eine *check\_interval*-Variable definiert ist. Weil
*generic-host* die erste in *devweb1* durch die *use*-Direktive
angegebene Vorlage ist, wird der Wert für die *check\_interval*-Variable
durch den *devweb1*-Host vererbt. Nach der Vererbung sieht die
Definition von *devweb1* wie folgt aus:

 # Development web server
 define host{
</code></pre>

### 7.26.13. Vorrang bei mehreren Vererbungsquellen

Wenn Sie mehrere Vererbungsquellen nutzen, ist es wichtig zu wissen, wie
Icinga Variablen behandelt, die in mehreren Quellen definiert sind. In
diesen Fällen wird Icinga die Variable/den Wert aus der ersten Quelle
benutzen, die in der *use*-Direktive angegeben ist. Weil
Vererbungsquellen ebenfalls Variablen/Werte aus ein oder mehreren
Quellen erben können, kann es kompliziert werden herauszufinden, welche
Variablen/Werte-Paare Vorrang haben.

Betrachten Sie die folgende Host-Definition, die drei Vorlagen
referenziert:

 # Development web server
 define host{
</code></pre>

Wenn einige dieser referenzierten Vorlagen selbst Variablen/Werte von
ein oder mehreren Vorlagen erben, werden die Vorrangregeln auf der
rechten Seite gezeigt.

Test, Versuch und Irrtum werden Ihnen helfen, besser zu verstehen, wie
die Dinge in komplexen Vererbungssituationen wie dieser funktionieren.
:-)

![](../images/multiple-templates2.png)

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
