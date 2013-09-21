NAME-ICINGA Web-GUI-Vergleich
=============================

Icinga bietet für Benutzer zwei Web-Interfaces an, um
Icinga-Monitoring-Ergebnisse anzusehen und Befehle an den Core zu
senden. In Icinga-New- und Classic-Web sind Host- und Service-Status,
Historie, Benachrichtungen und Status-Map verfügbar, um einen Überblick
über den aktuellen Zustand Ihres Netzwerks zu erhalten. Beide
unterstützen sowohl IPv4 als auch IPv6-Adressen.

Icinga-Classic-Web
------------------

Traditional im Design ist dies Icingas Benutzer-Interface für
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

  --------------------- ------------------------- ----------------
  Taktische Übersicht   Host-Gruppen              Service-Status
  Befehle               CGI-konfiguration         Ausfallzeiten
  Datumauswahl          Seitenweise Log-Anzeige   Trending
  --------------------- ------------------------- ----------------

  : Screenshots NAME-ICINGA-Classic-Web

Icinga-New-Web
--------------

Dynamisch und benutzerfreundlich ist dieses Agavi-basierende,
Ajax-getriebene, Web-2.0-inspirierte Icinga-Frontend.

> **Note**
>
> Icinga-Web benötigt eine Datenbank zum Betrieb. Bisher werden
> NAME-MYSQL, NAME-POSTGRES und NAME-ORACLE unterstützt.

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

  ------------------------ --------------------- -------------------------
  Portal-Ansicht           Taktische Übersicht   Offene Probleme
  Host-Status-Ereignisse   Host-Filter           Ausfallzeiten
  Suche                    Befehle               Reporting
  Business Process         Log-Datei-Anzeige     Benutzer-Administration
  Cronk-Builder            Cronk-Konfiguration   Status-Map
  ------------------------ --------------------- -------------------------

  : Screenshots NAME-ICINGA-New-Web

Icinga web GUI comparison
Icinga web GUI comparison
Icinga classic web GUI
Icinga web GUI comparison
Icinga new web GUI
