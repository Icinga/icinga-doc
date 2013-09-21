NAME-ICINGA für maximale Leistung optimieren
============================================

Einführung
----------

![](../images/tuning.png)

Jetzt haben Sie NAME-ICINGA endlich eingerichtet und lauffähig und nun
wollen Sie wissen, wie man ein wenig daran drehen kann. Die Leistung von
NAME-ICINGA zu optimieren kann notwendig sein, wenn Sie eine große Zahl
(\> 1.000) von Hosts und Services haben. Hier ein paar Dinge, nach denen
Sie schauen können, um NAME-ICINGA zu optimieren...

Optimierungshinweise:
---------------------

1.  **Stellen Sie Performance-Statistiken mit NAME-PNP dar**. Um zu
    verfolgen, wie die Last Ihrer NAME-ICINGA-Installation aussieht und
    welche Auswirkungen Ihre Konfigurationsänderungen darauf haben,
    sollten Sie verschiedene wichtige Statistiken mit NAME-PNP
    darstellen. Das ist wirklich sehr, sehr sinnvoll, wenn es um die
    Leistungsoptimierung einer NAME-ICINGA-Installation geht.
    Informationen, wie das zu tun ist, finden Sie [hier](#perfgraphs).

2.  **Benutzen Sie "Verbesserungen für große Installationen"** (large
    installation tweaks). Das Aktivieren der
    [use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)-Option
    kann Ihnen bessere Leistung bringen. Lesen Sie
    [hier](#largeinstalltweaks) mehr darüber, was diese Option tut.

3.  **Deaktivieren Sie Umgebungs-Makros**. Makros werden Prüfungen,
    Benachrichtigungen, Eventhandlern usw. normalerweise über
    Umgebungsvariablen zur Verfügung gestellt. Das kann in einer großen
    NAME-ICINGA-Installation zu einem Problem werden, weil es
    zusätzlichen Speicher (und wichtiger) mehr CPU verbraucht. Wenn Ihre
    Scripte nicht über Umgebungsvariablen auf Makros zugreifen (d.h.,
    wenn Sie alle benötigen Makros in der Kommandozeile übergeben), dann
    brauchen Sie dieses Feature nicht. Sie können über die
    [enable\_environment\_macros](#configmain-enable_environment_macros)-Option
    einstellen, ob Makros als Umgebungsvariablen verfügbar sind.

4.  **Prüfergebnis-Ernterhythmus** (Check Result Reaper Frequency). Die
    [check\_result\_reaper\_frequency](#configmain-check_result_reaper_frequency)-Variable
    legt fest, wie oft NAME-ICINGA prüfen soll, ob Host- und
    Service-Ergebnisse verarbeitet werden müssen. Die maximale Zeit, die
    es zur Verarbeitung solcher Ergebnisse benötigen darf, ist durch die
    maximale Erntezeit (max reaper time) festgelegt (siehe unten). Wenn
    Ihr Ernterhythmus zu hoch (zu selten) ist, könnten Sie hohe
    Latenzzeiten für Host- und Service-Prüfungen sehen.

5.  **maximale Erntezeit** (Max Reaper Time). Die
    [max\_check\_result\_reaper\_time](#configmain-max_check_result_reaper_time)-Variable
    legt die maximale Zeit fest, die der NAME-ICINGA-Daemon für die
    Verarbeitung der Ergebnisse von Host- und Service-Prüfungen
    verbringen darf, bevor er sich anderen Dingen zuwendet - wie z.B.
    dem Ausführen von neuen Host- und Service-Prüfungen. Ein zu hoher
    Wert kann zu hohen Latenzzeiten bei Ihren Host- und
    Service-Prüfungen führen. Ein zu niedriger Wert kann den gleichen
    Effekt haben. Wenn Sie zu hohe Latenzzeiten haben, dann passen Sie
    diesen Wert an und sehen Sie, welchen Effekt das hat. [Graphisch
    dargestellte Statistiken](#perfgraphs) helfen Ihnen bei der
    Auswertung der Auswirkungen.

6.  **Anpassen der Pufferwerte**. Gegebenenfalls müssen Sie den Wert der
    [external\_command\_buffer\_slots](#configmain-external_command_buffer_slots)-Option
    anpassen. Die graphische Analyse mit [NAME-PNP](#perfgraphs) (siehe
    oben) zeigt Ihnen, welche Werte Sie für diese Option nutzen sollten.

7.  **Prüfen Sie Service-Latenzzeiten, um den besten Wert für die
    maximale Anzahl von gleichzeitigen Prüfungen zu ermitteln**.
    NAME-ICINGA kann die Anzahl von gleichzeitig ausgeführten Prüfungen
    durch die
    [max\_concurrent\_checks](#configmain-max_concurrent_checks)-Option
    begrenzen. Das ist gut, weil es Ihnen etwas Kontrolle darüber gibt,
    wieviel Last NAME-ICINGA auf Ihrem Überwachungsrechner erzeugt, aber
    es kann auch die Dinge verlangsamen. Wenn Sie für die Mehrzahl Ihrer
    Service-Prüfungen hohe Latenzzeiten sehen (\> 10 oder 15 Sekunden),
    dann enthalten Sie NAME-ICINGA Prüfungen vor, die es braucht. Das
    ist nicht der Fehler von NAME-ICINGA - es ist Ihrer. Unter idealen
    Bedingungen hätten alle Service-Prüfungen eine Latenzzeit von 0, was
    bedeutet, dass alle Prüfungen zu der Zeit stattfinden, für die sie
    geplant sind. Allerdings ist es normal, dass einige Prüfungen kleine
    Latenzzeiten haben. Wir würden empfehlen, die niedrigste Zahl der
    meisten gleichzeitigen Prüfungen zu nehmen, wenn Sie NAME-ICINGA mit
    der **-s**-Option starten und diesen Wert zu verdoppeln. Erhöhen Sie
    diesen Wert dann soweit, bis die durchschnittlichen Latenzzeiten für
    Service-Prüfungen ziemlich niedrig ist. Mehr Informationen zur
    Planung von Service-Prüfungen finden Sie [hier](#checkscheduling).

8.  **Nutzen Sie passive Prüfungen, wenn möglich**. Der nötige Overhead,
    um die Ergebnisse von [passiven Service-Prüfungen](#passivechecks)
    zu verarbeiten, ist viel niedriger als bei "normalen" aktiven
    Prüfungen, also machen Sie Gebrauch von dieser Information, wenn Sie
    eine Menge von Services überwachen. Es sollte angemerkt werden, dass
    passive Prüfungen nur dann wirklich sinnvoll sind, wenn Sie
    irgendeine externe Applikation haben, die überwachen oder berichten
    kann; wenn also NAME-ICINGA all die Arbeit machen muss, ist das
    nicht hilfreich.

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
    umwandeln oder NAME-ICINGA mit eingebettetem Perl-Interpreter
    kompilieren (siehe unten).

10. **Nutzen Sie den eingebetteten Perl-Interpreter**. Wenn Sie eine
    Menge von Perl-Scripten für Prüfungen benutzen, dann werden Sie
    vielleicht feststellen, dass das Kompilieren des [eingebetteten
    Perl-Interpreters](#embeddedperl) (embedded Perl interpreter) in das
    NAME-ICINGA-Binary die Dinge beschleunigt.

11. **Optimieren Sie Host-Prüfbefehle**. Wenn Sie Host-Zustände mit dem
    check\_ping-Plugin prüfen, dann werden Sie feststellen, dass die
    Host-Prüfungen viel schneller durchgeführt werden, wenn Sie diese
    abbrechen. Statt einen *max\_attempts*-Wert von 1 anzugeben und mit
    dem check\_ping-Plugins 10 ICMP-Pakete an den Host zu schicken, wäre
    es viel schneller, den *max\_attempts*-Wert auf 10 zu setzen und
    jedes Mal nur ein ICMP-Paket zu senden. Das liegt daran, dass
    NAME-ICINGA den Zustand eines Hosts oft nach der Ausführung eines
    Plugins feststellen kann, so dass Sie die erste Prüfung so schnell
    wie möglich machen sollten. Diese Methode hat in einigen Situationen
    ihre Fallstricke (z.B. Hosts, die langsam reagieren, könnten als
    "down" angesehen werden), aber wir denken, dass Sie schnellere
    Host-Prüfungen sehen werden, wenn Sie sie benutzen. Eine weitere
    Möglichkeit wäre, statt check\_ping ein schnelleres Plugin (z.B.
    check\_fping) als *host\_check\_command* zu benutzen.

12. **Planen Sie regelmäßige Host-Prüfungen**. Regelmäßige
    Host-Prüfungen zu planen kann tatsächlich die Leistung von
    NAME-ICINGA steigern. Das liegt an der Art, wie die
    [Zwischenspeicher-Prüflogik](#cachedchecks) (cached check logic)
    arbeitet (siehe unten). Um regelmäßige Prüfungen eines Hosts zu
    planen, setzen Sie die *check\_interval*-Direktive in der
    [Host-Definition](#objectdefinitions-host) auf einen Wert größer als
    Null.

13. **Aktivieren Sie zwischengespeicherte Host-Prüfungsergebnisse**
    (cached host checks). Host-Prüfungen nach Bedarf können von der
    Zwischenspeicherung (caching) profitieren. Host-Prüfungen nach
    Bedarf werden ausgeführt, wenn NAME-ICINGA einen
    Service-Zustandswechsel feststellt. Diese Prüfungen nach Bedarf
    werden ausgeführt, wenn NAME-ICINGA wissen will, ob der mit dem
    Service verbundene Host den Zustand gewechselt hat. Durch die
    Aktivierung von zwischengespeicherten Host-Prüfungsergebnissen
    können Sie die Leistung optimieren. In einigen Fällen könnte
    NAME-ICINGA in der Lage sein, den alten/zwischengespeicherten
    Zustand des Hosts zu benutzen, statt eine Host-Prüfung auszuführen.
    Das kann die Dinge beschleunigen und die Last des
    Überwachungsservers reduzieren. Damit zwischengespeicherte Prüfungen
    effektiv sind, müssen Sie regelmäßige Prüfungen für Ihre Hosts
    planen (siehe oben). Mehr Informationen zu zwischengespeicherten
    Prüfungen finden Sie [hier](#cachedchecks).

14. **Nutzen Sie keine agressiven Host-Prüfungen**. Solange Sie keine
    Probleme damit haben, dass NAME-ICINGA Host-Erholungen nicht korrekt
    erkennt, würden wir empfehlen, die
    [use\_aggressive\_host\_checking](#configmain-use_agressive_host_checking)-Option
    nicht zu aktivieren. Wenn diese Option abgeschaltet ist, werden
    Host-Prüfungen viel schneller ausgeführt, was zu schnellerer
    Ausführung von Service-Prüfungen führt. Allerdings können
    Host-Erholungen unter bestimmten Umständen übersehen werden, wenn
    sie ausgeschaltet ist. Wenn sich z.B. der Host erholt, aber alle mit
    ihm verbundenen Services in einem nicht-OK-Zustand bleiben (und
    nicht zwischen verschiedenen nicht-OK-Zuständen "kippeln"), dann
    könnte NAME-ICINGA übersehen, dass sich der Host erholt hat. Einige
    wenige Leute könnten diese Option aktivieren, aber die Mehrheit
    nicht und wir würden empfehlen, sie nicht zu aktivieren, solange Sie
    nicht glauben, dass Sie sie benötigen...

15. **Optimierung externer Befehle**. Wenn Sie eine Menge externer
    Befehle verarbeiten (d.h. passive Prüfungen in einer [verteilten
    Umgebung](#distributed), dann wollen Sie vielleicht die
    [command\_check\_interval](#configmain-command_check_interval)-Variable
    auf **-1** setzen. Das bewirkt, dass NAME-ICINGA so oft wie möglich
    auf externe Befehle prüft. Sie sollten außerdem überlegen, die
    Anzahl verfügbarer [externer
    Befehlspuffer](#configmain-external_command_buffer_slots) zu
    erhöhen. Puffer werden benutzt, um externe Befehle zu speichern, die
    (durch einen separaten Thread) aus dem [external command
    file](#configmain-command_file) gelesen werden, bevor sie vom
    NAME-ICINGA-Daemon verarbeitet werden. Wenn Ihr NAME-ICINGA-Daemon
    eine Menge von passiven Prüfungen oder externen Befehlen empfängt,
    dann könnten Sie in eine Situation kommen, in der immer alle Puffer
    voll sind. Das führt zu blockierenden Kind-Prozessen (externe
    Scripte, NAME-NSCA-Daemon usw.), wenn sie versuchen, in das
    "external command file" zu schreiben. Wir würden sehr empfehlen,
    dass Sie die Nutzung von externen Befehlspuffern graphisch mit Hilfe
    von NAME-PNP und dem NAME-STATS-Utility darstellen, wie es
    [hier](#perfgraphs) beschrieben ist, so dass Sie die typische
    externe Befehlspuffernutzung Ihrer NAME-ICINGA-Installation sehen.

16. **Optimieren Sie die Hardware für maximale Leistung**. Hinweis:
    Hardware-Leistung sollte kein Thema sein, solange Sie nicht 1)
    Tausende von Services überwachen, 2) eine Menge von Nachverarbeitung
    von Performance-Daten usw. machen. Ihre Systemkonfiguration und Ihre
    Hardware-Ausstattung werden direkt beeinflussen, was Ihr
    Betriebssystem leistet, so dass sie beeinflussen, was NAME-ICINGA
    leistet. Die häufigste Hardware-Optimierung betrifft die
    Festplatte(n). CPU und Speichergeschwindigkeit sind offensichtliche
    Faktoren, die die Leistung beeinflussen, aber der Plattenzugriff
    wird Ihr größter Flaschenhals sein. Speichern Sie Plugins, das
    Status-Log usw. nicht auf langsamen Platten (d.h. alte IDE-Platten
    oder NFS-Mounts). Wenn Sie sie haben, dann nutzen Sie UltraSCSI-
    oder schnelle IDE-Platten. Ein wichtiger Hinweis für
    IDE/NAME-LINUX-Benutzer ist, dass viele NAME-LINUX-Installationen
    nicht versuchen, den Plattenzugriff zu optimieren. Wenn Sie die
    Plattenzugriffsparameter nicht ändern (z.B. mit einem Utility wie
    **hdparam**), werden Sie eine **Menge** der schnellen Features der
    neuen IDE-Platten verlieren.

17. **Benutzen Sie eine RAM-Disk für temporäre Daten** . Verschiedene
    Dateien werden sehr oft angelegt und verarbeitet. Das betrifft u.a.
    den aktuellen Zustand, der im [status file](#configmain-status_file)
    gespeichert wird und die laufende Konfiguration, die im [object
    cache file](#configmain-object_cache_file) abgelegt ist. Um
    physikalischen I/O zu reduzieren, ist es ratsam, diese Daten auf
    einer RAM-Disk abzulegen. Datenverlust durch einen Stromausfall oder
    etwas ähnliches ist nicht kritisch, weil diese beiden Dateien bei
    jedem (Re-)Start von NAME-ICINGA neu erzeugt werden. Das Anlegen
    einer RAM-Disk und die Änderungen an der Hauptkonfigurationsdatei
    werden [hier](#temp_data) beschrieben.

NAME-ICINGA für maximale Leistung optimieren
