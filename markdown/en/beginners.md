![Icinga](../images/logofullsize.png "Icinga")

2.1. Advice for beginners

[Prev](ch02.md) 

Chapter 2. Getting Started

 [Next](newbie.md)

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

1.  **Relax - it's going to take some time.** Don't expect to be able to
    get things working exactly the way you want them right off the bat.
    It's not that easy. Setting up Icinga can involve a bit of work -
    partly because of the options that Icinga offers, partly because you
    need to know what to monitor on your network (and how best to do
    it).

2.  **Use package instead of source install.** Meanwhile you will find
    packages for the most important distributions. Please consider using
    one of them instead of installing from source. It will save you some
    time. Please keep in mind that the paths differ from the ones
    mentioned in this documentation. For a detailed list of package
    specific locations, check [wiki
    page](https://wiki.icinga.org/display/howtos/Package+Specific+Locations).
    For information on packages please take a look
    [here](icinga_packages.md "2.8. Icinga Packages for Linux Distributions").

3.  **Use the Quickstart guides.** If you don't find a package or don't
    want to use if for whatever reason then please use the
    [quickstart](quickstart.md "2.3. Quickstart Installation Guides")
    instructions. The quickstart installation guide is designed to get
    most new users up and running with a basic Icinga setup fairly
    quickly. Within 20 minutes you can have Icinga installed and
    monitoring your local system. Once that's complete, you can move on
    to learning how to configure Icinga to do more.

4.  **Read the documentation.** Icinga can be tricky to configure when
    you've got a good grasp of what's going on, and nearly impossible if
    you don't. Make sure you read the documentation (particularly the
    sections on ["Configuring
    Icinga"](ch03.md "Chapter 3. Configuring Icinga") and ["The
    Basics"](ch05.md "Chapter 5. The Basics")). It is important to
    know how [plugins](plugins.md "5.1. Icinga Plugins") work. Take a
    look at the [monitoring
    overview](monitoring-overview.md#monitoring_overview) as well.
    Save the [advanced topics](ch06.md "Chapter 6. User Interfaces")
    for when you've got a good understanding of the basics.

5.  **Understand the architecture.** Icinga Core ships with two GUIs,
    Icinga Classic UI and Icinga Web. Icinga Classic UI uses the native
    status and log file format, while Icinga Web requires IDOUtils with
    a database backend. Both GUIs can co-exist on the same host below
    /icinga and /icinga-web. The IDOUtils database is also a requirement
    for Icinga Reporting based on JasperReports Server which can be
    integrated into Icinga Web as cronk. Check [IDOUtils
    chapter](ch12.md "Chapter 12. IDOUtils") for details on the
    IDOUtils components involved.
    [Plugins](plugins.md "5.1. Icinga Plugins") are essential to your
    checks, as well as
    [addons](ch10.md "Chapter 10. Additional software") may enhance
    your setup.

6.  **Seek the help of others.** If you've read the documentation,
    reviewed the sample config files, and are still having problems,
    send an email message describing your problems to the icinga-users
    mailing list. If you've done some background reading and you provide
    a good problem description, odds are that someone will give you some
    pointers on getting things working properly. "good description"
    means to include details on your operating system, the version of
    Icinga, as well as what you tried and the results of it (preferably
    copy&paste). More information on subscribing to the mailing lists or
    searching the list archives can be found at
    [https://support.icinga.org](http://www.icinga.org/support/).
    Another source of information is the [how to wiki
    section](https://wiki.icinga.org/display/howtos/Home).

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
"`next`{.uri}" might be more up-to-date than this documentation.

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

-   JSON output for accelerated data access

-   CSV export on CGIs to aid addon development

-   Log file search with filters, regular expressions and wildcard
    capabilities

-   Host search with wildcard capabilities

-   Compound commands to send to multiple hosts/services simultaneously

-   Dependencies displayed in host/service details

-   Config command expander integrated for frontend access

-   Tactical overview header to keep an eye on the most important
    details in every window

-   CGI Config Options to view user authorisations

-   Modified Attributes to see host and service configurations compared
    against the latest attributes applied in the front end

Because Icinga Classic Web receives continuous development, you can rest
assured that any addons you are accustomed to use with Nagios can be
used with Icinga too.

Table 2.1. Screenshots Icinga classic web

  ----------------------------------------------------
  ![](../images/Icinga_Classic_TacticalOverview.png)
  ----------------------------------------------------

Tactical Overview

  ---------------------------------------------
  ![](../images/Icinga_Classic_HostGroup.png)
  ---------------------------------------------

Host Groups

  -------------------------------------------------
  ![](../images/Icinga_Classic_ServiceStatus.png)
  -------------------------------------------------

Service Status

  --------------------------------------------
  ![](../images/Icinga_Classic_Commands.png)
  --------------------------------------------

Commands

  ---------------------------------------------
  ![](../images/Icinga_Classic_CGIConfig.png)
  ---------------------------------------------

CGI Config

  ---------------------------------------------
  ![](../images/Icinga_Classic_Downtimes.png)
  ---------------------------------------------

Downtimes

  ----------------------------------------------
  ![](../images/Icinga_Classic_DatePicker.png)
  ----------------------------------------------

Date Picker

  --------------------------------------------------
  ![](../images/Icinga_Classic_PaginationLogs.png)
  --------------------------------------------------

Paginated Logs

  --------------------------------------------
  ![](../images/Icinga_Classic_Trending.png)
  --------------------------------------------

Trending

#### 2.1.2.2. Icinga New Web

Dynamic and user-friendly, this is Icinga’s Agavi based, Ajax driven,
Web 2.0 inspired frontend.

![[Note]](../images/note.png)

Note

Icinga Web needs a database to operate. So far MySQL, PostgreSQL, and
Oracle are supported.

-   **View your monitoring as you like it**

    Icinga New Web displays real-time status data in a configurable
    spreadsheet, so you can:

    -   Sort and group data by columns (eg. host or status)

    -   Filter data in detail (eg. HTTP services which are not OK)

    -   Send commands simultaneously to multiple hosts/services by
        checking boxes

    -   View host or service details and history in the same window

-   **Search with Ajax ease**

    The powerful Ajax search tool allows you to type in the first few
    letters of a string, to choose from results listed by host, service
    or group complete with colour-coded status. Needless to say, the
    tool only displays results which meet your user rights and
    permissions – ideal for the larger enterprise.

-   **Customize-a-Cronk ‘n’ Dashboard**

    A library of Cronks (widgets) offer various views which can be
    dragged and dropped around the screen, customized, minimized,
    resized and categorized. As changes are persistent, you can come
    back to your tailored Cronk or arrangement of Cronks in the panels
    and tabs of your personal dashboard.

-   **Manage user rights meticulously**

    Beyond the standard contact group restriction, user settings can be
    individualized to limit access to certain host or service groups,
    remove the ability to send commands and even limit the display of
    custom variables such as specific hosts or services. All from the
    front end. With LDAP and Active Directory support, Icinga New Web
    also makes life easier for larger enterprises.

Table 2.2. Screenshots Icinga new web

  --------------------------------------
  ![](../images/IcingaWeb_Portal2.png)
  --------------------------------------

Portal View

  -----------------------------------------------
  ![](../images/IcingaWeb_TacticalOverview.png)
  -----------------------------------------------

Tactical Overview

  -------------------------------------------
  ![](../images/IcingaWeb_OpenProblems.png)
  -------------------------------------------

Open Problems

  ------------------------------------------------
  ![](../images/IcingaWeb_HostStatus_Events.png)
  ------------------------------------------------

Host Status Events

  --------------------------------------------
  ![](../images/IcingaWeb_Host_filtered.png)
  --------------------------------------------

Host filtered

  ----------------------------------------
  ![](../images/IcingaWeb_Downtimes.png)
  ----------------------------------------

Downtimes

  -------------------------------------
  ![](../images/IcingaWeb_Search.png)
  -------------------------------------

Search

  ---------------------------------------
  ![](../images/IcingaWeb_Commands.png)
  ---------------------------------------

Commands

  ----------------------------------------
  ![](../images/IcingaWeb_Reporting.png)
  ----------------------------------------

Reporting

  ----------------------------------------------
  ![](../images/IcingaWeb_BusinessProcess.png)
  ----------------------------------------------

Business Process

  ----------------------------------------
  ![](../images/IcingaWeb_LogViewer.png)
  ----------------------------------------

Log Viewer

  ----------------------------------------
  ![](../images/IcingaWeb_UserAdmin.png)
  ----------------------------------------

User Admin

  -------------------------------------------
  ![](../images/IcingaWeb_CronkBuilder.png)
  -------------------------------------------

Cronk Builder

  --------------------------------------------------
  ![](../images/IcingaWeb_Cronk_Configuration.png)
  --------------------------------------------------

Cronk Configuration

  ----------------------------------------
  ![](../images/IcingaWeb_StatusMap.png)
  ----------------------------------------

Status Map

* * * * *

  ----------------------------- -------------------- ---------------------------
  [Prev](ch02.md)             [Up](ch02.md)       [Next](newbie.md)
  Chapter 2. Getting Started    [Home](index.md)    2.2. I'm a newbie to ...
  ----------------------------- -------------------- ---------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
