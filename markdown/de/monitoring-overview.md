![Icinga](../images/logofullsize.png "Icinga")

2.12. Monitoring-Überblick

[Zurück](upgrading_idoutils.md) 

Kapitel 2. Los geht's

 [Weiter](monitoring-windows.md)

* * * * *

2.12. Monitoring-Überblick
--------------------------

**Einführung**

Icinga ist gedacht, um "Geräte" (z.B. Server, Router, Drucker und andere
Hardware wie Temperatursensoren, usw.) und "Services" (Prozesse auf
diesen Geräten bzw. Metriken) zu überwachen. Es gibt verschiedene Wege,
das zu tun und unterschiedliche Ansätze für unterschiedliche Geräte,
abhängig von Ihren Bedürfnissen oder der Infrastruktur.

-   [Aktive
    Prüfungen](activechecks.md "5.6. Aktive Prüfungen (Active Checks)")

    Die Prüfungen werden vom Überwachungsrechner zu vorgegebenen
    Intervallen initiiert. Der Server warten auf die Prüfergebnisse. Die
    Mess- und Schwellwerte werden auf dem Überwachungsrechner gesetzt.
    Die Prüfergebnisse können abgefragt werden

    -   mit Hilfe von SNMP. Auf dem entfernten System läuft ein
        SNMP-Dämon, der das Auslesen der erforderlichen Werte erlaubt.
        Abhängig von Plugin und Dämon werden SNMP v1, v2c bzw. v3
        unterstützt

    -   per [NRPE](nrpe.md "10.2. NRPE"), das einen NRPE-Dämon auf dem
        entfernten System kontaktiert, das eine Prüfung ausführt und die
        Ergebnisse an NRPE zurückliefert, das sie wiederum an den
        Icinga-Prozess übergibt

    -   über ein Plugin, das SSH benutzt, um eine Prüfung auf dem
        entfernten System ausführt und die Daten an das Plugin
        zurückliefert

    -   über das Plugin check\_nt, das einen Dienst (z.B.
        "[NSClient++](http://nsclient.org)") auf dem entfernten
        Windows-System anspricht und die Daten zu verschiedenen Metriken
        zurückliefert

    -   mit Hilfe von Addons wie [check\_multi](http://my-plugin.de)
        oder
        [check\_mk](http://mathias-kettner.de/check_mk_overview.md),
        die ihrerseits Plugins aufrufen, um die Belastung des
        Überwachungsprozesses zu verringen (durch parallelisierte
        Aufrufe). Die Konfiguration von Mess- und Schwellwerten wird
        größtenteils auf diese Addons verlagert, was den
        Konfigurationsaufwand erhöhen kann

-   [Passive
    Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")

    Die Prüfungen werden auf den entfernten Systemen ausgelöst (nicht
    notwendigerweise auf den zu überwachenden Systemen, sondern ggf. auf
    "Satellitensystemen", sog. "Poller", die z.B. eine
    Origanisationeinheit überwachen). Die Prüfergebnisse werden mit
    Hilfe von [NSCA](nsca.md "10.3. NSCA"), bestehend aus send\_nsca
    auf dem Client-System und dem NSCA-Dämon auf dem
    Überwachungsrechner, an diesen übertragen und dort verarbeitet, um
    den Status zu aktualisieren. Durch das Setzen von
    [Frische-Schwellwerten](freshness.md "7.5. Service- und Host-Frische-Prüfungen")
    werden Sie informiert, wenn die Ergebnisse nicht rechtzeitig
    eintreffen. Abhängig von den benutzen Administrations-Tools ist die
    Verwaltung ggf. komplexer, aber wegen Firewalls oder anderen
    Beschränkungen, die durch Sicherheitsmaßnahmen, Kunden, oder anderen
    Vorgaben unerläßlich sind, haben Sie möglicherweise keine andere
    Wahl. Die Nutzung von passiven Prüfungen reduziert auch die
    Belastung Ihres Überwachungsrechners, denn es werden nur Ergebnisse
    verarbeitet statt Prüfungen ausgeführt. Sie können Einträge in der
    crontab nutzen, um Prüfungen zu festgelegten Zeiten auszuführen,
    lang laufende Auswertungen nach Bedarf starten, oder Backup-Jobs
    ausführen, die lediglich die Ergebnisse zurückliefern.

-   Eine Mischung aus beidem

    Vielleicht haben Sie entfernte Systeme, die Prüfungen zu bestimmten
    Zeiten ausführen und die Ergebnisse auf einer geheimen und
    gesicherten Web-Seite bereitstellen. Der Überwachungsrechner kann
    (/darf) die System nicht direkt prüfen (wegen Firewalls,
    Kundenvorgaben), aber er hat Zugriff auf das Dokument auf dieser
    Web-Seite, kann die Daten mit Hilfe eines Scripts (einer Prüfung)
    auswerten und die Ergebnisse über [externe
    Kommandos](extcommands.md "7.1. Externe Befehle") bereitstellen.

-   SNMP-Traps

    Manchmal möchten Sie die Dinge nicht regelmäßig überprüfen, weil sie
    normalerweise fehlerfrei funktionieren und unnötig Netzwerkverkehr
    erzeugt wird. Verschiedene Geräte informieren Sie eigenständig per
    SNMP-Traps wenn etwas schiefgeht.

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte lesen Sie auch den Abschnitt zu
[Addons](addons.md "10.1. Icinga Addons"), weil dort allgemeine
Hinweise zu Konfigurations-Tools, Web-Interfaces und anderen Addons zu
finden sind, die es für Icinga gibt.

* * * * *

  ----------------------------------------- -------------------------- -------------------------------------
  [Zurück](upgrading_idoutils.md)         [Nach oben](ch02.md)      [Weiter](monitoring-windows.md)
  2.11. IDOUtils-Datenbank aktualisieren    [Zum Anfang](index.md)    2.13. Windows-Maschinen überwachen
  ----------------------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
