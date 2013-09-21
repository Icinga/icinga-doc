Ausführen von CGIs auf der Kommandozeile
========================================

Einführung
----------

In den meisten Fällen werden Sie Ihren Browser benutzen, um die
Informationen anzusehen, die Sie benötigen. Es mag Situationen geben, in
denen Sie die Daten mit anderen Werkzeugen bearbeiten möchten, um
Wiki-Einträge zu erzeugen, Mails zu verschicken usw. Zusammen mit den
[Informationen zu den CGI-Parametern](#cgiparams) können Sie die CGIs
auf der Kommandozeile aufrufen.

Voraussetzungen
---------------

Bevor Sie die CGIs tatsächlich aufrufen können, müssen Sie drei
Umgebungsvariablen setzen:

-   REMOTE\_USER

    Diese Variable enthälft einen Benutzer, der berechtigt ist, die
    Informationen abzurufen. In den meisten Fällen wird dies
    "icingaadmin" sein (`set REMOTE_USER='icingaadmin')`

-   REQUEST\_METHOD

    `set REQUEST_METHOD='GET'`. Mögliche Werte sind "GET", "POST" und
    "HEAD"

-   QUERY\_STRING

    Anstatt Argumente über die Kommandozeile an die CGIs zu übergeben,
    müssen Sie die Variable "QUERY\_STRING" mit den entsprechenden
    Werten füllen.

    > **Note**
    >
    > Die meisten Leute finden es schwierig, HTML-Ausgaben zu lesen, so
    > dass es eine gute Idee ist, der Variable QUERY\_STRING
    > "jsonoutput" oder "csvoutput" hinzuzufügen
    > ` (QUERY_STRING='jsonoutput' bzw. QUERY_STRING='jsonoutput')` .

Wenn Sie vergessen, die Umgebungsvariablen zu setzen, dann bekommen Sie
beim Aufruf die folgenden Zeilen:

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

Beispiele
---------

> **Note**
>
> Die CGIs werden aus dem Ordner aufgerufen, in dem sich die
> \*.cgi-Dateien befinden (z.B. `/usr/local/icinga/sbin`). Dies ist
> nicht notwendig, sondern dient lediglich der Einfachheit. Solange
> nichts anderes angegeben ist, gilt `REQUEST_METHOD='GET'`.

Tactical overview

     $> set QUERY_STRING='jsonoutput'
     $> ./tac.cgi

Alle Hosts im Zustand DOWN

     $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4'
     $> ./status.cgi

Alle Hosts im Zustand DOWN, die "unacknowledged" *und* nicht in einer
Downtime sind

     $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4&hostprops=10'
     $> ./status.cgi

Alle Services in einem nicht-OK-Zustand

     $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28'
     $> ./status.cgi

Alle passiven Services im Zustand CRITICAL

     $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28&serviceprops=65536'
     $> ./status.cgi

Kommentare für alle Objekte

     $> set QUERY_STRING='jsonoutput&type=3'
     $> ./extinfo.cgi

Trends für router\_02, Zeitangaben durch Unix-Timestamps

     $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom&t1=130748400&t2=1307570400'
     $> ./extinfo.cgi

Trends für router\_02, Zeitangaben durch Datum und Uhrzeit

     $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom\
     &sday=6&smon=6&syear=2011&shour=0&smin=0&ssec=0\
     &eday=7&emon=6&eyear=2011&ehour=0&emin=0&esec=0'
     $> ./extinfo.cgi

(wird fortgesetzt)

CGIs
Ausführen von CGIs auf der Kommandozeile
