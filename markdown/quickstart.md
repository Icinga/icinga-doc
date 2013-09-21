Schnellstart-Installationsanleitungen
=====================================

**Einführung**

Diese Schnellstartanleitungen sind dazu gedacht, Ihnen einfache
Anweisungen zu liefern, wie Sie NAME-ICINGA innerhalb von 20 bis 30
Minuten aus dem Quellcode installieren und Ihren lokalen Rechner damit
überwachen. Hier werden keine fortgeschrittenen Installationsoptionen
vorgestellt - lediglich die Grundlagen, die für 95% aller Benutzer
funktionieren, die anfangen wollen.

Verweise zu Konfigurations-Tools und anderen Addons finden Sie
[hier](#addons).

> **Note**
>
> Anstatt NAME-ICINGA von Grund auf zu installieren möchten Sie
> vielleicht ein Paket benutzen, das es möglicherweise für Ihr
> Betriebssystem gibt. Bitte werfen Sie einen Blick auf die [Tabelle der
> Pakete](https://www.icinga.org/download/packages).
>
> Falls Sie aus den Sourcen installieren möchten, dann benutzen Sie
> bitte die offiziellen Release-Tarballs.

> **Important**
>
> Bitte benutzen Sie keine GIT-Snapshots, solange Sie kein Problem
> haben, das in der aktuellen Entwicklerversion ggf. gelöst ist.

Außerdem gibt es eine neue Schnellstartanleitung für die Installation
von NAME-ICINGA zusammen mit den NAME-IDOUTILS für die Anbindung einer
NAME-MYSQL-, NAME-ORACLE- oder NAME-POSTGRES-Datenbank.

**Anleitungen**

In den Schnellstart-Anleitungen wird auf verschiedene
NAME-LINUX-Distributionen eingegangen, u.a. NAME-FEDORA, NAME-UBUNTU und
NAME-OPENSUSE. Einige Distributionen sind ähnlich, so dass Sie diese
Anleitungen voraussichtlich auch für NAME-REDHAT, NAME-DEBIAN und
NAME-SLES verwenden können. Von Marcel Hecko stammt eine Anleitung für
NAME-ICINGA auf NAME-FREEBSD

> **Note**
>
> Bitte beachten Sie, dass sich teilweise die Namen der Pakete zwischen
> verschiedenen Versionen des gleichen Betriebssystems verändern. Wenn
> Sie also die genannten Pakete nicht finden, dann sollten Sie Ihre
> bevorzugte Suchmaschine nutzen, um den korrekten Namen zu ermitteln.

Die [Schnellstartanleitung für NAME-LINUX](#quickstart-icinga) und die
[Schnellstartanleitung für NAME-FREEBSD](#quickstart-icinga-freebsd)
geben Ihnen Anweisungen für die Installation von NAME-ICINGA,
grundlegenden Plugins, um verschiedene Dinge zu prüfen, und der
klassischen GUI, auf die sie mit Ihrem Web-Browser zugreifen können. Das
äußere Erscheinungsbild ist NAME-NAGIOS-ähnlich, obwohl die GUI
verschiedene Verbesserungen bietet (z.B. erweiterter CSV-Export, Befehle
gleichzeitig für mehrere Objekte, usw.). Es gibt keine Datenbank und
alle Informationen werden in normalen Dateien gespeichert. NAME-WEB ist
in diesem Setup *nicht* verfügbar.

Mit Hilfe der [Schnellstartanleitung für NAME-ICINGA mit
NAME-IDOUTILS](#quickstart-idoutils) und der [Schnellstartanleitung für
NAME-ICINGA mit NAME-IDOUTILS für
NAME-FREEBSD](#quickstart-idoutils-freebsd) bekommen Sie die o.g. Dinge
sowie eine Datenbank zur Speicherung von aktuellen und historischen
Informationen. Die Datenbank wird *nicht* benutzt, um die Konfiguration
über ein Web-Interface zu ermöglichen. Es gibt verschiedene
[Addons](#addons), die auf diesen Zweck spezialisiert sind und es gibt
keine Pläne für ein eingebautes Tool. Das neue NAME-ICINGAWEB kann
installiert werden, wenn Sie dieses Setup benutzen. Separate Anweisungen
finden Sie [hier](#icinga-web-scratch).

-   [Schnellstartanleitung für NAME-LINUX](#quickstart-icinga)

-   [Schnellstartanleitung für NAME-FREEBSD](#quickstart-icinga-freebsd)

-   [Schnellstartanleitung für NAME-ICINGA mit
    NAME-IDOUTILS](#quickstart-idoutils)

-   [Schnellstartanleitung für NAME-ICINGA mit NAME-IDOUTILS für
    NAME-FREEBSD](#quickstart-idoutils)

Wenn Sie NAME-ICINGA auf einem Betriebssystem oder einer
NAME-LINUX-Distribution installieren, die oben nicht aufgeführt ist,
lesen Sie die [Schnellstartanleitung für Linux](#quickstart-icinga), um
einen Überblick zu bekommen, was zu tun ist. Befehlsnamen, Pfade und
anderes variiert stark zwischen verschiedenen
Betriebssystemen/Distributionen, so dass Sie wahrscheinlich die
Installationsanleitung ein wenig anpassen müssen, damit sie für Ihren
besonderen Fall funktioniert.

Schnellstart
Quickstart
Icinga-Pakete
