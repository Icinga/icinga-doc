 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

11.3. Keine Icinga API mehr zu installieren
-------------------------------------------

11.3.1. [Installation und Benutzung der Icinga
API](icinga-api.md#idp16704272)

11.3.2. [Konfiguration](icinga-api.md#idp16734992)

11.3.3. [Unterstützte Backends](icinga-api.md#idp16737520)

![[Wichtig]](../images/important.png)

Wichtig

In der Zeit vor dem Release der Version 1.5 sagten wir unserer Icinga
API "Tschüss" und führten ein neues API- und Web-Konzept ein.

Sie fragen sich vielleicht, was war diese API überhaupt? In der Tat,
wenn Sie keine Erweiterungen oder Anpassungen für das neue Web-Interface
entwickelt haben, dann hatten Sie wahrscheinlich wenig Kontakt mit
dieser wichtigen Projektkomponente. Als Icinga konzipiert wurde, war
eines der Hauptziele die Unterstützung der Entwicklung von Addons und
Plugins. Die API stellte einen Satz von allgemein verwendbaren
Abfragebefehlen zur Verfügung, um die Notwendigkeit zu beseitigen,
SQL-Abfragen und generell eine Menge überflüssigen Code zu schreiben.

Alles war in Ordnung, bis wir uns entschieden, etwas mehr zusätzliche
Datenbankflexibilität anzubieten. Als wir neben MySQL Unterstützung für
Oracle and PostgreSQL hinzufügten, gaben wir auch dem Icinga API-Team
etwas zusätzliche Arbeit. Mit jeder Änderung, jedem Bugfix oder neuer
Funktionalität mussten Marius, Michael L und Jannis die Abfragen für
jedes Datenbank-Backend separat anpassen. Dieser Prozess war nicht nur
kompliziert und fehlerbehaftet, sondern auch ein Zeichen dafür, dass wir
eine neue flexiblere Architektur benötigten.

Mit Icinga 1.5 wurde die externe Icinga API durch eine interne
Datenbankschicht namens Doctrine ersetzt und mit Icinga Web
verschmolzen. Ähnlich wie vorher laufen Abfragen durch diese Schicht
zwischen der Datenbank (IDOUtils) und dem Web-Interface. Trotzdem können
wir dank Doctrine mehrere Datenbank-Backends benutzen und das Abfragen
der Datenbank ist nun viel einfacher. Im Gegensatz zu SQL nutzt der
"object relational mapper" (ORM) die Doctrine Query Language, so dass
wir nun die Flexibilität ohne die Code-Duplizierung haben.

![](../images/Architecture_1.5_800px.png)

Allerdings funktionieren Abfragen mit der alten API nach wie vor, dank
des 'Legacy Layer', der alte API-Abfragen in diesen neuen ORM-Typ
umwandelt. Auf diese Weise erhalten wir die Kompatibilität mit Addons,
die für ältere Icinga-Versionen erstellt wurden. Das Rest-API ist also
weiterhin vorhanden als ein Teil von Icinga Web, und erweitert unsere
Doctrine-Schicht mit HTTP für Addons, die nur bestimmte Teile der
Überwachungsinformationen benötigen.

Durch den Wegfall einer eigenständigen API wird der durchschnittliche
Icinga-Benutzer kaum einen Unterschied bemerken, außer der Tatsache,
dass die Konfiguration nun in die `databases.xml` verschoben
wurde. Das Beste daran ist, dass jeder Modul-Entwickler nun einfach,
ohne viel Code-Overhead, auf die Icinga-Datenbank zugreifen kann- also
Adddon-Entwickler, legt los!

Mehr (englischsprachige) Informationen gibt es in unserem Wiki:




![[Wichtig]](../images/important.png)

Wichtig

Das Folgende ist veraltet

### 11.3.1. Installation und Benutzung der Icinga API










































### 11.3.2. Konfiguration

Wenn Sie Ihr eigenes Addon auf Basis der Icinga API entwickeln möchten,
benötigen Sie das folgende assoziative Array:

<pre><code>
 $idoConfig = array (
 );
</code></pre>

Beispiel:

<pre><code>
 $idoConfig = array (
 );
</code></pre>

### 11.3.3. Unterstützte Backends

Aktuell sind folgende Backend Typen verfügbar. Mehr Information finden
Sie unter doc/icinga-api-types.txt.




**Benutzung**


















* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
