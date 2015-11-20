 ![Icinga](../images/logofullsize.png "Icinga") 

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








### 2.1.1. Icinga-Überblick

**Überblick**

Dieser Abschnitt soll Ihnen einen kurzen Überblick darüber geben, was
enthalten ist und was nicht.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Informationen sind nicht vollständig, aber wir arbeiten daran. Der
git-Branch "`next`" ist möglicherweise aktueller als diese
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











Weil das Icinga-Classic-Web ständig weiter entwickelt wird, können Sie
sicher sein, dass jedes Addon, das Sie mit Nagios nutzen, auch mit
Icinga funktionieren wird.

Tabelle 2.1. Screenshots Icinga-Classic-Web


Taktische Übersicht


Host-Gruppen


Service-Status


Befehle


CGI-konfiguration


Ausfallzeiten


Datumauswahl


Seitenweise Log-Anzeige


Trending

#### 2.1.2.2. Icinga-New-Web

Dynamisch und benutzerfreundlich ist dieses Agavi-basierende,
Ajax-getriebene, Web-2.0-inspirierte Icinga-Frontend.

![[Anmerkung]](../images/note.png)

Anmerkung

Icinga-Web benötigt eine Datenbank zum Betrieb. Bisher werden MySQL,
PostgreSQL und Oracle unterstützt.













Tabelle 2.2. Screenshots Icinga-New-Web


Portal-Ansicht


Taktische Übersicht


Offene Probleme


Host-Status-Ereignisse


Host-Filter


Ausfallzeiten


Suche


Befehle


Reporting


Business Process


Log-Datei-Anzeige


Benutzer-Administration


Cronk-Builder


Cronk-Konfiguration


Status-Map

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
