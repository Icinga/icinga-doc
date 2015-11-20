 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.17. Wiederkehrende Ausfallzeiten
----------------------------------

7.17.1. [Ausfallzeiten
definieren](recurring_downtimes.md#introduction)

7.17.2. [Variable Daten](recurring_downtimes.md#variabledates)

7.17.3. [Lokale Feiertage](recurring_downtimes.md#localholidays)

7.17.4. [Eingaben von
Ausfallzeiten](recurring_downtimes.md#enteringdowntimes)

7.17.5. [Planen von
Ausfallzeiten](recurring_downtimes.md#planningdowntimes)

7.17.6. [Konvertieren von
Ausfallzeitdefinitionen](recurring_downtimes.md#conversion)

7.17.7. [Dateien](recurring_downtimes.md#files)

Viele Leute haben regelmäßige Ausfallzeiten zu verschiedenen Zeiten und
es wäre eine mühselige Arbeit, sie immer wieder manuell einzuplanen.
**Bisher gibt es kein offizielles Format, um solche Planungen zu
definieren. Das bedeutet, dass diese Definitionen in einer eigenen Datei
gespeichert werden müssen, die nicht in die anderen Objektdefinitionen
eingebunden werden darf.** Ein cronjob ruft ein Skript auf, dass diese
Definitionen liest, bereits existierende Ausfallzeiten berücksichtigt
und neue Ausfallzeiten plant, falls notwendig.

### 7.17.1. Ausfallzeiten definieren

Das Skript nutzt ein neues Format für diese Ausfallzeiten, das auf
existierenden Definitionen basiert, die aus der Statusdatei und den
Zeitfenster-Definitionen stammen:

<pre><code>
 define downtime {
}
</code></pre>

Anmerkungen zu den obigen Definitionen:















### 7.17.2. Variable Daten

Die obigen Definitionen funktionieren für die meisten Daten, aber es
gibt einige, die auf dem Osterfest basieren, das jedes Jahr an einem
anderen Tag ist. Wir haben versucht, diesen Engpass zu beseitigen, indem
wir diese Daten berechnen und ihnen Namen geben, die Sie benutzen
können. Die Namen sind unabhängig von Groß- und Kleinschreibung. In
Klammern finden Sie deutsche Bezeichnungen, die Sie ebenfalls benutzen
können:

Variablenname

Offset / Datum

Twelfth\_day (Heilige\_drei\_Koenige)

​6. Januar

Labour\_day (Tag\_der\_Arbeit)

​1. Mai

Carnival\_monday (Rosenmontag)

-48

Mardi\_gras (Faschingsdienstag)

-47

Ash\_wednesday (Aschermittwoch)

-46

Maundy\_thursday (Gruendonnerstag)

-3

Good\_friday (Karfreitag)

-2

Easter\_sunday (Ostersonntag)

0

Easter\_monday (Ostermontag)

1

Ascension\_day (Chr\_Himmelfahrt)

+39

Whit\_sunday (Pfingstsonntag)

+49

Whit\_monday (Pfingstmontag)

+50

Trinity (Trinitatis)

+56

Corpus\_christi (Fronleichnam)

+70

Assumption\_day (Maria\_Himmelfahrt)

​8. August

Penance\_day (Buss\_und\_Bettag)

Mittwoch vor dem 23. Nov.

Christmas\_day (Weihnachtstag\_1)

​25. Dezember

Boxing\_day (Weihnachtstag\_2)

​26. Dezember, 26th

Auf diese Weise können Sie eine Ausfallzeit für Rosenmontag wie folgt
definieren:

<pre><code>
 define downtime {
 }
</code></pre>

### 7.17.3. Lokale Feiertage

Beim Blick auf die Kalender verschiedener Länder gibt es eine Reihe von
Feiertagen, die nur in einem bestimmten Land gelten. Unglücklicherweise
sind einige dieser Daten an einem Wochentag einer Woche in einem Monat.
Sie können diese Daten bereits durch Angaben wie "monday 3 february"
oder "monday -1 may" definieren, aber vielleicht möchten Sie auch hier
Variablennamen benutzen. Durch Definition der Namen und der zugehörigen
Berechnung in einer eigenen Datei können Sie das tun. Als Standard wird
im Verzeichnis `/usr/local/icinga/etc` nach
`holiday.cfg` gesucht. Name und Standort können über die
Option "-l" eingestellt werden.

Wir haben nur drei Daten ausgewählt, um Ihnen die Vorgehensweise zu
zeigen:

<pre><code>
# example of local holiday definitions
# please don't use local characters
# variable names must not contain spaces
#
</code></pre>

Es gibt zwei "Funktionen", mit denen flexible Daten definiert werden
können:






Jetzt können Sie eine Ausfallzeit wie folgt definieren:

<pre><code>
 define downtime {
 }
</code></pre>

Bitte beachten Sie, dass Sie den Standort der Datei über die Option "-l"
angeben müssen.

### 7.17.4. Eingaben von Ausfallzeiten

Bisher gibt es keine Möglichkeit, die Definitionen über den Browser
einzugeben, so dass Sie Ihren bevorzugten Editor benutzen müssen, um die
Ausfallzeiten einzugeben. Sorry.

### 7.17.5. Planen von Ausfallzeiten

Sobald Sie eine Datei angelegt haben, die die Definitionen von
Ausfallzeiten enthält, möchten Sie sicherlich, dass die Ausfallzeiten
automatisch geplant werden. Dies kann über das Perl-Skript
"sched\_down.pl" erfolgen, das über die crontab aufgerufen wird. Das
Skript selbst benötigt das Perl-Modul "Date::Calc".

Der einfachste Weg ist, "/Pfad/zu/sched\_down.pl" aufzurufen. Wenn Sie
die Option "-h" hinzufügen, erhalten Sie einige Informationen:

<pre><code>

Note: Enabled debugging, forecasting, and/or examine will prevent that schedules

Setting environment variables influences the behaviour:
- FAKE_DATE (YYYYMMDD): date deviating from current date
</code></pre>

Alle Parameter sind optional. Um lediglich die Funktion des Skripts zu
prüfen, ist es vielleicht hilfreich, die "examine"-Option gefolgt von
einer Ausfallzeitdefinition zu nutzen:

<pre><code>
 /usr/local/icinga/libexec/sched_down.pl -e "tuesday 20:00-21:00"
</code></pre>

Dies wird eine Zeichenkette zurückliefern, die dem tatsächlichen Befehl
ähnlich ist, falls die Ausfallzeit innerhalb der Planungsperiode ist
(Standard zwei Tage), die über die Option "-m" verändert werden kann. Um
Ausfallzeiten in der Zukunft zu simulieren, kann es hilfreich sein, über
die Umgebungsvariable FAKE\_DATE (z.B. FAKE\_DATE=20130127) ein anderes
Datum zu setzen, bevor Sie das Skript aufrufen. Es kann einfacher sein,
dafür die Option "-t" zu benutzen.

Es gibt zwei Möglichkeiten, das Skript auszuführen:











Solange die Ausfallzeiten nicht sehr kurzfristig geplant werden, sollte
das ausreichen. Das Skript wird lediglich neue Ausfallzeiten planen, so
dass es keine Schwierigkeiten gibt, wenn es öfter aufgerufen wird.

### 7.17.6. Konvertieren von Ausfallzeitdefinitionen

Steve Shipway hat bereits vor längerer Zeit Skripte geschrieben, um
Ausfallzeiten per CGI zu erzeugen und sie für verschiedene
Nagios-Versionen zu planen ([siehe
hier](https://exchange.icinga.org/exchange/downtime_sched%3A+recurring+downtime+scheduler)).

Die kommerzielle Nagios-Version hat ebenfalls wiederkehrende
Ausfallzeiten, aber anstatt alle Skripte von Steve zu nutzen haben sie
entschieden, nur das Planungsskript zu verwenden und ein neues CGI zu
schreiben, das allerdings anscheinend keine flexiblen Ausfallzeiten
unterstützt (zumindest nicht in der 2011 VM).

Das Perl-Skript "sched\_conv.pl" wird Dateien konvertieren, die von
beiden genannten Quellen erzeugt wurden. Sie können auch hier die Option
"-h" benutzen, um ein wenig Hilfe zu erhalten.

### 7.17.7. Dateien

Die Perl-Skripte finden Sie im Ordner `tools/downtimes`.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
