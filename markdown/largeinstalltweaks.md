Large Installation Tweaks
=========================

Einführung
----------

Benutzer mit großen NAME-ICINGA-Installation können von der
[use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)-Konfigurationsoption
profitieren. Das Aktivieren dieser Option erlaubt es dem
NAME-ICINGA-Daemon, bestimmte Abkürzungen zu nehmen, die in geringerer
Systembelastung und besserer Leistung resultieren.

Effekte
-------

Wenn Sie die
[use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)-Option
in Ihrer NAME-ICINGA-Hauptkonfigurationsdatei aktivieren, werden mehrere
Anpassungen gemacht, wie der NAME-ICINGA-Daemon arbeitet:

1.  **Keine Zusammenfassungsmakros in Umgebungsvariablen** - Die
    [Zusammenfassungsmakros](#macrolist-summary_macros) werden Ihnen
    nicht als Umgebungsvariablen zur Verfügung stehen. Die Berechnung
    der Werte dieser Makros kann in großen Konfigurationen ziemlich
    zeitintensiv sein, so dass sie nicht als Umgebungsvariablen zur
    Verfügung stehen, wenn Sie diese Option benutzen.
    Zusammenfassungsmakros sind weiterhin als reguläre Makros verfügbar,
    wenn Sie diese Ihren Scripts als Parameter übergeben.

    > **Note**
    >
    > Seit 1.9 werden
    > host
    > and
    > service
    > group member macros nicht mehr exportiert, da diese sehr gross
    > werden und die Shellumgebung zerstören können.

2.  **Unterschiedliche Speicherbereinigung** - Normalerweise wird
    NAME-ICINGA den allokierten Speicher in Kind-Prozessen freigeben,
    bevor sie enden. Dies ist wahrscheinlich die beste Vorgehensweise,
    aber vielleicht in großen Installationen unnötig, weil die meisten
    Betriebssysteme selbst darauf achten, allokierten Speicher
    freizugeben, wenn Prozesse enden. Das Betriebssystem neigt dazu,
    belegten Speicher schneller freizugeben, als NAME-ICINGA das kann,
    so dass NAME-ICINGA nicht versucht, Speicher in Kind-Prozessen
    freizugeben, wenn Sie diese Option aktivieren.

3.  **Weniger fork()** - Normalerweise wird NAME-ICINGA zweimal fork()
    aufrufen, wenn es Host- und Service-Prüfungen ausführt. Das wird
    getan, um (1) ein hohes Maß an Resistenz sicherzustellen gegen
    Plugins, die fehlschlagen und einen SegFault erzeugen und (2) dafür
    sorgen, dass das Betriebssystem sich um die Bereinigung der
    Enkel-Prozesse kümmert, sobald sie enden. Der zusätzliche fork() ist
    nicht wirklich nötig, so dass er übersprungen wird, wenn Sie diese
    Option aktivieren. Als Ergebnis werden Kind-Prozesse von NAME-ICINGA
    selbst bereinigt (anstatt diese Aufgabe dem Betriebssystem zu
    überlassen). Dieses Feature sollte für spürbare Lasteinsparungen in
    Ihrer NAME-ICINGA-Installation sorgen.

Large Installation Tweaks
