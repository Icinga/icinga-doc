NAME-ICINGA-Überblick
=====================

**Überblick**

Dieser Abschnitt soll Ihnen einen kurzen Überblick darüber geben, was
enthalten ist und was nicht.

> **Note**
>
> Die Informationen sind nicht vollständig, aber wir arbeiten daran. Der
> git-Branch "<next>" ist möglicherweise aktueller als diese
> Dokumentation.

NAME-ICINGA besteht aus einem Kern, der die Ergebnisse verarbeitet, die
von Prüfungen stammen, die entweder vom Core initiert werden ([aktive
Prüfungen](#activechecks)), oder von anderen Maschinen kommen ([passive
Prüfungen](#passivechecks)), der entscheidet ob
[Benachrichtungen](#notifications) versandt werden müssen, der
Informationen in Log-Dateien schreibt oder sie durch ein
[Web-interface](#cgis) darstellt, sowie andere Aufgaben.

Der Kern enthält *keinerlei* Prüfungen, sondern diese werden stattdessen
von [Plugins](#plugins) ausgeführt. Die Benachrichtigung von
[Kontakten](#objectdefinitions-contact) erfolgt mit Methoden, die vom
Betriebssystem zur Verfügung gestellt werden (z.B. sendmail/postfix/...,
SMS, Pager).

> **Note**
>
> Die Installation und Konfiguration von Plugins, Addons und
> betriebssystemnaher Software sprengt in den meisten Fällen den Rahmen
> dieser Dokumentation. Konsultieren Sie daher möglichst zuerst die
> Dokumentation des Herstellers, benutzen Sie Ihre bevorzugte
> Suchmaschine falls das nicht hilft, und suchen Sie Hilfe in Foren.
> Wenn Sie Anleitungen aus Blogs oder anderen privaten Quellen
> konsultieren, dann finden Sie oft veraltete Informationen oder solche,
> die nicht auf Ihre Umgebung passt, so dass Sie darauf verzichten
> sollten.

Die Erweiterung der Funktionalität kann durch die Installation von
[Addons](#addons) erreicht werden. Dort finden Sie Hinweise zu
Web-basierten Konfigurations-Tools, alternativen Web-Interfaces, der
Darstellung von Performance-Daten, Benachrichtigung von Kontakten und
mehr.

Die Konfiguration basiert auf Textdateien und die Verwaltung erfordert
lediglich einen Texteditor wie den vi. Die
[Vererbung](#objectinheritance) mit Hilfe von Vorlagen vereinfacht die
Definition von Objekten, indem sie die Definition auf ein Minimum
reduziert.

Der Zugriff auf die Informationen kann durch das CGI-basierte
Classic-UI, das NAME-WEB-UI, oder verschiedene andere Interfaces
erfolgen, die ebenfalls in [Addons](#addons) genannt werden.
