 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

6.1. Icinga Classic UI: Informationen über die Classic UI-Module
----------------------------------------------------------------

**Einführung in das Icinga Classic UI**

Die verschiedenen mit dem Icinga Core gelieferten Classic UI-Module
(CGIs) werden hier beschrieben, zusammen mit den
Autorisierungsanforderungen für den Zugriff und den Gebrauch jedes
Moduls. Im Grundzustand erwarten die Module, dass Sie sich dem
Web-Server gegenüber authentifiziert haben und autorisiert sind, jede
Information zu sehen, die Sie anfordern. Mehr Informationen über die
Konfiguration der Autorisierung finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

Die Module können über verschiedene Parameter gesteuert werden. Mehr
Informationen finden Sie
[hier](cgiparams.md "6.3. Informationen zu den Classic UI-Modul-Parametern").

**Index**

[Status-Modul](cgis.md#cgis-status_cgi)

[Status map-Modul](cgis.md#cgis-statusmap_cgi)

[Tactical overview-Modul](cgis.md#cgis-tac_cgi)

[Network outages-Modul](cgis.md#cgis-outages_cgi)

[Configuration-Modul](cgis.md#cgis-config_cgi)

[Command-Modul](cgis.md#cgis-cmd_cgi)

[Extended information-Modul](cgis.md#cgis-extinfo_cgi)

[Event log-Modul](cgis.md#cgis-showlog_cgi)

[Alert history-Modul](cgis.md#cgis-history_cgi)

[Notifications-Modul](cgis.md#cgis-notifications_cgi)

[Trends-Modul](cgis.md#cgis-trends_cgi)

[Availability reporting-Modul](cgis.md#cgis-avail_cgi)

[Alert histogram-Modul](cgis.md#cgis-histogram_cgi)

[Alert summary-Modul](cgis.md#cgis-summary_cgi)

[Änderungen am Classic UI](cgis.md#cgis-changes)

**Status-Modul**

![](../images/cgi-status-a.png)

![](../images/cgi-status-b.png)

![](../images/cgi-status-c.png)

![](../images/cgi-status-d.png)

Dateiname: **status.cgi**

**Beschreibung:**

Dies ist das wichtigste mit Icinga gelieferte Classic UI-Modul. Es
erlaubt Ihnen den aktuellen Status aller überwachten Hosts und Services
Status-Überblick aller Hostgruppen (oder einer bestimmten Hostgruppe)
und eine detaillierte Anzeige aller Services (oder diese bezogen auf
einen bestimmten Host).

**Autorisierungsanforderungen:**




**Status Map Modul**

![](../images/cgi-statusmap.png)

Dateiname: **statusmap.cgi**

**Beschreibung:**

Dieses Classic UI-Modul erstellt eine Karte aller Hosts, die Sie in
Ihrem Netzwerk definiert haben. Das Modul nutzt Thomas Boutells
[gd](http://www.boutell.com/gd/)-Library (Version 1.6.3 oder höher), um
ein PNG-Bild Ihrer Netzwerk-Struktur zu erstellen. Die verwendeten
Koordinaten (zusammen mit den optionalen Icons) werden aus den
[Host](objectdefinitions.md#objectdefinitions-host)-Definitionen
genommen. Wenn Sie es vorziehen, dass das Modul automatisch für Sie
Koordinaten generiert, nutzen Sie die
[default\_statusmap\_layout](configcgi.md#configcgi-default_statusmap_layout)-Direktive,
um einen Layout-Algorithmus zu definieren.

**Autorisierungsanforderungen:**



![[Anmerkung]](../images/note.png)

Anmerkung

Anmerkung: Benutzer, die nicht autorisiert sind, bestimmte Hosts zu
sehen, werden *unbekannte* Knoten an diesen Stellen sehen. Uns ist klar,
dass sie eigentlich *überhaupt nichts* dort sehen sollten, aber es ist
nicht sinnvoll, eine Karte zu generieren, wenn man nicht die ganzen
Host-Abhängigkeiten sehen kann.

**Tactical Overview Modul**

![](../images/cgi-tac.png)

Dateiname: **tac.cgi**

**Beschreibung:**

Dieses Classic UI-Modul dient als Sicht aus der "Vogelperspektive" auf
alle Netzwerk-Überwachungs-Aktivitäten. Es erlaubt Ihnen schnell
Netzwerkausfälle sowie Host- und Service-Zustände zu erkennen. Es
unterscheidet zwischen Problemen, die auf irgendeine Weise "behandelt"
wurden (z.B. bestätigt oder Benachrichtigungen deaktiviert) und solchen,
die nicht behandelt wurden und die deshalb Beachtung erfordern. Das ist
sehr hilfreich, wenn Sie viele zu überwachende Hosts und Services haben
und einen einzelnen Bildschirm zur Alarmierung über Probleme einsetzen
möchten.

**Autorisierungsanforderungen:**




**Network Outages Modul**

![](../images/cgi-outages.png)

Dateiname: **outages.cgi**

**Beschreibung:**

Dieses Classic UI-Modul zeigt eine Liste von "Problem"-Hosts, die
Netzwerkausfälle hervorrufen. Dies kann besonders dann hilfreich sein,
wenn Sie ein großes Netzwerk haben und schnell die Quelle des Problems
identifizieren möchten. Hosts werden sortiert nach der Schwere des
Ausfalls, den sie bewirken.



**Configuration Modul**

![](../images/cgi-config.png)

Dateiname: **config.cgi**

**Beschreibung:**

Dieses Classic UI-Modul erlaubt es Ihnen, Objekte (z.B. Hosts,
Hostgruppen, Kontakte, Kontaktgruppen, Zeitfenster, Services, etc.)
anzusehen, die Sie in Ihrer/Ihren
[Objekt-Konfigurationsdatei(en)](configobject.md "3.3. Überblick Objektkonfiguration")
definiert haben.

**Autorisierungsanforderungen:**


**Command-Modul**

![](../images/cgi-cmd.png)

Dateiname: **cmd.cgi**

**Beschreibung:**

Dieses Classic UI-Modul erlaubt es Ihnen, Befehle an den Icinga-Prozess
zu senden. Obwohl dieses Modul mehrere Argumente hat, sollten Sie besser
darauf verzichten. Die meisten wechseln zwischen verschiedenen
Revisionen von Icinga. Nutzen Sie das [extended information
Modul](cgis.md#cgis-extinfo_cgi) als Startpunkt, um Befehle zu
erteilen.

**Autorisierungsanforderungen:**





**Anmerkungen:**


**Extended Information-Modul**

![](../images/cgi-extinfo-a.png)

![](../images/cgi-extinfo-b.png)

![](../images/cgi-extinfo-c.png)

![](../images/cgi-extinfo-d.png)

Dateiname: **extinfo.cgi**

**Beschreibung:**

Dieses Classic UI-Modul erlaubt es Ihnen, Icinga-Prozess-Informationen,
Host- und Service-Zustandsstatistiken, Host- und Service-Kommentare und
mehr anzusehen. Es dient auch als Startpunkt, um über das
[command-Modul](cgis.md#cgis-cmd_cgi) Befehle an Icinga zu erteilen.
Obwohl dieses Modul mehrere Argumente hat, sollten Sie besser darauf
verzichten. Die meisten wechseln zwischen verschiedenen Revisionen von
Icinga. Sie können dieses Modul erreichen, indem Sie auf 'Network
Health' bzw. 'Process Information' in der seitlichen Navigationsleiste
klicken oder auf einen Host- oder Service-Link in der Ausgabe des
[status-Modul](cgis.md#cgis-status_cgi).

**Autorisierungsanforderungen:**





**Event Log-Modul**

![](../images/cgi-showlog.png)

Dateiname: **showlog.cgi**

**Beschreibung:**

Dieses Classic UI-Modul zeigt das [log
file](configmain.md#configmain-log_file). Wenn Sie die [log
rotation](configmain.md#configmain-log_rotation_method) aktiviert
haben, können Sie in archivierten Log-Dateien blättern, indem Sie die
Navigations-Links oben auf der Seite benutzen.

**Autorisierungsanforderungen:**


**Alert History-Modul**

![](../images/cgi-history.png)

Dateiname: **history.cgi**

**Beschreibung:**

Dieses Classic UI-Modul wird benutzt, um die Problem-Historie für einen
oder alle Hosts anzuzeigen. Die Ausgabe ist grundsätzlich ein Auszug der
Informationen, die über das [log file-Modul](cgis.md#cgis-showlog_cgi)
angezeigt werden. Sie haben die Möglichkeit, die Ausgabe zu filtern, um
nur die Problemtypen anzuzeigen, die Sie sehen wollen (z.B. Hard-
und/oder Soft-Alarme, verschiedene Typen von Service- und Host-Alarmen,
alle Arten von Alarmen, usw.). Wenn Sie die [log
rotation](configmain.md#configmain-log_rotation_method) aktiviert
haben, können Sie in archivierten Log-Dateien blättern, indem Sie die
Navigations-Links oben auf der Seite benutzen.

**Autorisierungsanforderungen:**




**Notifications-Modul**

![](../images/cgi-notifications.png)

Dateiname: **notifications.cgi**

**Beschreibung:**

Dieses Classic UI-Modul wird genutzt, um Host- und
Service-Benachrichtigungen anzuzeigen, die an verschiedene Kontakte
versandt wurden. Die Ausgabe ist grundsätzlich ein Auszug der
Informationen, die über das [log file-Modul](cgis.md#cgis-showlog_cgi)
angezeigt werden. Sie haben die Möglichkeit, die Ausgabe zu filtern, um
nur die Benachrichtigungen anzuzeigen, die Sie sehen wollen (z.B.
Service-Benachrichtigungen, Host-Benachrichtigungen, Benachrichtigungen,
die an bestimmte Kontakte versandt wurden, usw.). Wenn Sie die [log
rotation](configmain.md#configmain-log_rotation_method) aktiviert
haben, können Sie in archivierten Log-Dateien blättern, indem Sie die
Navigations-Links oben auf der Seite benutzen.

**Autorisierungsanforderungen:**




**Trends-Modul**

![](../images/cgi-trends.png)

Dateiname: **trends.cgi**

**Beschreibung:**

Dieses Classic UI-Modul wird genutzt, um einen Graphen über Host- oder
Service-Zustände für einen beliebigen Zeitraum zu erstellen. Damit
dieses Modul von Wert ist, sollten Sie [log
rotation](configmain-log_rotation_method) aktivieren und archivierte
Logs in dem Verzeichnis lagern, das durch die
[log\_archive\_path](configmain-log_archive_path)-Direktive angegeben
wird. Das Modul nutzt Thomas Boutells
[gd](http://www.boutell.com/gd/)-Library (Version 1.6.3 oder höher), um
die Trend-Grafiken zu erstellen.

**Autorisierungsanforderungen:**




**Availability Reporting-Modul**

![](../images/cgi-avail-a.png)

![](../images/cgi-avail-b.png)

Dateiname: **avail.cgi**

**Beschreibung:**

Dieses Classic UI-Modul wird genutzt, um einen Bericht über die
Verfügbarkeit von Hosts oder Service für einen benutzerdefinierten
Zeitraum zu erstellen. Damit dieses Modul von Wert ist, sollten Sie [log
rotation](configmain.md#configmain-log_rotation_method) aktivieren und
archivierte Logs in dem Verzeichnis lagern, das durch die
[log\_archive\_path](configmain.md#configmain-log_archive_path)-Direktive
angegeben wird.

**Autorisierungsanforderungen:**




**Alert Histogram-Modul**

![](../images/cgi-histogram.png)

Dateiname: **histogram.cgi**

**Beschreibung:**

Dieses Classic UI-Modul wird genutzt, um einen Bericht über die
Verfügbarkeit von Hosts oder Service für einen benutzerdefinierten
Zeitraum zu erstellen. Damit dieses Modul von Wert ist, sollten Sie [log
rotation](configmain-log_rotation_method) aktivieren und archivierte
Logs in dem Verzeichnis lagern, das durch die
[log\_archive\_path](configmain-log_archive_path)-Direktive angegeben
wird. Das CGI nutzt Thomas Boutells
[gd](http://www.boutell.com/gd/)-Library (Version 1.6.3 oder höher), um
die Histogramm-Grafiken zu erstellen.

**Autorisierungsanforderungen:**




**Alert Summary-Modul**

![](../images/cgi-summary.png)

Dateiname: **summary.cgi**

**Beschreibung:**

Dieses Classic UI-Modul stellt einige generische Berichte über Host- und
Service-Alarmdaten zur Verfügung, darunter Gesamtzahl Alarme,
Alarm-Spitzenreiter, etc.

**Autorisierungsanforderungen:**




**Änderungen am Classic UI**

Diese Änderungen sind im Laufe der Zeit eingeflossen, so dass sie ggf.
nicht in Ihrer Version von Icinga verfügbar sind.



































* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
