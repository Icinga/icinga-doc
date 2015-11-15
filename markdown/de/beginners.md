![Icinga](../images/logofullsize.png "Icinga")

2.1. Hinweise für Neulinge

[Zurück](ch02.md) 

Kapitel 2. Los geht's

 [Weiter](newbie.md)

* * * * *

2.1. Hinweise für Neulinge
--------------------------

2.1.1. [Icinga-Überblick](beginners.md#icinga-overview)

2.1.2. [Icinga Web-GUI-Vergleich](beginners.md#icinga_gui_comparison)

Herzlichen Glückwunsch zur Wahl von Icinga! Icinga ist ziemlich mächtig
und flexibel, aber es kann viel Arbeit bedeuten, es so zu konfigurieren,
wie Sie es haben wollen. Sobald Sie damit vertraut sind, wie es
funktioniert und was es für Sie tun kann, dann werden Sie nicht mehr
ohne leben wollen :-). Hier sind einige wichtige Dinge, die zu beachten
sind, wenn Sie zum ersten Mal Icinga benutzen:

1.  **Entspannen Sie sich - es wird einige Zeit dauern.** Erwarten Sie
    nicht, dass alles gleich so funktioniert, wie Sie sich das
    vorstellen. Das Aufsetzen von Icinga kann ein bisschen an Arbeit
    erfordern - teilweise wegen der Optionen, die Icinga bietet,
    teilweise weil Sie wissen müssen, was Sie in Ihrem Netzwerk
    überwachen wollen (und wie das am Besten zu tun ist).

2.  **Verwenden Sie Pakete.** Inzwischen gibt es für viele
    Distributionen passende Pakete. Denken Sie über die Verwendung nach
    anstatt aus Sourcen zu installieren. Es spart Ihnen ein bisschen
    Zeit. Bitte beachten Sie dabei, dass sich die Pfade von denen
    unterscheiden, die in der Dokumentation beschrieben sind. Eine
    detaillierte Liste finden Sie auf dieser [Wiki
    Seite](https://wiki.icinga.org/display/howtos/Package+Specific+Locations).
    Informationen zu Paketen finden Sie
    [hier](icinga_packages.md "2.8. Icinga Pakete für Linux-Distributionen").

3.  **Nutzen Sie die Schnellstartanleitungen** (wenn Sie kein Paket
    verwenden möchten oder können). Die
    [Schnellstart-Installationsanleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
    ist so ausgelegt, dass die meisten neuen Benutzer ziemlich schnell
    ein einfaches Icinga zum Laufen bekommen. Innerhalb von 20 Minuten
    ist Icinga installiert und überwacht Ihr lokales System. Sobald das
    erledigt ist, können Sie lernen, wie Icinga konfiguriert wird, um
    mehr zu tun.

4.  **Lesen Sie die Dokumentation.** Icinga kann schwierig zu
    konfigurieren sein, wenn Sie ein Gespür dafür haben, was passiert,
    und ziemlich unmöglich, wenn Sie keins haben. Stellen Sie sicher,
    dass Sie die Dokumentation lesen (besonders die Abschnitte "Icinga
    konfigurieren" und "Die Grundlagen"). Es ist wichtig zu wissen wie
    [Plugins](plugins.md "5.1. Icinga Plugins") arbeiten. Werfen Sie
    auch einen Blick auf den
    [Monitoring-Überblick](monitoring-overview.md "2.12. Monitoring-Überblick").
    Heben Sie sich die fortgeschrittenen Themen auf, bis Sie ein gutes
    Verständnis der Grundlagen haben.

5.  **Verstehen Sie die Architektur.** Icinga Core wird mit 2 GUIs
    ausgeliefert, Icinga Classic UI und Icinga Web Icinga Classic UI
    verwendet die nativen Status und Log Dateien, während Icinga Web
    IDOUtils mit Datenbankbackend benötigt. Beide GUIs können am am
    selben Host installiert sein, unterhalb von /icinga und /icinga-web.
    Die IDOUtils Datenbank wird ebenso von Icinga Reporting auf Basis
    von JasperReports Server verwendet, welches als Cronk in Icinga Web
    integriert werden kann. Lesen Sie im [IDOUtils
    Kapitel](ch12.md "Kapitel 12. IDOUtils") weiter, um weitere
    Information zu den IDOUtils Komponenten zu erhalten.
    [Plugins](plugins.md "5.1. Icinga Plugins") sind für Ihre Checks
    essenziell, ebenso sollten Sie sich Gedanken über
    [Addons](ch10.md "Kapitel 10. weitere Software") in Ihrem Setup
    machen.

6.  **Suchen Sie die Hilfe von anderen.** Wenn Sie die Dokumentation
    gelesen haben, sich die Beispiel-Konfigurationsdateien angesehen und
    immer noch Probleme haben, dann senden Sie eine e-Mail mit der
    Beschreibung Ihrer Probleme an die *Icinga-users*-Mailing-Liste.
    Aufgrund der Arbeit an diesem Projekt können wir die meisten der
    direkt an uns gesandten Fragen nicht beantworten, so dass die beste
    Quelle die Mailing-Liste sein dürfte. Wenn Sie bereits einiges
    gelesen haben und eine gute Problembeschreibung liefern, dann stehen
    die Chancen gut, dass jemand Ihnen Hinweise geben kann, um die Dinge
    zum Laufen zu bringen. Mehr (englischsprachige) Informationen, wie
    Sie sich den Mailing-Listen anschließen oder die Archive durchsuchen
    können, finden Sie unter
    [http://www.Icinga.org/support/](http://www.Icinga.org/support/).
    Das deutsche Icinga-Portal finden Sie unter
    [http://www.Icinga-portal.de](http://www.Icinga-portal.de). Eine
    weitere Quelle für Informationen ist der
    [Howto-Wiki-Bereich](https://wiki.icinga.org/display/howtos/Home).

    Falls Sie ein Paket installiert haben, dann fehlen die
    Beispieldateien möglicherweise. Sie finden den Inhalt
    [hier](sample-config.md "13.1. Beispielkonfigurationsdateien und Definitionen")
    zum Nachschlagen.

### 2.1.1. Icinga-Überblick

**Überblick**

Dieser Abschnitt soll Ihnen einen kurzen Überblick darüber geben, was
enthalten ist und was nicht.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Informationen sind nicht vollständig, aber wir arbeiten daran. Der
git-Branch "`next`{.uri}" ist möglicherweise aktueller als diese
Dokumentation.

Icinga besteht aus einem Kern, der die Ergebnisse verarbeitet, die von
Prüfungen stammen, die entweder vom Core initiert werden ([aktive
Prüfungen](activechecks.md "5.6. Aktive Prüfungen (Active Checks)")),
oder von anderen Maschinen kommen ([passive
Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")),
der entscheidet ob
[Benachrichtungen](notifications.md "5.11. Benachrichtigungen")
versandt werden müssen, der Informationen in Log-Dateien schreibt oder
sie durch ein
[Web-interface](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module")
darstellt, sowie andere Aufgaben.

Der Kern enthält *keinerlei* Prüfungen, sondern diese werden stattdessen
von [Plugins](plugins.md "5.1. Icinga Plugins") ausgeführt. Die
Benachrichtigung von
[Kontakten](objectdefinitions.md#objectdefinitions-contact) erfolgt
mit Methoden, die vom Betriebssystem zur Verfügung gestellt werden (z.B.
sendmail/postfix/..., SMS, Pager).

![[Anmerkung]](../images/note.png)

Anmerkung

Die Installation und Konfiguration von Plugins, Addons und
betriebssystemnaher Software sprengt in den meisten Fällen den Rahmen
dieser Dokumentation. Konsultieren Sie daher möglichst zuerst die
Dokumentation des Herstellers, benutzen Sie Ihre bevorzugte Suchmaschine
falls das nicht hilft, und suchen Sie Hilfe in Foren. Wenn Sie
Anleitungen aus Blogs oder anderen privaten Quellen konsultieren, dann
finden Sie oft veraltete Informationen oder solche, die nicht auf Ihre
Umgebung passt, so dass Sie darauf verzichten sollten.

Die Erweiterung der Funktionalität kann durch die Installation von
[Addons](addons.md "10.1. Icinga Addons") erreicht werden. Dort finden
Sie Hinweise zu Web-basierten Konfigurations-Tools, alternativen
Web-Interfaces, der Darstellung von Performance-Daten, Benachrichtigung
von Kontakten und mehr.

Die Konfiguration basiert auf Textdateien und die Verwaltung erfordert
lediglich einen Texteditor wie den vi. Die
[Vererbung](objectinheritance.md "7.26. Objektvererbung") mit Hilfe
von Vorlagen vereinfacht die Definition von Objekten, indem sie die
Definition auf ein Minimum reduziert.

Der Zugriff auf die Informationen kann durch das CGI-basierte
Classic-UI, das Icinga Web-UI, oder verschiedene andere Interfaces
erfolgen, die ebenfalls in [Addons](addons.md "10.1. Icinga Addons")
genannt werden.

### 2.1.2. Icinga Web-GUI-Vergleich

2.1.2.1. [Icinga-Classic-Web](beginners.md#icinga_gui_classic)

2.1.2.2. [Icinga-New-Web](beginners.md#icinga_gui_new_web)

Icinga bietet für Benutzer zwei Web-Interfaces an, um
Icinga-Monitoring-Ergebnisse anzusehen und Befehle an den Core zu
senden. In Icinga-New- und Classic-Web sind Host- und Service-Status,
Historie, Benachrichtungen und Status-Map verfügbar, um einen Überblick
über den aktuellen Zustand Ihres Netzwerks zu erhalten. Beide
unterstützen sowohl IPv4 als auch IPv6-Adressen.

#### 2.1.2.1. Icinga-Classic-Web

Traditionell im Design ist dies Icingas Benutzer-Interface für
diejenigen, die das bekannte Ein-Fenster-Format wie in Nagios mögen,
kombiniert mit coolen Ergänzungen:

-   JSON-Ausgaben für schnelleren Datenzugriff

-   CSV-Export in den CGIs, um Addon-Entwicklung zu unterstützen

-   Log-Datei-Suche mit Filtern, regulären Ausdrücken und
    Wildcard-Fähigkeiten

-   Host-Suche mit Wildcard-Fähigkeiten

-   Zusammengesetzte Befehle, die simultan für mehrere Hosts/Services
    gesandt werden

-   Abhängigkeiten, die in Host-/Service-Details angezeigt werden

-   Integierter Konfigurationsbefehl-Expander für Endbenutzer

-   Taktische Übersicht im Header, um stets einen Blick auf die
    wichtigsten Details zu haben

-   CGI-Konfigurationsoptionen, um die Benutzerberechtigungen sehen zu
    können

-   Modifizierte Attribute, um die Unterschiede zwischen Host- und
    Service-Konfigurationseinstellungen und den letzten
    Attributänderungen im Frontend zu sehen

Weil das Icinga-Classic-Web ständig weiter entwickelt wird, können Sie
sicher sein, dass jedes Addon, das Sie mit Nagios nutzen, auch mit
Icinga funktionieren wird.

Tabelle 2.1. Screenshots Icinga-Classic-Web

  ----------------------------------------------------
  ![](../images/Icinga_Classic_TacticalOverview.png)
  ----------------------------------------------------

Taktische Übersicht

  ---------------------------------------------
  ![](../images/Icinga_Classic_HostGroup.png)
  ---------------------------------------------

Host-Gruppen

  -------------------------------------------------
  ![](../images/Icinga_Classic_ServiceStatus.png)
  -------------------------------------------------

Service-Status

  --------------------------------------------
  ![](../images/Icinga_Classic_Commands.png)
  --------------------------------------------

Befehle

  ---------------------------------------------
  ![](../images/Icinga_Classic_CGIConfig.png)
  ---------------------------------------------

CGI-konfiguration

  ---------------------------------------------
  ![](../images/Icinga_Classic_Downtimes.png)
  ---------------------------------------------

Ausfallzeiten

  ----------------------------------------------
  ![](../images/Icinga_Classic_DatePicker.png)
  ----------------------------------------------

Datumauswahl

  --------------------------------------------------
  ![](../images/Icinga_Classic_PaginationLogs.png)
  --------------------------------------------------

Seitenweise Log-Anzeige

  --------------------------------------------
  ![](../images/Icinga_Classic_Trending.png)
  --------------------------------------------

Trending

#### 2.1.2.2. Icinga-New-Web

Dynamisch und benutzerfreundlich ist dieses Agavi-basierende,
Ajax-getriebene, Web-2.0-inspirierte Icinga-Frontend.

![[Anmerkung]](../images/note.png)

Anmerkung

Icinga-Web benötigt eine Datenbank zum Betrieb. Bisher werden MySQL,
PostgreSQL und Oracle unterstützt.

-   **Betrachten Sie Ihr Monitoring wie Sie möchten**

    Icinga-New-Web zeigt aktuelle Statusdaten in einem konfigurierbaren
    Datenblatt, so dass Sie:

    -   Daten nach Spalten sortieren und gruppieren können (z.B. Host
        oder Status)

    -   Daten im Detail filtern können (z.B. HTTP-Services,die nicht
        "OK" sind)

    -   durch Anklicken von Kästchen gleichzeitig Befehle mehrere
        Host-/Services senden können

    -   Host- oder Service-Details und Historie im gleichen Fenster
        anzeigen können

-   **Suche mit Ajax-Leichtigkeit**

    Das mächtige Ajax-Suchwerkzeug erlaubt es Ihnen, die ersten
    Buchstaben einer Zeichenkette einzugeben, aus den angezeigten
    Ergebnissen aus Hosts, Services und Gruppen auszuwählen, die
    zusammen mit dem farblich kodierten Status dargestellt werden.
    Unnötig zu sagen, dass das Tool nur die Ergebnisse anzeigt, die den
    Benutzerberechtigugen entsprechen - ideal für größere Unternehmen.

-   **Customize-a-Cronk ‘n’ Dashboard**

    Eine Bibliothek von Cronks (Widgets) bietet verschiedene Ansichten,
    die per "Drag-and-Drop" auf dem Bildschirm eingestellt, verändert,
    minimiert, vergrößert und kategorisiert werden können. Weil die
    Änderungen persistent sind, können Sie später wieder zu Ihrem
    angepassten Cronk oder einer Anordnung von Cronks zurückkehren, die
    Ihr persönliches Armaturenbrett (Dashboard) darstellen.

-   **Benutzerrechte exakt verwalten**

    Jenseits der Standard-Gruppenbeschränkungen können
    Benutzereinstellungen individualisiert werden, um den Zugang auf
    bestimmte Host- oder Service-Gruppen zu beschränken, die Fähigkeit
    zum Senden von Befehlen zu entziehen, oder sogar das Ansehen von
    benutzerdefinierten Variablen bestimmter Hosts oder Services zu
    verhindern. Alles vom Frontend aus. Mit LDAP- oder
    Active-Directory-Unterstützung macht Icinga-Web auch das Leben für
    große Unternehmen leichter.

Tabelle 2.2. Screenshots Icinga-New-Web

  --------------------------------------
  ![](../images/IcingaWeb_Portal2.png)
  --------------------------------------

Portal-Ansicht

  -----------------------------------------------
  ![](../images/IcingaWeb_TacticalOverview.png)
  -----------------------------------------------

Taktische Übersicht

  -------------------------------------------
  ![](../images/IcingaWeb_OpenProblems.png)
  -------------------------------------------

Offene Probleme

  ------------------------------------------------
  ![](../images/IcingaWeb_HostStatus_Events.png)
  ------------------------------------------------

Host-Status-Ereignisse

  --------------------------------------------
  ![](../images/IcingaWeb_Host_filtered.png)
  --------------------------------------------

Host-Filter

  ----------------------------------------
  ![](../images/IcingaWeb_Downtimes.png)
  ----------------------------------------

Ausfallzeiten

  -------------------------------------
  ![](../images/IcingaWeb_Search.png)
  -------------------------------------

Suche

  ---------------------------------------
  ![](../images/IcingaWeb_Commands.png)
  ---------------------------------------

Befehle

  ----------------------------------------
  ![](../images/IcingaWeb_Reporting.png)
  ----------------------------------------

Reporting

  ----------------------------------------------
  ![](../images/IcingaWeb_BusinessProcess.png)
  ----------------------------------------------

Business Process

  ----------------------------------------
  ![](../images/IcingaWeb_LogViewer.png)
  ----------------------------------------

Log-Datei-Anzeige

  ----------------------------------------
  ![](../images/IcingaWeb_UserAdmin.png)
  ----------------------------------------

Benutzer-Administration

  -------------------------------------------
  ![](../images/IcingaWeb_CronkBuilder.png)
  -------------------------------------------

Cronk-Builder

  --------------------------------------------------
  ![](../images/IcingaWeb_Cronk_Configuration.png)
  --------------------------------------------------

Cronk-Konfiguration

  ----------------------------------------
  ![](../images/IcingaWeb_StatusMap.png)
  ----------------------------------------

Status-Map

* * * * *

  ------------------------ -------------------------- --------------------------
  [Zurück](ch02.md)      [Nach oben](ch02.md)      [Weiter](newbie.md)
  Kapitel 2. Los geht's    [Zum Anfang](index.md)    2.2. Ich bin neu bei...
  ------------------------ -------------------------- --------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
