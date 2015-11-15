![Icinga](../images/logofullsize.png "Icinga")

7.16. Geplante Ausfallzeiten

[Zurück](perfdata.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](recurring_downtimes.md)

* * * * *

7.16. Geplante Ausfallzeiten
----------------------------

7.16.1. [Einführung](downtime.md#introduction)

7.16.2. [Ausfallzeit einplanen](downtime.md#schedule)

7.16.3. [Feste und flexible
Ausfallzeiten](downtime.md#fixedvsflexible)

7.16.4. [ausgelöste Ausfallzeiten](downtime.md#triggered)

7.16.5. [Wie geplante Ausfallzeiten Benachrichtigungen
beeinflussen](downtime.md#affectednotifications)

7.16.6. [Überlappende geplante Ausfallzeiten](downtime.md#overlapping)

### 7.16.1. Einführung

Icinga erlaubt Ihnen, Termine für geplante Ausfallzeiten (downtime) von
Hosts und Services zu vergeben, die Sie überwachen. Das ist nützlich,
wenn Sie bereits wissen, dass Sie einen Server für einen Upgrade oder
etwas Ähnliches herunterfahren müssen.

![](../images/downtime.png)

### 7.16.2. Ausfallzeit einplanen

Sie können eine Ausfallzeit für Hosts und Services über das [extinfo
CGI](cgis.md#cgis-extinfo_cgi) einplanen (wenn Sie Host- oder
Service-Informationen ansehen). Klicken Sie auf den Link "Schedule
downtime for this host/service", um die Ausfallzeit zu planen.

Sobald Sie die Ausfallzeit für einen Host oder Service einplanen, wird
Icinga für diesen Host oder Service einen Kommentar hinzufügen, der
anzeigt, dass für diese Periode eine Ausfallzeit geplant ist. Wenn die
Zeit vorüber ist, wird Icinga diesen Kommentar automatisch löschen.
Cool, oder?

### 7.16.3. Feste und flexible Ausfallzeiten

Wenn Sie über das Web-Interface eine Ausfallzeit einplanen, werden Sie
gefragt, ob sie fest oder flexibel sein soll. Hier eine Erklärung, wie
sich "fest" und "flexibel" unterscheiden:

"Feste" Ausfallzeiten starten und stoppen genau zu den Zeiten, die Sie
bei der Planung festgelegt haben. Okay, das war einfach genug...

"Flexible" Ausfallzeiten sind gedacht für Zeiten, wenn Sie wissen, dass
ein Host oder Service für X Minuten (oder Stunden) nicht verfügbar sein
wird, aber Sie nicht genau wissen, wann das sein wird. Wenn Sie flexible
Ausfallzeiten planen, wird Icinga die geplante Ausfallzeit irgendwann
zwischen den Start- und Endzeiten beginnen, die Sie angegeben haben. Die
Ausfallzeit wird solange dauern, wie Sie das bei der Planung angegeben
haben. Dabei wird angenommen, dass der Host oder Service, für den Sie
eine flexible Ausfallzeit geplant haben, ausfällt (oder unerreichbar
wird) oder zwischen der angegebenen Start- und Endezeit in einen
nicht-OK-Zustand wechselt. Die Zeit, zu der der Host oder Service in
einen Problemzustand wechselt, legt die Zeit fest, zu der Icinga
tatsächlich die Ausfallzeit startet. Die Ausfallzeit wird die angegebene
Zeitspanne dauern, auch wenn sich der Host oder Service vor der
definierten Zeit erholt. Das wird aus gutem Grund getan. Wie wir alle
wissen, denken Sie vielleicht, dass Sie ein Problem gelöst haben, aber
müssen den Server doch noch zehnmal neu starten, bevor es wirklich
funktioniert. Geschickt, oder?

### 7.16.4. ausgelöste Ausfallzeiten

Während des Planens von Host- oder Service-Ausfallzeiten haben Sie die
Möglichkeit, sie zu "ausgelösten" Ausfallzeiten (triggered downtime) zu
machen. Was ist eine ausgelöste Ausfallzeit, fragen Sie? Bei ausgelösten
Ausfallzeiten wird der Start der Ausfallzeit durch den Start einer
anderen geplanten Host- oder Service-Ausfallzeit ausgelöst. Dies ist
sehr nützlich, wenn Sie Ausfallzeiten für eine große Zahl von Hosts oder
Services planen und die Startzeit der Auszeit von der Startzeit eines
anderen Ausfallzeiteintrags abhängt. Wenn Sie zum Beispiel eine flexible
Ausfallzeit für einen bestimmten Host planen (weil er zur Wartung
heruntergefahren wird), könnten Sie ausgelöste Ausfallzeiten für alle
"Kinder" des Hosts planen.

### 7.16.5. Wie geplante Ausfallzeiten Benachrichtigungen beeinflussen

Wenn sich ein Host oder Service in einer Phase geplanter Ausfallzeit
befindet, wird Icinga keine normalen Benachrichtigungen für den Host
oder Service versenden. Allerdings wird es eine
"DOWNTIMESTART"-Benachrichtigung für den Host oder Service versenden,
die jeden Admin darüber informiert, dass sie nachfolgend keine
Problemalarme erhalten werden.

Wenn die geplante Ausfallzeit vorbei ist, wird Icinga wieder normale
Benachrichtigungen für den Host oder Service versenden. Eine
"DOWNTIMEEND"-Benachrichtigung wird an die Admins versandt, dass die
geplante Ausfallzeit vorüber ist und dass sie wieder normale Alarme
erhalten werden.

Wenn die geplante Auszeit vorzeitig abgebrochen wird (bevor sie endet),
wird eine "DOWNTIMECANCELLED"-Benachrichtigung an die betroffenen Admins
versandt.

### 7.16.6. Überlappende geplante Ausfallzeiten

Ich mag es, dieses als das "Oh Mist, es funktioniert nicht"-Syndrom zu
bezeichnen. Sie wissen, wovon wir sprechen. Sie fahren einen Server
herunter, um einen "Routine"-Hardware-Upgrade zu machen, nur um später
festzustellen, dass die OS-Treiber nicht funktionieren, das RAID-Array
hochgegangen ist oder Laufwerkskopien fehlgeschlagen und Ihre
Original-Platten jetzt nutzlos sind. Moral der Geschichte ist, dass jede
Routinearbeit an einem Server durchaus drei- oder viermal länger dauern
kann, als Sie ursprünglich geplant haben...

Nehmen wir das folgende Szenario:

1.  Sie planen eine Auszeit für Host A an einem Montag von 19:30 Uhr bis
    21:30 Uhr

2.  Sie fahren den Server am Montag gegen 19:45 Uhr herunter, um einen
    Platten-Upgrade durchzuführen

3.  nachdem Sie eineinhalb Stunden mit SCSI-Fehlern und
    Treiberinkompatibilitäten verschwendet haben, können Sie endlich den
    Server starten

4.  um 21:15 Uhr stellen Sie fest, dass eine Ihrer Partitions nirgends
    auf der Platte zu finden ist

5.  da Sie wissen, dass es eine lange Nacht wird, gehen Sie zurück und
    planen eine zusätzliche Auszeit für Host A von Montag 21:20 Uhr bis
    Dienstagmorgen 1:30 Uhr

Wenn Sie überlappende Ausfallzeiten für einen Host oder Service planen
(in diesem Fall waren die Zeiten von 19:40 Uhr bis 21:30 Uhr und 21:20
bis 1:30 Uhr), wird Icinga warten, bis die letzte Periode geplanter
Ausfallzeiten vorüber ist, bevor Benachrichtigungen zu diesem Host oder
Service versandt werden. In diesem Beispiel werden Benachrichtigungen
für Host A bis Dienstagmorgen 1:30 Uhr unterdrückt.

* * * * *

  -------------------------- -------------------------- -------------------------------------
  [Zurück](perfdata.md)    [Nach oben](ch07.md)      [Weiter](recurring_downtimes.md)
  7.15. Performance-Daten    [Zum Anfang](index.md)    7.17. Wiederkehrende Ausfallzeiten
  -------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
