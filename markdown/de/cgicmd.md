![Icinga](../images/logofullsize.png "Icinga")

6.4. Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile

[Zurück](cgiparams.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](icinga-web-scratch.md)

* * * * *

6.4. Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile
------------------------------------------------------------------

6.4.1. [Einführung](cgicmd.md#introduction)

6.4.2. [Voraussetzungen](cgicmd.md#prerequisites)

6.4.3. [Beispiele](cgicmd.md#examples)

### 6.4.1. Einführung

In den meisten Fällen werden Sie Ihren Browser benutzen, um die
Informationen anzusehen, die Sie benötigen. Es mag Situationen geben, in
denen Sie die Daten mit anderen Werkzeugen bearbeiten möchten, um
Wiki-Einträge zu erzeugen, Mails zu verschicken usw. Zusammen mit den
[Informationen zu den Classic
UI-Modul-Parametern](cgiparams.md "6.3. Informationen zu den Classic UI-Modul-Parametern")
können Sie die Classic UI-Module auf der Kommandozeile aufrufen.

### 6.4.2. Voraussetzungen

Bevor Sie die Module tatsächlich aufrufen können, müssen Sie drei
Umgebungsvariablen setzen:

-   REMOTE\_USER

    Diese Variable enthält einen Benutzer, der berechtigt ist, die
    Informationen abzurufen. In den meisten Fällen wird dies
    "icingaadmin" sein (`set REMOTE_USER='icingaadmin')`{.literal}

-   REQUEST\_METHOD

    `set REQUEST_METHOD='GET'`{.literal}. Mögliche Werte sind "GET",
    "POST" und "HEAD"

-   QUERY\_STRING

    Anstatt Argumente über die Kommandozeile an die Module zu übergeben,
    müssen Sie die Variable "QUERY\_STRING" mit den entsprechenden
    Werten füllen.

    ![[Anmerkung]](../images/note.png)

    Anmerkung

    Die meisten Leute finden es schwierig, HTML-Ausgaben zu lesen, so
    dass es eine gute Idee ist, der Variable QUERY\_STRING "jsonoutput"
    oder "csvoutput" hinzuzufügen
    ` (QUERY_STRING='jsonoutput' bzw. QUERY_STRING='jsonoutput')`{.code}
    .

Wenn Sie vergessen, die Umgebungsvariablen zu setzen, dann bekommen Sie
beim Aufruf die folgenden Zeilen:

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

### 6.4.3. Beispiele

![[Anmerkung]](../images/note.png)

Anmerkung

Die Module werden aus dem Ordner aufgerufen, in dem sich die
\*.cgi-Dateien befinden (z.B. `/usr/local/icinga/sbin`{.filename}). Dies
ist nicht notwendig, sondern dient lediglich der Einfachheit. Solange
nichts anderes angegeben ist, gilt `REQUEST_METHOD='GET'`{.literal}.

Taktischer Überblick

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput'
 $> ./tac.cgi
~~~~

Alle Hosts im Zustand DOWN

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4'
 $> ./status.cgi
~~~~

Alle Hosts im Zustand DOWN, die "unacknowledged" *und* nicht in einer
Downtime sind

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4&hostprops=10'
 $> ./status.cgi
~~~~

Alle Services in einem nicht-OK-Zustand

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28'
 $> ./status.cgi
~~~~

Alle passiven Services im Zustand CRITICAL

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28&serviceprops=65536'
 $> ./status.cgi
~~~~

Kommentare für alle Objekte

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&type=3'
 $> ./extinfo.cgi
~~~~

Trends für router\_02, Zeitangaben durch Unix-Timestamps

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom&t1=130748400&t2=1307570400'
 $> ./extinfo.cgi
~~~~

Trends für router\_02, Zeitangaben durch Datum und Uhrzeit

~~~~ {.screen}
 $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom\
 &sday=6&smon=6&syear=2011&shour=0&smin=0&ssec=0\
 &eday=7&emon=6&eyear=2011&ehour=0&emin=0&esec=0'
 $> ./extinfo.cgi
~~~~

(wird fortgesetzt)

* * * * *

  -------------------------------------------------------- -------------------------- --------------------------------------------
  [Zurück](cgiparams.md)                                 [Nach oben](ch06.md)      [Weiter](icinga-web-scratch.md)
  6.3. Informationen zu den Classic UI-Modul-Parametern    [Zum Anfang](index.md)    6.5. Installation des Icinga Web Frontend
  -------------------------------------------------------- -------------------------- --------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
