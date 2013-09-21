Wiederkehrende Ausfallzeiten (experimentell / Entwicklung)
==========================================================

Viele Leute haben regelmäßige Ausfallzeiten zu verschiedenen Zeiten und
es wäre eine mühselige Arbeit, sie immer wieder manuell einzuplanen.
**Bisher gibt es kein offizielles Format, um solche Planungen zu
definieren. Das bedeutet, dass diese Definitionen in einer eigenen Datei
gespeichert werden müssen, die nicht in die anderen Objektdefinitionen
eingebunden werden darf.** Ein cronjob ruft ein Skript auf, dass diese
Definitionen liest, bereits existierende Ausfallzeiten berücksichtigt
und neue Ausfallzeiten plant, falls notwendig.

Ausfallzeiten definieren
------------------------

Das Skript nutzt ein neues Format für diese Ausfallzeiten, das auf
existierenden Definitionen basiert, die aus der Statusdatei und den
Zeitfenster-Definitionen stammen:

     define downtime {
        host_name           some host 
        hostgroups          some hostgroup
        servicegroups       some servicegroup
        service_description some service
        author              some author
        comment             some comment
        duration            30
        downtime_period     2011-10-02 - 2011-10-10 10:00-12:00
        fixed               0
        propagate           1
        register            0
    }

Anmerkungen zu den obigen Definitionen:

-   "host\_name", "hostgroups" und "servicegroups" sind zwingend und
    schließen sich gegenseitig aus.

-   "service\_description" ist optional. Wenn nicht definiert, dann wird
    eine Ausfallzeit für eine/n Host / Hostgruppe(n) / Servicegruppe(n)
    geplant. Wenn es definiert wird, dann kann es ein einzelner Service
    oder "all" für alle Services eines einzelnen Hosts oder alle Hosts
    einer Hostgruppe sein.

-   "duration" ist optional, muss aber definiert sein, wenn eine
    flexible Ausfallzeit geplant werden soll.

-   "fixed" ist optional und wird "0" sein, wenn "duration" definiert
    ist und die Differenz von start time-end time davon abweicht.

-   "propagate" ist optional und der Default-Wert ist "0". Wenn gesetzt,
    dann wird die Ausfallzeit auch an abhängige Hosts des angegebenen
    Hosts "propagiert".

-   "register" kann genutzt werden, um diese Definition zu deaktieren.
    Es hat den gleichen Effekt, als würde die Definition nicht
    existieren.

