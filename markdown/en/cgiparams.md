![Icinga](../images/logofullsize.png "Icinga")

6.3. Information On Classic UI parameters

[Prev](cgiauth.md) 

Chapter 6. User Interfaces

 [Next](cgicmd.md)

* * * * *

6.3. Information On Classic UI parameters
-----------------------------------------

6.3.1. [Introduction](cgiparams.md#introduction_cgiparams)

6.3.2. [Executing Classic UI modules on the command
line](cgiparams.md#executecmdline)

6.3.3. [Properties / Statustypes](cgiparams.md#propsstatustypes)

6.3.4. [Matrix Parameters / Classic UI
modules](cgiparams.md#matrixparamscgis)

6.3.5. [Parameter Details](cgiparams.md#cgiparams_expl)

6.3.6. [Abbreviations, Classic UI modules,
Links](cgiparams.md#cgiparams_abbrev)

6.3.7. [Host and Service Filter
Properties](cgiparams.md#cgiparams-filter)

6.3.8. [Host and Service Status
Types](cgiparams.md#cgiparams-statustypes)

6.3.9. [Commands](cgiparams.md#idp12077040)

### 6.3.1. Introduction

The menu on the left side of the classical web interface contains
entries which offer a quick way to the information most people need.
However you can change the parameters or use other options as well. Some
Classic UI modules (CGIs) require an objecttype ("host", "hostgroup",
"service", or "servicegroup"), often followed by one or more options.
The best way is to take a look at the existing URLs and change them
according to your needs.

Below you will find a table showing the parameters and the Classic UI
modules they apply to. The names of the Classic UI modules are
abbreviated. An explanation along with a hint to the source code can be
found
[here](cgiparams.md#cgiparams_abbrev "6.3.6. Abbreviations, Classic UI modules, Links").

Following this table is an explanation of the parameters (work in
progress).

### 6.3.2. Executing Classic UI modules on the command line

Instead of using your browser you may want to run the Classic UI modules
on the command line and process the results with other tools. For a
first impression change to the folder containing the \*.cgi modules
(e.g. `/usr/local/icinga/sbin`{.filename}), set some environment
variables and execute one of the Classic UI modules:

~~~~ {.screen}
 $> export REMOTE_USER=icingaadmin   # or choose the appropriate user
 $> export REQUEST_METHOD='GET'      # if you enter queries
 $> export QUERY_STRING='host=all'   # see the tables below 

 $> ./status.cgi
~~~~

Depending on the number of hosts this may return a lot of lines
containing HTML code in between which most people will find hard to read
so you should add "&csvoutput" or "&jsonoutput" to QUERY\_STRING along
with other arguments.

Set QUERY\_STRING as needed and execute the desired Classic UI module.

If you forgot to set the environment variables you'll receive the
following lines:

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

You will find some examples
[here](cgicmd.md "6.4. Executing Classic UI modules (CGIs) on the command line").

### 6.3.3. Properties / Statustypes

You can use `status.cgi`{.filename} to show objects with one or more
statustype (hoststatustype / servicestatustype) and with certain
properties (hostprops / serviceprops). Each statustype / property is
identified by a number (shown
[here](cgiparams.md#cgiparams-filter "6.3.7. Host and Service Filter Properties")
and
[here](cgiparams.md#cgiparams-statustypes "6.3.8. Host and Service Status Types")
at the end of this section). Please sum up the appropriate numbers and
use the resulting value for each option.

The example shows all non-OK services which are neither in downtime nor
acknowledged:

~~~~ {.screen}
 http://localhost/icinga/cgi-bin/status.cgi?host=all&servicestatustypes=29&serviceprops=10
~~~~

"29" includes PENDING services (not being checked since start up) as
well.

![[Note]](../images/note.png)

Note

Please note that using properties will only show the objects satisfying
ALL conditions whereas the objects are shown when satifying ONE of the
statustypes.

### 6.3.4. Matrix Parameters / Classic UI modules

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

attr [4]

 

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

jsonoutput [3]

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

ts\_end [3]

 

 

 

 

 

X

X

 

 

 

 

 

 

 

ts\_start [3]

 

 

 

 

 

X

X

 

 

 

 

 

 

 

trigger

 

X

 

 

 

 

 

 

 

 

 

 

 

 

type

 

 

X

X

 

X

X

 

 

 

 

 

 

 

### 6.3.5. Parameter Details

Further information regarding the several parameters is given below. For
a detailed understanding please have a look at the source code.

Parameter

Description

Possible Values

Example

Notes

[ahas](cgiparams.md#cgiparams-ahas)

The command will affects host and its services

 

ahas

 

[alerttypes](cgiparams.md#cgiparams-alerttypes)

Show host and/or service alerts

1=host alerts; 2=service alerts; 3=host and service alerts

alerttypes=3

 

[assumeinitialstates](cgiparams.md#cgiparams-assumeinitialstates)

 

yes; no

 

 

[assumestatesduringnotrunning](cgiparams.md#cgiparams-assumestatesduringnotrunning)

 

yes; no

 

 

[assumestateretention](cgiparams.md#cgiparams-assumestateretention)

 

yes; no

 

 

[attr](cgiparams.md#cgiparams-attr)

Reset modified attributes and don't set them in the future.

0

attr=0

see note [4].

[backtrack](cgiparams.md#cgiparams-backtrack)

How many archive log files will be searched to determine the initial
states

0-n

backtrack=1

Please keep in mind that processing of the files may take a while

[breakdown](cgiparams.md#cgiparams-breakdown)

Breakdown data by timeperiod

0=monthly; 1=day of month; 2=day of week; 3=hourly

breakdown=2

 

[broadcast\_notification](cgiparams.md#cgiparams-broadcast_notification)

Send notification to all contacts (non-escalated and escalated)

 

broadcast\_notification

 

[childoptions](cgiparams.md#cgiparams-childoptions)

Downtime handling for child hosts

0=doesn't affect child hosts; 1=schedule triggered downtime; 2=schedule
non-triggered downtime

childoptions=1

 

[cmd\_mod](cgiparams.md#cgiparams-cmd_mod)

Command mode

1, 2

cmd\_mod=2

1 means request, show confirmation form; 2 means commit directly

[cmd\_typ](cgiparams.md#cgiparams-cmd_typ)

Command type

0 - 169, 999

cmd\_typ=160

For details see [here](cgiparams.md#cgiparams-commands)

[columns](cgiparams.md#cgiparams-columns)

Number of overview columns

\>= 1

 

Default is 3

[com\_author](cgiparams.md#cgiparams-com_author)

Comment author

a valid user

com\_author=icingaadmin

May depend on the setting of "lock\_author\_names" in cgi.cfg

[com\_data](cgiparams.md#cgiparams-com_data)

Comment contents

an urlencoded string

 

 

[com\_id](cgiparams.md#cgiparams-com_id)

Comment id

 

 

 

[contact](cgiparams.md#cgiparams-contact)

A valid contact as mail recipient

 

 

 

[createimage](cgiparams.md#cgiparams-createimage)

 

 

createimage

 

[csvoutput](cgiparams.md#cgiparams-csvoutput)

Specify whether or not the report output should be in csv format

yes;no

 

This option automatically sets "noheader". Added to nearly all CGIs (see
note )

[displaytype](cgiparams.md#cgiparams-displaytype)

Type of alert report

1=recent alerts; 2=alert totals; 3=top alerts; 4=hostgroup alert totals;
5=host alert totals; 6=service alert totals; 7=servicegroup alert totals

 

 

[down\_id](cgiparams.md#cgiparams-down_id)

Downtime id

 

 

 

[eday](cgiparams.md#cgiparams-eday)

End of custom timeperiod (day)

 

 

Only valid when using "custom" timeperiod

[ehour](cgiparams.md#cgiparams-ehour)

End of custom timeperiod (hour)

 

 

Only valid when using "custom" timeperiod

[embedded](cgiparams.md#cgiparams-embedded)

Omit some HTML code and SSI header/footer

 

embedded

 

[emin](cgiparams.md#cgiparams-emin)

End of custom timeperiod (minute)

 

 

Only valid when using "custom" timeperiod

[emon](cgiparams.md#cgiparams-emon)

End of custom timeperiod (month)

 

 

Only valid when using "custom" timeperiod

[end\_time](cgiparams.md#cgiparams-end_time)

End time of the fixed downtime

 

 

Format "MM-DD-YYYY HH:MI"

[esec](cgiparams.md#cgiparams-esec)

End of custom timeperiod (second)

 

 

Only valid when using "custom" timeperiod

[eyear](cgiparams.md#cgiparams-eyear)

End of custom timeperiod (year)

 

 

Only valid when using "custom" timeperiod

[fixed](cgiparams.md#cgiparams-fixed)

Whether or not the downtime will be fixed

0=flexible, \>0=fixed

 

 

[force\_check](cgiparams.md#cgiparams-force_check)

The service check will be forced

 

forcecheck

 

[force\_notification](cgiparams.md#cgiparams-force_notification)

Send notification regardless of restrictions (timeperiods or else)

 

force\_notification

 

[full\_log\_entries](cgiparams.md#cgiparams-full_log_entries)

Show full or "condensed" log entries

 

full\_log\_entries

Default is "condensed" view

[get\_date\_parts](cgiparams.md#cgiparams-get_date_parts)

Get custom time ranges

 

get\_date\_parts

 

[graphevents](cgiparams.md#cgiparams-graphevents)

Which objects should be graphed in what state

 

graphevents=112 (all service problems)

A boolean OR of: 1=Host up; 2=Host down; 4=Host unreachable; 8=Service
OK; 16=Service Warning; 32=Service Unknown; 64=Service Critical

[graphstatetypes](cgiparams.md#cgiparams-graphstatetypes)

Graph hard and/or soft states

1=soft states; 2=hard states; 3=hard and soft states

graphstatetypes=3

 

[host](cgiparams.md#cgiparams-host)

Select all hosts or a specific host whose services should be displayed

all; \<host name\>

host=monitor

special characters in the name have to be urlencoded (i.e. "%20" instead
of a blank)

[hostgroup](cgiparams.md#cgiparams-hostgroup)

Select all hostgroups or one specific hostgroup whose hosts and services
should be displayed

all; \<hostgroup name\>

hostgroup=linux-boxes

special characters in the name have to be urlencoded (i.e. "%20" instead
of a blank)

[hostprops](cgiparams.md#cgiparams-hostprops)

Select the hosts (including the services) matching the given bit
pattern. Note that the hosts have to match ALL conditions specified

 

hostprops=131088 (active checks being disabled)

A boolean OR of the states specified in include/cgiutils.c
[[1]](cgiparams.md#cgiparams-filter "6.3.7. Host and Service Filter Properties")
(HOST AND SERVICE FILTER PROPERTIES)

[hoststates](cgiparams.md#cgiparams-hoststates)

The state the hosts should be in

1 - 7

hoststates=3 (hosts in problem state)

A boolean OR of the states: 1=DOWN; 2=UNREACHABLE; 4=UP

[hoststatustypes](cgiparams.md#cgiparams-hoststatustypes)

The state the host should be in

1 - 15

hoststatustypes=12 (hosts in problem state)

A boolean OR of the states: 1=Pending; 2=Up; 4=Down; 8=Unreachable

[hours](cgiparams.md#cgiparams-hours)

Duration of the flexible downtime in full hours (see minutes)

\>= 0

 

Only valid if defining a flexible downtime

[includesoftstates](cgiparams.md#cgiparams-includesoftstates)

Include soft states

yes; no

includesoftstate=yes

Default: don't include soft states

[initialassumedhoststate](cgiparams.md#cgiparams-initialassumedhoststate)

 

 

 

 

[initialassumedservicestate](cgiparams.md#cgiparams-initialassumedservicestate)

 

 

 

 

[initialstateslogged](cgiparams.md#cgiparams-initialstateslogged)

 

 

 

 

[input](cgiparams.md#cgiparams-input)

 

 

 

 

[item\_name](cgiparams.md#cgiparams-item_name)

Search for exact match of specified string (for regex search see
[search\_string](cgiparams.md#cgiparams-search_string))

 

item\_name=localhost

[3]

[jsonoutput](cgiparams.md#cgiparams-jsonoutput)

Specify whether or not the report output should be in json format

yes;no

 

This option automatically sets "noheader". Added to nearly all CGIs (see
note )

[limit](cgiparams.md#cgiparams-limit)

Number of items to display per page

1-n

limit=10

Used for paging-ability [3]. The summary.cgi doesn't have pagination,
default=25.

[minutes](cgiparams.md#cgiparams-minutes)

Duration of the flexible downtime (see hours)

\>= 0

 

 

[navbarsearch](cgiparams.md#cgiparams-navbarsearch)

 

 

 

 

[newstatesonly](cgiparams.md#cgiparams-newstatesonly)

Only display new states

yes; no

newstatesonly=yes

Default: display all states

[nodowntime](cgiparams.md#cgiparams-nodowntime)

Don't display downtimes

 

nodowntime

 

[noflapping](cgiparams.md#cgiparams-noflapping)

Don't display flapping alerts

 

noflapping

 

[nofrills](cgiparams.md#cgiparams-nofrills)

Don't display frills

 

nofrills

 

[noheader](cgiparams.md#cgiparams-noheader)

Omit global status information and only show status details

 

noheader

 

[not\_dly](cgiparams.md#cgiparams-not_dly)

Delay notification for n minutes

\>= 0

 

 

[notimebreaks](cgiparams.md#cgiparams-notimebreaks)

Don't display timebreaks

 

 

 

[nosystem](cgiparams.md#cgiparams-nosystem)

Don't display system messages

 

nosystem

Default: display system (process) messages

[oldestfirst](cgiparams.md#cgiparams-oldestfirst)

Reverse sort order

 

oldestfirst

Default: show most recent entries first; see note [4]

[order](cgiparams.md#cgiparams-order)

Specify sort order

new2old, old2new

order=old2new

Default: show most recent entries first; see note [3]

[paused](cgiparams.md#cgiparams-paused)

Stop automatic update

 

paused

 

[performance\_data](cgiparams.md#cgiparams-performance_data)

The string sent as the performance data

 

 

 

[persistent](cgiparams.md#cgiparams-persistent)

The comment will be persistent if this option is set

 

persistent

 

[plugin\_output](cgiparams.md#cgiparams-plugin_output)

The string sent as the plugin output

 

 

The length is limited by the value of MAX\_INPUT\_LENGTH (set during
compile time)

[plugin\_state](cgiparams.md#cgiparams-plugin_state)

Specify the state the plugin should have

0=OK; 1=Warning; 2=Critical; 3=Unknown

plugin\_state=2

 

[ptc](cgiparams.md#cgiparams-ptc)

The command will be propagated to child hosts

 

ptc

 

[report](cgiparams.md#cgiparams-report)

Create report

 

report

 

[report\_type](cgiparams.md#cgiparams-report_type)

Select the report type

hostgroups; servicegroups; hosts; services

report\_type=hostgroups

 

[rpttimeperiod](cgiparams.md#cgiparams-rpttimeperiod)

Specify a timeperiod which is used for the availability report

One of the defined timeperiods

 

Use the short name from the timeperiod definition

[sched\_dly](cgiparams.md#cgiparams-sched_dly)

Delay command scheduling by n minutes

\>= 0

 

 

[sday](cgiparams.md#cgiparams-sday)

Start of custom timeperiod (day)

 

 

 

[search\_string](cgiparams.md#cgiparams-search_string)

Find object (host, service, etc) with given string using regular
expressions

 

 

[3]

[send\_notification](cgiparams.md#cgiparams-send_notification)

Send a notification for the acknowledgement

0=disabled, 1=enabled (default)

send\_notification

[3] cmd.cgi requires 0|1 vars, if not set, default is 1. View [Bug
\#2926](https://dev.icinga.org/issues/2926) for additional information.

[service](cgiparams.md#cgiparams-service)

Select all services or a specific service which should be displayed

all; \<service description\>

service=PING

Special characters in the name have to be urlencoded (i.e. "%20" instead
of a blank)

[servicefilter](cgiparams.md#cgiparams-servicefilter)

Select only services matching the given pattern

 

servicefilter=Current; servicefilter=[PL]

The pattern is case sensitive. Regular expressions seemed to work up to
Icinga 1.6; see [search\_string](cgiparams.md#cgiparams-search_string)

[servicegroup](cgiparams.md#cgiparams-servicegroup)

Select all servicegroup or one specific servicegroup whose hosts and
services should be displayed

all; \<servicegroup name\>

servicegroup=disk

Special characters in the name have to be urlencoded (i.e. "%20" instead
of a blank)

[serviceprops](cgiparams.md#cgiparams-serviceprops)

Select the services matching the given bit pattern. Note that the
services have to match ALL conditions specified

 

serviceprops=131088 (active checks being disabled)

A boolean OR of the states specified in include/cgiutils.c
[[1]](cgiparams.md#cgiparams-filter "6.3.7. Host and Service Filter Properties")
(HOST AND SERVICE FILTER PROPERTIES)

[servicestates](cgiparams.md#cgiparams-servicestates)

State the services should be in

 

servicestates=56 (services in problem state)

A boolean OR of the states: 8=Warning; 16=Unknown; 32=Critical; 64=OK

[servicestatustypes](cgiparams.md#cgiparams-servicestatustypes)

State the services should be in

1 - 31

servicestatustype=28 (services in problem state)

A boolean OR of the states: 1=Pending; 2=OK, 4=Warning; 8=Unknown;
16=Critical

[service\_divisor](cgiparams.md#cgiparams-service_divisor)

Importance of services in relation to hosts

\>=1

 

Services are 1/n important as hosts. Default: n=4

[shour](cgiparams.md#cgiparams-shour)

Start of custom timeperiod (hour)

 

 

Only valid when using "custom" timeperiod

[showscheduleddowntime](cgiparams.md#cgiparams-showscheduleddowntime)

Display scheduled downtimes

yes; no

 

Default: yes

[show\_log\_entries](cgiparams.md#cgiparams-show_log_entries)

Display log entries

 

show\_log\_entries

Default: don't show log entries

[smin](cgiparams.md#cgiparams-smin)

Start of custom timeperiod (minute)

 

 

Only valid when using "custom" timeperiod

[smon](cgiparams.md#cgiparams-smon)

Start of custom timeperiod (month)

 

 

Only valid when using "custom" timeperiod

[sortoption](cgiparams.md#cgiparams-sortoption)

Specify the column to sort on

1-n

sortoption=3

Default is column 1

[sorttype](cgiparams.md#cgiparams-sorttype)

Specify the sort order on the column specified by "sortoption=\<n\>"

1=ascending; 2=decending

sorttype=2

 

[ssec](cgiparams.md#cgiparams-ssec)

Start of custom timeperiod (second)

 

 

Only valid when using "custom" timeperiod

[standardreport](cgiparams.md#cgiparams-standardreport)

Standard report

1=recent alerts; 2=recent host alerts; 3=recent service alerts; 4=top
host alert producers; 5=top service alert producers

 

 

[start](cgiparams.md#cgiparams-start)

Resultcounter

 

 

[3] Result counter for pagination.

[start\_time](cgiparams.md#cgiparams-start_time)

Start of the fixed downtime

 

 

Format "MM-DD-YYYY HH:MI" (may depend on your local settings, but unsure
about that)

[statetype](cgiparams.md#cgiparams-statetype)

Hard and/or soft states

0=hard and soft states; 1=soft states; 2=hard states

statetype=2

 

[statetypes](cgiparams.md#cgiparams-statetypes)

Hard and/or soft states

1=soft states; 2=hard states; 3=hard and soft states

statetypes=2

 

[sticky\_ack](cgiparams.md#cgiparams-sticky_ack)

The acknowledgement will be "sticky"

0=disabled, 1=enabled (default)

sticky\_ack

[3] cmd.cgi requires 0|1 vars, if not set, default is 1. View [Bug
\#2926](https://dev.icinga.org/issues/2926)for additional information.

[style](cgiparams.md#cgiparams-style)

Specify the information to be shown

overview; detail; summary; grid; hostdetail

 

only applies to objecttypes "hostgroups" and
"servicegroups";hostdetail=host status details; detail=service status
details; summary=status summary; grid=status grid;

[syear](cgiparams.md#cgiparams-syear)

Start of custom timeperiod (year)

 

 

Only valid when using "custom" timeperiod

[t1](cgiparams.md#cgiparams-t1)

Start point of a custom timeperiod

 

t1=1296109300

Unix timestamp

[t2](cgiparams.md#cgiparams-t2)

End point of a custom timeperiod

 

t2=1296189360

Unix timestamp

[timeperiod](cgiparams.md#cgiparams-timeperiod)

Timeperiod which should be used for the availability report

today; yesterday; thisweek; lastweek; thismonth; lastmonth; thisquarter;
lastquarter; thisyear; lastyear; last24hours; last7days; last31days;
custom

timeperiod=lastmonth

 

[trigger](cgiparams.md#cgiparams-trigger)

The downtime will be triggered by downtime id \<n\>

A valid downtime id

 

 

[ts\_end](cgiparams.md#cgiparams-ts_end)

Data is shown up to ts\_end (unix timestamp)

A valid unix timestamp

 

[3]

[ts\_start](cgiparams.md#cgiparams-ts_start)

Data is shown starting at ts\_start (unix timestamp)

A valid unix timestamp

 

[3]

[type](cgiparams.md#cgiparams-type)

Objecttype

hosts; hostgroups; services; servicegroups; contacts; contactgroups;
timeperiods; commands; hostescalations; serviceescalations;
hostdependencies; servicedependencies

type=hosts

 

![[Note]](../images/note.png)

Note

Starting with 1.8 the 'scroll' parameter was added to status.cgi to save
and restore the current scroll position. This is minor, as only used as
internal variable when using refresh\_type=javascript in cgi.cfg

[1] Logical OR means that the numbers are added and only the objects
will be displayed satisfying ALL conditions (properties).

[2] avail, log, notif, out, status, sum: all views/reports support
jsonoutput; config: all types except command expansion; ext: all views
except hostgroup/servicegroup info (always without performance data);
tac: data output in json format. More details in the [Icinga
wiki](https://wiki.icinga.org/display/howtos/Using+JSON+export+in+Classic-UI).

[3] Available starting with Icinga 1.8.

[4] Removed starting with Icinga 1.8.

### 6.3.6. Abbreviations, Classic UI modules, Links

Abbreviations used in the first table, relations to Classic UI module
and menu items, and links to the source code in \<icinga-core\>/cgis.

Abbreviation

Classic UI module

Menu item(s)

Source Code

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

### 6.3.7. Host and Service Filter Properties

**Excerpt from include/cgiutils.h**

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

### 6.3.8. Host and Service Status Types

**Excerpt from include/statusdata.h**

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

### 6.3.9. Commands

**Excerpt from include/common.h**

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

  ---------------------------------------------------------- -------------------- ---------------------------------------------------------------
  [Prev](cgiauth.md)                                       [Up](ch06.md)       [Next](cgicmd.md)
  6.2. Authentication And Authorization In The Classic UI    [Home](index.md)    6.4. Executing Classic UI modules (CGIs) on the command line
  ---------------------------------------------------------- -------------------- ---------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
