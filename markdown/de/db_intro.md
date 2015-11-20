 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

12.1. Einleitung
----------------

12.1.1. [Zweck](db_intro.md#purpose)

12.1.2. [Design-Überblick](db_intro.md#design)

12.1.3. [Instanzen](db_intro.md#instances)

12.1.4. [Installation](db_intro.md#install)

Das IDOUtils-Addon (Icinga Data Output Utils) basiert auf den NDOUtils,
die ursprünglich vom Nagios (R)-Entwickler Ethan Galstad erstellt
wurden, so dass die Grundlagen sowohl auf Nagios als auch auf Icinga
zutreffen.

### 12.1.1. Zweck

Das IDOUtils-Addon dient dazu, alle Konfigurations- und Ereignisdaten
(Statusdaten, historische Daten von Icinga in einer relationalen
Datenbank abzulegen. Das Speichern der Informationen von Icinga in einem
RDBMS erlaubt die schnellere Abfrage und Verarbeitun der Daten. Icinga
Web verwendet diese Daten, sowie auch andere Addons wie NagVis dies als
Datenquelle heranziehen können. Icinga Web stellt seine eigene REST API
zur Verfügung.

Bisher werden MySQL, Oracle und PostgreSQL von IDOUtils unterstützt.
Andere Datenbanksysteme werden ggf. unterstützt, wenn sich genügend
interessierte Benutzer und vor allem Benutzer finden, die Tests
durchführen.

### 12.1.2. Design-Überblick

Das IDOUtils-Addon wurde entwickelt für Benutzer mit:




Daten eines Icinga-Prozesses (im weiteren als "Instanz" bezeichnet)
können entweder in der gleichen oder in verschiedenen Datenbanken wie
die Daten von anderen Icinga-Instanzen gespeichert werden.

**Abbildung 12.1. Mögliche Anordnungen**

![Mögliche Anordnungen](../images/fig1.png)

\

Obwohl es bisher nicht unterstützt wird, könnten in der Zukunft die
Daten einer beliebigen Instanz in mehrere Datenbanken gespeichert
werden, falls das gewünscht wird..

**Abbildung 12.2. zukünfte Entwicklung: Eine Instanz, mehrere
Datenbanken**

![zukünfte Entwicklung: Eine Instanz, mehrere
Datenbanken](../images/fig2.png)

\

### 12.1.3. Instanzen

Jeder Icinga-Prozess, egal ob es ein einzelner Überwachungsserver oder
Teil eines verteilten, redundanten Setups ist, ggf. mit
Ausfallsicherung, wird als "Instanz" bezeichnet. Um die Integrität der
gespeicherten Daten zu gewährleisten muss jede Icinga-Instanz mit einem
eindeutigen Bezeichner oder Namen gekennzeichnet werden.

Sie können den Namen jeder Icinga-Instanz Ihren Bedürfnissen anpassen.
So können Sie z.B. die Icinga-Instanzen aufgrund des geografischen
Standorts bezeichnen....

**Abbildung 12.3. Instanznamen basierend auf dem geografischen
Standorts**

![Instanznamen basierend auf dem geografischen
Standorts](../images/fig3.png)

\

Oder Sie können die Icinga-Instanzen nach dem Zweck benennen...

**Abbildung 12.4. Instanznamen basierend auf dem Zweck**

![Instanznamen basierend auf dem Zweck](../images/fig4.png)

\

Wie Sie die Icinga-Instanzen nennen, bestimmen Sie. Wichtig ist dabei
lediglich, dass jeder einzelne Icinga-Prozess einen eindeutigen
Instanznamen erhält.

Mehr Informationen dazu, welche Rolle die Instanznamen spielen, gibt es
in den nächsten Abschnitten.

### 12.1.4. Installation

Die installation der IDOUtils wird im [Quickstart
IDOUtils](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
beschrieben.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