-   "downtime\_period" ist ähnlich zu der Definition, die in [time
    periods](#objectdefinitions-timeperiod) zu finden ist. Das bedeutet,
    dass jede der folgenden Zeilen gültig sein sollte:

           downtime_period     2011-10-01              20:00-02:00
           downtime_period     2011-10-10 - 2011-10-20 10:00-12:00
           downtime_period     day 1 - 3               04:00-12:00
           downtime_period     sunday                  00:00-24:00
           downtime_period     monday - wednesday      20:00-22:00
           downtime_period     monday                  00:00-09:00,17:00-24:00
           downtime_period     1999-01-28              00:00-24:00
           downtime_period     saturday                00:00-24:00
           downtime_period     monday 3                00:00-24:00
           downtime_period     day 2                   00:00-24:00
           downtime_period     february 10             00:00-24:00
           downtime_period     february -1             00:00-24:00
           downtime_period     friday -2               00:00-24:00
           downtime_period     thursday -1 november    00:00-24:00
           downtime_period     2007-01-01 - 2008-02-01 00:00-24:00   (s. Hinweis)
           downtime_period     monday 3 - thursday 4   00:00-24:00
           downtime_period     day 1 - 15              00:00-24:00
           downtime_period     day 20 - -1             00:00-24:00
           downtime_period     july 10 - 15            00:00-24:00
           downtime_period     april 10 - may 15       00:00-24:00
           downtime_period     tuesday 1 april - friday 2 may      00:00-24:00
           downtime_period     2007-01-01 - 2008-02-01 / 3         00:00-24:00
           downtime_period     2008-04-01 / 7                      00:00-24:00
           downtime_period     monday 3 - thursday 4 / 2           00:00-24:00
           downtime_period     day 1 - 15 / 5                      00:00-24:00
           downtime_period     july 10 - 15 / 2                    00:00-24:00
           downtime_period     tuesday 1 april - friday 2 may / 6  00:00-24:00

    Bitte beachten Sie, dass wie auch bei Zeitfenstern mehrere
    "downtime\_period"-Einträge pro Definition möglich sind, um
    verschiedene Zeiten für ein einzelnes Objekt zu planen wie im
    Folgenden:

         define downtime {
            ...
            comment            Backup: incr on wed, full on sat
            downtime_period    wednesday 20:00-21:00
            downtime_period    saturday  20:00-23:30
        }

    Nun, es gibt ein kleines Manko. Auf diese Weise können Sie keine
    flexiblen Ausfallzeiten mit unterschiedlichen Zeiten definieren.

    > **Note**
    >
    > Bitte beachten Sie, dass trotz einer durchgehenden Ausfallzeit vom
    > 01.01.2007 bis zum 01.02.2008 nicht eine einzelne, sondern für
    > jeden Tag eine Ausfallzeit von 00:00 Uhr bis 24:00 Uhr geplant
    > wird.

Variable Daten
--------------

Die obigen Definitionen funktionieren für die meisten Daten, aber es
gibt einige, die auf dem Osterfest basieren, das jedes Jahr an einem
anderen Tag ist. Wir haben versucht, diesen Engpass zu beseitigen, indem
wir diese Daten berechnen und ihnen Namen geben, die Sie benutzen
können. Die Namen sind unabhängig von Groß- und Kleinschreibung. In
Klammern finden Sie deutsche Bezeichnungen, die Sie ebenfalls benutzen
können:

  Variablenname                           Offset / Datum
  --------------------------------------- ---------------------------
  Twelfth\_day (Heilige\_drei\_Koenige)   6. Januar
  Labour\_day (Tag\_der\_Arbeit)          1. Mai
  Carnival\_monday (Rosenmontag)          -48
  Mardi\_gras (Faschingsdienstag)         -47
  Ash\_wednesday (Aschermittwoch)         -46
  Maundy\_thursday (Gruendonnerstag)      -3
  Good\_friday (Karfreitag)               -2
  Easter\_sunday (Ostersonntag)           0
  Easter\_monday (Ostermontag)            1
  Ascension\_day (Chr\_Himmelfahrt)       +39
  Whit\_sunday (Pfingstsonntag)           +49
  Whit\_monday (Pfingstmontag)            +50
  Trinity (Trinitatis)                    +56
  Corpus\_christi (Fronleichnam)          +70
  Assumption\_day (Maria\_Himmelfahrt)    8. August
  Penance\_day (Buss\_und\_Bettag)        Mittwoch vor dem 23. Nov.
  Christmas\_day (Weihnachtstag\_1)       25. Dezember
  Boxing\_day (Weihnachtstag\_2)          26. Dezember, 26th

Auf diese Weise können Sie eine Ausfallzeit für Rosenmontag wie folgt
definieren:

     define downtime {
        ...
        comment            Cheer up, lads
        downtime_period    Rosenmontag 09:00-17:00
     }

Lokale Feiertage
----------------

Beim Blick auf die Kalender verschiedener Länder gibt es eine Reihe von
Feiertagen, die nur in einem bestimmten Land gelten. Unglücklicherweise
sind einige dieser Daten an einem Wochentag einer Woche in einem Monat.
Sie können diese Daten bereits durch Angaben wie "monday 3 february"
oder "monday -1 may" definieren, aber vielleicht möchten Sie auch hier
Variablennamen benutzen. Durch Definition der Namen und der zugehörigen
Berechnung in einer eigenen Datei können Sie das tun. Als Standard wird
im Verzeichnis `/usr/local/icinga/etc` nach `holiday.cfg` gesucht. Name
und Standort können über die Option "-l" eingestellt werden.

Wir haben nur drei Daten ausgewählt, um Ihnen die Vorgehensweise zu
zeigen:

    # example of local holiday definitions
    # please don't use local characters
    # variable names must not contain spaces
    #
    Presidents_day        day_in_week_of_month(2,1,3)
    Spring_Bank_Holiday   day_in_week_of_month(5,1,-1)
    Pentecote             date_easter(49)

Es gibt zwei "Funktionen", mit denen flexible Daten definiert werden
können:

-   "day\_in\_week\_of\_month": Sie müssen drei Parameter angeben

    -   Monat: 1 = Januar ... 12 = Dezember

    -   Tag: 1 = Montag ... 7 = Sonntag

    -   Woche: 1 .. 5 für die Woche im Monat oder -1 für die letzte
        Woche des Monats

-   "date\_easter": Die Zahl gibt den Abstand zum Ostersonntag an

Jetzt können Sie eine Ausfallzeit wie folgt definieren:

     define downtime {
        ...
        comment            Das Weibsvolk ist unterwegs
        downtime_period    Weiberfastnacht  09:00-17:00
     }

Bitte beachten Sie, dass Sie den Standort der Datei über die Option "-l"
angeben müssen.

Eingaben von Ausfallzeiten
--------------------------

Bisher gibt es keine Möglichkeit, die Definitionen über den Browser
einzugeben, so dass Sie Ihren bevorzugten Editor benutzen müssen, um die
Ausfallzeiten einzugeben. Sorry.

Planen von Ausfallzeiten
------------------------

Sobald Sie eine Datei angelegt haben, die die Definitionen von
Ausfallzeiten enthält, möchten Sie sicherlich, dass die Ausfallzeiten
automatisch geplant werden. Dies kann über das Perl-Skript
"sched\_down.pl" erfolgen, das über die crontab aufgerufen wird. Das
Skript selbst benötigt das Perl-Modul "Date::Calc".

Der einfachste Weg ist, "/Pfad/zu/sched\_down.pl" aufzurufen. Wenn Sie
die Option "-h" hinzufügen, erhalten Sie einige Informationen:

       -c | --config=s     Icinga main config
                           default: /usr/local/icinga/etc/icinga.cfg
       -s | --schedule=s   schedule definitions
                           default: /usr/local/icinga/etc/downtime.cfg
       -l | --local=s      local holiday definitions
                           default: /usr/local/icinga/etc/holiday.cfg
       -m | --max_ahead=s  plan max. days ahead (default = 2)
       -f | --forecast=s   forecast next schedules
       -e | --examine=s    examine period and show next schedule
                           specify date and time instead like in downtime_period
       -t | --timestamp=s  specify deviating date/time
                           YYYYMMDDhhmi, YYYYMMDD, or hhmi
       -d | --debug=s      0|1|2|3 (default = 1)
       -h | --help         display this help

    Note: Enabled debugging, forecasting, and/or examine will prevent that schedules
          are sent to the command pipe (downtimes are only calculated)!

    Setting environment variables influences the behaviour:
    - FAKE_DATE (YYYYMMDD): date deviating from current date
    - FAKE_TIME (HHMM)    : time deviating from current time
    - DEBUG (0|1|2|3)     : disables/enables debugging information
      0 = no debugging / cmds are sent to external command pipe!
      Note: command line options take precedence over environment variables 

Alle Parameter sind optional. Um lediglich die Funktion des Skripts zu
prüfen, ist es vielleicht hilfreich, die "examine"-Option gefolgt von
einer Ausfallzeitdefinition zu nutzen:

     /usr/local/icinga/libexec/sched_down.pl -e "tuesday 20:00-21:00"

Dies wird eine Zeichenkette zurückliefern, die dem tatsächlichen Befehl
ähnlich ist, falls die Ausfallzeit innerhalb der Planungsperiode ist
(Standard zwei Tage), die über die Option "-m" verändert werden kann. Um
Ausfallzeiten in der Zukunft zu simulieren, kann es hilfreich sein, über
die Umgebungsvariable FAKE\_DATE (z.B. FAKE\_DATE=20130127) ein anderes
Datum zu setzen, bevor Sie das Skript aufrufen. Es kann einfacher sein,
dafür die Option "-t" zu benutzen.

Es gibt zwei Möglichkeiten, das Skript auszuführen:

-   Als eine aktive Prüfung

    Sie können das Skript mit einem passenden Prüfintervall wie eine
    normale aktive Prüfung aufrufen

         define service {
            host_name             icinga-server
            service_description   schedule_downtimes
            check_command         schedule_script!-d0
            check_interval        60
            retry_interval        60
            check_period          24x7
            ...
         }

         define command {
            command_name          schedule_script
            command_line          $USER1$/sched_down.pl $ARG1$
         }

    > **Caution**
    >
    > Bitte beachten Sie, dass diese Prüfung nur auf dem (zentralen)
    > NAME-ICINGA-Server ausgeführt werden darf, nicht auf irgendeinem
    > anderen in einer verteilten Umgebung.

-   Über die crontab

    Eine Zeile in der crontab des NAME-ICINGA-Benutzers, das das Skript
    jede volle Stunde aufruft, könnte wie folgt aussehen

         0 * * * * /usr/local/icinga/bin/sched_down.pl -d0

Solange die Ausfallzeiten nicht sehr kurzfristig geplant werden, sollte
das ausreichen. Das Skript wird lediglich neue Ausfallzeiten planen, so
dass es keine Schwierigkeiten gibt, wenn es öfter aufgerufen wird.

Konvertieren von Ausfallzeitdefinitionen
----------------------------------------

Steve Shipway hat bereits vor längerer Zeit Skripte geschrieben, um
Ausfallzeiten per CGI zu erzeugen und sie für verschiedene
Nagios-Versionen zu planen ([siehe
hier](https://www.monitoringexchange.org/inventory/Utilities/AddOn-Projects/Downtimes/downtime_sched%253A-recurring-downtime-scheduler)).

Die kommerzielle Nagios-Version hat ebenfalls wiederkehrende
Ausfallzeiten, aber anstatt alle Skripte von Steve zu nutzen haben sie
entschieden, nur das Planungsskript zu verwenden und ein neues CGI zu
schreiben, das allerdings anscheinend keine flexiblen Ausfallzeiten
unterstützt (zumindest nicht in der 2011 VM).

Das Perl-Skript "sched\_conv.pl" wird Dateien konvertieren, die von
beiden genannten Quellen erzeugt wurden. Sie können auch hier die Option
"-h" benutzen, um ein wenig Hilfe zu erhalten.

Dateien
-------

Die Perl-Skripte finden Sie im Ordner `contrib/downtimes`.

Ausfallzeit
wiederkehrende
Downtime
wiederkehrende
