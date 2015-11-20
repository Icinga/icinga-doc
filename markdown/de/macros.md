 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.2. Makros verstehen und wie sie arbeiten
------------------------------------------

5.2.1. [Makros](macros.md#introduction)


5.2.3. [Beispiel 1: Host-Address Makro](macros.md#hostaddressexample)

5.2.4. [Beispiel 2:
Befehlsargument-Makros](macros.md#commandargexample)

5.2.5. [On-Demand-Makros](macros.md#ondemand)

5.2.6. [On-Demand-Gruppen-Makros](macros.md#ondemandgroup)

5.2.7. [Benutzervariablen-Makros](macros.md#customvar)

5.2.8. [Makrobereinigung](macros.md#cleaning)

5.2.9. [Makros als Umgebungsvariablen](macros.md#environmentvars)

5.2.10. [Verfügbare Makros](macros.md#availablelist)

### 5.2.1. Makros

Eine der Haupteigenschaften, die Icinga so flexibel machen, ist die
Fähigkeit, Makros in Befehlsdefinitionen zu benutzen. Makros erlauben
Ihnen, Bezug auf Informationen von Hosts, Services und anderen Quellen
zu nehmen.


Bevor Icinga einen Befehl ausführt, ersetzt es jedes Makro, das es in
der Befehlsdefinition findet, durch den entsprechenden Wert. Diese
Makroersetzung erfolgt für alle Arten von Befehlen, die Icinga ausführt
- Host- und Service-Checks, Benachrichtigungen, Eventhandler usw.

Bestimmte Makros können wieder Makros enthalten. Dazu zählen die Makros
\$HOSTNOTES\$, \$HOSTNOTESURL\$, \$HOSTACTIONURL\$, \$SERVICENOTES\$,
\$SERVICENOTESURL\$ und \$SERVICEACTIONURL\$.

### 5.2.3. Beispiel 1: Host-Address Makro

Wenn Sie Host- und Service-Makros in Befehlsdefinitionen benutzen,
beziehen sich diese auf Werte für den Host oder Service, für den der
Befehl ausgeführt wird. Nehmen wir ein Beispiel. Angenommen, wir
benutzen eine Host-Definition und einen *check\_ping*-Befehl, die wie
folgt definiert sind:

<pre><code>
 define host{
 define command{
</code></pre>

die erweiterte/endgültige auszuführende Befehlszeile für die
Host-Prüfung würde so aussehen:

$> /usr/local/icinga/libexec/check_ping -H 192.168.1.2 -w 100.0,25% -c 200.0,50%
</code></pre>

Ziemlich einfach, stimmt's? Die Schönheit liegt darin, dass Sie eine
einzelne Befehlsdefinition für eine unbegrenzte Zahl von Hosts nutzen
können. Jeder Host kann mit der selben Befehlsdefinition geprüft werden,
weil jede Host-Adresse automatisch vor der Ausführung in der
Befehlszeile ersetzt wird.

### 5.2.4. Beispiel 2: Befehlsargument-Makros

Sie können auch Argumente an Befehle übergeben, was recht handlich ist,
wenn Sie Ihre Befehlsdefinitonen ziemlich generisch halten möchten.
Argumente werden in der Objektdefinition (d.h. Host oder Service)
angegeben, indem sie durch Ausrufezeichen (!) vom Befehlsnamen getrennt
werden:

<pre><code>
 define service{
</code></pre>

Im obigen Beispiel hat der Service-Check zwei Argumente (auf die mit
[\$ARGn\$](macrolist.md#macrolist-arg)-Makros zugegriffen werden
kann). Das \$ARG1\$-Makro wird "200.0,50%" und \$ARG2\$ wird "400.0,25%"
(beide ohne Anführungszeichen). Angenommen, wir benutzen die vorher
angegebene Host-Definiton und einen wie folgt definierten
*check\_ping*-Befehl:

<pre><code>
 define command{
</code></pre>

die erweiterte/endgültige auszuführende Befehlszeile für die
Service-Prüfung würde so aussehen:

$> /usr/local/icinga/libexec/check_ping -H 192.168.1.2 -w 200.0,25% -c 400.0,50%
</code></pre>

![[Tipp]](../images/tip.png)

Tipp

Falls Sie Ausrufezeichen (!) in Ihren Argumenten übergeben müssen, dann
können Sie das tun, indem Sie diese mit einem Backslash (\\) maskieren.
Falls Sie Backslashes in Ihren Argumenten einsetzen müssen, sind diese
ebenfalls mit Backslashes zu maskieren.

![[Tipp]](../images/tip.png)

Tipp

Falls Sie ein Semikolon (;) in Ihren Argumenten übergeben müssen, dann
können Sie das nicht tun, indem Sie das Zeichen in der Definition
verwenden, weil es als Start eines Kommentars angesehen wird. Sie
definieren stattdessen eine \$USER\$-Variable in der Ressource-Datei und
benutzen diese in Ihrer Definition.

Ressource File

<pre><code>
$USER255$=;
</code></pre>

Command-Definition

<pre><code>
define command{
}
</code></pre>

### 5.2.5. On-Demand-Makros

Wenn Sie Host- und Service-Makros in Ihren Befehlsdefinitionen benutzen,
dann beziehen sie sich normalerweise auf Werte des Hosts oder Service,
für den der Befehl ausgeführt wird. Wenn beispielsweise eine
Host-Prüfung für einen Host namens "linuxbox" ausgeführt wird, werden
sich all die
[Standard-Host-Makros](macrolist.md "5.3. Standard-Makros in Icinga")
auf Werte für diesen Host beziehen ("linuxbox").

Wenn Sie möchten, dass sich die Werte eines Befehls auf einen anderen
Host oder Service beziehen (für den der Befehl nicht ausgeführt wird),
dann können Sie die sogenannten "On-Demand-Makros" benutzen.
On-Demand-Makros sehen wie normale Makros aus, außer der Tatsache, dass
sie einen Bezeichner für den Host oder Service enthalten, von dem sie
ihren Wert erhalten sollen. Hier das grundsätzliche Format von
On-Demand-Makros:



Ersetzen Sie *HOSTMACRONAME* und *SERVICEMACRONAME* durch den Namen
eines der Standard-Host- oder Service-Makros, die
[hier](macrolist.md "5.3. Standard-Makros in Icinga") zu finden sind.

Beachten Sie, dass der Makroname durch einen Doppelpunkt (:) vom Host-
oder Service-Bezeichner getrennt ist. Für On-Demand-Service-Makros
besteht der Service-Bezeichner aus einem Host-Namen und einer
voneinander getrennt.

![](../images/tip.gif) Hinweis: On-Demand-Service-Makros können ein
leeres Host-Namen-Feld enthalten. In diesem Fall wird automatisch der
Name des Hosts benutzt, der mit dem Service verbunden ist.

Beispiele für On-Demand-Host- und Service-Makros folgen:

</code></pre>

On-Demand-Makros gibt es auch für hostgroup-, servicegroup-, contact-
und contactgroup-Makros. Zum Beispiel:

</code></pre>

### 5.2.6. On-Demand-Gruppen-Makros

Sie können die Werte eines Makros über alle Kontakte, Hosts oder
Services in einer bestimmten Gruppe mit einem speziellen Format Ihrer
On-Demand-Makrodeklaration erhalten. Sie tun dies, indem Sie auf eine
bestimmte Hostgruppe, Servicegruppe oder Kontaktgruppe in einem
On-Demand-Makro verweisen und zwar wie folgt:




Ersetzen Sie *HOSTMACRONAME*, *SERVICEMACRONAME* und *CONTACTMACRONAME*
durch den Namen eines der Standard-Host-, Service- oder Kontaktmakros,
die Sie [hier](macrolist.md "5.3. Standard-Makros in Icinga") finden.
Der Begrenzer (delimiter), den Sie angeben, wird benutzt, um Makrowerte
der einzelnen Gruppenmitglieder von einander zu trennen.

Das folgende Makro wird beispielsweise eine komma-separierte Liste von
Host-Status-IDs zurückliefern, die Mitglieder der *hg1*-Hostgruppe sind:

 $HOSTSTATEID:hg1:,$
</code></pre>

Diese Makrodefinition wird etwas zurückliefern, was etwa so aussieht:

 0,2,1,1,0,0,2
</code></pre>

### 5.2.7. Benutzervariablen-Makros

Jede
[Benutzerobjekt-Variable](customobjectvars.md "3.5. Maßgeschneiderte Objektvariablen"),
die Sie in Host-, Service- oder Contact-Definitionen einsetzen, ist auch
in Makros verfügbar. Benutzervariablen-Makros werden wie folgt benannt:




Nehmen Sie die folgende Host-Definition mit einer "\_MACADDRESS"
genannten Benutzervariablen...

<pre><code>
 define host{
</code></pre>

Die Benutzervariable \_MACADRESS wäre in einem Makro
\$\_HOSTMACADDRESS\$ verfügbar. Weitere Informationen zu
Benutzervariablen und wie sie in Makros eingesetzt werden können, finden
Sie
[hier](customobjectvars.md "3.5. Maßgeschneiderte Objektvariablen").

### 5.2.8. Makrobereinigung

Einige Makros werden von potenziell gefährlichen Shell-Metazeichen
bereinigt, bevor Ersetzungen in Befehlen stattfinden. Welche Zeichen aus
den Makros entfernt werden, hängt von den Einstellungen der
[illegal\_macro\_output\_chars](configmain.md#configmain-illegal_macro_output_chars)-Direktive
ab. Die folgenden Makros werden von potenziell gefährlichen Zeichen
bereinigt:










10. [\$SERVICEACKCOMMENT\$](macrolist.md#macrolist-serviceackcomment)

### 5.2.9. Makros als Umgebungsvariablen

Die meisten Makros werden als Umgebungsvariablen zur Verfügung gestellt,
um einen einfachen Einsatz in Scripts oder Befehlen zu ermöglichen, die
von Icinga ausgeführt werden. Aus Gründen der Sicherheit und der
Vernunft werden [\$USERn\$](macrolist.md#macrolist-user) und
"on-demand" Host- und Service-Makros nicht als Umgebungsvariablen zur
Verfügung gestellt.

Umgebungsvariablen, die Standard-Makros enthalten, werden ebenso wie
ihre entsprechenden Makronamen benannt
([hier](macrolist.md "5.3. Standard-Makros in Icinga") aufgeführt),
wobei ihnen "ICINGA\_" vorangestellt wird. Beispielsweise wäre das
[\$HOSTNAME\$](macrolist.md#macrolist-hostname)-Makro als
Umgebungsvariable "ICINGA\_HOSTNAME" verfügbar.

### 5.2.10. Verfügbare Makros

Eine Liste aller in Icinga verfügbaren Makros sowie eine Tabelle, wann
sie eingesetzt werden können, finden Sie
[hier](macrolist.md "5.3. Standard-Makros in Icinga").

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
