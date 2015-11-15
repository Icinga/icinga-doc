![Icinga](../images/logofullsize.png "Icinga")

6.3. Informationen zu den Classic UI-Modul-Parametern

[Zurück](cgiauth.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](cgicmd.md)

* * * * *

6.3. Informationen zu den Classic UI-Modul-Parametern
-----------------------------------------------------

6.3.1. [Einführung](cgiparams.md#introduction)

6.3.2. [Ausführen der Classic UI-Modules auf der
Kommandozeile](cgiparams.md#executecmdline)

6.3.3. [Properties / Statustypes](cgiparams.md#propsstatustypes)

6.3.4. [Matrix Parameter / Module](cgiparams.md#matrixparamscgis)

6.3.5. [Einzelheiten zu den Parametern](cgiparams.md#cgiparams_expl)

6.3.6. [Abkürzungen, Classic UI-Module (CGIs),
Verweise](cgiparams.md#cgiparams_abbrev)

6.3.7. [Host- und
Service-Filter-Eigenschaften](cgiparams.md#cgiparams-filter)

6.3.8. [Host- und
Service-Statustypen](cgiparams.md#cgiparams-statustypes)

6.3.9. [Commands](cgiparams.md#idp11982752)

### 6.3.1. Einführung

Das Menü auf der linken Seite des klassischen Web-Interface enthält
Eintrage, die einen schnellen Zugriff auf die Informationen bieten, die
die meisten Leute benötigen. Sie können diese Parameter ändern oder auch
andere Optionen wählen. Einige Module benötigen einen Objekttyp ("host",
"hostgroup", "service" oder "servicegroup"), oftmals gefolgt von einer
oder mehreren Optionen. Der beste Weg ist es, einen Blick auf die
existierenden URLs zu werden und sie Ihren Bedürfnissen anzupassen.

Nachfolgend finden Sie eine Tabelle mit den Parametern und den Modulen,
die sie anbieten. Die Namen der Module sind abgekürzt (damit die Tabelle
nicht so breit wird). Eine Erklärung der Abkürzungen zusammen mit einem
Hinweis auf den Source-Code finden Sie
[hier](cgiparams.md#cgiparams_abbrev "6.3.6. Abkürzungen, Classic UI-Module (CGIs), Verweise").

Nach dieser Tabelle folgt eine Erklärung der Parameter (in Bearbeitung).

### 6.3.2. Ausführen der Classic UI-Modules auf der Kommandozeile

Anstelle über Ihren Browsers können Sie die Module auch auf der
Kommandozeile ausführen und deren Ergebnisse mit anderen Tools
verarbeiten. Um einen ersten Eindruck zu erhalten, wechseln Sie in den
Ordner mit den \*.cgi Dateien (z.B.
`/usr/local/icinga/sbin`{.filename}), setzen Sie einige
Umgebungsvariablen und führen Sie eines der Module aus.

~~~~ {.screen}
 $> export REMOTE_USER=icingaadmin   # or choose the appropriate user
 $> export REQUEST_METHOD='GET'      # if you enter queries
 $> export QUERY_STRING='host=all'   # see the tables below

 $> ./status.cgi
~~~~

Abhängig von der Anzahl von Hosts wird diese viele HTML-Zeilen liefern.
Für die meisten Leute ist es schwierig, dazwischen die Informationen
herauszulesen, also sollten Sie"&csvoutput" oder "&jsonoutput" zum
QUERY\_STRING mit anderen Argumenten hinzufügen.

Setzen Sie QUERY\_STRING wie erforderlich und führen Sie das Modul aus.

Falls Sie eine Umgebungsvariable vergessen haben, werden Sie folgende
Zeilen sehen:

~~~~ {.screen}
 $> ./status.cgi
 getcgivars(): Unsupported REQUEST_METHOD -> ''

 I'm guessing you're trying to execute the CGI from a command line.
 In order to do that, you need to set the REQUEST_METHOD environment
 variable to either "GET", "HEAD", or "POST". When using the
 GET and HEAD methods, arguments can be passed to the CGI
 by setting the "QUERY_STRING" environment variable. If you're
 using the POST method, data is read from standard input. Also of
 note: if you've enabled authentication in the CGIs, you must set the
 "REMOTE_USER" environment variable to be the name of the user you're
 "authenticated" as.
~~~~

Mehr Beispiele finden Sie
[hier](cgicmd.md "6.4. Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile").

### 6.3.3. Properties / Statustypes

Sie können `status.cgi`{.filename} benutzen, um Objekte mit einem oder
mehreren "Statustypen" (hoststatustype / servicestatustype) und mit
bestimmten Eigenschaften (hostprops / serviceprops) anzuzeigen. Jeder
Statustyp / jede Eigenschaft wird durch eine Zahl identifiziert (die
[hier](cgiparams.md#cgiparams-filter "6.3.7. Host- und Service-Filter-Eigenschaften")
und
[hier](cgiparams.md#cgiparams-statustypes "6.3.8. Host- und Service-Statustypen")
am Ende des Abschnitts zu finden sind). Bitte addieren Sie die
entsprechenden Zahlen und setzen die resultierende Summe jeweils bei der
Option ein.

Das Beispiel zeigt alle Services im nicht-OK-Zustand, die weder in einer
Ausfallzeit (downtime) sind noch bestätigt (acknowledged) wurden:

~~~~ {.screen}
 http://localhost/icinga/cgi-bin/status.cgi?host=all&servicestatustypes=29&serviceprops=10
~~~~

"29" enthält auch "PENDING" Services (die seit dem Start noch nicht
geprüft wurden).

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte beachten Sie, dass "properties" nur die Objekte anzeigt, die ALLE
Bedingungen gleichzeitig erfüllen, während bei "statustypes" nur EINE
Bedingung erfüllt sein muss (kann).

### 6.3.4. Matrix Parameter / Module

Parameter

avail

cmd

config

ext

hgram

hist

notif

out

log

status

map

sum

tac

trends

ahas

 

X

 

 

 

 

 

 

 

 

 

 

 

 

alerttypes

 

 

 

 

 

 

 

 

 

 

 

X

 

 

assumeinitialstates

X

 

 

 

 

 

 

 

 

 

 

 

 

X

assumestateretention

X

 

 

 

X

 

 

 

 

 

 

 

 

X

assumestatesduringnotrunning

X

 

 

 

 

 

 

 

 

 

 

 

 

X

attr

 

X

 

 

 

 

 

 

 

 

 

 

 

 

backtrack

X

 

 

 

X

 

 

 

 

 

 

 

 

X

breakdown

 

 

 

 

X

 

 

 

 

 

 

 

 

 

broadcast\_notification

 

X

 

 

 

 

 

 

 

 

 

 

 

 

childoptions

 

X

 

 

 

 

 

 

 

 

 

 

 

 

cmd\_mod

 

X

 

 

 

 

 

 

 

 

 

 

 

 

cmd\_typ

 

X

 

 

 

 

 

 

 

 

 

 

 

 

columns

 

 

 

 

 

 

 

 

 

X

 

 

 

 

com\_author

 

X

 

 

 

 

 

 

 

 

 

 

 

 

com\_data

 

X

 

 

 

 

 

 

 

 

 

 

 

 

com\_id

 

X

 

 

 

 

 

 

 

 

 

 

 

 

contact

 

 

 

 

 

 

X

 

 

 

 

 

 

 

createimage

 

 

 

 

X

 

 

 

 

 

 

 

 

 

csvoutput

X

 

 

 

 

 

 

 

 

 

 

 

 

 

displaytype

 

 

 

 

 

 

 

 

 

 

 

X

 

 

down\_id

 

X

 

 

 

 

 

 

 

 

 

 

 

 

eday

X

 

 

 

X

 

 

 

 

 

 

X

 

X

ehour

X

 

 

 

X

 

 

 

 

 

 

X

 

X

embedded

X

 

 

X

X

X

X

X

X

X

X

X

X

 

emin

X

 

 

 

X

 

 

 

 

 

 

X

 

X

emon

X

 

 

 

X

 

 

 

 

 

 

X

 

X

end\_time

 

X

 

 

 

 

X[3]

 

 

 

 

 

 

 

esec

X

 

 

 

X

 

 

 

 

 

 

X

 

X

eyear

X

 

 

 

X

 

 

 

 

 

 

X

 

X

fixed

 

X

 

 

 

 

 

 

 

 

 

 

 

 

force\_check

 

X

 

 

 

 

 

 

 

 

 

 

 

 

force\_notification

 

X

 

 

 

 

 

 

 

 

 

 

 

 

full\_log\_entries

X

 

 

 

 

 

 

 

 

 

 

 

 

 

get\_date\_parts

X

 

 

 

 

 

 

 

 

 

 

 

 

 

graphevents

 

 

 

 

X

 

 

 

 

 

 

 

 

 

graphstatetypes

 

 

 

 

X

 

 

 

 

 

 

 

 

 

host

X

X

 

X

X

X

X

 

 

X

 

X

 

X

hostgroup

X

X

 

X

 

X[3]

X[3]

 

 

X

 

X

 

 

hostprops

 

 

 

 

 

 

 

 

 

X

 

 

 

 

hoststates

 

 

 

 

 

 

 

 

 

 

 

X

 

 

hoststatustypes

 

 

 

 

 

 

 

 

 

X

 

 

 

 

hours

 

X

 

 

 

 

 

 

 

 

 

 

 

 

includesoftstates

X

 

 

 

 

 

 

 

 

 

 

 

 

 

initialassumedhoststate

X

 

 

 

 

 

 

 

 

 

 

 

 

X

initialassumedservicestate

X

 

 

 

 

 

 

 

 

 

 

 

 

X

initialstateslogged

 

 

 

 

X

 

 

 

 

 

 

 

 

 

input

 

 

 

 

X

 

 

 

 

 

 

 

 

X

item\_name [3]

 

 

X

 

 

 

 

 

 

 

 

 

 

X

jsonoutput [2]

X

 

X

X

 

 

X

X

X

X

 

X

X

 

limit [3]

 

 

X

X

 

X

X

 

X

X

 

X

 

 

minutes

 

X

 

 

 

 

 

 

 

 

 

 

 

 

navbarsearch

 

 

 

 

 

 

 

 

 

X

 

 

 

 

newstatesonly

 

 

 

 

X

 

 

 

 

 

 

 

 

 

nodowntime

 

 

 

 

 

X

 

 

 

 

 

 

 

 

noflapping

 

 

 

 

 

X

 

 

 

 

 

 

 

 

nofrills

 

 

 

 

 

X

 

 

X

 

 

 

 

 

noheader

X

 

 

X

X

X

X

X

X

X

X

X

X

X

not\_dly

 

X

 

 

 

 

 

 

 

 

 

 

 

 

notimebreaks

 

 

 

 

 

X

 

 

X

 

 

 

 

 

nosystem

 

 

 

 

 

X

 

 

 

 

 

 

 

 

oldestfirst [4]

 

 

 

 

 

 

 

 

X

 

 

 

 

 

order [3]

 

 

 

 

 

X

X

 

 

 

 

 

 

 

paused

 

 

 

X

 

 

 

X

 

X

X

 

X

 

performance\_data

 

X

 

 

 

 

 

 

 

 

 

 

 

 

persistent

 

X

 

 

 

 

 

 

 

 

 

 

 

 

plugin\_output

 

X

 

 

 

 

 

 

 

 

 

 

 

 

plugin\_state

 

X

 

 

 

 

 

 

 

 

 

 

 

 

ptc

 

X

 

 

 

 

 

 

 

 

 

 

 

 

report

 

 

 

 

 

 

 

 

 

 

 

X

 

 

report\_type

X

 

 

 

 

 

 

 

 

 

 

 

 

 

rpttimeperiod

X

 

 

 

 

 

 

 

 

 

 

 

 

 

sched\_dly

 

X

 

 

 

 

 

 

 

 

 

 

 

 

sday

X

 

 

 

X

 

 

 

 

 

 

X

 

 

search\_string [3]

 

 

X

 

 

 

 

 

 

X

 

 

 

 

send\_notification

 

X

 

 

 

 

 

 

 

 

 

 

 

 

service

X

X

 

X

X

X

X

 

 

 

 

 

 

X

servicefilter

 

 

 

 

 

 

 

 

 

X

 

 

 

 

servicegroup

X

X

 

X

 

X[3]

X[3]

 

 

X

 

X

 

 

serviceprops

 

 

 

 

 

 

 

 

 

X

 

 

 

 

servicestates

 

 

 

 

 

 

 

 

 

 

 

X

 

 

servicestatustypes

 

 

 

 

 

 

 

 

 

X

 

 

 

 

service\_divisor

 

 

 

 

 

 

 

X

 

 

 

 

 

 

shour

X

 

 

 

X

 

 

 

 

 

 

X

 

 

showscheduleddowntime

X

 

 

 

 

 

 

 

 

 

 

 

 

 

show\_log\_entries

X

 

 

 

 

 

 

 

 

 

 

 

 

 

smin

X

 

 

 

X

 

 

 

 

 

 

X

 

 

smon

X

 

 

 

X

 

 

 

 

 

 

X

 

 

sortoption

 

 

 

X

 

 

 

 

 

X

 

 

 

 

sorttype

 

 

 

X

 

 

 

 

 

X

 

 

 

 

ssec

X

 

 

 

X

 

 

 

 

 

 

X

 

 

standardreport

 

 

 

 

 

 

 

 

 

 

 

X

 

 

start [3]

 

 

X

X

 

X

X

 

X

X

 

 

 

 

start\_time

 

X

 

 

 

 

X[3]

 

 

 

 

 

 

 

statetype

 

 

 

 

 

X

 

 

 

 

 

 

 

 

statetypes

 

 

 

 

 

 

 

 

 

 

 

X

 

 

sticky\_ack

 

X

 

 

 

 

 

 

 

 

 

 

 

 

style

 

 

 

 

 

 

 

 

 

X

 

 

 

 

syear

X

 

 

 

X

 

 

 

 

 

 

X

 

X

t1

X

 

 

 

X

 

 

 

 

 

 

X

 

X

t2

X

 

 

 

X

 

 

 

 

 

 

X

 

X

timeperiod

X

 

 

 

X

 

X[3]

 

 

 

 

X

 

X

trigger

 

X

 

 

 

 

 

 

 

 

 

 

 

 

ts\_end [3]

 

 

 

 

 

X

X

 

 

 

 

 

 

 

ts\_start [3]

 

 

 

 

 

X

X

 

 

 

 

 

 

 

type

 

 

X

X

 

X

X

 

 

 

 

 

 

 

### 6.3.5. Einzelheiten zu den Parametern

Mehr Informationen zu den einzelnen Parametern finden Sie nachfolgend.
Für ein tiefergehendes Verständnis sollten Sie einen Blick auf den
Source-Code werfen.

Parameter

Beschreibung

Mögl. Werte

Beispiel

Anmerkungen

[ahas](cgiparams.md#cgiparams-ahas)

Der Befehl beeinflusst den Host und seine Services

 

ahas

 

[alerttypes](cgiparams.md#cgiparams-alerttypes)

Host- und/oder Service-Alarme anzeigen

1=Host-Alarme; 2=Service-Alarme; 3=Host- und Service-Alarme

alerttypes=3

 

[assumeinitialstates](cgiparams.md#cgiparams-assumeinitialstates)

 

yes; no

 

 

[assumestatesduringnotrunning](cgiparams.md#cgiparams-assumestatesduringnotrunning)

 

yes; no

 

 

[assumestateretention](cgiparams.md#cgiparams-assumestateretention)

 

yes; no

 

 

[attr](cgiparams.md#cgiparams-attr)

Zurücksetzen der modifizierten Attribute und keine Veränderungen mehr
zulassen

0

attr=0

siehe

[backtrack](cgiparams.md#cgiparams-backtrack)

Wieviele Archiv-Log-Dateien sollen durchsucht werden, um den initialen
Zustand zu ermitteln

0-n

backtrack=1

Bitte beachten Sie, dass die Verarbeitung der Archivdateien eine Weile
dauern kann

[breakdown](cgiparams.md#cgiparams-breakdown)

Aufteilen der Daten nach Zeitbereich

0=monatlich; 1=Tag des Monats; 2=Tag der Woche; 3=stündlich

breakdown=2

 

[broadcast\_notification](cgiparams.md#cgiparams-broadcast_notification)

Benachrichtigung an alle Kontakte versenden ("non-escalated" und
"escalated")

 

broadcast\_notification

 

[childoptions](cgiparams.md#cgiparams-childoptions)

Ausfallzeitbehandlung für abhängige Hosts

0=ohne Berücksichtigung von abh. Hosts; 1="triggered downtime" für abh.
Hosts planen; 2="non-triggered downtime" für abh. Hosts planen

childoptions=1

 

[cmd\_mod](cgiparams.md#cgiparams-cmd_mod)

Command mode

1, 2

cmd\_mod=2

1 zeigt das Bestaetigungsformular; 2 schickt direkt ab

[cmd\_typ](cgiparams.md#cgiparams-cmd_typ)

Command type

0 - 169, 999

cmd\_typ=160

Einzelheiten siehe [hier](cgiparams.md#cgiparams-commands)

[columns](cgiparams.md#cgiparams-columns)

Anzahl von Übersichtsspalten

\>= 1

 

Default ist 3

[com\_author](cgiparams.md#cgiparams-com_author)

Autor des Kommentars

ein gültiger Benutzer

com\_author=icingaadmin

Kann ggf. von der Einstellung von "lock\_author\_names" in cgi.cfg
abhängen

[com\_data](cgiparams.md#cgiparams-com_data)

Inhalt des Kommentars

eine Zeichenkette (urlencoded)

 

 

[com\_id](cgiparams.md#cgiparams-com_id)

Id des Kommentars

 

 

 

[contact](cgiparams.md#cgiparams-contact)

Ein gültiger Kontakt als Mail-Empfänger

 

 

 

[createimage](cgiparams.md#cgiparams-createimage)

 

 

createimage

 

[csvoutput](cgiparams.md#cgiparams-csvoutput)

Ob die Ausgabe im CSV-Format sein soll

yes;no

 

Diese Option setzt automatisch "noheader". In fast allen CGIs verfügbar
(siehe )

[displaytype](cgiparams.md#cgiparams-displaytype)

Typ der Alarmauswertung

1=recent alerts; 2=alert totals; 3=top alerts; 4=hostgroup alert totals;
5=host alert totals; 6=service alert totals; 7=servicegroup alert totals

 

 

[down\_id](cgiparams.md#cgiparams-down_id)

ID der Ausfallzeit

 

 

 

[eday](cgiparams.md#cgiparams-eday)

Ende des maßgeschneiderten Zeitfensters (Tag)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[ehour](cgiparams.md#cgiparams-ehour)

Ende des maßgeschneiderten Zeitfensters (Stunde)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[embedded](cgiparams.md#cgiparams-embedded)

verschiedenen HTML-Code und SSI-header/footer weglassen

 

embedded

 

[emin](cgiparams.md#cgiparams-emin)

Ende des maßgeschneiderten Zeitfensters (Minute)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[emon](cgiparams.md#cgiparams-emon)

Ende des maßgeschneiderten Zeitfensters (Monat)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[end\_time](cgiparams.md#cgiparams-end_time)

Endzeit der festen Ausfallzeit

 

 

Format "MM-DD-YYYY HH:MI"

[esec](cgiparams.md#cgiparams-esec)

Ende des maßgeschneiderten Zeitfensters (Sekunde)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[eyear](cgiparams.md#cgiparams-eyear)

Ende des maßgeschneiderten Zeitfensters (Jahr)

 

 

Nur gültig bei "maßgeschneiderten" Zeitfenstern

[fixed](cgiparams.md#cgiparams-fixed)

Feste oder flexible Ausfallzeit

0=flexible, \>0=fixed

 

 

[force\_check](cgiparams.md#cgiparams-force_check)

Die Service-Prüfung wird erzwungen

 

forcecheck

 

[force\_notification](cgiparams.md#cgiparams-force_notification)

Benachrichtigung ungeachtet von Restriktionen versenden (Zeitfenster
oder andere)

 

force\_notification

 

[full\_log\_entries](cgiparams.md#cgiparams-full_log_entries)

Vollständige oder gekürzte Log-Eintrage anzeigen

 

full\_log\_entries

Default ist gekürzte Ansicht

[get\_date\_parts](cgiparams.md#cgiparams-get_date_parts)

maßgeschneiderte Zeitbereiche ermitteln

 

get\_date\_parts

 

[graphevents](cgiparams.md#cgiparams-graphevents)

Welche Objekte in welchem Zustand dargestellt werden sollen

 

graphevents=112 (alle Service-Probleme)

Ein logisches ODER von: 1=Host up; 2=Host down; 4=Host unreachable;
8=Service OK; 16=Service Warning; 32=Service Unknown; 64=Service
Critical

[graphstatetypes](cgiparams.md#cgiparams-graphstatetypes)

Hard- und/oder Soft-Zustande darstellen

1=Soft-states; 2=Hard states; 3=Hard- und Soft-states

graphstatetypes=3

 

[host](cgiparams.md#cgiparams-host)

Alle Hosts oder einen bestimmten Host auswählen, dessen Service
angezeigt werden sollen

all; \<host name\>

host=monitor

Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B.
"%20" statt eines Leerzeichens)

[hostgroup](cgiparams.md#cgiparams-hostgroup)

Alle Hostgruppen oder eine bestimmte Hostgruppe auswählen, deren Hosts
und Services angezeigt werden sollen

all; \<hostgroup name\>

hostgroup=linux-boxes

Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B.
"%20" statt eines Leerzeichens)

[hostprops](cgiparams.md#cgiparams-hostprops)

Alle Hosts auswählen, die dem angegebenen Bitmuster entsprechen. Bitte
beachten Sie, dass die Hosts ALLE angegebenen Bedingungen entsprechen
müssen

 

hostprops=131088 (aktive Prüfungen, die deaktiviert sind)

Ein logisches ODER der Bedingungen, die in include/cgiutils.c angegeben
sind
[[1]](cgiparams.md#cgiparams-filter "6.3.7. Host- und Service-Filter-Eigenschaften")
(HOST AND SERVICE FILTER PROPERTIES)

[hoststates](cgiparams.md#cgiparams-hoststates)

Der Zustand, in dem der Host sein sollte

1 - 7

hoststates=3 (Hosts in einem Problemzustand)

Ein logisches ODER der Zustände: 1=DOWN; 2=UNREACHABLE; 4=UP

[hoststatustypes](cgiparams.md#cgiparams-hoststatustypes)

Der Zustand, in dem der Host sein sollte

1 - 15

hoststatustypes=12 (Hosts in einem Problemzustand)

Ein logisches ODER der Zustände: 1=Pending; 2=Up; 4=Down; 8=Unreachable

[hours](cgiparams.md#cgiparams-hours)

Dauer der flexiblen Ausfallzeit in Stunden (siehe "minutes")

\>= 0

 

Nur gültig für flexible Ausfallzeiten

[includesoftstates](cgiparams.md#cgiparams-includesoftstates)

"soft"-Zustände einschließen

yes; no

includesoftstate=yes

Default: "soft"-Zustände nicht berücksichtigen

[initialassumedhoststate](cgiparams.md#cgiparams-initialassumedhoststate)

 

 

 

 

[initialassumedservicestate](cgiparams.md#cgiparams-initialassumedservicestate)

 

 

 

 

[initialstateslogged](cgiparams.md#cgiparams-initialstateslogged)

 

 

 

 

[input](cgiparams.md#cgiparams-input)

 

 

 

 

[item\_name](cgiparams.md#cgiparams-item_name)

Suche nach exakter Übereinstimmung der angegebenen Zeichenkette (für
regex-Suche siehe
[search\_string](cgiparams.md#cgiparams-search_string))

 

item\_name=localhost

[3]

[jsonoutput](cgiparams.md#cgiparams-jsonoutput)

Ob die Ausgabe im json-Format sein soll

yes;no

 

Diese Option setzt automatisch "noheader". In fast allen CGIs verfügbar
(siehe )

[limit](cgiparams.md#cgiparams-limit)

max. Anzahl von anzuzeigenden Einträgen pro Seite

1-n

limit=10

Nutzbar für Paging-Fähigkeit [3], ausgenommen summary.cgi, default=25.

[minutes](cgiparams.md#cgiparams-minutes)

Dauer der flexiblen Ausfallzeit (siehe "hours")

\>= 0

 

 

[navbarsearch](cgiparams.md#cgiparams-navbarsearch)

 

 

 

 

[newstatesonly](cgiparams.md#cgiparams-newstatesonly)

Nur "neue" Zustände anzeigen

yes; no

newstatesonly=yes

Default: alle Zustände anzeigen

[nodowntime](cgiparams.md#cgiparams-nodowntime)

Ausfallzeiten nicht anzeigen

 

nodowntime

 

[noflapping](cgiparams.md#cgiparams-noflapping)

"Flatter"-Alarme nicht anzeigen

 

noflapping

 

[nofrills](cgiparams.md#cgiparams-nofrills)

Don't display frills (?)

 

nofrills

 

[noheader](cgiparams.md#cgiparams-noheader)

Globale Statusinformationen weglassen und nur Status-Details anzeigen

 

noheader

 

[not\_dly](cgiparams.md#cgiparams-not_dly)

Benachrichtigung um n Minuten verzögern

\>= 0

 

 

[notimebreaks](cgiparams.md#cgiparams-notimebreaks)

Don't display timebreaks (?)

 

 

 

[nosystem](cgiparams.md#cgiparams-nosystem)

Keine Systemmeldungen anzeigen

 

nosystem

Default: Systemmeldungen (des Icinga-Prozesses) anzeigen

[oldestfirst](cgiparams.md#cgiparams-oldestfirst)

Sortierreihenfolge umdrehen

 

oldestfirst

Default: aktuelle Einträge zuerst anzeigen; siehe [4]

[order](cgiparams.md#cgiparams-order)

Sortierreihenfolge festlegen

old2new / new2old

order=old2new

Default: aktuelle Einträge zuerst anzeigen; siehe [3]

[paused](cgiparams.md#cgiparams-paused)

Stoppt den automatischen Update

 

paused

 

[performance\_data](cgiparams.md#cgiparams-performance_data)

Die als Performance-Daten zu sendende Zeichenkette

 

 

 

[persistent](cgiparams.md#cgiparams-persistent)

Der Kommentar ist persistent, wenn diese Option gesetzt ist

 

persistent

 

[plugin\_output](cgiparams.md#cgiparams-plugin_output)

Die als Plugin-Output zu sendende Zeichenkette

 

 

Die Länge ist begrenzt durch den Wert von MAX\_INPUT\_LENGTH (festgelegt
während des Compile-Vorgangs)

[plugin\_state](cgiparams.md#cgiparams-plugin_state)

Zustand des Plugins festlegen

0=OK; 1=Warning; 2=Critical; 3=Unknown

plugin\_state=2

 

[ptc](cgiparams.md#cgiparams-ptc)

Der Befehl wird an abhängige Hosts propagiert

 

ptc

 

[report](cgiparams.md#cgiparams-report)

Report erzeugen

 

report

 

[report\_type](cgiparams.md#cgiparams-report_type)

Reporttyp auswählen

hostgroups; servicegroups; hosts; services

report\_type=hostgroups

 

[rpttimeperiod](cgiparams.md#cgiparams-rpttimeperiod)

Angeben eines Zeitfensters, die für den Availability-Bericht benutzt
wird

Eins der definierten Zeitfenster

 

Benutzen Sie den Kurznamen der Zeitfenster-Definition

[sched\_dly](cgiparams.md#cgiparams-sched_dly)

Befehlsausführung um n Minuten verzögern

\>= 0

 

 

[sday](cgiparams.md#cgiparams-sday)

Start des maßgeschneiderten Zeitfensters (Tag)

 

 

 

[search\_string](cgiparams.md#cgiparams-search_string)

Suche nach der angegebenen Zeichenkette (Hosts, Services, etc) mit Hilfe
von regulären Ausdrücken

 

 

[3]

[send\_notification](cgiparams.md#cgiparams-send_notification)

Eine Benachrichtigung für die Bestätigung senden

0=disabled, 1=enabled (default)

send\_notification

[3] cmd.cgi erfordert 0|1 Werte, wenn nicht gesetzt, wird 1 als Standard
verwendet. Siehe auch [Bug \#2926](https://dev.icinga.org/issues/2926)
für weitere Informationen.

[service](cgiparams.md#cgiparams-service)

Alle oder einen bestimmten Service auswählen, der angezeigt werden soll

all; \<service description\>

service=PING

Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B.
"%20" statt einen Leerzeichens)

[servicefilter](cgiparams.md#cgiparams-servicefilter)

Nur Service selektieren, deren Beschreibung auf das angegebene Muster
passt

 

servicefilter=Current; servicefilter=[PL]

Das Muster ist abhängig von Groß-/Kleinschreibung. Reguläre Ausdrucke
scheinen bis zu Icinga 1.6 zu funktionieren. Siehe
[search\_string](cgiparams.md#cgiparams-search_string)

[servicegroup](cgiparams.md#cgiparams-servicegroup)

Alle oder eine bestimmte Servicegruppe auswählen, deren Hosts und
Services angezeigt werden sollen

all; \<servicegroup name\>

servicegroup=disk

Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B.
"%20" statt einen Leerzeichens)

[serviceprops](cgiparams.md#cgiparams-serviceprops)

Alle Services auswählen, die dem angegebenen Bitmuster entsprechen.
Bitte beachten Sie, dass die Services ALLE angegebenen Bedingungen
entsprechen müssen

 

serviceprops=131088 (aktive Prüfungen, die deaktiviert sind)

Ein logisches ODER der Bedingungen, die in include/cgiutils.c angegeben
sind
[[1]](cgiparams.md#cgiparams-filter "6.3.7. Host- und Service-Filter-Eigenschaften")
(HOST AND SERVICE FILTER PROPERTIES)

[servicestates](cgiparams.md#cgiparams-servicestates)

Zustand, in dem die Services sein sollten

 

servicestates=56 (Services in einem Problemzustand)

Ein logisches ODER der Zustände: 8=Warning; 16=Unknown; 32=Critical;
64=OK

[servicestatustypes](cgiparams.md#cgiparams-servicestatustypes)

Zustand, in dem die Services sein sollten

1 - 31

servicestatustype=28 (services in problem state)

Ein logisches ODER der Zustände: 1=Pending; 2=OK, 4=Warning; 8=Unknown;
16=Critical

[service\_divisor](cgiparams.md#cgiparams-service_divisor)

Wichtigkeit der Service in Relation zu Hosts

\>=1

 

Services sind 1/n so wichtig wie Hosts. Default: n=4

[shour](cgiparams.md#cgiparams-shour)

Start des maßgeschneiderten Zeitfensters (Stunde)

 

 

Nur gültig für flexible Ausfallzeiten

[showscheduleddowntime](cgiparams.md#cgiparams-showscheduleddowntime)

Geplante Ausfallzeiten anzeigen

yes; no

 

Default: yes

[show\_log\_entries](cgiparams.md#cgiparams-show_log_entries)

Log-Eintrage anzeigen

 

show\_log\_entries

Default: keine Log-Einträge anzeigen

[smin](cgiparams.md#cgiparams-smin)

Start des maßgeschneiderten Zeitfensters (Minute)

 

 

Nur gültig für flexible Ausfallzeiten

[smon](cgiparams.md#cgiparams-smon)

Start des maßgeschneiderten Zeitfensters (Monat)

 

 

Nur gültig für flexible Ausfallzeiten

[sortoption](cgiparams.md#cgiparams-sortoption)

Angeben der Spalte, nach der sortiert werden soll

1-n

sortoption=3

Default ist Spalte 1

[sorttype](cgiparams.md#cgiparams-sorttype)

Sortierrichtung für die Spalte, die über "sortoption=\<n\>" angegeben
wurde

1=ascending; 2=decending

sorttype=2

 

[ssec](cgiparams.md#cgiparams-ssec)

Start des maßgeschneiderten Zeitfensters (Sekunde)

 

 

Nur gültig für flexible Ausfallzeiten

[standardreport](cgiparams.md#cgiparams-standardreport)

Standard-Report

1=recent alerts; 2=recent host alerts; 3=recent service alerts; 4=top
host alert producers; 5=top service alert producers

 

 

[start](cgiparams.md#cgiparams-start)

Ergebniszähler

 

 

[3] Nutzbar für Paging-Fähigkeit

[start\_time](cgiparams.md#cgiparams-start_time)

Start der festen Ausfallzeit

 

 

Format "MM-DD-YYYY HH:MI" (kann ggf. von Ihren Ländereinstellungen
abhängen, das ist aber unklar)

[statetype](cgiparams.md#cgiparams-statetype)

Hard- und/oder Soft-states

0=Hard- und Soft-states; 1=Soft-states; 2=Hard-states

statetype=2

 

[statetypes](cgiparams.md#cgiparams-statetypes)

Hard- und/oder Soft-states

1=Soft-states; 2=Hard-states; 3=Hard- und Soft-states

statetypes=2

 

[sticky\_ack](cgiparams.md#cgiparams-sticky_ack)

Die Bestätigung ist "sticky"

0=disabled, 1=enabled (default)

sticky\_ack

[3] cmd.cgi erfordert 0|1 Werte, wenn nicht gesetzt, wird 1 als Standard
verwendet. Siehe auch [Bug \#2926](https://dev.icinga.org/issues/2926)
für weitere Informationen.

[style](cgiparams.md#cgiparams-style)

Angabe der anzuzeigenden Informationen

overview; detail; summary; grid; hostdetail

 

Trifft nur auf die Objekttypen "hostgroups" und "servicegroups" zu;
hostdetail=host status details; detail=service status details;
summary=status summary; grid=status grid;

[syear](cgiparams.md#cgiparams-syear)

Start des maßgeschneiderten Zeitfensters (Jahr)

 

 

Nur gültig für flexible Ausfallzeiten

[t1](cgiparams.md#cgiparams-t1)

Startpunkt eines maßgeschneiderten Zeitfensters

 

t1=1296109300

Unix timestamp

[t2](cgiparams.md#cgiparams-t2)

Endpunkt eines maßgeschneiderten Zeitfensters

 

t2=1296189360

Unix timestamp

[timeperiod](cgiparams.md#cgiparams-timeperiod)

Zeitfenster, das für den "Availability report" benutzt werden soll

today; yesterday; thisweek; lastweek; thismonth; lastmonth; thisquarter;
lastquarter; thisyear; lastyear; last24hours; last7days; last31days;
custom

timeperiod=lastmonth

 

[trigger](cgiparams.md#cgiparams-trigger)

Die Ausfallzeit wird von der Downtime-ID \<n\> ausgelöst

Eine gültige Downtime-ID

 

 

[ts\_end](cgiparams.md#cgiparams-ts_end)

Daten bis zu ts\_end anzeigen (Unix-Timestamp)

Ein gültiger Unix-Timestamp

 

siehe [3]

[ts\_start](cgiparams.md#cgiparams-ts_start)

Daten ab ts\_start anzeigen (Unix-Timestamp)

Ein gültiger Unix-Timestamp

 

siehe [3]

[type](cgiparams.md#cgiparams-type)

Objekttyp

hosts; hostgroups; services; servicegroups; contacts; contactgroups;
timeperiods; commands; hostescalations; serviceescalations;
hostdependencies; servicedependencies

type=hosts

 

![[Anmerkung]](../images/note.png)

Anmerkung

Seit 1.8 gibt es 'scroll' als Parameter für `status.cgi`{.filename}.
Dies dient dazu, die aktuelle Scroll-Position abzuspeichern und
wiederherzustellen. Dies ist nicht essenziell, da diese Variable nur
intern verwendet wird, wenn refresh\_type=javascript gesetzt ist in der
cgi.cfg

[1] Logisches ODER bedeutet, dass die jeweiligen Zahlen addiert werden.
Es werden dann die Objekte angezeigt, die ALLE Bedingungen erfüllen.

[2] avail, log, notif, out, status, sum: Alle Views/Reports unterstützen
jsonoutput; config: Alle Typen außer command expansion; ext: Alle Views
außer hostgroup/servicegroup info (immer außer Performance-Daten); tac:
Datenausgabe im json-Format. Mehr Informationen finden Sie im
[Icinga-Wiki](https://wiki.icinga.org/display/howtos/Using+JSON+export+in+Classic-UI).

[3] Verfügbar ab Icinga 1.8.

[4] Entfällt ab Icinga 1.8.

### 6.3.6. Abkürzungen, Classic UI-Module (CGIs), Verweise

Abkürzungen, die in der ersten Tabelle benutzt werden, Beziehungen zu
CGIs- und Menüeintragen sowie Verweise auf den Source-Code in
\<icinga-core\>/cgis.

Abkürzung

Classic UI-Modul

Menüeintrag

Source-Code

avail

avail.cgi

Availability

avail.c

cmd

cmd.cgi

N/A

cmd.c

config

config.cgi

Configuration

config.c

ext

extinfo.cgi

Comments, Downtime, Process Info, Performance Info, Schedulung Info

extinfo.c

hgram

histogram.cgi

Alert Histogram

histogram.c

hist

history.cgi

Alert History

history.c

notif

notifications.cgi

Notifications

notifications.c

out

outages.cgi

Network Outages

outages.c

log

showlog.cgi

Event Log

showlog.c

status

status.cgi

Hostgroup Overview, Servicegroup Overview, Host Problems, Service
Problems

status.c

map

statusmap.cgi

Status Map

statusmap.c

summary

summary.cgi

Alert Summary

summary.c

tac

tac.cgi

N/A

tac.c

trends

trends.cgi

Trends

trends.c

### 6.3.7. Host- und Service-Filter-Eigenschaften

**Ausschnitt aus include/cgiutils.h**

~~~~ {.programlisting}
/****************** HOST AND SERVICE FILTER PROPERTIES  *******************/

#define HOST_SCHEDULED_DOWNTIME         1
#define HOST_NO_SCHEDULED_DOWNTIME      2
#define HOST_STATE_ACKNOWLEDGED         4
#define HOST_STATE_UNACKNOWLEDGED       8
#define HOST_CHECKS_DISABLED            16
#define HOST_CHECKS_ENABLED             32
#define HOST_EVENT_HANDLER_DISABLED     64
#define HOST_EVENT_HANDLER_ENABLED      128
#define HOST_FLAP_DETECTION_DISABLED    256
#define HOST_FLAP_DETECTION_ENABLED     512
#define HOST_IS_FLAPPING                1024
#define HOST_IS_NOT_FLAPPING            2048
#define HOST_NOTIFICATIONS_DISABLED     4096
#define HOST_NOTIFICATIONS_ENABLED      8192
#define HOST_PASSIVE_CHECKS_DISABLED    16384
#define HOST_PASSIVE_CHECKS_ENABLED     32768
#define HOST_MODIFIED_ATTRIBUTES        65536
#define HOST_NO_MODIFIED_ATTRIBUTES     131072
#define HOST_HARD_STATE                 262144
#define HOST_SOFT_STATE                 524288
#define HOST_STATE_HANDLED              1048576
#define HOST_NOT_ALL_CHECKS_DISABLED    2097152

#define SERVICE_SCHEDULED_DOWNTIME      1
#define SERVICE_NO_SCHEDULED_DOWNTIME   2
#define SERVICE_STATE_ACKNOWLEDGED      4
#define SERVICE_STATE_UNACKNOWLEDGED    8
#define SERVICE_CHECKS_DISABLED         16
#define SERVICE_CHECKS_ENABLED          32
#define SERVICE_EVENT_HANDLER_DISABLED  64
#define SERVICE_EVENT_HANDLER_ENABLED   128
#define SERVICE_FLAP_DETECTION_ENABLED  256
#define SERVICE_FLAP_DETECTION_DISABLED 512
#define SERVICE_IS_FLAPPING             1024
#define SERVICE_IS_NOT_FLAPPING         2048
#define SERVICE_NOTIFICATIONS_DISABLED  4096
#define SERVICE_NOTIFICATIONS_ENABLED   8192
#define SERVICE_PASSIVE_CHECKS_DISABLED 16384
#define SERVICE_PASSIVE_CHECKS_ENABLED  32768
#define SERVICE_MODIFIED_ATTRIBUTES     65536
#define SERVICE_NO_MODIFIED_ATTRIBUTES  131072
#define SERVICE_HARD_STATE              262144
#define SERVICE_SOFT_STATE              524288
#define SERVICE_STATE_HANDLED           1048576
#define SERVICE_NOT_ALL_CHECKS_DISABLED 2097152
~~~~

### 6.3.8. Host- und Service-Statustypen

**Ausschnitt aus include/statusdata.h**

~~~~ {.programlisting}
/*************************** SERVICE STATES ***************************/
#define SERVICE_PENDING  1
#define SERVICE_OK       2
#define SERVICE_WARNING  4
#define SERVICE_UNKNOWN  8
#define SERVICE_CRITICAL 16

/**************************** HOST STATES ****************************/
#define HOST_PENDING     1
#define HOST_UP          2
#define HOST_DOWN        4
#define HOST_UNREACHABLE 8
~~~~

### 6.3.9. Commands

**Ausschnitt aus include/common.h**

~~~~ {.programlisting}
/***************************** COMMANDS *********************************/

#define CMD_NONE                                           0

#define CMD_ADD_HOST_COMMENT                               1
#define CMD_DEL_HOST_COMMENT                               2
#define CMD_ADD_SVC_COMMENT                                3
#define CMD_DEL_SVC_COMMENT                                4

#define CMD_ENABLE_SVC_CHECK                               5
#define CMD_DISABLE_SVC_CHECK                              6
#define CMD_SCHEDULE_SVC_CHECK                             7

#define CMD_DELAY_SVC_NOTIFICATION                         9
#define CMD_DELAY_HOST_NOTIFICATION                        10
#define CMD_DISABLE_NOTIFICATIONS                          11
#define CMD_ENABLE_NOTIFICATIONS                           12

#define CMD_RESTART_PROCESS                                13
#define CMD_SHUTDOWN_PROCESS                               14

#define CMD_ENABLE_HOST_SVC_CHECKS                         15
#define CMD_DISABLE_HOST_SVC_CHECKS                        16
#define CMD_SCHEDULE_HOST_SVC_CHECKS                       17

#define CMD_DEL_ALL_HOST_COMMENTS                          20
#define CMD_DEL_ALL_SVC_COMMENTS                           21

#define CMD_ENABLE_SVC_NOTIFICATIONS                       22
#define CMD_DISABLE_SVC_NOTIFICATIONS                      23
#define CMD_ENABLE_HOST_NOTIFICATIONS                      24
#define CMD_DISABLE_HOST_NOTIFICATIONS                     25
#define CMD_ENABLE_ALL_NOTIFICATIONS_BEYOND_HOST           26
#define CMD_DISABLE_ALL_NOTIFICATIONS_BEYOND_HOST          27
#define CMD_ENABLE_HOST_SVC_NOTIFICATIONS                  28
#define CMD_DISABLE_HOST_SVC_NOTIFICATIONS                 29

#define CMD_PROCESS_SERVICE_CHECK_RESULT                   30

#define CMD_SAVE_STATE_INFORMATION                         31
#define CMD_READ_STATE_INFORMATION                         32

#define CMD_ACKNOWLEDGE_HOST_PROBLEM                       33
#define CMD_ACKNOWLEDGE_SVC_PROBLEM                        34

#define CMD_START_EXECUTING_SVC_CHECKS                     35
#define CMD_STOP_EXECUTING_SVC_CHECKS                      36
#define CMD_START_ACCEPTING_PASSIVE_SVC_CHECKS             37
#define CMD_STOP_ACCEPTING_PASSIVE_SVC_CHECKS              38
#define CMD_ENABLE_PASSIVE_SVC_CHECKS                      39
#define CMD_DISABLE_PASSIVE_SVC_CHECKS                     40

#define CMD_ENABLE_EVENT_HANDLERS                          41
#define CMD_DISABLE_EVENT_HANDLERS                         42
#define CMD_ENABLE_HOST_EVENT_HANDLER                      43
#define CMD_DISABLE_HOST_EVENT_HANDLER                     44
#define CMD_ENABLE_SVC_EVENT_HANDLER                       45
#define CMD_DISABLE_SVC_EVENT_HANDLER                      46

#define CMD_ENABLE_HOST_CHECK                              47
#define CMD_DISABLE_HOST_CHECK                             48

#define CMD_START_OBSESSING_OVER_SVC_CHECKS                49
#define CMD_STOP_OBSESSING_OVER_SVC_CHECKS                 50

#define CMD_REMOVE_HOST_ACKNOWLEDGEMENT                    51
#define CMD_REMOVE_SVC_ACKNOWLEDGEMENT                     52

#define CMD_SCHEDULE_FORCED_HOST_SVC_CHECKS                53
#define CMD_SCHEDULE_FORCED_SVC_CHECK                      54

#define CMD_SCHEDULE_HOST_DOWNTIME                         55
#define CMD_SCHEDULE_SVC_DOWNTIME                          56

#define CMD_ENABLE_HOST_FLAP_DETECTION                     57
#define CMD_DISABLE_HOST_FLAP_DETECTION                    58
#define CMD_ENABLE_SVC_FLAP_DETECTION                      59
#define CMD_DISABLE_SVC_FLAP_DETECTION                     60
#define CMD_ENABLE_FLAP_DETECTION                          61
#define CMD_DISABLE_FLAP_DETECTION                         62

#define CMD_ENABLE_HOSTGROUP_SVC_NOTIFICATIONS             63
#define CMD_DISABLE_HOSTGROUP_SVC_NOTIFICATIONS            64
#define CMD_ENABLE_HOSTGROUP_HOST_NOTIFICATIONS            65
#define CMD_DISABLE_HOSTGROUP_HOST_NOTIFICATIONS           66

#define CMD_ENABLE_HOSTGROUP_SVC_CHECKS                    67
#define CMD_DISABLE_HOSTGROUP_SVC_CHECKS                   68

#define CMD_CANCEL_HOST_DOWNTIME                           69 /* not internally implemented */
#define CMD_CANCEL_SVC_DOWNTIME                            70 /* not internally implemented */
#define CMD_CANCEL_ACTIVE_HOST_DOWNTIME                    71 /* old - no longer used */
#define CMD_CANCEL_PENDING_HOST_DOWNTIME                   72 /* old - no longer used */
#define CMD_CANCEL_ACTIVE_SVC_DOWNTIME                     73 /* old - no longer used */
#define CMD_CANCEL_PENDING_SVC_DOWNTIME                    74 /* old - no longer used */
#define CMD_CANCEL_ACTIVE_HOST_SVC_DOWNTIME                75 /* unimplemented */
#define CMD_CANCEL_PENDING_HOST_SVC_DOWNTIME               76 /* unimplemented */

#define CMD_FLUSH_PENDING_COMMANDS                         77

#define CMD_DEL_HOST_DOWNTIME                              78
#define CMD_DEL_SVC_DOWNTIME                               79

#define CMD_ENABLE_FAILURE_PREDICTION                      80
#define CMD_DISABLE_FAILURE_PREDICTION                     81

#define CMD_ENABLE_PERFORMANCE_DATA                        82
#define CMD_DISABLE_PERFORMANCE_DATA                       83

#define CMD_SCHEDULE_HOSTGROUP_HOST_DOWNTIME               84
#define CMD_SCHEDULE_HOSTGROUP_SVC_DOWNTIME                85
#define CMD_SCHEDULE_HOST_SVC_DOWNTIME                     86

#define CMD_PROCESS_HOST_CHECK_RESULT                      87

#define CMD_START_EXECUTING_HOST_CHECKS                    88
#define CMD_STOP_EXECUTING_HOST_CHECKS                     89
#define CMD_START_ACCEPTING_PASSIVE_HOST_CHECKS            90
#define CMD_STOP_ACCEPTING_PASSIVE_HOST_CHECKS             91
#define CMD_ENABLE_PASSIVE_HOST_CHECKS                     92
#define CMD_DISABLE_PASSIVE_HOST_CHECKS                    93
#define CMD_START_OBSESSING_OVER_HOST_CHECKS               94
#define CMD_STOP_OBSESSING_OVER_HOST_CHECKS                95

#define CMD_SCHEDULE_HOST_CHECK                            96
#define CMD_SCHEDULE_FORCED_HOST_CHECK                     98

#define CMD_START_OBSESSING_OVER_SVC                       99
#define CMD_STOP_OBSESSING_OVER_SVC                        100
#define CMD_START_OBSESSING_OVER_HOST                      101
#define CMD_STOP_OBSESSING_OVER_HOST                       102

#define CMD_ENABLE_HOSTGROUP_HOST_CHECKS                   103
#define CMD_DISABLE_HOSTGROUP_HOST_CHECKS                  104
#define CMD_ENABLE_HOSTGROUP_PASSIVE_SVC_CHECKS            105
#define CMD_DISABLE_HOSTGROUP_PASSIVE_SVC_CHECKS           106
#define CMD_ENABLE_HOSTGROUP_PASSIVE_HOST_CHECKS           107
#define CMD_DISABLE_HOSTGROUP_PASSIVE_HOST_CHECKS          108

#define CMD_ENABLE_SERVICEGROUP_SVC_NOTIFICATIONS          109
#define CMD_DISABLE_SERVICEGROUP_SVC_NOTIFICATIONS         110
#define CMD_ENABLE_SERVICEGROUP_HOST_NOTIFICATIONS         111
#define CMD_DISABLE_SERVICEGROUP_HOST_NOTIFICATIONS        112

#define CMD_ENABLE_SERVICEGROUP_SVC_CHECKS                 113
#define CMD_DISABLE_SERVICEGROUP_SVC_CHECKS                114
#define CMD_ENABLE_SERVICEGROUP_HOST_CHECKS                115
#define CMD_DISABLE_SERVICEGROUP_HOST_CHECKS               116

#define CMD_ENABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS         117
#define CMD_DISABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS        118
#define CMD_ENABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS        119
#define CMD_DISABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS       120

#define CMD_SCHEDULE_SERVICEGROUP_HOST_DOWNTIME            121
#define CMD_SCHEDULE_SERVICEGROUP_SVC_DOWNTIME             122

#define CMD_CHANGE_GLOBAL_HOST_EVENT_HANDLER               123
#define CMD_CHANGE_GLOBAL_SVC_EVENT_HANDLER                124
#define CMD_CHANGE_HOST_EVENT_HANDLER                      125
#define CMD_CHANGE_SVC_EVENT_HANDLER                       126

#define CMD_CHANGE_HOST_CHECK_COMMAND                      127
#define CMD_CHANGE_SVC_CHECK_COMMAND                       128

#define CMD_CHANGE_NORMAL_HOST_CHECK_INTERVAL              129
#define CMD_CHANGE_NORMAL_SVC_CHECK_INTERVAL               130
#define CMD_CHANGE_RETRY_SVC_CHECK_INTERVAL                131

#define CMD_CHANGE_MAX_HOST_CHECK_ATTEMPTS                 132
#define CMD_CHANGE_MAX_SVC_CHECK_ATTEMPTS                  133

#define CMD_SCHEDULE_AND_PROPAGATE_TRIGGERED_HOST_DOWNTIME 134

#define CMD_ENABLE_HOST_AND_CHILD_NOTIFICATIONS            135
#define CMD_DISABLE_HOST_AND_CHILD_NOTIFICATIONS           136

#define CMD_SCHEDULE_AND_PROPAGATE_HOST_DOWNTIME           137

#define CMD_ENABLE_SERVICE_FRESHNESS_CHECKS                138
#define CMD_DISABLE_SERVICE_FRESHNESS_CHECKS               139
#define CMD_ENABLE_HOST_FRESHNESS_CHECKS                   140
#define CMD_DISABLE_HOST_FRESHNESS_CHECKS                  141

#define CMD_SET_HOST_NOTIFICATION_NUMBER                   142
#define CMD_SET_SVC_NOTIFICATION_NUMBER                    143

#define CMD_CHANGE_HOST_CHECK_TIMEPERIOD                   144  
#define CMD_CHANGE_SVC_CHECK_TIMEPERIOD                    145

#define CMD_PROCESS_FILE                                   146

#define CMD_CHANGE_CUSTOM_HOST_VAR                         147
#define CMD_CHANGE_CUSTOM_SVC_VAR                          148
#define CMD_CHANGE_CUSTOM_CONTACT_VAR                      149

#define CMD_ENABLE_CONTACT_HOST_NOTIFICATIONS              150
#define CMD_DISABLE_CONTACT_HOST_NOTIFICATIONS             151
#define CMD_ENABLE_CONTACT_SVC_NOTIFICATIONS               152
#define CMD_DISABLE_CONTACT_SVC_NOTIFICATIONS              153

#define CMD_ENABLE_CONTACTGROUP_HOST_NOTIFICATIONS         154
#define CMD_DISABLE_CONTACTGROUP_HOST_NOTIFICATIONS        155
#define CMD_ENABLE_CONTACTGROUP_SVC_NOTIFICATIONS          156
#define CMD_DISABLE_CONTACTGROUP_SVC_NOTIFICATIONS         157

#define CMD_CHANGE_RETRY_HOST_CHECK_INTERVAL               158

#define CMD_SEND_CUSTOM_HOST_NOTIFICATION                  159
#define CMD_SEND_CUSTOM_SVC_NOTIFICATION                   160

#define CMD_CHANGE_HOST_NOTIFICATION_TIMEPERIOD            161
#define CMD_CHANGE_SVC_NOTIFICATION_TIMEPERIOD             162
#define CMD_CHANGE_CONTACT_HOST_NOTIFICATION_TIMEPERIOD    163
#define CMD_CHANGE_CONTACT_SVC_NOTIFICATION_TIMEPERIOD     164

#define CMD_CHANGE_HOST_MODATTR                            165
#define CMD_CHANGE_SVC_MODATTR                             166
#define CMD_CHANGE_CONTACT_MODATTR                         167
#define CMD_CHANGE_CONTACT_MODHATTR                        168
#define CMD_CHANGE_CONTACT_MODSATTR                        169

#define CMD_SYNC_STATE_INFORMATION                         170

#define CMD_DEL_DOWNTIME_BY_HOST_NAME                      171
#define CMD_DEL_DOWNTIME_BY_HOSTGROUP_NAME                 172
#define CMD_DEL_DOWNTIME_BY_START_TIME_COMMENT             173

#define CMD_ACKNOWLEDGE_HOST_PROBLEM_EXPIRE                174
#define CMD_ACKNOWLEDGE_SVC_PROBLEM_EXPIRE                 175

#define CMD_DISABLE_NOTIFICATIONS_EXPIRE_TIME              176

#define CMD_CUSTOM_COMMAND                                 999
#define CMD_INTERNAL_CHANGE_HOST_CHECK_RETRY_INTERVAL     1001
#define CMD_INTERNAL_CHANGE_SVC_CHECK_RETRY_INTERVAL      1002
~~~~

* * * * *

  --------------------------------------------------------- -------------------------- ---------------------------------------------------------------------
  [Zurück](cgiauth.md)                                    [Nach oben](ch06.md)      [Weiter](cgicmd.md)
  6.2. Authentifizierung und Autorisierung im Classic UI    [Zum Anfang](index.md)    6.4. Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile
  --------------------------------------------------------- -------------------------- ---------------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
