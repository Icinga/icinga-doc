Status Stalking
===============

Einführung
----------

Statusverfolgung ("state stalking") ist ein Feature, welches
wahrscheinlich von den meisten Benutzern nicht eingesetzt wird. Wenn es
aktiviert ist, erlaubt es Ihnen die Protokollierung von Änderungen bei
Service- und Host-Prüfungen, selbst wenn sich der Zustand von Host oder
Service nicht ändert. Wenn die Verfolgung für einen bestimmten Host oder
Service aktiviert ist, wird NAME-ICINGA den Host oder Service sehr genau
beobachten und jede Änderung protokollieren, die es in der Ausgabe der
Prüfergebnisse sieht. Wie Sie sehen werden, kann es sehr hilfreich bei
der späteren Analyse der Log-Files sein.

Wie funktioniert es?
--------------------

Unter normalen Umständen wird das Ergebnis einer Host- oder
Service-Prüfung nur protokolliert, wenn der Host oder Service seit der
letzten Prüfung seinen Zustand geändert hat. Es gibt wenige Ausnahmen,
aber normalerweise ist das die Regel.

Wenn Sie die Verfolgung für einen oder mehrere Zustände eines bestimmten
Hosts oder Service aktivieren, wird NAME-ICINGA die Ergebnisse der Host-
oder Service-Prüfung protokollieren, wenn sich die Ausgaben der Prüfung
von den Ausgaben der letzten Prüfung unterscheiden. Nehmen Sie das
folgende Beispiel von acht aufeinander folgenden Prüfungen eines
Service:

  ---------- ---------- ------------------------------ ---------- ----------
  **Service  **Service  **Service Check Output:**      **Logged   **Logged
  Check      State:**                                  Normally** With
  \#:**                                                           Stalking**

  x          OK         RAID array optimal             -          -

  x+1        OK         RAID array optimal             -          -

  x+2        WARNING    RAID array degraded (1 drive   ![](../ima ![](../ima
                        bad, 1 hot spare rebuilding)   ges/checkm ges/checkm
                                                       ark.png)   ark.png)

  x+3        CRITICAL   RAID array degraded (2 drives  ![](../ima ![](../ima
                        bad, 1 host spare online, 1    ges/checkm ges/checkm
                        hot spare rebuilding)          ark.png)   ark.png)

  x+4        CRITICAL   RAID array degraded (3 drives  -          ![](../ima
                        bad, 2 hot spares online)                 ges/checkm
                                                                  ark.png)

  x+5        CRITICAL   RAID array failed              -          ![](../ima
                                                                  ges/checkm
                                                                  ark.png)

  x+6        CRITICAL   RAID array failed              -          -

  x+7        CRITICAL   RAID array failed              -          -
  ---------- ---------- ------------------------------ ---------- ----------

Bei dieser Reihenfolge von Prüfungen würden Sie normalerweise nur zwei
Einträge dieser Katastrophe sehen. Der erste würde bei Prüfung x+2
auftreten, wenn der Service von einem OK- in einen WARNING-Zustand
wechselt. Der zweite Log-Eintrag würde bei Service-Prüfung x+3
auftreten, wenn der Service von einem WARNING- in einen CRITICAL-Zustand
wechselt.

Aus welchem Grund auch immer möchten Sie die komplette Geschichte dieser
Katastrophe in Ihren Log-Dateien sehen. Vielleicht, um Ihrem Manager zu
zeigen, wie schnell die Situation außer Kontrolle geriet, vielleicht
nur, um bei ein paar Bier in der Kneipe darüber zu lachen...

Wenn Sie die Verfolgung dieses Services für CRITICAL-Zustände aktiviert
haben, hätten Sie zusätzlich zu den Ereignissen x+2 und x+3 auch noch
x+4 und x+5 protokolliert. Warum ist das so? Mit aktivierter Verfolgung
hätte NAME-ICINGA die Ausgaben jeder Service-Prüfung untersucht, um
Veränderungen zur Ausgabe der vorherigen Prüfung festzustellen. Wenn
sich die Ausgaben unterscheiden und sich der Zustand des Service
zwischen den beiden Prüfungen nicht verändert hat, würde die Ausgabe der
neueren Prüfung protokolliert.

Ein ähnliches Beispiel für die Verfolgung könnte ein Service sein, der
Ihren Web-Server prüft. Wenn das check\_http-Plugin das erste Mal einen
WARNING-Zustand wegen eines 404-Fehlers zurückliefert und bei folgenden
Prüfungen einen WARNING-Zustand wegen eines nicht gefundenen Musters
zurückliefert, dann möchten Sie das vielleicht wissen. Wenn Sie die
Statusverfolgung für WARNING-Zustände nicht aktiviert haben, würde nur
das erste WARNING-Ereignis (der 404-Fehler) protokolliert und Sie hätten
keine Ahnung (beim Blick auf archivierte Protokolle), dass weitere
WARNING-Zustände nicht auf dem 404-Fehler zurückzuführen sind, sondern
dass bestimmte Textmuster nicht in der untersuchten Web-Seite zu finden
waren.

Sollte ich die Verfolgung aktivieren?
-------------------------------------

Zuerst müssen Sie entscheiden, ob Sie wirklich Bedarf zur Untersuchung
archivierter Protokolldaten haben, um die genaue Ursache eines Problems
zu finden. Sie können entscheiden, dass Sie dieses Feature für ein paar
Hosts oder Services brauchen, aber nicht für alle. Sie können auch
feststellen, dass Sie die Verfolgung nur für einige Host- oder
Service-Zustände brauchen, statt für alle. Sie könnten z.B. entscheiden,
dass Sie die Verfolgung nur für die WARNING- und CRITICAL-Zustände eines
Service benötigen, aber nicht OK- und UNKNOWN-Zustände.

Die Entscheidung, die Verfolgung für einen bestimmten Host oder Service
zu aktivieren, hängt auch vom Plugin ab, das Sie zur Prüfung des Hosts
oder Service einsetzen.

Wie aktiviere ich die Verfolgung?
---------------------------------

Sie können die Verfolgung für Hosts und Services durch die
*stalking\_options*-Direktive in den [Host- und
Service-Definitionen](#configobject) aktivieren.

Wie unterschieden sich Verfolgung und "flüchtige Services"?
-----------------------------------------------------------

[Flüchtige Services](#volatileservices) (volatile services) sind
ähnlich, aber sie verursachen Benachrichtigungen und führen Eventhandler
aus. Die Verfolgung dient lediglich der Protokollierung.

Risiken
-------

Sie sollten beachten, dass es einige potenzielle Fallstricke bei der
Aktivierung von Verfolgungen gibt. Sie beziehen sich alle auf die
Berichtsfunktionen, die in verschiedenen [CGIs](#cgis) zu finden sind
(Histogramm, Alarmübersicht, usw.). Weil die Statusverfolgung
zusätzliche Alarmeinträge schreibt, werden die Berichte eine erhöhte
Anzahl von Alarmen anzeigen.

Als generelle Regel würden wir empfehlen, dass Sie die Verfolgung für
Hosts und Services *nicht* aktivieren, ohne gründlich darüber
nachgedacht zu haben. Auf jeden Fall ist sie da, wenn Sie sie brauchen.

Statusverfolgung
