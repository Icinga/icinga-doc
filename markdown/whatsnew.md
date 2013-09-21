What's New in NAME-ICINGA VER-ICINGA
====================================

As usual this is only a brief overview. Please take a look at the
[Changelog](#moreinfo) as well if you are missing something.

What's new in NAME-ICINGA
CHANGES
-------

-   IDOUtils: ido2db.cfg enable\_sla is now deprecated! \#3450

-   Icinga-Web: tackle cronk is now deprecated

Core
----

-   increase core performance on config read with hash compare \#3722

-   keep logfile open, reduce open/close performance decreases \#3390

-   enhance performance on illegal macro and host-service relation
    processing \#3389 \#3820

-   add skipping of status.dat/objects.cache write by setting to
    /dev/null \#3819

-   fix host\_check last\_check == next\_check wrong in scheduling queue
    \#2195

-   fix triggered downtimes for child hosts are missing after restart
    \#3390

-   fix unable to exclude hostgroups when using nested hostgroups \#2619

Classic UI
----------

-   increase performance with hash compare on host/service show/filter
    \#3722

-   add date/time selector to logfile navigation \#3168

-   classicui can be installed standalone (icinga2 compat) \#3869

-   add config options for acknowledgement notifications and expiry
    \#3467 \#3476

-   add 'executed command' to extinfo.cfg linking to command expander
    \#3901

-   add process status to json response \#3172

-   add lighttp config examples \#2253

IDOutils
--------

-   use transactions for large object dumps \#3527

-   add socket queue proxy (reduce core reload time significanlty)
    \#3533

-   oracle: change output columns to clob \#3412

-   fix memory leaks in idomod/ido2db \#3749

-   add workaround fix for num\_rows\_affected broken in libdbi/mariadb,
    returned ids are 0 \#3728

Icinga-Web
----------

-   Revamped credential system, better grouping of permissions and
    performance \#3715

-   New and smaller Cronk menu design, showing the cronks as a list
    \#3396

-   New filtering window which allows detailed and combined filters
    \#3268

-   Many small interface improvements \#3511 \#3430 \#3896

-   New Apache configuration, making the .htaccess files obsolete \#2759

-   Search in admin user- / group dialog \#3909

-   PENDING are now shown for any new host or service in the database
    \#2602 \#3844

Icinga-Reporting
----------------

-   add AvailReportParser into contrib/ (standalone) \#3978

-   reorganize directory structure \#3742

-   fixed image expression in pnp4nagios template \#3693

-   fixed state replacement in morning report \#3752

-   fixed rounding error with small numbers \#3942

Docs
----

-   add upgrade/troubleshooting notes about invisible icinga web
    cronks/modules after upgrade \#3939

-   make install-webconf-auth installs htpasswd.user with icingaadmin
    credentials \#3964

-   icinga web 1.9: new menu style (smaller icons) \#3944

-   icinga web 1.9: new filtering methods \#3947

-   add userpreferences.xml to icinga web configs \#3991

-   add web gui comparison to beginners \#3907

-   middle-clicking on TOC links doesn't open pages in new tab \#3561

More information
----------------

[More at Icinga Wiki](https://wiki.icinga.org/display/Dev/Changelogs)

Should you find any issues, please report them to one of the following
links:

[Report Issue
NAME-CORE](https://dev.icinga.org/projects/show/icinga-core)

[Report Issue NAME-WEB](https://dev.icinga.org/projects/show/icinga-web)

[Report Issue
NAME-REP](https://dev.icinga.org/projects/show/icinga-reporting)

[Report Issue
NAME-DOCS](https://dev.icinga.org/projects/show/icinga-docs)
