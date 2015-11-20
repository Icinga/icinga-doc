[Prev](ch02.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](newbie.md)

* * * * *

2.1. Advice for beginners
-------------------------

2.1.1. [Icinga Overview](beginners.md#icinga-overview)

2.1.2. [Icinga web GUI comparison](beginners.md#icinga_gui_comparison)

Thanks for choosing Icinga! Icinga is quite powerful and flexible and
although you can see the first results in less than 30 minutes, this is
just the beginning of your journey into system monitoring. Configuring
it to your needs can take a lot of work depending on the number of
things to be monitored and the complexity of your environment. Once you
become familiar with how it works and what it can do for you, you'll
never want to be without it. :-) Here are some important things to keep
in mind for first-time Icinga users:







![[Note]](../images/note.png)

Note

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

### 2.1.1. Icinga Overview

**Overview**

This section should give you a short overview on what is included and
what isn't.

![[Note]](../images/note.png)

Note

The information is incomplete but we're working on that. The git-branch
"`next`" might be more up-to-date than this documentation.

Icinga consists of a core processing results from checks which are
initiated by the core ([active
checks](activechecks.md "5.6. Active Checks")), or delivered from
other machines ([passive
checks](passivechecks.md "5.7. Passive Checks")), deciding if
[notifications](notifications.md "5.11. Notifications") have to be
sent, providing information by writing log files and showing it via a
[web
interface](cgis.md "6.1. Icinga Classic UI: Information On The Modules"),
and several other tasks.

The core does *not* contain any checks itself but they are executed by
[plugins](plugins.md "5.1. Icinga Plugins") instead. Notifying
[contacts](objectdefinitions.md#objectdefinitions-contact) is done by
methods provided by the operating system (i.e. sendmail/postfix/...,
sms, pager).

![[Note]](../images/note.png)

Note

Installation and configuration of plugins, addons, and os related
software is mostly beyond the scope of this documentation so please
consult the documentation provided by the manufacturer first, use your
favourite search engine if that doesn't help, and seek help in forums.
Consulting instructions from blogs or other personal stuff you will
often find information that is outdated or doesn't fit your environment
so try to avoid such sources.

Extending the functionality can be accomplished by installing
[addons](addons.md "10.1. Icinga Addons"). There you will find hints
on web-based configuration tools, alternative web interfaces, presenting
performance data, notifying contacts, and more.

The configuration is based on text files and managing them requires just
a text editor like vi.
[Inheritance](objectinheritance.md "7.26. Object Inheritance") using
templates simplifies defining objects because it enables you to reduce
the definition to a minimum.

Accessing the information can be done via the cgi-based classic ui, the
Icinga Web ui, or several other interfaces like mentioned in
[addons](addons.md "10.1. Icinga Addons") as well.

### 2.1.2. Icinga web GUI comparison

2.1.2.1. [Icinga Classic Web](beginners.md#idp177792)

2.1.2.2. [Icinga New Web](beginners.md#idp223952)

Icinga offers two web interfaces for users to view Icinga monitoring
results and send commands to the Icinga Core. In both Icinga New and
Classic Web, host and service status, history, notifications and status
maps are available to keep a check on the health of your network in
real-time. Both also support IPv4 as well as IPv6 addresses.

#### 2.1.2.1. Icinga Classic Web

Traditional in look and feel, this is Icinga’s interface for those who
like the familiar single window format as in Nagios, combined with cool
enhancements











Because Icinga Classic Web receives continuous development, you can rest
assured that any addons you are accustomed to use with Nagios can be
used with Icinga too.

Table 2.1. Screenshots Icinga classic web


Tactical Overview


Host Groups


Service Status


Commands


CGI Config


Downtimes


Date Picker


Paginated Logs


Trending

#### 2.1.2.2. Icinga New Web

Dynamic and user-friendly, this is Icinga’s Agavi based, Ajax driven,
Web 2.0 inspired frontend.

![[Note]](../images/note.png)

Note

Icinga Web needs a database to operate. So far MySQL, PostgreSQL, and
Oracle are supported.













Table 2.2. Screenshots Icinga new web


Portal View


Tactical Overview


Open Problems


Host Status Events


Host filtered


Downtimes


Search


Commands


Reporting


Business Process


Log Viewer


User Admin


Cronk Builder


Cronk Configuration


Status Map

* * * * *

[Prev](ch02.md) | [Up](ch02.md) | [Next](newbie.md)

Chapter 2. Getting Started  |<=== [Index](index.md) ===>|  2.2. I'm a newbie to ...

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
