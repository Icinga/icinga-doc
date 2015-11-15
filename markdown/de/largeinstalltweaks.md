![Icinga](../images/logofullsize.png "Icinga")

8.5. Large Installation Tweaks

[Zurück](faststartup.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](icingastats.md)

* * * * *

8.5. Large Installation Tweaks
------------------------------

8.5.1. [Einführung](largeinstalltweaks.md#introduction)

8.5.2. [Effekte](largeinstalltweaks.md#effects)

### 8.5.1. Einführung

Benutzer mit großen Icinga-Installation können von der
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)-Konfigurationsoption
profitieren. Das Aktivieren dieser Option erlaubt es dem Icinga-Daemon,
bestimmte Abkürzungen zu nehmen, die in geringerer Systembelastung und
besserer Leistung resultieren.

### 8.5.2. Effekte

Wenn Sie die
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)-Option
in Ihrer Icinga-Hauptkonfigurationsdatei aktivieren, werden mehrere
Anpassungen gemacht, wie der Icinga-Daemon arbeitet:

1.  **Keine Zusammenfassungsmakros in Umgebungsvariablen** - Die
    [Zusammenfassungsmakros](macrolist.md#macrolist-summary_macros)
    werden Ihnen nicht als Umgebungsvariablen zur Verfügung stehen. Die
    Berechnung der Werte dieser Makros kann in großen Konfigurationen
    ziemlich zeitintensiv sein, so dass sie nicht als Umgebungsvariablen
    zur Verfügung stehen, wenn Sie diese Option benutzen.
    Zusammenfassungsmakros sind weiterhin als reguläre Makros verfügbar,
    wenn Sie diese Ihren Scripts als Parameter übergeben.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Seit 1.9 werden [host](macrolist.md#macrolist-hostgroupmembers)
    and [service](macrolist.md#macrolist-servicegroupmembers)group
    member macros nicht mehr exportiert, da diese sehr gross werden und
    die Shellumgebung zerstören können.

2.  **Unterschiedliche Speicherbereinigung** - Normalerweise wird Icinga
    den allokierten Speicher in Kind-Prozessen freigeben, bevor sie
    enden. Dies ist wahrscheinlich die beste Vorgehensweise, aber
    vielleicht in großen Installationen unnötig, weil die meisten
    Betriebssysteme selbst darauf achten, allokierten Speicher
    freizugeben, wenn Prozesse enden. Das Betriebssystem neigt dazu,
    belegten Speicher schneller freizugeben, als Icinga das kann, so
    dass Icinga nicht versucht, Speicher in Kind-Prozessen freizugeben,
    wenn Sie diese Option aktivieren.

3.  **Weniger fork()** - Normalerweise wird Icinga zweimal fork()
    aufrufen, wenn es Host- und Service-Prüfungen ausführt. Das wird
    getan, um (1) ein hohes Maß an Resistenz sicherzustellen gegen
    Plugins, die fehlschlagen und einen SegFault erzeugen und (2) dafür
    sorgen, dass das Betriebssystem sich um die Bereinigung der
    Enkel-Prozesse kümmert, sobald sie enden. Der zusätzliche fork() ist
    nicht wirklich nötig, so dass er übersprungen wird, wenn Sie diese
    Option aktivieren. Als Ergebnis werden Kind-Prozesse von Icinga
    selbst bereinigt (anstatt diese Aufgabe dem Betriebssystem zu
    überlassen). Dieses Feature sollte für spürbare Lasteinsparungen in
    Ihrer Icinga-Installation sorgen.

* * * * *

  ----------------------------- -------------------------- ----------------------------------------
  [Zurück](faststartup.md)    [Nach oben](ch08.md)      [Weiter](icingastats.md)
  8.4. Schnellstart-Optionen    [Zum Anfang](index.md)    8.6. Nutzung des Icingastats-Utilitys
  ----------------------------- -------------------------- ----------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
