Hinweise für Neulinge
=====================

Herzlichen Glückwunsch zur Wahl von NAME-ICINGA! NAME-ICINGA ist
ziemlich mächtig und flexibel, aber es kann viel Arbeit bedeuten, es so
zu konfigurieren, wie Sie es haben wollen. Sobald Sie damit vertraut
sind, wie es funktioniert und was es für Sie tun kann, dann werden Sie
nicht mehr ohne leben wollen :-). Hier sind einige wichtige Dinge, die
zu beachten sind, wenn Sie zum ersten Mal NAME-ICINGA benutzen:

1.  **Entspannen Sie sich - es wird einige Zeit dauern.** Erwarten Sie
    nicht, dass alles gleich so funktioniert, wie Sie sich das
    vorstellen. Das Aufsetzen von NAME-ICINGA kann ein bisschen an
    Arbeit erfordern - teilweise wegen der Optionen, die NAME-ICINGA
    bietet, teilweise weil Sie wissen müssen, was Sie in Ihrem Netzwerk
    überwachen wollen (und wie das am Besten zu tun ist).

2.  **Verwenden Sie Pakete.** Inzwischen gibt es für viele
    Distributionen passende Pakete. Denken Sie über die Verwendung nach
    anstatt aus Sourcen zu installieren. Es spart Ihnen ein bisschen
    Zeit. Bitte beachten Sie dabei, dass sich die Pfade von denen
    unterscheiden, die in der Dokumentation beschrieben sind. Eine
    detaillierte Liste finden Sie auf dieser [Wiki
    Seite](https://wiki.icinga.org/display/howtos/Package+Specific+Locations).
    Informationen zu Paketen finden Sie [hier](#icinga_packages).

3.  **Nutzen Sie die Schnellstartanleitungen** (wenn Sie kein Paket
    verwenden möchten oder können). Die
    [Schnellstart-Installationsanleitung](#quickstart) ist so ausgelegt,
    dass die meisten neuen Benutzer ziemlich schnell ein einfaches
    NAME-ICINGA zum Laufen bekommen. Innerhalb von 20 Minuten ist
    NAME-ICINGA installiert und überwacht Ihr lokales System. Sobald das
    erledigt ist, können Sie lernen, wie NAME-ICINGA konfiguriert wird,
    um mehr zu tun.

4.  **Lesen Sie die Dokumentation.** NAME-ICINGA kann schwierig zu
    konfigurieren sein, wenn Sie ein Gespür dafür haben, was passiert,
    und ziemlich unmöglich, wenn Sie keins haben. Stellen Sie sicher,
    dass Sie die Dokumentation lesen (besonders die Abschnitte
    "NAME-ICINGA konfigurieren" und "Die Grundlagen"). Es ist wichtig zu
    wissen wie [Plugins](#plugins) arbeiten. Werfen Sie auch einen Blick
    auf den [Monitoring-Überblick](#monitoring-overview). Heben Sie sich
    die fortgeschrittenen Themen auf, bis Sie ein gutes Verständnis der
    Grundlagen haben.

5.  **Verstehen Sie die Architektur.** NAME-ICINGA Core wird mit 2 GUIs
    ausgeliefert, NAME-UI und NAME-WEB NAME-UI verwendet die nativen
    Status und Log Dateien, während NAME-WEB NAME-IDOUTILS mit
    Datenbankbackend benötigt. Beide GUIs können am am selben Host
    installiert sein, unterhalb von /icinga und /icinga-web. Die
    NAME-IDOUTILS Datenbank wird ebenso von NAME-REP auf Basis von
    NAME-JASPER verwendet, welches als Cronk in NAME-WEB integriert
    werden kann. Lesen Sie im [NAME-IDOUTILS Kapitel](#ch12) weiter, um
    weitere Information zu den NAME-IDOUTILS Komponenten zu erhalten.
    [Plugins](#plugins) sind für Ihre Checks essenziell, ebenso sollten
    Sie sich Gedanken über [Addons](#ch10) in Ihrem Setup machen.

6.  **Suchen Sie die Hilfe von anderen.** Wenn Sie die Dokumentation
    gelesen haben, sich die Beispiel-Konfigurationsdateien angesehen und
    immer noch Probleme haben, dann senden Sie eine e-Mail mit der
    Beschreibung Ihrer Probleme an die
    *NAME-ICINGA-users*-Mailing-Liste. Aufgrund der Arbeit an diesem
    Projekt können wir die meisten der direkt an uns gesandten Fragen
    nicht beantworten, so dass die beste Quelle die Mailing-Liste sein
    dürfte. Wenn Sie bereits einiges gelesen haben und eine gute
    Problembeschreibung liefern, dann stehen die Chancen gut, dass
    jemand Ihnen Hinweise geben kann, um die Dinge zum Laufen zu
    bringen. Mehr (englischsprachige) Informationen, wie Sie sich den
    Mailing-Listen anschließen oder die Archive durchsuchen können,
    finden Sie unter
    [http://www.NAME-ICINGA.org/support/](http://www.Icinga.org/support/).
    Das deutsche NAME-ICINGA-Portal finden Sie unter
    [http://www.NAME-ICINGA-portal.de](http://www.Icinga-portal.de).
    Eine weitere Quelle für Informationen ist der
    [Howto-Wiki-Bereich](https://wiki.icinga.org/display/howtos/Home).

    Falls Sie ein Paket installiert haben, dann fehlen die
    Beispieldateien möglicherweise. Sie finden den Inhalt
    [hier](#sample-config) zum Nachschlagen.

Anfänger, Hinweise für
