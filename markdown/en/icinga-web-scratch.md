[Prev](cgicmd.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](upgrading_icingaweb.md)

* * * * *

6.5. Installation of the Icinga Web Frontend
--------------------------------------------

6.5.1. [Introduction](icinga-web-scratch.md#introduction)

6.5.2. [Prerequisites](icinga-web-scratch.md#prerequisites)

6.5.3. [The installation](icinga-web-scratch.md#install)

6.5.4. [Settings](icinga-web-scratch.md#settings)

6.5.5. [Use It!](icinga-web-scratch.md#useit)

6.5.6. [Test & Errors?](icinga-web-scratch.md#webtroubleshooting)

### 6.5.1. Introduction

The new Icinga Web is under heavy development so please keep in mind
that some information in this howto might change without any further
notice. If you require more detailed information about installing,
please check doc/INSTALL.

More information about the overall architecture can be found on our
website:
[https://www.icinga.org/architecture/](http://www.icinga.org/architecture/).
If you want know more about Icinga web development and the module
architecture, please check out the development wiki of Icinga Web:
[Icinga
Wiki](https://dev.icinga.org/projects/icinga-development/wiki#24-Icinga-Web)

This installation guide describes the installation of Icinga Web with
MySQL or PostgreSQL as underlying database. Icinga Web also supports
Oracle as database backend.

### 6.5.2. Prerequisites










































### 6.5.3. The installation








































































































### 6.5.4. Settings

There are two different sections:

\* Settings of Icinga Web, especially database settings

\* Settings of the Icinga API which is mandatory as data source




































































### 6.5.5. Use It!

**Please ensure that your RDBMS, Apache, IDOUtils and Icinga are
running!**

Go to the webpath (http://localhost/icinga-web/) and check if the
webinterface starts without exceptions (database connections web and
api). You can login with user 'root' and password 'password'.

Have fun! :-)

### 6.5.6. Test & Errors?

![[Note]](../images/note.png)

Note

The following section tries to give some hints on common problems but
due to the nature of "written" material the [wiki
page](https://wiki.icinga.org/display/testing/Icinga+Web+Testing) will
most probably be more current than this manual so if you don't find a
solution here then have a look over there.

The following collection shows some useful information how to resolve
mailing lists or http://www.icinga-portal.org:




Where to look?




Use /path/to/clearcache.sh

</code></pre> 
#> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

Icinga Web shows a blank page?









Icinga Web does not show any data?


IDOUtils DB does not get filled with data?





**Testing the Web (make sure PHPUnit is installed):**

</code></pre> 
 $> make test
</code></pre>

![[Note]](../images/note.png)

Note

If you are using your root account for testing then make sure in advance
that the specified web user has a valid shell. Otherwise some tests
might fail. Depending on the version used you might experience wrong
permissions on `/usr/local/icinga-web/log` resulting in
Icinga-Web showing "loading" coming to no end!

![[Note]](../images/note.png)

Note

Apache reload/restart!

















If you have any updates on that please do not hesitate to report back!
:-)

* * * * *

[Prev](cgicmd.md) | [Up](ch06.md) | [Next](upgrading_icingaweb.md)

6.4. Executing Classic UI modules (CGIs) on the command line  |<=== [Index](index.md)    ===>|  6.6. Upgrading Icinga Web and Icinga Web Database

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
