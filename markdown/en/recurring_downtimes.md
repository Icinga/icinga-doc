[Prev](downtime.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](embeddedperl.md)

* * * * *

7.17. Recurring Downtimes
-------------------------

7.17.1. [Downtime definition](recurring_downtimes.md#introduction)

7.17.2. [Variable dates](recurring_downtimes.md#variabledates)

7.17.3. [Local holidays](recurring_downtimes.md#localholidays)

7.17.4. [Entering downtimes](recurring_downtimes.md#enteringdowntimes)

7.17.5. [Planning downtimes](recurring_downtimes.md#planningdowntimes)

7.17.6. [Converting downtime
definitions](recurring_downtimes.md#conversion)

7.17.7. [Files](recurring_downtimes.md#files)

Many people have regular downtimes at different times and it would be a
tedious task to reschedule them manually every time. **So far there is
no official format for defining such schedules. That means that these
definitions have to be stored in a separate file which cannot be
included into the other object definitions.** A cronjob will call a
script which will read the definitions, already existing downtimes, and
plan new downtimes if necessary.

### 7.17.1. Downtime definition

The script introduces a new format for these downtimes based on existing
definitions taken from the status file and time periods resulting in:

<pre><code>
 define downtime {
}
</code></pre>

Notes on the above definition:















### 7.17.2. Variable dates

The definitions above will work for most dates but some are calculated
based on easter sunday which is on a different date each year. We tried
to bypass these limitations by calculating the dates based on easter
sunday and giving them names you can refer to. The variable names are
not case sensitive.

Variable name

Offset / Date

Twelfth\_day

January, 6th

Labour\_day

May, 1st

Carnival\_monday

-48

Mardi\_gras

-47

Ash\_wednesday

-46

Maundy\_thursday

-3

Good\_friday

-2

Easter\_sunday

0

Easter\_monday

1

Ascension\_day

+39

Whit\_sunday

+49

Whit\_monday

+50

Trinity

+56

Corpus\_christi

+70

Assumption\_day

August, 8th

Penance\_day

Wednesday before Nov., 23rd

Christmas\_day

December, 25th

Boxing\_day

December, 26th

So now you can define a downtime for Carnival Monday using something
like:

<pre><code>
 define downtime {
 }
</code></pre>

### 7.17.3. Local holidays

Looking at the calendars of several countries there are a lot of
holidays which only apply to a single country. Unfortunately some of
these dates are on a weekday in a week within a month. You can already
define these dates using "monday 3 february" or "monday -1 may" but you
may want to use variables names as well. Defining these names and their
corresponding calculations in a separate file and processing them
enables you to do so. The default name for this file is
`holiday.cfg` located in `/usr/local/icinga/etc`.
The location can be altered using the option "-l".

We only picked three dates to give you the idea how to do it:

<pre><code>
# example of local holiday definitions
# please don't use local characters
# variable names must not contain spaces
#
</code></pre>

There are two "functions" available to define these flexible dates:






So now you can define a downtime using something like:

<pre><code>
 define downtime {
 }
</code></pre>

Please note that you have to specify the location of this file using the
option "-l".

### 7.17.4. Entering downtimes

So far there is no way to enter the definitions via your browser so you
have to use your favourite text editor to create the definitions. Sorry.

### 7.17.5. Planning downtimes

Once you have created a file holding the downtime definitions you will
want to schedule the downtimes automatically. This can be done using the
Perl script "sched\_down.pl" being called from the crontab. The script
itself requires the Perl module "Date::Calc".

The easiest way is to execute "/path/to/script/sched\_down.pl". Adding
the option "-h" will output some information:

<pre><code>

Note: Enabled debugging, forecasting, and/or examine will prevent that schedules

Setting environment variables influences the behaviour:
- FAKE_DATE (YYYYMMDD): date deviating from current date
</code></pre>

All arguments are optional. Just to test the function of the script it
might be helpful to use the "examine" option followed by a downtime
period:

<pre><code>
 /usr/local/icinga/bin/sched_down.pl -e "tuesday 20:00-21:00"
</code></pre>

This will return a string similar to the actual command if the downtime
is within the planning period (default two days) which can be altered
using the option "-m". To test downtimes in the future you may set the
environment variable FAKE\_DATE (e.g. "FAKE\_DATE=20130127") prior
calling the script although it might be easier to use the option "-t".

There are two ways to execute the script:











Unless you get the downtimes on short notice this should be sufficient.
The script will only plan non-existing downtimes so no harm will be done
if it is called more often.

### 7.17.6. Converting downtime definitions

Steve Shipway has created files to plan downtimes via a CGI and schedule
them for several Nagios versions a long time ago ([see
here](https://exchange.icinga.org/exchange/downtime_sched%3A+recurring+downtime+scheduler)).

The commercial Nagios version has added recurring downtimes as well but
instead of using all of Steve's scripts they decided to take the
scheduling script and write a new CGI which doesn't seem to be able to
plan flexible downtimes (well, at least not in the 2011 VM).

The Perl script "sched\_conv.pl" will try to convert files created by
these two scripts mentioned above into a new file. You may want to call
the script adding the option "-h" to get some help.

### 7.17.7. Files

You will find the perl scripts in `tools/downtimes`.

* * * * *

[Prev](downtime.md) | [Up](ch07.md) | [Next](embeddedperl.md)

7.16. Scheduled Downtime  |<=== [Index](index.md) ===>|  7.18. Using The Embedded Perl Interpreter

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
