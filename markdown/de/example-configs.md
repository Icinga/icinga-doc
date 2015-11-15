![Icinga](../images/logofullsize.png "Icinga")

12.4. Beispielkonfigurationen

[Zurück](configido.md) 

Kapitel 12. IDOUtils

 [Weiter](db_model.md)

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

1.  Das IDOMOD-Modul wird mit einem Instanznamen "default" konfiguriert,
    weil es lediglich eine Icinga-Instanz im Netzwerk gibt.

2.  Während der Icinga-Daemon läuft und die üblichen Aufgaben zur
    Überwachung des Netzwerks ausführt, sendet das IDOMOD-Modul
    Konfigurationsdaten und Ereignisinformationen an den TCP- oder
    Unix-Domain-Socket, der durch den IDO2DB-Daemon angelegt wurde.

3.  Der IDO2DB-Daemon liest die Daten, die durch den Socket vom
    IDOMOD-Modul kommen.

4.  Der IDO2DB-Daemon verarbeitet und überträgt die Daten, die vom
    IDOMOD-Modul empfanden wurden.

5.  Die verarbeiteten Daten werden für spätere Abfragen und Verarbeitung
    in einer Datenbank gespeichert.

Dieses Beispiel setzt voraus, dass:

1.  Icinga konfiguriert wurde, um das IDOMOD-Modul beim Start zu laden.

2.  Der IDO2DB-Daemon läuft (der ein separater, vom Icinga-Daemon
    unabhängiger, Prozess ist).

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

1.  Jeder Icinga-Daemon lädt das IDOMOD-Modul beim Start mit einem
    eindeutigen Instanznamen. In diesem Beispiel werden die Instanzen
    einfach "Icinga1", "Icinga2" und "Icinga3" benannt.

2.  Jedes IDOMOD-Modul sendet Konfigurationsdaten und
    Ereignisinformationen seiner Instanz des Icinga-Daemons an den TCP-
    oder Unix-Domain-Sockets, der vom IDO2DB-Daemon angelegt wurde.

3.  Der IDO2DB-Daemon liest die Daten, die durch den Socket von den drei
    IDOMOD-Modulen kommen.

4.  Der IDO2DB-Daemon verarbeitet und überträgt die Daten, die von den
    IDOMOD-Modules empfangen wurden.

5.  Die verarbeiteten Daten werden für spätere Abfragen und Verarbeitung
    in einer Datenbank gespeichert. Die Daten jeder Icinga-Instanz
    werden (mit Hilfe des eindeutigen Instanznamens) in der Datenbank
    getrennt voneinander gehalten.

### 12.4.3. Einzelner Server, einzelne Instanz, Log-Datei-Import

Es gibt zwei Gründe, warum Sie vielleicht Ihre Icinga-Log-Dateien in die
gleiche Datenbank importieren möchte, die Icinga-Konfigurations- und
Ereignisdaten enthält:

1.  Historische Log-Datei-Daten werden nicht automatisch in die
    Datenbank importiert und möglicherweise ist es wünschenswert,
    Einträge von Ereignisse zu haben, die vor der Implementierung des
    IDOUtils-Addon eintraten.

2.  Das IDOMOD-Modul ist nicht in der Lage, Echtzeit-Log-Einträge von
    direkt nach dem Start des Icinga-Daemon bis zum Zeitpunkt des Ladens
    des IDOMOD-Moduls durch den Icinga-Daemon zu verarbeiten. Diese
    "Blackout-Periode" ist unvermeidbar und führt zu Log-Einträgen wie
    "Icinga 1.0 starting...", die das IDOMOD-Modul nicht mitbekommt.
    Daher wird das Importieren der Logdateien des vorangegangenen Tages
    auf täglicher Basis (über einen cron-Job) empfohlen.

**Abbildung 12.13. Einzelner Server, einzelne Instanz,
Log-Datei-Import**

![Einzelner Server, einzelne Instanz,
Log-Datei-Import](../images/fig13.png)

\

Hier eine Beschreibung, was an jedem Punkt des Schaubilds passiert:

1.  Historische Icinga-Log-Dateien werden vom LOG2IDO-Utility gelesen.

2.  Das LOG2IDO-Utility verarbeitet den Inhalt der Log-Dateien und
    versieht sie mit dem Instanznamen "default". Dieser Instanzname muss
    mit dem Instanznamen übereinstimmen, der vom IDOMOD-Modul im
    Icinga-Daemon verwendet wird.

3.  Historische Log-Datei-Daten werden in einem Format an den TCP- oder
    Unix-Domain-Socket geschickt, das der IDO2DB-Daemon verstehen kann.

4.  Der IDO2DB-Daemon liest die Log-Datei-Daten vom TCP- oder
    Unix-Domani-Socket.

5.  Der IDO2DB-Daemon verarbeitet die Log-Datei-Daten.

6.  Historische Log-Datei-Daten werden für spätere Abfragen und
    Verarbeitung in einer Datenbank gespeichert. Der IDO2DB-Daemon wird
    einige Prüfungen durchführen, um das mehrfache importieren der
    gleichen historischen Log-Einträge zu verhindern, so dass der Aufruf
    des LOG2IDO-Utilitys mit den gleichen Dateien keine negativen
    Auswirkungen haben sollte.

Das war's! Ziemlich einfach.

* * * * *

  ----------------------------------- -------------------------- --------------------------------
  [Zurück](configido.md)            [Nach oben](ch12.md)      [Weiter](db_model.md)
  12.3. Konfiguration der IDOUtils    [Zum Anfang](index.md)    12.5. IDOUtils Database Model
  ----------------------------------- -------------------------- --------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
