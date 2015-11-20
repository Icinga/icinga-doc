[Prev](cgiparams.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](icinga-web-scratch.md)

* * * * *

6.4. Executing Classic UI modules (CGIs) on the command line
------------------------------------------------------------

6.4.1. [Introduction](cgicmd.md#introduction_cgicmd)

6.4.2. [Prerequisites](cgicmd.md#prerequisites)

6.4.3. [Examples](cgicmd.md#examples)

### 6.4.1. Introduction

In most cases you will use your browser to retrieve the information you
need. There may be situations where you want to process the data with
other tools to create wiki entries, send mails and so on. Together with
the [information on the CGI
parameters](cgiparams.md "6.3. Information On Classic UI parameters")
you can call the Classic UI modules from the command line.

### 6.4.2. Prerequisites

Before actually calling the modules you have to set three environment
variables:










If you forgot to set the environment variables you'll receive the
following lines:

</code></pre> 
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
</code></pre>

### 6.4.3. Examples

![[Note]](../images/note.png)

Note

The modules are called from within the folder which contains the \*.cgi
files (e.g. `/usr/local/icinga/sbin`). This is not necessary
but for the sake of simplicity. Unless otherwise specified the
REQUEST\_METHOD is set to 'GET'.

Tactical overview

</code></pre> 
 $> set QUERY_STRING='jsonoutput'
 $> ./tac.cgi
</code></pre>

All hosts in DOWN state

</code></pre> 
 $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4'
 $> ./status.cgi
</code></pre>

All hosts in DOWN state being unacknowledged *and* not in a downtime

</code></pre> 
 $> set QUERY_STRING='jsonoutput&style=hostdetail&hoststatustypes=4&hostprops=10'
 $> ./status.cgi
</code></pre>

All service in non-OK state

</code></pre> 
 $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28'
 $> ./status.cgi
</code></pre>

All services being in CRITICAL state and being passive checks

</code></pre> 
 $> set QUERY_STRING='jsonoutput&style=detail&servicestatustypes=28&serviceprops=65536'
 $> ./status.cgi
</code></pre>

Comments for all objects

</code></pre> 
 $> set QUERY_STRING='jsonoutput&type=3'
 $> ./extinfo.cgi
</code></pre>

Trends for router\_02 specifying a custom timeperiod using unix
timestamps

</code></pre> 
 $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom&t1=130748400&t2=1307570400'
 $> ./extinfo.cgi
</code></pre>

Trends for router\_02 specifying a custom timeperiod using date and time

</code></pre> 
 $> set QUERY_STRING='jsonoutput&host=router_02&timeperiod=custom\
 &sday=6&smon=6&syear=2011&shour=0&smin=0&ssec=0\
 &eday=7&emon=6&eyear=2011&ehour=0&emin=0&esec=0'
 $> ./extinfo.cgi
</code></pre>

(to be continued)

* * * * *

[Prev](cgiparams.md) | [Up](ch06.md) | [Next](icinga-web-scratch.md)

6.3. Information On Classic UI parameters  |<=== [Index](index.md) ===>|  6.5. Installation of the Icinga Web Frontend

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
