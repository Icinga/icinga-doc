![Icinga](../images/logofullsize.png "Icinga")

2.3. Schnellstart-Installationsanleitungen

[Zurück](newbie.md) 

Kapitel 2. Los geht's

 [Weiter](quickstart-icinga.md)

* * * * *

2.3. Schnellstart-Installationsanleitungen
------------------------------------------

**Einführung**

Diese Schnellstartanleitungen sind dazu gedacht, Ihnen einfache
Anweisungen zu liefern, wie Sie Icinga innerhalb von 20 bis 30 Minuten
aus dem Quellcode installieren und Ihren lokalen Rechner damit
überwachen. Hier werden keine fortgeschrittenen Installationsoptionen
vorgestellt - lediglich die Grundlagen, die für 95% aller Benutzer
funktionieren, die anfangen wollen.

Verweise zu Konfigurations-Tools und anderen Addons finden Sie
[hier](addons.md "10.1. Icinga Addons").

![[Anmerkung]](../images/note.png)

Anmerkung

Anstatt Icinga von Grund auf zu installieren möchten Sie vielleicht ein
Paket benutzen, das es möglicherweise für Ihr Betriebssystem gibt. Bitte
werfen Sie einen Blick auf die [Tabelle der
Pakete](https://www.icinga.org/download/packages).

Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie bitte
die offiziellen Release-Tarballs.

![[Wichtig]](../images/important.png)

Wichtig

Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem haben,
das in der aktuellen Entwicklerversion ggf. gelöst ist.

Außerdem gibt es eine neue Schnellstartanleitung für die Installation
von Icinga zusammen mit den IDOUtils für die Anbindung einer MySQL-,
Oracle- oder PostgreSQL-Datenbank.

**Anleitungen**

In den Schnellstart-Anleitungen wird auf verschiedene
Linux-Distributionen eingegangen, u.a. Fedora, Ubuntu und openSuSE.
Einige Distributionen sind ähnlich, so dass Sie diese Anleitungen
voraussichtlich auch für RedHat, Debian und SLES verwenden können. Von
Marcel Hecko stammt eine Anleitung für Icinga auf FreeBSD

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass sich teilweise die Namen der Pakete zwischen
verschiedenen Versionen des gleichen Betriebssystems verändern. Wenn Sie
also die genannten Pakete nicht finden, dann sollten Sie Ihre bevorzugte
Suchmaschine nutzen, um den korrekten Namen zu ermitteln.

Die [Schnellstartanleitung für
Linux](quickstart-icinga.md "2.4. Icinga-Schnellstart auf Linux") und
die [Schnellstartanleitung für
FreeBSD](quickstart-icinga-freebsd.md "2.5. Icinga-Schnellstart auf FreeBSD")
geben Ihnen Anweisungen für die Installation von Icinga, grundlegenden
Plugins, um verschiedene Dinge zu prüfen, und der klassischen GUI, auf
die sie mit Ihrem Web-Browser zugreifen können. Das äußere
Erscheinungsbild ist Nagios-ähnlich, obwohl die GUI verschiedene
Verbesserungen bietet (z.B. erweiterter CSV-Export, Befehle gleichzeitig
für mehrere Objekte, usw.). Es gibt keine Datenbank und alle
Informationen werden in normalen Dateien gespeichert. Icinga Web ist in
diesem Setup *nicht* verfügbar.

Mit Hilfe der [Schnellstartanleitung für Icinga mit
IDOUtils](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
und der [Schnellstartanleitung für Icinga mit IDOUtils für
FreeBSD](quickstart-idoutils-freebsd.md "2.7. Icinga-Schnellstart mit IDOUtils auf FreeBSD")
bekommen Sie die o.g. Dinge sowie eine Datenbank zur Speicherung von
aktuellen und historischen Informationen. Die Datenbank wird *nicht*
benutzt, um die Konfiguration über ein Web-Interface zu ermöglichen. Es
gibt verschiedene [Addons](addons.md "10.1. Icinga Addons"), die auf
diesen Zweck spezialisiert sind und es gibt keine Pläne für ein
eingebautes Tool. Das neue Icinga Webinterface kann installiert werden,
wenn Sie dieses Setup benutzen. Separate Anweisungen finden Sie
[hier](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend").

-   [Schnellstartanleitung für
    Linux](quickstart-icinga.md "2.4. Icinga-Schnellstart auf Linux")

-   [Schnellstartanleitung für
    FreeBSD](quickstart-icinga-freebsd.md "2.5. Icinga-Schnellstart auf FreeBSD")

-   [Schnellstartanleitung für Icinga mit
    IDOUtils](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")

-   [Schnellstartanleitung für Icinga mit IDOUtils für
    FreeBSD](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")

Wenn Sie Icinga auf einem Betriebssystem oder einer Linux-Distribution
installieren, die oben nicht aufgeführt ist, lesen Sie die
[Schnellstartanleitung für
Linux](quickstart-icinga.md "2.4. Icinga-Schnellstart auf Linux"), um
einen Überblick zu bekommen, was zu tun ist. Befehlsnamen, Pfade und
anderes variiert stark zwischen verschiedenen
Betriebssystemen/Distributionen, so dass Sie wahrscheinlich die
Installationsanleitung ein wenig anpassen müssen, damit sie für Ihren
besonderen Fall funktioniert.

* * * * *

  -------------------------- -------------------------- -------------------------------------
  [Zurück](newbie.md)      [Nach oben](ch02.md)      [Weiter](quickstart-icinga.md)
  2.2. Ich bin neu bei...    [Zum Anfang](index.md)    2.4. Icinga-Schnellstart auf Linux
  -------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
