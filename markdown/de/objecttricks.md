 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.27. Zeitsparende Tricks für Objektdefinitionen
------------------------------------------------

oder...

**Einführung**

Dieses Dokument versucht zu erklären, wie Sie die (etwas) versteckten
Möglichkeiten von [vorlagenbasierenden
Objektdefinitionen](objectdefinitions.md "3.4. Objektdefinitionen")
ausnutzen können, um Ihren Verstand zu bewahren. Sie fragen sich wie?
Verschiedene Objekttypen erlauben es Ihnen, mehrere Host-Namen und/oder
Hostgruppen-Namen in Definitionen anzugeben und die Objektdefinitionen
in mehrere Hosts oder Services zu "kopieren". Wir werden jeden
Objekttyp, der diese Möglichkeiten unterstützt, separat behandeln. Für
den Anfang sind die Objekttypen, die diese zeitsparende Möglichkeit
unterstützen, wie folgt:







Objekttypen, die nicht oben aufgeführt sind (z.B. Zeitfenster, Befehle
usw.), unterstützen nicht die Möglichkeiten, die wir beschreiben werden.

**Übereinstimmung von regulären Ausdrücken** (Regular Expression
Matching)

Die Beispiele, die wir unten zeigen, benutzen "Standard"-Übereinstimmung
(Matching) von Objektnamen und **\*erfordern\***, dass die Option
[use\_regexp\_matching](configmain.md#configmain-use_regexp_matching)**\*deaktiviert\***ist.

Wenn Sie wollen, können Sie die Übereinstimmung von regulären Ausdrücken
mit Hilfe der
[use\_regexp\_matching](configmain.md#configmain-use_regexp_matching)-Konfigurationsoption
aktivieren. Reguläre Ausdrücke können in jedem der Felder benutzt
werden, die in den Beispielen unten benutzt werden (Hostnamen,
Hostgruppen-Namen, Service-Namen und Servicegruppen-Namen).

![[Anmerkung]](../images/note.png)

Anmerkung

Seien Sie vorsichtig bei der Aktivierung der Übereinstimmung von
ändern müssen, weil vielleicht einige der Direktiven als reguläre
Ausdrücke interpretiert werden, bei denen Sie das nicht möchten!
Probleme sollten offensichtlich werden, sobald Sie Ihre Konfiguration
überprüfen.

Wenn Sie beabsichtigen reguläre Ausdrücke zu nutzen
(`use_regexp_matching=1`), dann stellen Sie sicher, dass Sie die
man-Page (`man regex`) gelesen und verstanden haben.

**Service-Definitionen**

**Mehrere Hosts:**

Wenn Sie identische
[Services](objectdefinitions.md#objectdefinitions-service) erzeugen
möchten, die mehreren Hosts zugeordnet sind, können Sie mehrere Hosts in
der *host\_name*-Direktive angeben. Die folgende Definition würde einen
Service namens *SOMESERVICE* auf den Hosts *HOST1* bis *HOSTN* erzeugen.
Jede Instanz des *SOMESERVICE*-Service wäre identisch (d.h. hätte den
gleichen Prüfbefehl, Benachrichtigungsperiode, usw.).

</code></pre> 
 define service{
</code></pre>

**Alle Hosts in mehreren Hostgruppen:**

Wenn Sie identische Services erzeugen wollen, die allen Hosts in einer
oder mehreren Hostgruppen zugeordnet sind, können Sie das mit einer
einzigen Service-Definition erreichen. Wie? Die
*hostgroup\_name*-Direktive erlaubt es Ihnen, den Namen von einer oder
mehreren Hostgruppen anzugeben, für den dieser Service erzeugt werden
soll. Die folgende Definition würde einen Service namens *SOMESERVICE*
auf allen Hosts anlegen, die Mitglied von Hostgruppe *HOSTGROUP1* bis
*HOSTGROUPN* sind. Alle Instanzen des *SOMESERVICE*-Service wären
identisch (d.h. hätten den gleichen Prüfbefehl,
Benachrichtigungsperiode, usw.).

</code></pre> 
 define service{
</code></pre>

**Alle Hosts:**

Wenn Sie identische Services erzeugen wollen, die allen Hosts in Ihren
Konfigurationsdateien zugeordnet sind, können Sie einen Platzhalter
(wildcard) in der *host\_name*-Direktive benutzen. Die folgende
Definition würde einen Service namens *SOMESERVICE* auf **allen Hosts**
erzeugen, die in Ihren Konfigurationsdateien definiert sind. Alle
Instanzen des *SOMESERVICE*-Service wären identisch (d.h. hätten den
gleichen Prüfbefehl, Benachrichtigungsperiode, usw.).

</code></pre> 
 define service{
</code></pre>

**Hosts ausschließen:**

Wenn Sie identische Services auf zahlreichen Hosts anlegen, aber einige
Hosts von dieser Definition ausnehmen möchten, kann dies durch das
Voranstellen eines Ausrufezeichens (!) vor dem Host oder der Hostgruppe
geschehen.

</code></pre> 
 define service{
</code></pre>

**Service-Eskalationsdefinitionen**

**Mehrere Hosts:**

Wenn Sie identische
[Service-Eskalationen](objectdefinitions.md#objectdefinitions-serviceescalation)
für Services mit dem gleichen Namen/der gleichen Beschreibung erzeugen
möchten, die mehreren Hosts zugeordnet sind, können Sie mehrere Hosts in
der *host\_name*-Direktive angeben. Die folgende Definition würde eine
Service-Eskalation für Services namens *SOMESERVICE* auf den Hosts
*HOST1* bis *HOSTN* erzeugen. Alle Instanzen des *SOMESERVICE*-Service
wären identisch (d.h. hätten den gleichen Prüfbefehl,
Benachrichtigungsperiode, usw.).

</code></pre> 
 define serviceescalation{
</code></pre>

**Alle Hosts in mehreren Hostgruppen:**

Wenn Sie identische Service-Eskalationen für Services mit dem gleichen
Namen/der gleichen Beschreibung erzeugen wollen, die allen Hosts in
einer oder mehreren Hostgruppen zugeordnet sind, können Sie das mit der
*hostgroup\_name*-Direktive tun. Die folgende Definition würde eine
Service-Eskalation für Services namens *SOMESERVICE* auf allen Hosts
anlegen, die Mitglied von Hostgruppe *HOSTGROUP1* bis *HOSTGROUPN* sind.
Alle Instanzen des *SOMESERVICE*-Service wären identisch (d.h. hätten
den gleichen Prüfbefehl, Benachrichtigungsperiode, usw.).

</code></pre> 
 define serviceescalation{
</code></pre>

**Alle Hosts:**

Wenn Sie identische Service-Eskalationen für Services mit dem gleichen
Namen/der gleichen Beschreibung erzeugen wollen, die allen Hosts in
Ihren Konfigurationsdateien zugeordnet sind, können Sie einen
Platzhalter (wildcard) in der *host\_name*-Direktive benutzen. Die
folgende Definition würde eine Service-Eskalation für alle Service
namens *SOMESERVICE* auf **allen Hosts** erzeugen, die in Ihren
Konfigurationsdateien definiert sind. Alle Instanzen des
*SOMESERVICE*-Service wären identisch (d.h. hätten den gleichen
Prüfbefehl, Benachrichtigungsperiode, usw.).

</code></pre> 
 define serviceescalation{
</code></pre>

**Hosts ausschließen:**

Wenn Sie identische Service-Eskalationen für Services auf zahlreichen
Hosts anlegen, aber einige Hosts von dieser Definition ausnehmen
möchten, kann dies durch das Voranstellen eines Ausrufezeichens (!) vor
dem Host oder der Hostgruppe geschehen.

</code></pre> 
 define serviceescalation{
</code></pre>

**Alle Services auf dem gleichen Host:**

Wenn Sie
[Service-Eskalationen](objectdefinitions.md#objectdefinitions-serviceescalation)
für alle Services eines bestimmten Hosts anlegen möchten, können Sie
einen Platzhalter in der *service\_description*-Direktive benutzen. Die
folgende Definition würde eine Service-Eskalation für *alle* Services
auf Host *HOST1* erzeugen. Alle Instanzen der Service-Eskalation wären
identisch (d.h. hätten die gleichen Kontaktgruppe,
Benachrichtigungsintervall, usw.).

Wenn Sie sich abenteuerlustig fühlen, dann können Sie einen Platzhalter
sowohl bei der *host\_name*- als auch bei der
*service\_description*-Direktive angeben. Dadurch würden Sie eine
Service-Eskalation für **alle Services** anlegen, die Sie in Ihren
Konfigurationsdateien definiert haben.

</code></pre> 
 define serviceescalation{
</code></pre>

**Mehrere Services auf dem gleichen Host:**

Wenn Sie
[Service-Eskalationen](objectdefinitions.md#objectdefinitions-serviceescalation)
für mehrere Services eines bestimmten Hosts anlegen möchten, können Sie
mehr als eine Service-Beschreibung in der
*service\_description*-Direktive benutzen. Die folgende Definition würde
eine Service-Eskalation für die Services *SERVICE1* bis *SERVICEN* auf
Host *HOST1* erzeugen. Alle Instanzen der Service-Eskalation wären
identisch (d.h. hätten die gleichen Kontaktgruppe,
Benachrichtigungsintervall, usw.).

</code></pre> 
 define serviceescalation{
</code></pre>

**Alle Services in mehreren Servicegruppen:**

Wenn Sie
[Service-Eskalationen](objectdefinitions.md#objectdefinitions-serviceescalation)
für alle Services anlegen möchten, die zu einer oder mehreren
Servicegruppen gehören, können Sie die *servicegroup\_name*-Direktive
benutzen. Die folgende Definition würde Service-Eskalationen für alle
Services anlegen, die Mitglied der Servicegruppen *SERVICEGROUP1* bis
*SERVICEGROUPN* sind. Alle Instanzen der Service-Eskalation wären
identisch (d.h. hätten die gleichen Kontaktgruppe,
Benachrichtigungsintervall, usw.).

</code></pre> 
 define serviceescalation{
</code></pre>

**Service-Abhängigkeitsdefinitionen**

**Mehrere Hosts:**

Wenn Sie
[Service-Abhängigkeiten](objectdefinitions.md#objectdefinitions-servicedependency)
für Services mit dem gleichen Namen/der gleichen Beschreibung erstellen
möchten, die mehreren Hosts zugeordnet sind, können Sie mehrere Hosts in
den *host\_name*- und/oder *dependent\_host\_name*-Direktiven benutzen.
Im folgenden Beispiel wäre Service *SERVICE2* auf den Hosts *HOST3* und
*HOST4* abhängig von *SERVICE1* auf den Hosts *HOST1* und *HOST2*. Alle
Instanzen der Service-Abhängigkeiten wären identisch bis auf die
Host-Namen (d.h. hätten die gleichen Fehlerbenachrichtigungs-Kriterien
usw.).

</code></pre> 
 define servicedependency{
</code></pre>

**Alle Hosts in mehreren Hostgruppen:**

Wenn Sie Service-Abhängigkeiten für Services mit dem gleichen Namen/der
gleichen Beschreibung erstellen möchten, die allen Hosts in einer oder
mehreren Hostgruppen zugeordnet sind, können Sie die *hostgroup\_name*-
und/oder *dependent\_hostgroup\_name*-Direktiven benutzen. Im folgenden
Beispiel wäre Service *SERVICE2* auf allen Hosts in den Hostgruppen
*HOSTGROUP3* und *HOSTGROUP4* abhängig von *SERVICE1* auf allen Hosts in
den Hostgruppen *HOSTGROUP1* und *HOSTGROUP2*. Angenommen, es gibt fünf
Hosts in jeder der Hostgruppen, dann wäre diese Definition äquivalent
zur Definition von 100 einzelnen Service-Abhängigkeitsdefinitionen! Alle
Instanzen der Service-Abhängigkeiten wären identisch bis auf die
Host-Namen (d.h. hätten die gleichen Fehlerbenachrichtigungs-Kriterien
usw.).

</code></pre> 
 define servicedependency{
</code></pre>

**Alle Services auf einem Host:**

Wenn Sie Service-Abhängigkeiten für alle Services eines bestimmten Hosts
erstellen möchten, können Sie einen Platzhalter in den
*service\_description*- und/oder
*dependent\_service\_description*-Direktiven benutzen. Im folgenden
Beispiel wären **alle Services** auf Host *HOST2* abhängig von **allen
Services** auf Host *HOST1*. Alle Instanzen der Service-Abhängigkeiten
wären identisch (d.h. hätten die gleichen
Fehlerbenachrichtigungs-Kriterien usw.).

</code></pre> 
 define servicedependency{
</code></pre>

**Mehrere Services auf einem Host:**

Wenn Sie Service-Abhängigkeiten für mehrere Services eines bestimmten
Hosts erstellen möchten, können Sie mehr als eine Service-Beschreibung
in den *service\_description*- und/oder
*dependent\_service\_description*-Direktiven wie folgt angeben:

</code></pre> 
 define servicedependency{
</code></pre>

**Alle Services in mehreren Servicegruppen:**

Wenn Sie Service-Abhängigkeiten für alle Services erstellen möchten, die
einer oder mehreren Servicegruppen zugeordnet sind, können Sie die
*servicegroup\_name*- und/oder
*dependent\_servicegroup\_name*-Direktiven wie folgt benutzen:

</code></pre> 
 define servicedependency{
</code></pre>

**Abhängigkeiten des gleichen Hosts:**

Wenn Sie Service-Abhängigkeiten für mehrere Services erstellen möchten,
die von Services auf dem gleichen Host abhängig sind, lassen Sie die
*dependent\_host\_name*- und *dependent\_hostgroup\_name*-Direktiven
leer. Im folgenden Beispiel wird angenommen, dass den Hosts *HOST1* und
*HOST2* mindestens die folgenden vier Services zugeordnet sind:
*SERVICE1*, *SERVICE2*, *SERVICE3* und *SERVICE4*. In diesem Beispiel
sind *SERVICE3* und *SERVICE4* auf *HOST1* abhängig von *SERVICE1* und
*SERVICE2* auf *HOST1*. Ähnlich sind *SERVICE3* und *SERVICE4* auf
*HOST2* abhängig von *SERVICE1* und *SERVICE2* auf *HOST2*.

</code></pre> 
 define servicedependency{
</code></pre>

**Abhängigkeiten des gleichen Hosts mit Servicegruppen:**

Wenn Sie Service-Abhängigkeiten für alle Services erstellen möchten, die
zu einer oder mehreren Servicegruppen eines Service gehören, der auf dem
gleichen Host wie der abhängige Service läuft, lassen Sie die
*host\_name*- und *hostgroup\_name*-Direktiven leer. Im folgenden
Beispiel wird angenommen, dass Hosts mit Services aus den Servicegruppen
*SERVICEGROUP1* und *SERVICEGROUP2* auch folgender Service zugeordnet
ist: *SERVICE1*. In diesem Beispiel sind alle Service aus den
Servicegruppen *SERVICEGROUP1* und *SERVICEGROUP2* abhängig von
*SERVICE1*, der auf dem gleichen Host läuft wie der abhängige Service.

</code></pre> 
</code></pre>

**Host-Eskalationsdefinitionen**

**Mehrere Hosts:**

Wenn Sie
[Host-Eskalationen](objectdefinitions.md#objectdefinitions-hostescalation)
für mehrere Hosts erstellen möchten, können Sie mehrere Hosts in der
*host\_name*-Direktive angeben. Die folgende Definitione würde eine
Host-Eskalation für die Hosts *HOST1* bis *HOSTN* anlegen. Alle
Instanzen der Host-Eskalation wären identisch (d.h. hätten die gleichen
Kontaktgruppen, Benachrichtigungsintervalle usw.).

</code></pre> 
 define hostescalation{
</code></pre>

**Alle Hosts in mehreren Hostgruppen:**

Wenn Sie Host-Eskalationen für alle Hosts in einer oder mehreren
Hostgruppen erstellen möchten, können Sie die
*hostgroup\_name*-Direktive benutzen. Die folgende Definition würde eine
Host-Eskalation für alle Hosts anlegen, die Mitglieder der Hostgruppen
*HOSTGROUP1* bis *HOSTGROUPN* sind. Alle Instanzen der Host-Eskalation
wären identisch (d.h. hätten die gleichen Kontaktgruppen,
Benachrichtigungsintervalle usw.).

</code></pre> 
 define hostescalation{
</code></pre>

**Alle Hosts:**

Wenn Sie identische Host-Eskalationen für alle Hosts erstellen wollen,
die in Ihren Konfigurationsdateien definiert sind, können Sie einen
Platzhalter in der *host\_name*-Direktive benutzen. Die folgende
Definition würde eine Host-Eskalation für alle Hosts anlegen, die in
Ihren Konfigurationsdateien definiert sind. Alle Instanzen der
Host-Eskalation wären identisch (d.h. hätten die gleichen
Kontaktgruppen, Benachrichtigungsintervalle usw.).

</code></pre> 
 define hostescalation{
</code></pre>

**Hosts ausschließen:**

Wenn Sie identische Host-Eskalationen auf zahlreichen Hosts oder
Hostgruppen erstellen, aber einige Hosts von der Definition ausschließen
möchten, kann dies durch das Voranstellen eines Ausrufezeichens (!) vor
dem Host oder der Hostgruppe geschehen.

</code></pre> 
 define hostescalation{
</code></pre>

**Host-Abhängigkeitsdefinitionen**

**Mehrere Hosts:**

Wenn Sie
[Host-Abhängigkeiten](objectdefinitions.md#objectdefinitions-hostdependency)
für mehrere Hosts erstellen möchten, können Sie mehrere Hosts in den
*host\_name*- und/oder *dependent\_host\_name*-Direktiven angeben. Die
folgende Definition wäre äquivalent mit der Erstellung von sechs
einzelnen Host-Abhängigkeiten. Im obigen Beispiel wären die Hosts
*HOST3*, *HOST4* und *HOST5* abhängig von den Hosts *HOST1* und *HOST2*.
Alle Instanzen der Host-Abhängigkeiten wären identisch bis auf die
Host-Namen (d.h. sie hätten die gleichen
Fehlerbenachrichtigungs-Kriterien, usw.).

</code></pre> 
 define hostdependency{
</code></pre>

**Alle Hosts in mehreren Hostgruppen:**

Wenn Sie Host-Abhängigkeiten für alle Hosts in einer oder mehreren
Hostgruppen erstellen möchten, können Sie die *hostgroup\_name*-
und/oder *dependent\_hostgroup\_name*-Direktiven benutzen. Im folgenden
Beispiel wären alle Hosts in den Hostgruppen *HOSTGROUP3* und
*HOSTGROUP4* abhängig von allen Hosts in den Hostgruppen *HOSTGROUP1*
und *HOSTGROUP2*. Alle Instanzen der Host-Abhängigkeiten wären identisch
bis auf die Host-Namen (d.h. sie hätten die gleichen
Fehlerbenachrichtigungs-Kriterien, usw.).

</code></pre> 
 define hostdependency{
</code></pre>

**Hostgruppen**

**Alle Hosts:**

Wenn Sie eine Hostgruppe anlegen möchten, die alle Hosts aus Ihren
Konfigurationsdateien als Mitglieder enthält, können Sie einen
Platzhalter in der *members*-Direktive benutzen. Die folgende Definition
würde eine Hostgruppe namens *HOSTGROUP1* erstellen, die **alle Hosts**
aus Ihren Konfigurationsdateien als Mitglieder enthält.

</code></pre> 
 define hostgroup{
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
