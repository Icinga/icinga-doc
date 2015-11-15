![Icinga](../images/logofullsize.png "Icinga")

1.2. What's New in Icinga 1.13

[Zurück](about.md) 

Kapitel 1. Über

 [Weiter](ch02.md)

* * * * *

1.2. What's New in Icinga 1.13
------------------------------

1.2.1. [CHANGES](whatsnew.md#whatsnew-changes)

1.2.2. [Core](whatsnew.md#whatsnew-core)

1.2.3. [Classic UI](whatsnew.md#whatsnew-classicui)

1.2.4. [IDOutils](whatsnew.md#whatsnew-idoutils)

1.2.5. [Icinga-Web](whatsnew.md#whatsnew-web)

1.2.6. [Docs](whatsnew.md#docs)

1.2.7. [More information](whatsnew.md#moreinfo)

As usual this is only a brief overview. Please take a look at the
[Changelog](whatsnew.md#moreinfo "1.2.7. More information") as well if
you are missing something.

### 1.2.1. CHANGES

-   Releases are now hosted at
    [GitHub](https://www.icinga.org/download)!

-   Mailinglists have been migrated to
    [lists.icinga.org](https://www.icinga.org/support)!

-   docs: rename nagios plugins to monitoring plugins \#5460

-   classic ui: fix vulnerability against CSRF attacks CVE-2013-7107
    \#5346 requires HTTP\_REFFERER on the cmd line

-   idoutils: dump customvariable status by default (restore feature for
    icinga web (2)) \#5732

-   Icinga Web 1.11 requires IDO schema version \>= 1.11

### 1.2.2. Core

-   Added commands for {en,dis}able freshness checks per host/service
    (thanks Philip Matuskiewicz) \#5422 \#4430

-   Added state history entries for newly added services (check result
    with OK state) \#3854

-   Added option to make external command user in Icinga log anonymous
    \#5689

-   Allow exclude (!) to work for regexp matches for hosts (thanks
    Franky Van Liedekerke) \#5324

-   Fixed passive check result processing for host checks (Marco Hoyer)
    \#5671

-   Accept service escalations without host mapping (Tomas Dubec) \#5697

### 1.2.3. Classic UI

-   Added status.cgi modifed\_attributes filter parameter \#4880

-   Added "current\_notification\_number" to JSON output of hosts and
    services in status.cgi \#5370

-   Added group notes and action URL links to status summary, overview
    and grid \#5301

-   Integrated a range of logos \#4057

-   Added support for gzip compressed logs \#4519

-   Time picker no longer resets time in input field \#5239

### 1.2.4. IDOutils

-   ido2db should check database schema on start up, and bail early on
    errors \#5272

-   Wait for child processes on exit preventing zombies (Laurent
    Bigonville) \#4427

-   Fixed errors in oracle.sql with timed event sequences \#5688

-   Fixed SEGV in ido2db and idomod syslog call in Solaris - \#5687,
    \#5686

-   Allow agent\_version to store more than 16 chars \#5731

### 1.2.5. Icinga-Web

-   Timezone handling has been fixed for duration and command fields.
    \#5713

-   Added reload progress bar (Immobilienscout24) \#5098 \#5107

-   Expanded macros in action\_url and notes\_url \#1882

-   Added jump links to host and service status from performance view -
    \#4984

-   ExtJS framework has been updated to 3.4.1.1 \#5620

### 1.2.6. Docs

-   Define SELinux contexts rather than using chcon command \#3555

-   explain "Check results for service x on host y are stale by 0d 0h 0m
    10s (threshold=0d 0h 10m 0s). Forcing an immediate check of the
    service..." \#5252

-   addons: suggest nsca-ng as nsca alternative \#5253

-   rename nagios plugins to monitoring plugins \#5460

-   icinga web rest api updates \#4970

-   clean mysql creation commands \#5426

-   replace sourceforge download links with github releases \#5429

### 1.2.7. More information

[More at Icinga Wiki](https://wiki.icinga.org/display/Dev/Changelogs)

Should you find any issues, please report them to one of the following
links:

[Report Issue Icinga
Core](https://dev.icinga.org/projects/show/icinga-core)

[Report Issue Icinga
Web](https://dev.icinga.org/projects/show/icinga-web)

[Report Issue Icinga
Reporting](https://dev.icinga.org/projects/show/icinga-reporting)

[Report Issue Icinga
Docs](https://dev.icinga.org/projects/show/icinga-docs)

* * * * *

  ----------------------- -------------------------- ------------------------
  [Zurück](about.md)    [Nach oben](ch01.md)      [Weiter](ch02.md)
  1.1. Über Icinga        [Zum Anfang](index.md)    Kapitel 2. Los geht's
  ----------------------- -------------------------- ------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
