![Icinga](../images/logofullsize.png "Icinga")

6.9. Integration von PNP4Nagios in das Icinga Web Frontend

[Zurück](icinga-web-introduction.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](ch07.md)

* * * * *

6.9. Integration von PNP4Nagios in das Icinga Web Frontend
----------------------------------------------------------

6.9.1. [Installieren von PNP4Nagios](icinga-web-pnp.md#installpnp)

6.9.2. [Template-Extensions](icinga-web-pnp.md#templateextension)

6.9.3. [Löschen des Cache](icinga-web-pnp.md#idp12925840)

Mit Hilfe dieser Anleitung können Sie PNP4Nagios in das Icinga
Web-Frontend integrieren. Wenn Sie PNP4Nagios in das Icinga Classic UI
integrieren möchten, lesen Sie bitte die PNP4Nagios
[Dokumentation.](http://docs.pnp4nagios.org/de/pnp-0.6/start)

**Abbildung 6.41. Expander-Icon**

![Expander-Icon](../images/icinga-web-exp_1.png)

\

Links sehen Sie das "Expander"-Icon. Nach dem Klicken öffnet sich ein
Balken (unterhalb des OK-Zeichens).

**Abbildung 6.42. Icon-Balken**

![Icon-Balken](../images/icinga-web-exp_2.png)

\

Rechts im "PNP4Nagios"-Abschnitt gibt es zwei Buttons.

**Abbildung 6.43. PNP4Nagios-Icons**

![PNP4Nagios-Icons](../images/icinga-web-exp_3.png)

\

Nach Rechts-Klick auf einen der beiden und auswählen von "Move into
grid" wird das entsprechende Icon ins Raster verschoben.

**Abbildung 6.44. Icon verschieben in Raster**

![Icon verschieben in Raster](../images/icinga-web-exp_4.png)

\

Auswählen des neuen Icons öffnet den PNP-Graphen in einem kleinen
Fenster, das lediglich einen Zeitabschnitt anzeigt oder es wird ein
neuer Reiter erstellt, in dem die übliche PNP-Ansicht zu sehen ist.

Klicken auf"Setting" und auswählen von "Reset grid action icons"
entfernt die eingefügten Icons und stellt die Standardansicht wieder
her.

**Abbildung 6.45. Zurücksetzen von Icon-Einstellungen**

![Zurücksetzen von Icon-Einstellungen](../images/icinga-web-exp_5.png)

\

### 6.9.1. Installieren von PNP4Nagios

1.  Installieren Sie PNP4Nagios wie in der
    PNP4Nagios-[Dokumentation](http://docs.pnp4nagios.org/de/pnp-0.6/start)
    beschrieben.

2.  Passen Sie die PNP4Nagios-Konfiguration auf Ihre
    Icinga-Konfiguration an. Wahrscheinlich müssen Sie hier ändern:

    ~~~~ {.programlisting}
    #> vi npcd.cfg
        user = icinga
        group = icinga
        log_file = /var/log/icinga/npcd.log
        perfdata_spool_dir = /var/icinga/spool/
        perfdata_file = /var/icinga/perfdata.dump
    ~~~~

    ~~~~ {.programlisting}
    #> vi process_perfdata.cfg
        LOG_FILE = /var/log/icinga/perfdata.log
        XML_ENC = ISO-8859-1   # falls Sie Probleme mit Umlauten haben
    ~~~~

    ~~~~ {.programlisting}
    #> vi config.php 
        $conf['nagios_base'] = "/icinga/cgi-bin";
    ~~~~

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Stellen Sie sicher, dass Sie bestehende Pfade benutzen, legen Sie
    sie an, falls notwendig, und/oder passen Sie die Angaben an Ihre
    Distribution an.

    Bitte überprüfen Sie, dass die command-Definitionen für
    "process-host-perfdata-file" und "process-service-perfdata-file"
    (wahrscheinlich in `etc/objects/commands.cfg`{.filename}) auf das
    gleiche Zielverzeichnis zeigen, das in perfdata\_spool\_dir
    angegeben wurde.

### 6.9.2. Template-Extensions

Die PNP-Integration wurde mit diesen Extensions upgrade-sicher gemacht.

Ausschnitt aus `INSTALL`{.filename} in
`contrib/PNP_Integration/`{.filename}

~~~~ {.screen}
#> cat contrib/PNP_Integration/INSTALL
    ************************
    * INSTALLATION
    ************************

    * To install this addon, simply copy both xml files under templateExtensions
    * to your icinga-webs app/modules/Cronks/data/xml/extensions folder
    * and clear the app/cache/CronkTemplates folder
    * To remove it, just delete the extension files and clear the cache folder again
~~~~

*Install Script*

Nachdem es sich lediglich um das Kopieren der beiden genannten Daten
handelt, gibt es kein Skript. Sorry.

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass Sie das Addon nach einem Icinga-Web-Upgrade
erneut installieren müssen.

### 6.9.3. Löschen des Cache

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte denken Sie daran, dass Sie nach dem Editieren von \*.xml-Dateien
den Cache bereinigen müssen!

~~~~ {.programlisting}
#> rm -f app/cache/config/*.php
~~~~

oder /path/to/clearcache.sh

~~~~ {.programlisting}
#> /usr/local/icinga-web/bin/clearcache.sh
~~~~

Das war es auch schon, Sie sind fertig!

* * * * *

  ----------------------------------------- -------------------------- -------------------------------------
  [Zurück](icinga-web-introduction.md)    [Nach oben](ch06.md)      [Weiter](ch07.md)
  6.8. Einführung in Icinga Web             [Zum Anfang](index.md)    Kapitel 7. Fortgeschrittene Themen
  ----------------------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
