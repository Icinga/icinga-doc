![Icinga](../images/logofullsize.png "Icinga")

9.4. MKLiveStatus Integration

[Prev](int-tcpwrappers.md) 

Chapter 9. Integration With Other Software

 [Next](reporting.md)

* * * * *

9.4. MKLiveStatus Integration
-----------------------------

9.4.1. [Introduction](int-mklivestatus.md#introduction)

9.4.2. [Installation /
Configuration](int-mklivestatus.md#installconfig)

### 9.4.1. Introduction

MKLiveStatus is a module written by Mathias Kettner interfacing Icinga
(or Nagios) with several addons like NagVis or Thruk. Unless you need a
database for storing historical data this might be a good choice because
it's quite small and easy to install. Please have a look at the
[official website](http://mathias-kettner.de/checkmk_livestatus.md)
for a complete documentation as the following lines are just a very
short guide on how to install and configure MKLiveStatus for Icinga. We
assume that you have installed Icinga in /usr/local/icinga.

### 9.4.2. Installation / Configuration

1.  Download the software and compile it (please check the website for
    the latest version)

    ~~~~ {.programlisting}
     wget http://mathias-kettner.de/download/mk-livestatus-1.2.4.tar.gz
     tar xzvf mk-livestatus-1.2.4.tar.gz
     cd mk-livestatus-1.2.4
     ./configure --prefix=/usr/local/icinga --exec-prefix=/usr/local/icinga
     make
     cp src/livestatus.o /usr/local/icinga/bin
    ~~~~

2.  Create a module definition in the `modules`{.filename} subdirectory:

    ~~~~ {.programlisting}
     define module{
            module_name    mklivestatus
            path           /usr/local/icinga/bin/livestatus.o
            module_type    neb
            args           /usr/local/icinga/var/rw/live
            }
    ~~~~

    Please make sure that the directory */usr/local/icinga/var/rw*
    exists and is writable for the Icinga user. It should be the same
    directory used for the command file (mostly
    `icinga.cmd`{.filename}). "live" is a socket and it will only be
    present during runtime of the module.

3.  Restart Icinga

    ~~~~ {.programlisting}
    service icinga restart
    ~~~~

    or

    ~~~~ {.programlisting}
    /etc/init.d/icinga restart
    ~~~~

4.  Check operation

    ~~~~ {.programlisting}
     ps -ef | grep livestatus
     ls -la /usr/local/icinga/var/rw/live
    ~~~~

    If there is no running process and/or no socket then please check
    the Icinga log file and resolve any errors.

* * * * *

  ------------------------------- -------------------- ----------------------------------------------------------------------
  [Prev](int-tcpwrappers.md)    [Up](ch09.md)       [Next](reporting.md)
  9.3. TCP Wrapper Integration    [Home](index.md)    9.5. Installation of the Icinga Reporting with JasperReports Server
  ------------------------------- -------------------- ----------------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
