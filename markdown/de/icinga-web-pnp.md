 ![Icinga](../images/logofullsize.png "Icinga") 

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










### 6.9.2. Template-Extensions

Die PNP-Integration wurde mit diesen Extensions upgrade-sicher gemacht.

Ausschnitt aus `INSTALL` in
`contrib/PNP_Integration/`

#> cat contrib/PNP_Integration/INSTALL

</code></pre>

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

<pre><code>
#> rm -f app/cache/config/*.php
</code></pre>

oder /path/to/clearcache.sh

<pre><code>
#> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

Das war es auch schon, Sie sind fertig!

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
