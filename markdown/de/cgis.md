![Icinga](../images/logofullsize.png "Icinga")

6.1. Icinga Classic UI: Informationen über die Classic UI-Module

[Zurück](ch06.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](cgiauth.md)

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
zu sehen. Das Status-Modul kann zwei Arten von Ausgaben liefern - einen
Status-Überblick aller Hostgruppen (oder einer bestimmten Hostgruppe)
und eine detaillierte Anzeige aller Services (oder diese bezogen auf
einen bestimmten Host).

**Autorisierungsanforderungen:**

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie alle Hosts **und** alle Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie alle Hosts
    und Services ansehen, deren Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie alle Hosts **und** alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie alle
    Services ansehen, deren Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie alle Hosts **und** alle Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie alle Hosts
    und Services ansehen, deren Kontakt Sie sind.

**Network Outages Modul**

![](../images/cgi-outages.png)

Dateiname: **outages.cgi**

**Beschreibung:**

Dieses Classic UI-Modul zeigt eine Liste von "Problem"-Hosts, die
Netzwerkausfälle hervorrufen. Dies kann besonders dann hilfreich sein,
wenn Sie ein großes Netzwerk haben und schnell die Quelle des Problems
identifizieren möchten. Hosts werden sortiert nach der Schwere des
Ausfalls, den sie bewirken.

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie alle Hosts ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie alle Hosts
    ansehen, deren Kontakt Sie sind.

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

