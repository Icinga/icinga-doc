![Icinga](../images/logofullsize.png "Icinga")

8.3. Icinga für maximale Leistung optimieren

[Zurück](cgisecurity.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](faststartup.md)

* * * * *

8.3. Icinga für maximale Leistung optimieren
--------------------------------------------

8.3.1. [Einführung](tuning.md#introduction)

8.3.2. [Optimierungshinweise:](tuning.md#optimizationtips)

### 8.3.1. Einführung

![](../images/tuning.png)

Jetzt haben Sie Icinga endlich eingerichtet und lauffähig und nun wollen
Sie wissen, wie man ein wenig daran drehen kann. Die Leistung von Icinga
zu optimieren kann notwendig sein, wenn Sie eine große Zahl (\> 1.000)
von Hosts und Services haben. Hier ein paar Dinge, nach denen Sie
schauen können, um Icinga zu optimieren...

### 8.3.2. Optimierungshinweise:

1.  **Stellen Sie Performance-Statistiken mit PNP4Nagios dar**. Um zu
    verfolgen, wie die Last Ihrer Icinga-Installation aussieht und
    welche Auswirkungen Ihre Konfigurationsänderungen darauf haben,
    sollten Sie verschiedene wichtige Statistiken mit PNP4Nagios
    darstellen. Das ist wirklich sehr, sehr sinnvoll, wenn es um die
    Leistungsoptimierung einer Icinga-Installation geht. Informationen,
    wie das zu tun ist, finden Sie
    [hier](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios").

2.  **Benutzen Sie "Verbesserungen für große Installationen"** (large
    installation tweaks). Das Aktivieren der
    [use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)-Option
    kann Ihnen bessere Leistung bringen. Lesen Sie
    [hier](largeinstalltweaks.md "8.5. Large Installation Tweaks")
    mehr darüber, was diese Option tut.

3.  **Deaktivieren Sie Umgebungs-Makros**. Makros werden Prüfungen,
    Benachrichtigungen, Eventhandlern usw. normalerweise über
    Umgebungsvariablen zur Verfügung gestellt. Das kann in einer großen
    Icinga-Installation zu einem Problem werden, weil es zusätzlichen
    Speicher (und wichtiger) mehr CPU verbraucht. Wenn Ihre Scripte
    nicht über Umgebungsvariablen auf Makros zugreifen (d.h., wenn Sie
    alle benötigen Makros in der Kommandozeile übergeben), dann brauchen
    Sie dieses Feature nicht. Sie können über die
    [enable\_environment\_macros](configmain.md#configmain-enable_environment_macros)-Option
    einstellen, ob Makros als Umgebungsvariablen verfügbar sind.

4.  **Prüfergebnis-Ernterhythmus** (Check Result Reaper Frequency). Die
    [check\_result\_reaper\_frequency](configmain.md#configmain-check_result_reaper_frequency)-Variable
    legt fest, wie oft Icinga prüfen soll, ob Host- und
    Service-Ergebnisse verarbeitet werden müssen. Die maximale Zeit, die
    es zur Verarbeitung solcher Ergebnisse benötigen darf, ist durch die
    maximale Erntezeit (max reaper time) festgelegt (siehe unten). Wenn
    Ihr Ernterhythmus zu hoch (zu selten) ist, könnten Sie hohe
    Latenzzeiten für Host- und Service-Prüfungen sehen.

5.  **maximale Erntezeit** (Max Reaper Time). Die
    [max\_check\_result\_reaper\_time](configmain.md#configmain-max_check_result_reaper_time)-Variable
    legt die maximale Zeit fest, die der Icinga-Daemon für die
    Verarbeitung der Ergebnisse von Host- und Service-Prüfungen
    verbringen darf, bevor er sich anderen Dingen zuwendet - wie z.B.
    dem Ausführen von neuen Host- und Service-Prüfungen. Ein zu hoher
    Wert kann zu hohen Latenzzeiten bei Ihren Host- und
    Service-Prüfungen führen. Ein zu niedriger Wert kann den gleichen
    Effekt haben. Wenn Sie zu hohe Latenzzeiten haben, dann passen Sie
    diesen Wert an und sehen Sie, welchen Effekt das hat. [Graphisch
    dargestellte
    Statistiken](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios")
    helfen Ihnen bei der Auswertung der Auswirkungen.

6.  **Anpassen der Pufferwerte**. Gegebenenfalls müssen Sie den Wert der
    [external\_command\_buffer\_slots](configmain.md#configmain-external_command_buffer_slots)-Option
    anpassen. Die graphische Analyse mit
    [PNP4Nagios](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios")
    (siehe oben) zeigt Ihnen, welche Werte Sie für diese Option nutzen
    sollten.

7.  **Prüfen Sie Service-Latenzzeiten, um den besten Wert für die
    maximale Anzahl von gleichzeitigen Prüfungen zu ermitteln**. Icinga
    kann die Anzahl von gleichzeitig ausgeführten Prüfungen durch die
    [max\_concurrent\_checks](configmain.md#configmain-max_concurrent_checks)-Option
    begrenzen. Das ist gut, weil es Ihnen etwas Kontrolle darüber gibt,
    wieviel Last Icinga auf Ihrem Überwachungsrechner erzeugt, aber es
    kann auch die Dinge verlangsamen. Wenn Sie für die Mehrzahl Ihrer
    Service-Prüfungen hohe Latenzzeiten sehen (\> 10 oder 15 Sekunden),
    dann enthalten Sie Icinga Prüfungen vor, die es braucht. Das ist
    nicht der Fehler von Icinga - es ist Ihrer. Unter idealen
    Bedingungen hätten alle Service-Prüfungen eine Latenzzeit von 0, was
    bedeutet, dass alle Prüfungen zu der Zeit stattfinden, für die sie
    geplant sind. Allerdings ist es normal, dass einige Prüfungen kleine
    Latenzzeiten haben. Wir würden empfehlen, die niedrigste Zahl der
    meisten gleichzeitigen Prüfungen zu nehmen, wenn Sie Icinga mit der
    **-s**-Option starten und diesen Wert zu verdoppeln. Erhöhen Sie
    diesen Wert dann soweit, bis die durchschnittlichen Latenzzeiten für
    Service-Prüfungen ziemlich niedrig ist. Mehr Informationen zur
    Planung von Service-Prüfungen finden Sie
    [hier](checkscheduling.md "7.23. Service- und Host-Prüfungsplanung").

8.  **Nutzen Sie passive Prüfungen, wenn möglich**. Der nötige Overhead,
    um die Ergebnisse von [passiven
    Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
    zu verarbeiten, ist viel niedriger als bei "normalen" aktiven
    Prüfungen, also machen Sie Gebrauch von dieser Information, wenn Sie
    eine Menge von Services überwachen. Es sollte angemerkt werden, dass
    passive Prüfungen nur dann wirklich sinnvoll sind, wenn Sie
    irgendeine externe Applikation haben, die überwachen oder berichten
    kann; wenn also Icinga all die Arbeit machen muss, ist das nicht
    hilfreich.

9.  **Vermeiden Sie interpretierte Plugins**. Etwas, was spürbar die
    Last Ihres Überwachungs-Hosts senkt, ist die Nutzung von
    kompilierten (C/C++, usw.) Plugins statt interpretierter Scripts
    (Perl, usw.). Während Perl und ähnliches einfach zu schreiben ist
    und gut läuft, kann die Tatsache, dass es bei jeder Ausführung
    kompiliert/interpretiert werden muss, zu einer spürbaren Steigerung
    der Last Ihres Überwachungs-Hosts führen, wenn Sie eine Menge von
    Service-Prüfungen haben. Wenn Sie Perl-Plugins nutzen wollen, dann
    überlegen Sie, ob Sie diese nicht mit perlcc(1) (einem Utility, das
    Teil der Standard-Perl-Distribution ist) zu einem richtigen Programm
    umwandeln oder Icinga mit eingebettetem Perl-Interpreter kompilieren
    (siehe unten).

10. **Nutzen Sie den eingebetteten Perl-Interpreter**. Wenn Sie eine
    Menge von Perl-Scripten für Prüfungen benutzen, dann werden Sie
    vielleicht feststellen, dass das Kompilieren des [eingebetteten
    Perl-Interpreters](embeddedperl.md "7.18. Benutzen des Embedded Perl Interpreters")
    (embedded Perl interpreter) in das Icinga-Binary die Dinge
    beschleunigt.

11. **Optimieren Sie Host-Prüfbefehle**. Wenn Sie Host-Zustände mit dem
    check\_ping-Plugin prüfen, dann werden Sie feststellen, dass die
    Host-Prüfungen viel schneller durchgeführt werden, wenn Sie diese
    abbrechen. Statt einen *max\_attempts*-Wert von 1 anzugeben und mit
    dem check\_ping-Plugins 10 ICMP-Pakete an den Host zu schicken, wäre
    es viel schneller, den *max\_attempts*-Wert auf 10 zu setzen und
    jedes Mal nur ein ICMP-Paket zu senden. Das liegt daran, dass Icinga
    den Zustand eines Hosts oft nach der Ausführung eines Plugins
    feststellen kann, so dass Sie die erste Prüfung so schnell wie
    möglich machen sollten. Diese Methode hat in einigen Situationen
    ihre Fallstricke (z.B. Hosts, die langsam reagieren, könnten als
    "down" angesehen werden), aber wir denken, dass Sie schnellere
    Host-Prüfungen sehen werden, wenn Sie sie benutzen. Eine weitere
    Möglichkeit wäre, statt check\_ping ein schnelleres Plugin (z.B.
    check\_fping) als *host\_check\_command* zu benutzen.

12. **Planen Sie regelmäßige Host-Prüfungen**. Regelmäßige
    Host-Prüfungen zu planen kann tatsächlich die Leistung von Icinga
    steigern. Das liegt an der Art, wie die
    [Zwischenspeicher-Prüflogik](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen")
    (cached check logic) arbeitet (siehe unten). Um regelmäßige
    Prüfungen eines Hosts zu planen, setzen Sie die
    *check\_interval*-Direktive in der
    [Host-Definition](objectdefinitions.md#objectdefinitions-host) auf
    einen Wert größer als Null.

13. **Aktivieren Sie zwischengespeicherte Host-Prüfungsergebnisse**
    (cached host checks). Host-Prüfungen nach Bedarf können von der
    Zwischenspeicherung (caching) profitieren. Host-Prüfungen nach
    Bedarf werden ausgeführt, wenn Icinga einen Service-Zustandswechsel
    feststellt. Diese Prüfungen nach Bedarf werden ausgeführt, wenn
    Icinga wissen will, ob der mit dem Service verbundene Host den
    Zustand gewechselt hat. Durch die Aktivierung von
    zwischengespeicherten Host-Prüfungsergebnissen können Sie die
    Leistung optimieren. In einigen Fällen könnte Icinga in der Lage
    sein, den alten/zwischengespeicherten Zustand des Hosts zu benutzen,
    statt eine Host-Prüfung auszuführen. Das kann die Dinge
    beschleunigen und die Last des Überwachungsservers reduzieren. Damit
    zwischengespeicherte Prüfungen effektiv sind, müssen Sie regelmäßige
    Prüfungen für Ihre Hosts planen (siehe oben). Mehr Informationen zu
    zwischengespeicherten Prüfungen finden Sie
    [hier](cachedchecks.md "7.21. Zwischengespeicherte Prüfungen").

14. **Nutzen Sie keine agressiven Host-Prüfungen**. Solange Sie keine
    Probleme damit haben, dass Icinga Host-Erholungen nicht korrekt
    erkennt, würden wir empfehlen, die
    [use\_aggressive\_host\_checking](configmain.md#configmain-use_agressive_host_checking)-Option
    nicht zu aktivieren. Wenn diese Option abgeschaltet ist, werden
    Host-Prüfungen viel schneller ausgeführt, was zu schnellerer
    Ausführung von Service-Prüfungen führt. Allerdings können
    Host-Erholungen unter bestimmten Umständen übersehen werden, wenn
    sie ausgeschaltet ist. Wenn sich z.B. der Host erholt, aber alle mit
    ihm verbundenen Services in einem nicht-OK-Zustand bleiben (und
    nicht zwischen verschiedenen nicht-OK-Zuständen "kippeln"), dann
    könnte Icinga übersehen, dass sich der Host erholt hat. Einige
    wenige Leute könnten diese Option aktivieren, aber die Mehrheit
    nicht und wir würden empfehlen, sie nicht zu aktivieren, solange Sie
    nicht glauben, dass Sie sie benötigen...

15. **Optimierung externer Befehle**. Wenn Sie eine Menge externer
    Befehle verarbeiten (d.h. passive Prüfungen in einer [verteilten
    Umgebung](distributed.md "7.6. Verteilte Überwachung"), dann
    wollen Sie vielleicht die
    [command\_check\_interval](configmain.md#configmain-command_check_interval)-Variable
    auf **-1** setzen. Das bewirkt, dass Icinga so oft wie möglich auf
    externe Befehle prüft. Sie sollten außerdem überlegen, die Anzahl
    verfügbarer [externer
    Befehlspuffer](configmain.md#configmain-external_command_buffer_slots)
    zu erhöhen. Puffer werden benutzt, um externe Befehle zu speichern,
    die (durch einen separaten Thread) aus dem [external command
    file](configmain.md#configmain-command_file) gelesen werden, bevor
    sie vom Icinga-Daemon verarbeitet werden. Wenn Ihr Icinga-Daemon
    eine Menge von passiven Prüfungen oder externen Befehlen empfängt,
    dann könnten Sie in eine Situation kommen, in der immer alle Puffer
    voll sind. Das führt zu blockierenden Kind-Prozessen (externe
    Scripte, NSCA-Daemon usw.), wenn sie versuchen, in das "external
    command file" zu schreiben. Wir würden sehr empfehlen, dass Sie die
    Nutzung von externen Befehlspuffern graphisch mit Hilfe von
    PNP4Nagios und dem icingastats-Utility darstellen, wie es
    [hier](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios")
    beschrieben ist, so dass Sie die typische externe
    Befehlspuffernutzung Ihrer Icinga-Installation sehen.

16. **Optimieren Sie die Hardware für maximale Leistung**. Hinweis:
    Hardware-Leistung sollte kein Thema sein, solange Sie nicht 1)
    Tausende von Services überwachen, 2) eine Menge von Nachverarbeitung
    von Performance-Daten usw. machen. Ihre Systemkonfiguration und Ihre
    Hardware-Ausstattung werden direkt beeinflussen, was Ihr
    Betriebssystem leistet, so dass sie beeinflussen, was Icinga
    leistet. Die häufigste Hardware-Optimierung betrifft die
    Festplatte(n). CPU und Speichergeschwindigkeit sind offensichtliche
    Faktoren, die die Leistung beeinflussen, aber der Plattenzugriff
    wird Ihr größter Flaschenhals sein. Speichern Sie Plugins, das
    Status-Log usw. nicht auf langsamen Platten (d.h. alte IDE-Platten
    oder NFS-Mounts). Wenn Sie sie haben, dann nutzen Sie UltraSCSI-
    oder schnelle IDE-Platten. Ein wichtiger Hinweis für
    IDE/Linux-Benutzer ist, dass viele Linux-Installationen nicht
    versuchen, den Plattenzugriff zu optimieren. Wenn Sie die
    Plattenzugriffsparameter nicht ändern (z.B. mit einem Utility wie
    **hdparam**), werden Sie eine **Menge** der schnellen Features der
    neuen IDE-Platten verlieren.

17. **Benutzen Sie eine RAM-Disk für temporäre Daten** . Verschiedene
    Dateien werden sehr oft angelegt und verarbeitet. Das betrifft u.a.
    den aktuellen Zustand, der im [status
    file](configmain.md#configmain-status_file) gespeichert wird und
    die laufende Konfiguration, die im [object cache
    file](configmain.md#configmain-object_cache_file) abgelegt ist. Um
    physikalischen I/O zu reduzieren, ist es ratsam, diese Daten auf
    einer RAM-Disk abzulegen. Datenverlust durch einen Stromausfall oder
    etwas ähnliches ist nicht kritisch, weil diese beiden Dateien bei
    jedem (Re-)Start von Icinga neu erzeugt werden. Das Anlegen einer
    RAM-Disk und die Änderungen an der Hauptkonfigurationsdatei werden
    [hier](temp_data.md "8.8. Temporäre Daten") beschrieben.

* * * * *

  --------------------------------------------------------------------- -------------------------- -----------------------------
  [Zurück](cgisecurity.md)                                            [Nach oben](ch08.md)      [Weiter](faststartup.md)
  8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung    [Zum Anfang](index.md)    8.4. Schnellstart-Optionen
  --------------------------------------------------------------------- -------------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
