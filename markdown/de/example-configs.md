 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

12.4. Beispielkonfigurationen
-----------------------------

12.4.1. [Einzelner Server, einzelne
Instanz](example-configs.md#singleserversingleinstance)

12.4.2. [Einzelner Server, mehrere
Instanzen](example-configs.md#singleservermultipleinstance)

12.4.3. [Einzelner Server, einzelne Instanz,
Log-Datei-Import](example-configs.md#singleserversingleinstancelogfile)

### 12.4.1. Einzelner Server, einzelne Instanz

Die einfachste Konfiguration tritt auf, wenn in Ihrem Netzwerk eine
einzelne Icinga-Instanz läuft. In diesem Fall ist die Installation und
Konfiguration der einzelnen Komponenten ziemlich geradeaus.

Das folgende Schaubild zeigt, wie die einzelnen Komponenten in diesem
Einzelserver, Einzel-Icinga-Instanz-Aufbau zusammenspielen...

**Abbildung 12.11. Einzelserver, Einzelinstanz**

![Einzelserver, Einzelinstanz](../images/fig11.png)

\

Hier eine Beschreibung, was an jedem Punkt des Schaubilds passiert:






Dieses Beispiel setzt voraus, dass:



### 12.4.2. Einzelner Server, mehrere Instanzen

Eine weitere einfache Konfiguration kann genutzt werden, wenn Sie
mehrere Icinga-Instanzen haben, die auf einem einzigen Server laufen.
Installation und Konfiguration der verschiedenen Komponenten des
IDOUtils-Addons ist ähnlich zum vorigen Beispiel.

Das folgende Schaubild zeigt, wie die verschiedenen Komponenten in
diesem "einzelner Server, mehrere Icinga-Instanzen"-Aufbau
zusammenspielen...

**Abbildung 12.12. Einzelner Server, mehrere Instanzen**

![Einzelner Server, mehrere Instanzen](../images/fig12.png)

\

Sie werden bemerken, dass das obige Schaubild ähnlich zu dem "einzelner
Server, einzelne Instanz"-Aufbau ist. Der Hauptunterschied besteht
darin, dass es nun drei (3) verschiedene Icinga-Daemons statt eines
einzelnen gibt.






### 12.4.3. Einzelner Server, einzelne Instanz, Log-Datei-Import

Es gibt zwei Gründe, warum Sie vielleicht Ihre Icinga-Log-Dateien in die
gleiche Datenbank importieren möchte, die Icinga-Konfigurations- und
Ereignisdaten enthält:



**Abbildung 12.13. Einzelner Server, einzelne Instanz,
Log-Datei-Import**

![Einzelner Server, einzelne Instanz,
Log-Datei-Import](../images/fig13.png)

\

Hier eine Beschreibung, was an jedem Punkt des Schaubilds passiert:







Das war's! Ziemlich einfach.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
