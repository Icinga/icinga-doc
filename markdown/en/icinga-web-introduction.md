![Icinga](../images/logofullsize.png "Icinga")

6.8. Introduction to Icinga Web

[Prev](icinga-web-config.md) 

Chapter 6. User Interfaces

 [Next](icinga-web-pnp.md)

* * * * *

6.8. Introduction to Icinga Web
-------------------------------

6.8.1. [Introduction to Icinga Web (\>=
1.13)](icinga-web-introduction.md#icinga-web-intro)

**Overview**

This introduction takes you on a short tour showing some aspects of
Icinga Web. It is not complete so there will be things which aren't
covered. We're working on this.

Due to constant development some things change over time resulting in
different appearance and additional options. Please have a look at the
current [version
1.10](icinga-web-introduction.md#icinga-web-intro "6.8.1. Introduction to Icinga Web (>= 1.13)").

### 6.8.1. Introduction to Icinga Web (\>= 1.13)

If you followed the quickstart guides
([IDOUtils](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")
and [Icinga
Web](icinga-web-scratch.md "6.5. Installation of the Icinga Web Frontend"))
then please open your browser and enter http://\<icinga
server\>/icinga-web. You will get the login screen

**Figure 6.2. Icinga Web login screen**

![Icinga Web login screen](../images/icinga-web-login.png)

\

You should be able to login using "root" and "password". This will take
you to an overview page showing the state of the hosts and services
being monitored

**Figure 6.3. Icinga Web overview**

![Icinga Web overview](../images/icinga-web-overview.png)

\

*Top menu*

The top menu consists of general information about Icinga and the
[administration](icinga-web-introduction.md#web-intro-admin) items for
users, groups, logs, and tasks. The live-search is accessible using the
field next to the magnifying glass. On the top right, you can see the
user currently logged in and edit its preferences or log out of Icinga
Web.

**Figure 6.4. Icinga Web top menu**

![Icinga Web top menu](../images/icinga-web-topmenu1.png)

\

*Search*

The search form shows results while typing. The results will be shown in
a separate inlay window. By clicking/selecting the results, a new tab in
the main view opens with more information. The search starts at the
beginning of the string but you can use wildcards as well.

**Figure 6.5. Icinga Web live search**

![Icinga Web live search](../images/icinga-web-search1.png)

\

*Status Cronk*

The status cronk shows host and service counters for their respective
states. If count is zero, the colour remains grey. Clicking on states
opens a new tab in the main view showing the selected state only. Next
to that, the number and state of the Icinga instances is shown. In the
remaining space general process information is provided, just as

-   Hosts|Services (active/passive)

-   Host|Service execution time (min/avg/max)

-   Host|Services latency (min/avg/max)

**Figure 6.6. Icinga Web status cronk**

![Icinga Web status cronk](../images/icinga-web-statuscronk.png)

\

*Left menu*

-   In the left (also hideable) menu you can select among different
    widgets (we call them "cronks"). You can either doubleclick on each
    cronk or drag it with the cursor into the main view. The categories
    are separated into

    **Figure 6.7. Icinga Web data cronks**

    ![Icinga Web data cronks](../images/icinga-web-cronks1.png)

    \

-   "Tactical Overview" keeps general charts and customized ones (custom
    variables)

    **Figure 6.8. Icinga Web tactical overview cronks**

    ![Icinga Web tactical overview
    cronks](../images/icinga-web-cronks2.png)

    \

-   "Reporting" enables to create reports

    **Figure 6.9. Icinga Web reporting cronk**

    ![Icinga Web reporting cronk](../images/icinga-web-cronks3.png)

    \

-   "Misc" contains several useful cronks, just as iframes for external
    websites or the 1,2,3 columns for main view and links to the
    documentation.

    **Figure 6.10. Icinga Web misc cronks**

    ![Icinga Web misc cronks](../images/icinga-web-cronks4.png)

    \

Within the settings menu, you can switch back to the old view with the
bigger icons. Within `userpreferences.xml`{.filename} config file you
may set a global default value.

**Figure 6.11. Icinga Web Cronk Menu Style Change**

![Icinga Web Cronk Menu Style
Change](../images/icinga-web-cronks-settings.png)

\

*Main Screen*

This is where everything comes together: You can drag and drop new
windows over here resulting in a new opened tab. The views are
customizable for the current user (they remain persistent) by dragging
the column heading to the new place. Rightclicking on the heading allows
to change the sort order or to hide columns.

**Figure 6.12. Icinga Web main screen**

![Icinga Web main screen](../images/icinga-web-mainscreen.png)

\

*Host Status*

The HostStatus view shows the host status and below the number of
warnings/critical of the services attached to the host.

**Figure 6.13. Icinga Web host status**

![Icinga Web host status](../images/icinga-web-host.png)

\

Use the expanded view to change to ServiceStatus- view for this host, to
look for history informations or to locate the host in statusmap. If you
use PNP4Nagios you can also switch to the performance data.

On the left you will see the expander icon. Clicking on it will open a
bar below the icon.

**Figure 6.14. Expander icon / icon bar**

![Expander icon / icon bar](../images/icinga-web-exp_2.png)

\

Right-clicking on any of the new icons and selecting "Move into grid"
will move the appropriate icon into the grid.

**Figure 6.15. Move icon into grid**

![Move icon into grid](../images/icinga-web-exp_3.png)

\

Selecting the new icon opens a small window or it will create a new tab
showing the desired information.

**Figure 6.16. Icinga Web New icons in grid**

![Icinga Web New icons in grid](../images/icinga-web-exp_4.png)

\

Clicking on "Setting" and selecting "Reset grid action icons" will
remove the inserted icons restoring the default view.

**Figure 6.17. Icinga Web Reset icon view**

![Icinga Web Reset icon view](../images/icinga-web-exp_5.png)

\

*Host Object Informations*

Use **Details** to see more detailed object informations like status,
relations and external references.

**Figure 6.18. Icinga Web host object information**

![Icinga Web host object information](../images/icinga-web-host-obj.png)

\

*Service Status*

The ServiceStatus view shows all services for each host.

**Figure 6.19. Icinga Web service status**

![Icinga Web service status](../images/icinga-web-srv.png)

\

*Service Object Informations*

Use the expanded view to look at the service object and history
informations, the host object informations or to change to HostStatus
view.

**Figure 6.20. Icinga Web service object Information**

![Icinga Web service object
Information](../images/icinga-web-srv_obj.png)

\

*Hostgroup Status*

The hostgroup view will show the status and the number of hosts grouped
by hostgroup.

**Figure 6.21. Icinga Web hostgroup status**

![Icinga Web hostgroup status](../images/icinga-web-hostgroup.png)

\

*Log*

The log view shows the log messages.

**Figure 6.22. Icinga Web log**

![Icinga Web log](../images/icinga-web-log.png)

\

**Cronks and Views**

Icinga Web allows to open different cronks in order to view data, set
filters for different views, send commands. The following list
summarizes the possibilities in general (several cronks can provide
more, like sending commands).

**Figure 6.23. Icinga Web cronk bar**

![Icinga Web cronk bar](../images/icinga-web-main_bar.png)

\

-   Manual Refresh

-   Settings

    Enable/Disable Auto-Refresh

    Get this \<item\> by url

**Figure 6.24. Icinga Web cronk bar**

![Icinga Web cronk bar](../images/icinga-web-settings.png)

\

-   Filter

    Modify/Remove

*Commands*

There are different commands available (check the chapter [External
Commands](extcommands.md "7.1. External Commands") for more
information on commands). Select the items which should be affected and
then select the command to be executed.

Host Commands

**Figure 6.25. Icinga Web host commands**

![Icinga Web host commands](../images/icinga-web-commands_hst.png)

\

Service Commands

**Figure 6.26. Icinga Web service commands**

![Icinga Web service commands](../images/icinga-web-commands_svc.png)

\

*Filters*

Icinga Web allows to set filters and create customized views which can
be saved as own persistent cronks, too. First, select "View Filter". On
the left side on top of the cronk menu, you'll see the attributes and
condition to select at the bottom. At the top the current selected
filter is shown.

**Figure 6.27. Icinga Web filter restriction**

![Icinga Web filter restriction](../images/icinga-web-filter1.png)

\

Afterwards, specify on which condition the filter should match by moving
the conditions and selected attributes using drag and drop.

drag filters

**Figure 6.28. Icinga Web drag filters**

![Icinga Web drag filters](../images/icinga-web-filter2.png)

\

drop filters

**Figure 6.29. Icinga Web drop filters**

![Icinga Web drop filters](../images/icinga-web-filter3.png)

\

Once you have dropped an attribute filter onto a condition, you can
specify its values (depending on the attribute, the screenshot shows
only the state selection). Click "Add filter" when done.

**Figure 6.30. Icinga Web filter attribute selection**

![Icinga Web filter attribute
selection](../images/icinga-web-filter4.png)

\

The active filter now shows only the filtered entries.

**Figure 6.31. Icinga Web filter active**

![Icinga Web filter active](../images/icinga-web-filter5.png)

\

You can combine multiple filters of the same type at once, as well as
combine conditions. The example below shows an OR condition for the
filter on critical and warning states.

**Figure 6.32. Icinga Web filter advanced filters**

![Icinga Web filter advanced filters](../images/icinga-web-filter6.png)

\

****

**Administration**

Enter the administration panel by selecting "Admin" from the top menu,
and select "Users", "Groups", "Logs", or "Tasks".

**Figure 6.33. Icinga Web top menu admin**

![Icinga Web top menu admin](../images/icinga-web-topmenu2.png)

\

*Users*

You can add, remove and edit users. You can also search for users.

**Figure 6.34. Icinga Web user admin**

![Icinga Web user admin](../images/icinga-web-admin_users1.png)

\

Doubleclick a user to open a new inlay window which lets you edit very
detailed options. The same options apply when adding a new user. You can
modify the size by dragging the cursor in the corners.

-   General information

-   Change password (and optional AuthKey for API)

-   Permissions e.g. which group membership

-   Principals for special roles

**Figure 6.35. Icinga Web edit user**

![Icinga Web edit user](../images/icinga-web-admin_users2.png)

\

*Roles*

You can add, remove and edit roles. You can also modify role inheritance
within the group tree in the lower half. You can also search for groups.

**Figure 6.36. Icinga Web group admin**

![Icinga Web group admin](../images/icinga-web-admin_groups1.png)

\

Doubleclick a role to activate the window on the right side which lets
you edit very detailed options (see below). The same options apply when
adding a new role. You can modify the size by dragging the cursor in the
corners.

**Figure 6.37. Icinga Web groups**

![Icinga Web groups](../images/icinga-web-admin_groups2.png)

\

![[Note]](../images/note.png)

Note

Please visit the
[wiki](https://wiki.icinga.org/display/Dev/Object+Credentials+-+How+they+work)
for further information about roles and credentials.

*Logs*

You can view several logs here, in order to catch up on possible errors.

**Figure 6.38. Icinga Web logs**

![Icinga Web logs](../images/icinga-web-admin_logs1.png)

\

*Tasks*

Several changes require clearing the cache. Instead of using the command
line you can issue the command via the "Tasks" menu.

**Figure 6.39. Icinga Web Tasks**

![Icinga Web Tasks](../images/icinga-web-admin_tasks.png)

\

* * * * *

  -------------------------------------------- -------------------- -------------------------------------------------
  [Prev](icinga-web-config.md)               [Up](ch06.md)       [Next](icinga-web-pnp.md)
  6.7. Configuration Overview of Icinga Web    [Home](index.md)    6.9. Integration of PNP4Nagios into Icinga Web
  -------------------------------------------- -------------------- -------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
