[Prev](beginners.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](quickstart.md)

* * * * *

2.2. I'm a newbie to ...
------------------------

2.2.1. [Linux](newbie.md#newbie-linux)

2.2.2. [Mail](newbie.md#newbie-mail)

2.2.3. [SNMP](newbie.md#newbie-snmp)

2.2.4. [Packages](newbie.md#newbie-packages)

2.2.5. [Monitoring](newbie.md#newbie-monitoring)

2.2.6. [Help!](newbie.md#newbie-help)

Prior to computing a "newbie" was called "novice" and it began long
before you could walk. You managed that challenge and so there is no
reason to shy away now. The following sections contain some hints on
several topics. Please read them carefully if you feel to be a newbie to
any of them. We will point you here if we have the feeling that you are
lacking some basic knowledge ;-).

### 2.2.1. Linux

Quite a number of people are new to monitoring, and they are new to
Linux, too. They have been instructed to setup a monitoring system which
should monitor several hosts and some services on these devices. The
number itself is irrelevant because the first obstacle is the operating
system.

Especially young folks are accustomed to graphic user interfaces making
it easy to install software with a number of mouse clicks which sets
whatever values in a hive commonly known as "registry". Even server
operating systems have some kind of graphic user interfaces nowadays but
often enough it is necessary to issue commands from a text based console
nonetheless.

Please grab a good book on Linux basics from your local public library
to get an overview on the file layout and frequently used commands. Use
your browser if you don't like books but please don't ask such questions
in a monitoring forum (you wouldn't ask for instructions on how to find
one's feet if you are in a gym for the first time, would you?).

![[Note]](../images/note.png)

Note

The tempt to execute commands as "root" (a.k.a. "Administrator" on
Windows systems) is high but please try to avoid that because it can
leave your system unusable quite easily and there is noone asking
nagging questions ("Are you sure...?"). Due to the permissions of this
superuser you might not recognise (necessary) limitations of the user
normally used to execute monitoring tasks resulting in statements such
"it already worked" (and it didn't, if you look closer).

### 2.2.2. Mail

In most cases you want to send messages if monitored objects fail or
recover instead of just watching the user interface. This might work on
your local system (the monitoring server) but sending mails to other
systems requires you to advise your local post office where to send them
(a method called "relaying"). Modern systems have security settings
rejecting (at best) or just ignoring unwanted mails so you have to
instruct the receiving post office to actually accept and relay mails
coming from your local post office.









### 2.2.3. SNMP

"SNMP exposes management data in the form of variables on the managed
systems, which describe the system configuration. These variables can
then be queried (and sometimes set) by managing applications." ([Excerpt
from Wikipedia](http://en.wikipedia.org/wiki/SNMP)).

The information is placed in a tree structure. Each node/leaf has a
unique "OID" (object identifier).

Using the check\_snmp plugin from the [Monitoring
Plugins](&url-monitoring-plugins;) package you can retrieve data from
managed systems. Please make sure that the target system has a running
SNMP daemon which is configured to respond to queries from you
monitoring server. Executing something like
`snmpwalk -v1 -c public -On target_system system` should be
used to verify that.

You can specify OIDs in a more human readable way or using numbers only.
The latter eliminates the need to read MIBs, is faster and less error
prone.

### 2.2.4. Packages

Please use packages to install the necessary software wherever possible.
monitoring you very seldomly need a feature introduced in the most
current git snapshot. "Leading edge" can result in "bleeding edge" very
quickly and having enough trouble getting the product up and running
with a limited knowledge of all the relations you don't need this kind
of problems and hence should stick to a stable version. Please take a
look
[here](icinga_packages.md "2.8. Icinga Packages for Linux Distributions"),
too.

### 2.2.5. Monitoring

"Monitoring" means getting information from other systems. Make sure
that you are permitted to access these other systems by asking the
people who are administrating these systems if you are allowed to do so.
Probing ports and things alike might be considered an attack! If there
are firewalls or other means of restricting access then ask for
appropriate rules/exceptions to be defined.

![[Note]](../images/note.png)

Note

Depending on data protection policies you may not be allowed to access
workstations or other systems where individuals work or the extent of
monitoring may be restricted. Make sure to get written permission
*before* you start monitoring.

### 2.2.6. Help!

Monitoring is a complex field and even if you have a solid knowledge of
your operating system questions may arise earlier than you expected. Use
your favourite search engine. Somebody else might have had the same
problem and probably there is a solution already. If not then there are
a lot of forums out there. Please select one fitting to your problem.
Questions related to your monitoring are best answered by folks
specialised on that topic and operating system questions are better
placed elsewhere.

The community is ready to help but you are the only one viewing the
problem so please ...









The more (precise) information you give the higher is the chance that
you get answers enabling you to solve the problem. Otherwise you might
lose valuable time because you are asked to provide information you
should have given the first time.

Be patient. The reaction time on threads containing "urgent" or similar
expressions tends to be reciprocal. Forums are mostly non-profit
platforms and folks answering do that in their spare time.

Please avoid [crossposting](http://en.wikipedia.org/wiki/Crossposting)
(asking the same question at the same time at different places).

* * * * *

[Prev](beginners.md) | [Up](ch02.md) | [Next](quickstart.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