-   Sie müssen [*für Konfigurationsinformationen
    autorisiert*](configcgi.md#configcgi-authorized_for_configuration_information)
    sein, um jegliche Konfigurationsinformationen ansehen zu können.

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

-   Sie müssen [*für System-Befehle
    autorisiert*](configcgi.md#configcgi-authorized_for_system_commands)
    sein, um Befehle zu erteilen, die den Icinga-Prozess beeinflussen
    (Start, Stop, Modus-Wechsel, etc.).

-   Wenn Sie [*für alle Hosts-Befehle
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Befehle für alle Hosts **und** alle Services
    erteilen.

-   Wenn Sie [*für alle Service-Befehle
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Befehle für alle Services erteilen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie Befehle
    für alle Hosts und Services erteilen, deren Kontakt Sie sind.

**Anmerkungen:**

-   Wenn Sie sich entschieden haben, die Option
    [use\_authentication](configcgi.md#configcgi-use_authentication)
    für die Module nicht zu nutzen, wird dieses Modul *jedem* die
    Möglichkeit verweigern, Befehle zu erteilen. Dies geschieht zu Ihrem
    eigenen Schutz. Wir würden empfehlen, dieses Modul komplett zu
    entfernen, wenn Sie die Authentifizierung für Module nicht nutzen.

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

-   Sie müssen [*für Systeminformationen
    autorisiert*](configcgi.md#configcgi-authorized_for_system_information)
    sein, um Icinga-Prozess-Informationen ansehen zu können.

-   Wenn Sie [*für lle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie erweiterte Informationen für alle Hosts **und**
    alle Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie erweiterte Informationen für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie erweiterte
    Informationen für alle Hosts und Services ansehen, deren Kontakt Sie
    sind.

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

-   Sie müssen [*für Systeminformationen
    autorisiert*](configcgi.md#configcgi-authorized_for_system_information)
    sein, um das Logfile ansehen zu können.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie historische Informationen für alle Hosts **und**
    alle Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie historische Informationen für alle Services
    ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie
    historische Informationen für alle Hosts und Services ansehen, deren
    Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Benachrichtigungen für alle Hosts **und** alle
    Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Benachrichtigungen für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie
    Benachrichtigungen für alle Hosts und Services ansehen, deren
    Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Trends für alle Hosts **und** alle Services
    ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Trends für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie Trends für
    alle Hosts und Services ansehen, deren Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Verfügbarkeitsdaten für alle Hosts **und** alle
    Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Verfügbarkeitsdaten für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie
    Verfügbarkeitsdaten für alle Hosts und Services ansehen, deren
    Kontakt Sie sind.

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

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Histogramme für alle Hosts **und** alle Services
    ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Histogramme für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie
    Histogramme für alle Hosts und Services ansehen, deren Kontakt Sie
    sind.

**Alert Summary-Modul**

![](../images/cgi-summary.png)

Dateiname: **summary.cgi**

**Beschreibung:**

Dieses Classic UI-Modul stellt einige generische Berichte über Host- und
Service-Alarmdaten zur Verfügung, darunter Gesamtzahl Alarme,
Alarm-Spitzenreiter, etc.

**Autorisierungsanforderungen:**

-   Wenn Sie [*für alle Hosts
    autorisiert*](configcgi.md#configcgi-authorized_for_all_hosts)
    sind, können Sie Summary-Informationen für alle Hosts **und** alle
    Services ansehen.

-   Wenn Sie [*für alle Services
    autorisiert*](configcgi.md#configcgi-authorized_for_all_services)
    sind, können Sie Summary-Informationen für alle Services ansehen.

-   Wenn Sie ein *authentifizierter Kontakt* sind, können Sie
    Summary-Informationen für alle Hosts und Services ansehen, deren
    Kontakt Sie sind.

**Änderungen am Classic UI**

Diese Änderungen sind im Laufe der Zeit eingeflossen, so dass sie ggf.
nicht in Ihrer Version von Icinga verfügbar sind.

-   Das Aussehen des "General"-Abschnitts auf der linke Seite hat sich
    erneut geändert

    **General-Modul**

    ![](../images/cgi-general.png)

    File Name:

    **general.cgi**

    Beim Klick auf die entsprechende Flagge können Sie weiterhin auf die
    Dokumentation in der dargestellten Sprache zugreifen.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Es gibt keine Option, um die Sprache im Classic UI zu ändern. Dafür
    sind Anpassungen im Source-Code notwendig.

    Nun können Sie wieder nach Hosts suchen, ohne weitere Dinge
    anzuklicken.

-   Das klassische Interface wird in regelmäßigen Intervallen
    aktualisiert. Manchmal ist das nicht erwünscht, z.B. wenn Sie ein
    bestimmtes Objekt betrachten möchten. In diesem Fall können Sie die
    automatische Aktualisierung durch Klicken auf [pause] deaktivieren
    (direkt neben dem Text "Updated every 90 seconds" links oben im
    Status-Fenster). Klicken auf [continue] aktiviert die Aktualisierung
    wieder.

    **Pause-Modul**

    ![](../images/cgi-pause.png)

    File Name:

    **pause.cgi**

    **Continue-Modul**

    ![](../images/cgi-continue.png)

    File Name:

    **continue.cgi**

-   Die Seiten "Host Detail" und "Service Detail" wurden erweitert, so
    dass Sie nun Befehle für mehrere Objekte gleichzeitig erteilen
    können. Nun können Sie ein oder mehrere Objekte durch Check-Boxen
    neben den Objekten auswählen. Durch aktivieren der Check-Box neben
    "Status information" werden alle Services eines Hosts ausgewählt.

    **Statusinfo-Modul**

    ![](../images/cgi-statusinfo.png)

    File Name:

    **statusinfo.cgi**

    **Commands-Modul**

    ![](../images/cgi-commands.png)

    File Name:

    **commands.cgi**

    Nach dem Klick auf "Select command" zeigt eine Drop-Down-Liste die
    verfügbaren Befehle. Nach der Auswahl einer Aktion und dem
    anschließenden Klick auf "Submit" wird der Befehl für die
    ausgewählten Objekte ausgeführt.

-   "Export to CSV" wurde auf verschiedenen Seiten hinzugefügt.

-   Die Zellen der Tabelle in extinfo.cgi haben Namen bekommen. Mit
    Hilfe von SSI-Fragmenten können Sie JavaScript-Code einbinden, um
    auf die Daten dieser Zellen zuzugreifen.

    Der Beispiel-Code benutzt Daten der Zelle "comment\_data", um einen
    Link zu erzeugen (Dank an Oliver Graf).

    common-header.ssi:

    ~~~~ {.programlisting}
    <script type='text/javascript'>
    function urlify() {
        var comments=document.getElementsByName('comment_data');
        var neu="";
        for (i=0; i<=comments.length; i++) {
            comments[i].innerHTML = comments[i].innerHTML.replace(/\bRT#(\d+)\b/g,"<a href='https://YOUR-SERVER/Ticket/Display.md?id=$1'>RT#$1</a>");
        }
    }
    window.onload=urlify;
    </script>
    ~~~~

* * * * *

  ------------------------------------- -------------------------- ---------------------------------------------------------
  [Zurück](ch06.md)                   [Nach oben](ch06.md)      [Weiter](cgiauth.md)
  Kapitel 6. Die Benutzeroberflächen    [Zum Anfang](index.md)    6.2. Authentifizierung und Autorisierung im Classic UI
  ------------------------------------- -------------------------- ---------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
