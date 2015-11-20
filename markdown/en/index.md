 ![Icinga](../images/logofullsize.png "Icinga") [Next](ch01.md)

* * * * *

Copyright 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team.

file in the Icinga core sources for more information..

Credits to Yoann LAMY for creating the Vautour Style we use for the
Icinga Classic UI

Icinga and this documentation is licensed under the terms of the GNU
General Public License Version 2 as published by the Free Software
Foundation. This gives you legal permission to copy, distribute and/or
modify Icinga under certain conditions. Read the 'LICENSE' file in the
Icinga distribution or read the online version of the license for more
details.

Icinga is provided “AS IS” with “NO WARRANTY OF ANY KIND, INCLUDING THE
WARRANTY OF DESIGN, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR
PURPOSE.”

Nagios is licensed under the terms of the GNU General Public License
Version 2 as published by the Free Software Foundation. This gives you
legal permission to copy, distribute and/or modify Nagios under certain
conditions. Read the 'LICENSE' file in the Nagios distribution or read
the online version of the license for more details.

Nagios and the Nagios logo are registered trademarks of Ethan Galstad.
All other trademarks, servicemarks, registered trademarks, and
registered servicemarks mentioned herein may be the property of their
respective owner(s). The information contained herein is provided “AS
IS” with “NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN,
MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.”

2015.03.13


* * * * *

**Table of Contents**

​1. [About](ch01.md)

1.1. [About Icinga](about.md)

1.1.1. [What is Icinga?](about.md#whatsicinga)

1.1.2. [System requirements](about.md#system_requirements)

1.1.3. [Licensing](about.md#licensing)

1.1.4. [Acknowledgements](about.md#acknowledgements)

1.1.5. [Downloading The Latest Version](about.md#downloading)

1.1.6. [Compatibility](about.md#compatibility)

1.2. [What's New in Icinga 1.13](whatsnew.md)

1.2.1. [CHANGES](whatsnew.md#whatsnew-changes)

1.2.2. [Core](whatsnew.md#whatsnew-core)

1.2.3. [Classic UI](whatsnew.md#whatsnew-classicui)

1.2.4. [IDOutils](whatsnew.md#whatsnew-idoutils)

1.2.5. [Icinga-Web](whatsnew.md#whatsnew-web)

1.2.6. [Docs](whatsnew.md#docs)

1.2.7. [More information](whatsnew.md#moreinfo)

​2. [Getting Started](ch02.md)

2.1. [Advice for beginners](beginners.md)

2.1.1. [Icinga Overview](beginners.md#icinga-overview)

2.1.2. [Icinga web GUI comparison](beginners.md#icinga_gui_comparison)

2.2. [I'm a newbie to ...](newbie.md)

2.2.1. [Linux](newbie.md#newbie-linux)

2.2.2. [Mail](newbie.md#newbie-mail)

2.2.3. [SNMP](newbie.md#newbie-snmp)

2.2.4. [Packages](newbie.md#newbie-packages)

2.2.5. [Monitoring](newbie.md#newbie-monitoring)

2.2.6. [Help!](newbie.md#newbie-help)

2.3. [Quickstart Installation Guides](quickstart.md)

2.4. [Icinga Quickstart](quickstart-icinga.md)

2.4.1. [Introduction](quickstart-icinga.md#introduction)

2.4.2. [Prerequisites](quickstart-icinga.md#prerequisites)

2.4.3. [Install packages](quickstart-icinga.md#installpackages)

2.4.4. [Create Account
Information](quickstart-icinga.md#createaccount)

2.4.5. [Download Icinga and the
Plugins](quickstart-icinga.md#downloadicingaandplugins)

2.4.6. [Compile and install
Icinga](quickstart-icinga.md#compileinstall)

2.4.7. [Customise Configuration](quickstart-icinga.md#customiseconfig)

2.4.8. [Configure the Classic Web
Interface](quickstart-icinga.md#configclassicui)

2.4.9. [Compile and Install the Monitoring
Plugins](quickstart-icinga.md#compileinstallplugins)

2.4.10. [Adjusting the SELinux
settings](quickstart-icinga.md#selinuxsettings)

2.4.11. [Start Icinga](quickstart-icinga.md#starticinga)

2.4.12. [Login to the Classic Web
Interface](quickstart-icinga.md#loginclassicui)

2.4.13. [Other Modifications](quickstart-icinga.md#othermods)

2.4.14. [You're Done](quickstart-icinga.md#done)

2.5. [Icinga Quickstart FreeBSD](quickstart-icinga-freebsd.md)

2.6. [Icinga with IDOUtils Quickstart](quickstart-idoutils.md)

2.6.1. [Introduction](quickstart-idoutils.md#introduction_idoutils)

2.6.2. [Prerequisites](quickstart-idoutils.md#prerequisites_idoutils)

2.6.3. [New features for the
IDOUtils:](quickstart-idoutils.md#newfeatures_idoutils)

2.6.4. [Install
Packages](quickstart-idoutils.md#installpackages_idoutils)

2.6.5. [Create Account
Information](quickstart-idoutils.md#createaccount_idoutils)

2.6.6. [Download Icinga and the
Plugins](quickstart-idoutils.md#downloadicingaandplugins_idoutils)

2.6.7. [Compile and Install Icinga with
IDOUtils](quickstart-idoutils.md#compileinstallidoutils)

2.6.8. [Compile and
Install](quickstart-idoutils.md#compileinstall_idoutils)

2.6.9. [Customise
Configuration](quickstart-idoutils.md#customiseconfig_idoutils)

2.6.10. [Enable the idomod event broker
module](quickstart-idoutils.md#enableidomod)

2.6.11. [Creation of Database and
IDOUtils](quickstart-idoutils.md#createidoutilsdatabase)

2.6.12. [Configure the Classic Web
Interface](quickstart-idoutils.md#configclassicui_idoutils)

2.6.13. [Compile and Install the Monitoring
Plugins](quickstart-idoutils.md#compileinstallplugins_idoutils)

2.6.14. [Adjusting the SELinux
settings](quickstart-idoutils.md#selinuxsettings_idoutils)

2.6.15. [Start IDOUtils and
Icinga](quickstart-idoutils.md#startiido2dbandicinga)

2.6.16. [Configure Icinga
Startup](quickstart-idoutils.md#configstartup_idoutils)

2.6.17. [Login to the Classic Web
Interface](quickstart-idoutils.md#loginclassicui_idoutils)

2.6.18. [Other
Modifications](quickstart-idoutils.md#othermods_idoutils)

2.6.19. [You're Done](quickstart-idoutils.md#done_idoutils)

2.7. [Icinga and IDOUtils Quickstart on
FreeBSD](quickstart-idoutils-freebsd.md)

2.8. [Icinga Packages for Linux Distributions](icinga_packages.md)

2.9. [Links to other published Howtos](howtos.md)

2.10. [Upgrading (to) Icinga](upgrading.md)

2.10.1. [Upgrading from previous Icinga
Releases](upgrading.md#upgradepreviousrelease)

2.10.2. [Upgrading from Nagios 3.x
Releases](upgrading.md#upgradenagios3x)

2.10.3. [Upgrading from Nagios 2.x
Releases](upgrading.md#upgradenagios2x)

2.10.4. [Upgrading from an RPM
Installation](upgrading.md#upgradefromrpm)

2.11. [Upgrading IDOUtils Database](upgrading_idoutils.md)

2.11.1. [Upgrading IDOUtils to
1.13](upgrading_idoutils.md#upgrade1.13)

2.12. [Monitoring Overview](monitoring-overview.md)

2.13. [Monitoring Windows Machines](monitoring-windows.md)

2.13.1. [Introduction](monitoring-windows.md#introduction_win)

2.13.2. [Overview](monitoring-windows.md#overview)

2.13.3. [Steps](monitoring-windows.md#steps)

2.13.4. [What's Already Done For You](monitoring-windows.md#whatsdone)

2.13.5. [Prerequisites](monitoring-windows.md#prequisites)

2.13.6. [Installing the Windows
Agent](monitoring-windows.md#installwindowsagent)

2.13.7. [Configuring Icinga](monitoring-windows.md#configicinga)

2.13.8. [Password Protection](monitoring-windows.md#passwordprotect)

2.13.9. [Restarting Icinga](monitoring-windows.md#restarticinga)

2.13.10. [Troubleshooting](monitoring-windows.md#troubleshooting)

2.14. [Monitoring Linux/Unix Machines](monitoring-linux.md)

2.14.1. [Introduction](monitoring-linux.md#introduction_linux)

2.14.2. [Overview](monitoring-linux.md#overview)

2.15. [Monitoring Netware Servers](monitoring-netware.md)

2.16. [Monitoring Network Printers](monitoring-printers.md)

2.16.1. [Introduction](monitoring-printers.md#introduction_printers)

2.16.2. [Overview](monitoring-printers.md#overview)

2.16.3. [Steps](monitoring-printers.md#steps)

2.16.4. [What's Already Done For
You](monitoring-printers.md#whatsdone)

2.16.5. [Prerequisites](monitoring-printers.md#prerequisites)

2.16.6. [Configuring Icinga](monitoring-printers.md#configicinga)

2.16.7. [Restarting Icinga](monitoring-printers.md#restarticinga)

2.17. [Monitoring Routers and Switches](monitoring-routers.md)

2.17.1. [Introduction](monitoring-routers.md#introduction_routers)

2.17.2. [Overview](monitoring-routers.md#overview)

2.17.3. [Steps](monitoring-routers.md#steps)

2.17.4. [What's Already Done For You](monitoring-routers.md#whatsdone)

2.17.5. [Prerequisites](monitoring-routers.md#prereuisites)

2.17.6. [Configuring Icinga](monitoring-routers.md#configicinga)

2.17.7. [Restarting Icinga](monitoring-routers.md#restarticinga)

2.18. [Monitoring Publicly Available
Services](monitoring-publicservices.md)

2.18.1.
[Introduction](monitoring-publicservices.md#introduction_publicservices)

2.18.2. [Plugins for Monitoring
Services](monitoring-publicservices.md#pluginsformonitoringservices)

2.18.3. [Creating a Host
Definition](monitoring-publicservices.md#createhostdefinition)

2.18.4. [Creating Service
Definitions](monitoring-publicservices.md#createservicedefinition)

2.18.5. [Restarting
Icinga](monitoring-publicservices.md#restarticinga)

​3. [Configuring Icinga](ch03.md)

3.1. [Configuration Overview](config.md)

3.1.1. [Introduction](config.md#introduction_config)

3.1.2. [File names](config.md#config_filenames)

3.1.3. [Main Configuration File](config.md#mainconfigfile)

3.1.4. [Resource File(s)](config.md#resourcefile)

3.1.5. [Object Definition Files](config.md#objectdefinitionfiles)

3.1.6. [CGI Configuration File](config.md#cgiconfigfile)

3.2. [Main Configuration File Options](configmain.md)

3.3. [Object Configuration Overview](configobject.md)

3.4. [Object Definitions](objectdefinitions.md)

3.4.1. [Host definition](objectdefinitions.md#host)

3.4.2. [Hostgroup Definition](objectdefinitions.md#hostgroup)

3.4.3. [Service Definition](objectdefinitions.md#service)

3.4.4. [Servicegroup Definition](objectdefinitions.md#servicegroup)

3.4.5. [Contact Definition](objectdefinitions.md#contact)

3.4.6. [Contactgroup Definition](objectdefinitions.md#contactgroup)

3.4.7. [Timeperiod Definition](objectdefinitions.md#timeperiod)

3.4.8. [Command Definition](objectdefinitions.md#command)

3.4.9. [Servicedependency
Definition](objectdefinitions.md#servicedepdency)

3.4.10. [Serviceescalation
Definition](objectdefinitions.md#serviceescalation)

3.4.11. [Hostdependency
Definition](objectdefinitions.md#hostdependency)

3.4.12. [Hostescalation
Definition](objectdefinitions.md#hostescalation)

3.4.13. [Hostextinfo Definition](objectdefinitions.md#hostextinfo)

3.4.14. [Serviceextinfo
Definition](objectdefinitions.md#serviceextinfo)

3.4.15. [Module Definition](objectdefinitions.md#module)

3.5. [Custom Object Variables](customobjectvars.md)

3.5.1. [Introduction](customobjectvars.md#introduction)

3.5.2. [Custom Variable Basics](customobjectvars.md#basicscustomvars)

3.5.3. [Examples](customobjectvars.md#examples)

3.5.4. [Custom Variables As
Macros](customobjectvars.md#customvarsasmacros)

3.5.5. [Custom Variables And
Inheritance](customobjectvars.md#inheritancecustomvars)

3.6. [CGI Configuration File Options](configcgi.md)

​4. [Running Icinga](ch04.md)

4.1. [Verifying Your Configuration](verifyconfig.md)

4.2. [Starting and Stopping Icinga](startstop.md)

​5. [The Basics](ch05.md)

5.1. [Icinga Plugins](plugins.md)

5.1.1. [Introduction](plugins.md#introduction_plugins)

5.1.2. [What Are Plugins?](plugins.md#plugins-overview)

5.1.3. [Plugins As An Abstraction Layer](plugins.md#abstractionlayer)

5.1.4. [What Plugins Are Available?](plugins.md#plugins-available)

5.1.5. [Obtaining Plugins](plugins.md#plugins-obtaining)

5.1.6. [Switch to the Icinga user](plugins.md#plugins-hints)

5.1.7. [Extending the environment](plugins.md#plugins-extending)

5.1.8. [How Do I Use Plugin X?](plugins.md#plugins-howto)

5.1.9. [Integrating a new plugin](plugins.md#plugins-new_plugin)

5.1.10. [Raw command line](plugins.md#plugins-rawcommandline)

5.1.11. [Threshold and ranges](plugins.md#plugins-thresholdranges)

5.1.12. [Activating the definition](plugins.md#plugins-errors)

5.1.13. [Plugin API](plugins.md#pluginsapi)

5.2. [Understanding Macros and How They Work](macros.md)

5.2.1. [Macros](macros.md#introduction)


5.2.3. [Example 1: Host Address Macro](macros.md#hostaddressexample)

5.2.4. [Example 2: Command Argument
Macros](macros.md#commandargexample)

5.2.5. [On-Demand Macros](macros.md#ondemand)

5.2.6. [On-Demand Group Macros](macros.md#ondemandgroup)

5.2.7. [Custom Variable Macros](macros.md#customvar)

5.2.8. [Macro Cleaning](macros.md#cleaning)

5.2.9. [Macros as Environment Variables](macros.md#environmentvars)

5.2.10. [Available Macros](macros.md#availablelist)

5.3. [Standard Macros in Icinga](macrolist.md)

5.3.1. [Macro Validity](macrolist.md#validity)

5.3.2. [Macro Availability Chart](macrolist.md#availabilitychart)

5.4. [Host Checks](hostchecks.md)

5.4.1. [Introduction](hostchecks.md#introduction)

5.4.2. [When Are Host Checks Performed?](hostchecks.md#whenrun)

5.4.3. [Cached Host Checks](hostchecks.md#caching)

5.4.4. [Dependencies and Checks](hostchecks.md#dependencieschecks)

5.4.5. [Parallelization of Host Checks](hostchecks.md#parallelization)

5.4.6. [Host States](hostchecks.md#hoststates)

5.4.7. [Host State
Determination](hostchecks.md#hoststatedetermination)

5.4.8. [Host State Changes](hostchecks.md#hoststatechanges)

5.5. [Service Checks](servicechecks.md)

5.5.1. [Introduction](servicechecks.md#introduction)

5.5.2. [When Are Service Checks Performed?](servicechecks.md#when)

5.5.3. [Cached Service Checks](servicechecks.md#caching)

5.5.4. [Dependencies and Checks](servicechecks.md#dependencieschecks)

5.5.5. [Parallelization of Service
Checks](servicechecks.md#parallelization)

5.5.6. [Service States](servicechecks.md#servicestates)

5.5.7. [Service State
Determination](servicechecks.md#servicestatedetermination)

5.5.8. [Service State Changes](servicechecks.md#servicestatechanges)

5.5.9. [Service State is "stale"](servicechecks.md#servicestatestale)

5.6. [Active Checks](activechecks.md)

5.6.1. [Introduction](activechecks.md#introduction_activechecks)

5.6.2. [How Are Active Checks Performed?](activechecks.md#performed)

5.6.3. [When Are Active Checks Executed?](activechecks.md#executed)

5.7. [Passive Checks](passivechecks.md)

5.7.1. [Introduction](passivechecks.md#introduction)

5.7.2. [Uses For Passive Checks](passivechecks.md#usecases)

5.7.3. [How Passive Checks Work](passivechecks.md#howitworks)

5.7.4. [Enabling Passive Checks](passivechecks.md#enable)

5.7.5. [Submitting Passive Service Check
Results](passivechecks.md#servicecheckresults)

5.7.6. [Submitting Passive Host Check
Results](passivechecks.md#hostcheckresults)

5.7.7. [Passive Checks and Host States](passivechecks.md#hoststates)

5.7.8. [Submitting Passive Check Results From Remote
Hosts](passivechecks.md#checkresultsfromremotehosts)

5.8. [State Types](statetypes.md)

5.8.1. [Introduction](statetypes.md#introduction)

5.8.2. [Service and Host Check Retries](statetypes.md#checkretries)

5.8.3. [Soft States](statetypes.md#softstates)

5.8.4. [Hard States](statetypes.md#hardstates)

5.8.5. [Example](statetypes.md#example)

5.9. [Time Periods](timeperiods.md)

5.9.1. [Introduction](timeperiods.md#introduction)

5.9.2. [Precedence in Time Periods](timeperiods.md#precedence)

5.9.3. [How Time Periods Work With Host and Service
Checks](timeperiods.md#hostservicechecks)

5.9.4. [How Time Periods Work With Contact
Notifications](timeperiods.md#contactnotifications)

5.9.5. [How Time Periods Work With Notification
Escalations](timeperiods.md#notificationescalations)

5.9.6. [How Time Periods Work With
Dependencies](timeperiods.md#dependenciestimeperiods)

5.10. [Determining Status and Reachability of Network
Hosts](networkreachability.md)

5.10.1. [Introduction](networkreachability.md#introduction)

5.10.2. [Example Network](networkreachability.md#examplenetwork)

5.10.3. [Defining Parent/Child
Relationships](networkreachability.md#parentchildrelations)

5.10.4. [Reachability Logic in
Action](networkreachability.md#logicinaction)

5.10.5. [UNREACHABLE States and
Notifications](networkreachability.md#unreachableandnotifications)

5.11. [Notifications](notifications.md)

5.11.1. [Introduction](notifications.md#introduction)

5.11.2. [When Do Notifications Occur?](notifications.md#when)

5.11.3. [Who Gets Notified?](notifications.md#who)

5.11.4. [What Filters Must Be Passed In Order For Notifications To Be
Sent?](notifications.md#whatfilters)

5.11.5. [Program-Wide Filter:](notifications.md#programwidefilters)

5.11.6. [Service and Host
Filters:](notifications.md#servicehostfilters)

5.11.7. [Contact Filters:](notifications.md#contactfilters)

5.11.8. [Notification Methods](notifications.md#methods)

5.11.9. [Notification Type Macro](notifications.md#typemacro)

5.11.10. [Helpful Resources](notifications.md#helpfulresources)

5.12. [Notifications: Examples and troubleshooting](notifications2.md)

5.12.1. [Introduction](notifications2.md#introduction)

5.12.2. [Some examples](notifications2.md#examples)

5.12.3. [Troubleshooting](notifications2.md#troubleshooting)

​6. [User Interfaces](ch06.md)

6.1. [Icinga Classic UI: Information On The Modules](cgis.md)

6.2. [Authentication And Authorization In The Classic UI](cgiauth.md)

6.2.1. [Introduction](cgiauth.md#introduction_cgiauth)

6.2.2. [Definitions](cgiauth.md#definitionscgiauth)

6.2.3. [Setting Up Authenticated Users](cgiauth.md#configwebusers)

6.2.4. [Enabling Authentication/Authorization Functionality In The
Classic UI](cgiauth.md#enablecgiauth)

6.2.5. [Default Permissions To Classic UI
Information](cgiauth.md#defaultpermissions)

6.2.6. [Granting Additional Permissions To Classic UI
Information](cgiauth.md#additionalpermissions)

6.2.7. [Classic UI Authorization
Requirements](cgiauth.md#requirementscgiauth)

6.2.8. [Authentication On Secured Web
Servers](cgiauth.md#securedwebservers)

6.3. [Information On Classic UI parameters](cgiparams.md)

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

6.4. [Executing Classic UI modules (CGIs) on the command
line](cgicmd.md)

6.4.1. [Introduction](cgicmd.md#introduction_cgicmd)

6.4.2. [Prerequisites](cgicmd.md#prerequisites)

6.4.3. [Examples](cgicmd.md#examples)

6.5. [Installation of the Icinga Web Frontend](icinga-web-scratch.md)

6.5.1. [Introduction](icinga-web-scratch.md#introduction)

6.5.2. [Prerequisites](icinga-web-scratch.md#prerequisites)

6.5.3. [The installation](icinga-web-scratch.md#install)

6.5.4. [Settings](icinga-web-scratch.md#settings)

6.5.5. [Use It!](icinga-web-scratch.md#useit)

6.5.6. [Test & Errors?](icinga-web-scratch.md#webtroubleshooting)

6.6. [Upgrading Icinga Web and Icinga Web
Database](upgrading_icingaweb.md)

6.6.1. [Upgrading Icinga
Web](upgrading_icingaweb.md#upgradingicingaweb)

6.6.2. [The Upgrade](upgrading_icingaweb.md#upgrade)

6.6.3. [Upgrading the Icinga Web
Database](upgrading_icingaweb.md#upgradedatabase)

6.7. [Configuration Overview of Icinga Web](icinga-web-config.md)

6.7.1. [Where are my config
files?](icinga-web-config.md#configfilelocation)

6.7.2. [Index](icinga-web-config.md#confogfileindex)

6.7.3. [Global Configuration
Section](icinga-web-config.md#globalconfig)

6.7.4. [Troubleshooting](icinga-web-config.md#troubleshooting)

6.7.5. [Module Configuration](icinga-web-config.md#moduleconfig)

6.7.6. [Customised Configuration](icinga-web-config.md#customconfig)

6.8. [Introduction to Icinga Web](icinga-web-introduction.md)

6.8.1. [Introduction to Icinga Web (\>=
1.13)](icinga-web-introduction.md#icinga-web-intro)

6.9. [Integration of PNP4Nagios into Icinga Web](icinga-web-pnp.md)

6.9.1. [Install PNP4Nagios](icinga-web-pnp.md#installpnp)

6.9.2. [Templates Extension](icinga-web-pnp.md#templateextension)

6.9.3. [Clearing the cache](icinga-web-pnp.md#clearcache)

​7. [Advanced Topics](ch07.md)

7.1. [External Commands](extcommands.md)

7.1.1. [Introduction](extcommands.md#introduction)

7.1.2. [Enabling External Commands](extcommands.md#enable)

7.1.3. [When Does Icinga Check For External
Commands?](extcommands.md#whenchecked)

7.1.4. [Using External Commands](extcommands.md#usage)

7.1.5. [Command Format](extcommands.md#format)

7.1.6. [External Commands List](extcommands.md#externalcommandslist)

7.2. [List of External Commands](extcommands2.md)

7.3. [Event Handlers](eventhandlers.md)

7.3.1. [Introduction](eventhandlers.md#introduction)

7.3.2. [When Are Event Handlers Executed?](eventhandlers.md#execution)

7.3.3. [Event Handler Types](eventhandlers.md#types)

7.3.4. [Enabling Event Handlers](eventhandlers.md#enable)

7.3.5. [Event Handler Execution
Order](eventhandlers.md#executionorder)

7.3.6. [Writing Event Handler
Commands](eventhandlers.md#writingcommands)

7.3.7. [Permissions For Event Handler
Commands](eventhandlers.md#commandpermissions)

7.3.8. [Service Event Handler
Example](eventhandlers.md#serviceexample)

7.4. [Volatile Services](volatileservices.md)

7.4.1. [Introduction](volatileservices.md#introduction)

7.4.2. [What Are They Useful For?](volatileservices.md#usage)

7.4.3. [What's So Special About Volatile
Services?](volatileservices.md#speciality)

7.4.4. [The Power Of Two](volatileservices.md#poweroftwo)

7.4.5. [Icinga Configuration:](volatileservices.md#configvolatile)

7.4.6. [PortSentry
Configuration:](volatileservices.md#portsentryconfig)

7.4.7. [Port Scan Script:](volatileservices.md#portscanscript)

7.5. [Service and Host Freshness Checks](freshness.md)

7.5.1. [Introduction](freshness.md#introduction)

7.5.2. [How Does Freshness Checking Work?](freshness.md#howitworks)

7.5.3. [Enabling Freshness Checking](freshness.md#enable)

7.5.4. [Example](freshness.md#example)

7.5.5. ["Check results ... are stale. Forcing an immediate check
...](freshness.md#stale)

7.6. [Distributed Monitoring](distributed.md)

7.6.1. [Introduction](distributed.md#introduction)

7.6.2. [Goals](distributed.md#goals)

7.6.3. [Reference Diagram](distributed.md#referencediagram)

7.6.4. [Central Server vs. Distributed
Servers](distributed.md#centralvsdistributed)

7.6.5. [Obtaining Service Check Information From Distributed
Monitors](distributed.md#servicecheckinfo)

7.6.6. [Distributed Server
Configuration](distributed.md#distributedconfig)

7.6.7.
[ocsp\_command=submit\_check\_result](distributed.md#oscpsubmitcheckresult)

7.6.8. [Central Server Configuration](distributed.md#centralconfig)

7.6.9. [Problems With Passive Checks](distributed.md#problemspassive)

7.6.10. [Freshness Checking](distributed.md#freshnesschecks)

7.6.11. [Performing Host Checks](distributed.md#hostcheckperforming)

7.7. [Redundant and Failover Network Monitoring](redundancy.md)

7.7.1. [Introduction](redundancy.md#introduction)

7.7.2. [Prerequisites](redundancy.md#redprerequisites)

7.7.3. [Sample Scripts](redundancy.md#samplescripts)

Monitoring](redundancy.md#redundantmonitoring)

Monitoring](redundancy.md#failovermonitoring)

7.8. [Detection and Handling of State Flapping](flapping.md)

7.8.1. [Introduction](flapping.md#introduction)

7.8.2. [How Flap Detection Works](flapping.md#howitworks)

7.8.3. [Example](flapping.md#example)

7.8.4. [Flap Detection for Services](flapping.md#detectionservices)

7.8.5. [Flap Detection for Hosts](flapping.md#detectionhosts)

7.8.6. [Flap Detection Thresholds](flapping.md#thresholds)

7.8.7. [States Used For Flap Detection](flapping.md#statesused)

7.8.8. [Flap Handling](flapping.md#handling)

7.8.9. [Enabling Flap Detection](flapping.md#enable)

7.9. [Notification Escalations](escalations.md)

7.9.1. [Introduction](escalations.md#introduction)

7.9.2. [When Are Notifications
Escalated?](escalations.md#notificationsescalated)

7.9.3. [Contact Groups](escalations.md#contactgroups)

7.9.4. [Overlapping Escalation
Ranges](escalations.md#overlappingranges)

7.9.5. [Recovery Notifications](escalations.md#recoverynotifications)

7.9.6. [Notification Intervals](escalations.md#notificationintervals)

7.9.7. [Time Period
Restrictions](escalations.md#timeperiodrestrictions)

7.9.8. [State Restrictions](escalations.md#staterestrictions)

7.10. [Escalation Condition](escalation_condition.md)

7.10.1. [Introduction](escalation_condition.md#introduction)

7.10.2. [Syntax](escalation_condition.md#syntax)

7.10.3. [Example](escalation_condition.md#example)

7.11. [On-Call Rotations](oncallrotation.md)

7.11.1. [Introduction](oncallrotation.md#introduction)

7.11.2. [Scenario 1: Holidays and
Weekends](oncallrotation.md#holidaysweekends)

7.11.3. [Scenario 2: Alternating
Days](oncallrotation.md#alternatingdays)

7.11.4. [Scenario 3: Alternating
Weeks](oncallrotation.md#alternatingweeks)

7.11.5. [Scenario 4: Vacation Days](oncallrotation.md#vacationdays)

7.11.6. [Other Scenarios](oncallrotation.md#others)

7.12. [Monitoring Service and Host Clusters](clusters.md)

7.12.1. [Introduction](clusters.md#introduction_clusters)

7.12.2. [Plan of Attack](clusters.md#planofattack)

7.12.3. [Using the check\_cluster
Plugin](clusters.md#checkclusterplugin)

7.12.4. [Monitoring Service Clusters](clusters.md#serviceclusters)

7.12.5. [Monitoring Host Clusters](clusters.md#hostclusters)

7.13. [Host and Service Dependencies](dependencies.md)

7.13.1. [Introduction](dependencies.md#introduction)

7.13.2. [Service Dependencies Overview](dependencies.md#overview)

7.13.3. [Defining Service Dependencies](dependencies.md#definition)

7.13.4. [Example Service Dependencies](dependencies.md#example)

7.13.5. [How Service Dependencies Are Tested](dependencies.md#test)

7.13.6. [Execution Dependencies](dependencies.md#execution)

7.13.7. [Notification Dependencies](dependencies.md#idp14493488)

7.13.8. [Dependency Inheritance](dependencies.md#inheritance)

7.13.9. [Host Dependencies](dependencies.md#dep_host)

7.13.10. [Example Host Dependencies](dependencies.md#examplehost)

7.14. [State Stalking](stalking.md)

7.14.1. [Introduction](stalking.md#introduction)

7.14.2. [How Does It Work?](stalking.md#howitworks)

7.14.3. [Should I Enable Stalking?](stalking.md#whyenable)

7.14.4. [How Do I Enable Stalking?](stalking.md#howenable)

7.14.5. [How Does Stalking Differ From Volatile
Services?](stalking.md#differtovolatile)

7.14.6. [Caveats](stalking.md#caveats)

7.15. [Performance Data](perfdata.md)

7.15.1. [Introduction](perfdata.md#introduction)

7.15.2. [Types of Performance Data](perfdata.md#typesperfdata)

7.15.3. [Plugin Performance Data](perfdata.md#pluginperfdata)

7.15.4. [Processing Performance Data](perfdata.md#processing)

7.15.5. [Processing Performance Data Using
Commands](perfdata.md#processingcommands)

7.15.6. [Writing Performance Data To
Files](perfdata.md#writingtofiles)

7.15.7. [Performance Data Format](perfdata.md#formatperfdata)

7.16. [Scheduled Downtime](downtime.md)

7.16.1. [Introduction](downtime.md#introduction)

7.16.2. [Scheduling Downtime](downtime.md#schedule)

7.16.3. [Fixed vs. Flexible Downtime](downtime.md#fixedvsflexible)

7.16.4. [Triggered Downtime](downtime.md#triggered)

7.16.5. [How Scheduled Downtime Affects
Notifications](downtime.md#affectednotifications)

7.16.6. [Overlapping Scheduled Downtime](downtime.md#overlapping)

7.17. [Recurring Downtimes](recurring_downtimes.md)

7.17.1. [Downtime definition](recurring_downtimes.md#introduction)

7.17.2. [Variable dates](recurring_downtimes.md#variabledates)

7.17.3. [Local holidays](recurring_downtimes.md#localholidays)

7.17.4. [Entering downtimes](recurring_downtimes.md#enteringdowntimes)

7.17.5. [Planning downtimes](recurring_downtimes.md#planningdowntimes)

7.17.6. [Converting downtime
definitions](recurring_downtimes.md#conversion)

7.17.7. [Files](recurring_downtimes.md#files)

7.18. [Using The Embedded Perl Interpreter](embeddedperl.md)

7.18.1. [Advantages](embeddedperl.md#pros)

7.18.2. [Disadvantages](embeddedperl.md#cons)

7.18.3. [Using The Embedded Perl
Interpreter](embeddedperl.md#interpreter)

7.18.4. [Compiling Icinga With Embedded
Perl](embeddedperl.md#compileicinga)

7.18.5. [Plugin-Specific Use of the Perl
Interpreter](embeddedperl.md#plugspecs)

7.18.6. [Developing Plugins For Use With Embedded
Perl](embeddedperl.md#devlopplugs)

7.19. [Adaptive Monitoring](adaptive.md)

7.19.1. [Introduction](adaptive.md#introduction_adaptive)

7.19.2. [What Can Be Changed?](adaptive.md#changed)

7.19.3. [External Commands For Adaptive
Monitoring](adaptive.md#extcommandsadaptive)

7.20. [Predictive Dependency Checks](dependencychecks.md)

7.20.1. [Introduction](dependencychecks.md#introduction)

7.20.2. [How Do Predictive Checks
Work?](dependencychecks.md#howitworks)

7.20.3. [Enabling Predictive Checks](dependencychecks.md#enable)

7.20.4. [Cached Checks](dependencychecks.md#cacheddependencychecks)

7.21. [Cached Checks](cachedchecks.md)

7.21.1. [Introduction](cachedchecks.md#introduction_cachedchecks)

7.21.2. [For On-Demand Checks Only](cachedchecks.md#ondemandchecks)

7.21.3. [How Caching Works](cachedchecks.md#howitworks)

7.21.4. [What This Really Means](cachedchecks.md#whatthismeans)

7.21.5. [Configuration Variables](cachedchecks.md#configvars)

7.21.6. [Optimizing Cache
Effectiveness](cachedchecks.md#optimizeeffectiveness)

7.22. [Passive Host State Translation](passivestatetranslation.md)

7.22.1. [Introduction](passivestatetranslation.md#introduction)

7.22.2. [Different World
Views](passivestatetranslation.md#differentviews)

7.22.3. [Enabling State
Translation](passivestatetranslation.md#enablestatetranslation)

7.23. [Service and Host Check Scheduling](checkscheduling.md)

7.23.1.
[Introduction](checkscheduling.md#introduction_checkscheduling)

7.23.2. [Configuration
Options](checkscheduling.md#configurationoptions)

7.23.3. [Initial Scheduling](checkscheduling.md#initialscheduling)

7.23.4. [Inter-Check Delay](checkscheduling.md#serviceintercheckdelay)

7.23.5. [Service Interleaving](checkscheduling.md#serviceinterleaving)

7.23.6. [Maximum Concurrent Service
Checks](checkscheduling.md#maxconcurrentchecks)

7.23.7. [Time Restraints](checkscheduling.md#timerestraints)

7.23.8. [Normal Scheduling](checkscheduling.md#normalscheduling)

7.23.9. [Scheduling During
Problems](checkscheduling.md#problemscheduling)

7.23.10. [Host Checks](checkscheduling.md#hostcheckscheduling)

7.23.11. [Scheduling Delays](checkscheduling.md#schedulingdelays)

7.23.12. [Scheduling Example](checkscheduling.md#schedulingexample)

7.23.13. [Service Definition Options That Affect
Scheduling](checkscheduling.md#serviceoptions)

7.23.14. [TODO](checkscheduling.md#todo)

7.24. [Custom CGI Headers and Footers (Classic UI)](cgiincludes.md)

7.24.1. [Introduction](cgiincludes.md#introduction_cgiincludes)

7.24.2. [How Does It Work?](cgiincludes.md#howitworks)

7.25. [Modified attributes](modified_attr.md)

7.25.1. [Introduction](modified_attr.md#introduction)

7.25.2. [Example](modified_attr.md#example)

7.26. [Object Inheritance](objectinheritance.md)

7.26.1.
[Introduction](objectinheritance.md#objectinheritance-introduction)

7.26.2. [Basics](objectinheritance.md#objectinheritance-basics)

7.26.3. [Local Variables vs. Inherited
Variables](objectinheritance.md#objectinheritance-localvsinveritedvars)

7.26.4. [Inheritance
Chaining](objectinheritance.md#objectinheritance-inheritancechaining)

7.26.5. [Using Incomplete Object Definitions as
Templates](objectinheritance.md#objectinheritance-templates)

7.26.6. [Custom Object
Variables](objectinheritance.md#objectinheritance-customobjectvariables)

7.26.7. [Cancelling Inheritance of String
Values](objectinheritance.md#objectinheritance-cancel_string)

7.26.8. [Additive Inheritance of String
Values](objectinheritance.md#objectinheritance-add_string)

7.26.9. [Implied
Inheritance](objectinheritance.md#objectinheritance-implied_inheritance)

7.26.10. [Implied/Additive Inheritance in
Escalations](objectinheritance.md#objectinheritance-implied_escalations)

7.26.11. [Important
values](objectinheritance.md#objectinheritance-important_values)

7.26.12. [Multiple Inheritance
Sources](objectinheritance.md#objectinheritance-multiple_templates)

7.26.13. [Precedence With Multiple Inheritance
Sources](objectinheritance.md#objectinheritance-multipleinheritancesources)

7.27. [Time-Saving Tricks For Object Definitions](objecttricks.md)

​8. [Security and Performance Tuning](ch08.md)

8.1. [Security Considerations](security.md)

8.1.1. [Introduction](security.md#introduction)

8.1.2. [Best Practices](security.md#bestpractices)

8.2. [Enhanced Classic UI Security and Authentication](cgisecurity.md)

8.2.1. [Introduction](cgisecurity.md#introduction_cgisecurity)

8.2.2. [Additional Techniques](cgisecurity.md#additionaltechniques)

8.2.3. [Implementing Digest
Authentication](cgisecurity.md#implementationdigest)

8.2.4. [Implementing Forced TLS/SSL](cgisecurity.md#implementationssl)

8.2.5. [Implementing IP subnet
lockdown](cgisecurity.md#implementationlockdown)

8.2.6. [Important Notes](cgisecurity.md#importantnotes)

8.3. [Tuning Icinga For Maximum Performance](tuning.md)

8.3.1. [Introduction](tuning.md#introduction)

8.3.2. [Optimization Tips](tuning.md#optimizationtips)

8.4. [Fast Startup Options](faststartup.md)

8.4.1. [Introduction](faststartup.md#introduction)

8.4.2. [Background](faststartup.md#background)

8.4.3. [Evaluating Startup Times](faststartup.md#evalstartuptime)

8.4.4. [Pre-Caching Object
Configuration](faststartup.md#precacheobjectconfig)

8.4.5. [Skipping Circular Path
Tests](faststartup.md#skipcircularpathtests)

8.4.6. [Putting It All Together](faststartup.md#puttogether)

8.5. [Large Installation Tweaks](largeinstalltweaks.md)

8.5.1. [Introduction](largeinstalltweaks.md#introduction)

8.5.2. [Effects](largeinstalltweaks.md#effects)

8.6. [Using The Icingastats Utility](icingastats.md)

8.6.1. [Introduction](icingastats.md#introduction)

8.6.2. [Usage Information](icingastats.md#usageinfo)

8.6.3. [Human-Readable Output](icingastats.md#output)

8.6.4. [PNP4Nagios Integration](icingastats.md#integration)

8.7. [Graphing Performance Info With PNP4Nagios](perfgraphs.md)

8.7.1. [Introduction](perfgraphs.md#introduction)

8.7.2. [Prerequisites](perfgraphs.md#prerequisites)

8.7.3. [Average Host / Service Check
Latency](perfgraphs.md#avghostsvcchecklatency)

8.7.4. [Service Statistics](perfgraphs.md#servicestatistics)

8.7.5. [Host Statistics](perfgraphs.md#hoststatistics)

8.7.6. [Average Execution Times](perfgraphs.md#avgexecutiontimes)

8.7.7. [External Commands](perfgraphs.md#externalcommands)

8.7.8. [External Command
Buffers](perfgraphs.md#externalcommandbuffers)

8.7.9. [Cached Host and Service Checks](perfgraphs.md#idp15978528)

8.7.10. [Average State Changes](perfgraphs.md#avgstatechanges)

8.8. [Temporary Data](temp_data.md)

​9. [Integration With Other Software](ch09.md)

9.1. [Integration Overview](integration.md)

9.1.1. [Introduction](integration.md#introduction)

9.1.2. [Integration Points](integration.md#points)

9.1.3. [Integration Examples](integration.md#examples)

9.2. [SNMP Trap Integration](int-snmptrap.md)

9.3. [TCP Wrapper Integration](int-tcpwrappers.md)

9.3.1. [Introduction](int-tcpwrappers.md#introduction)

9.3.2. [Defining A
Service](int-tcpwrappers.md#servicedefinitiontcpwrapper)

9.3.3. [Configuring TCP
Wrappers](int-tcpwrappers.md#configtcpwrappers)

9.3.4. [Writing The Script](int-tcpwrappers.md#tcpwrapperscript)

9.3.5. [Finishing Up](int-tcpwrappers.md#finish)

9.4. [MKLiveStatus Integration](int-mklivestatus.md)

9.4.1. [Introduction](int-mklivestatus.md#introduction)

9.4.2. [Installation /
Configuration](int-mklivestatus.md#installconfig)

9.5. [Installation of the Icinga Reporting with JasperReports
Server](reporting.md)

9.5.1. [Introduction](reporting.md#introduction)

9.5.2. [Official Docs](reporting.md#officialdocs)

9.5.3. [Requirements](reporting.md#requirements)

9.5.4. [Icinga Reporting](reporting.md#icingareporting)

9.5.5. [Configuration](reporting.md#configuration)

9.5.6. [Reports](reporting.md#reports)

9.5.7. [Errors](reporting.md#errors)

​10. [Additional software](ch10.md)

10.1. [Icinga Addons](addons.md)

10.1.1. [Introduction](addons.md#introduction_addons)

10.2. [NRPE](nrpe.md)

10.2.1. [Introduction](nrpe.md#introduction)

10.2.2. [Prerequisites](nrpe.md#prerequisites)

10.2.3. [Download](nrpe.md#download)

10.2.4. [Optional changes](nrpe.md#optionalchanges)

10.2.5. [Compile on the Icinga server](nrpe.md#compile)

10.2.6. [First test](nrpe.md#firsttest)

10.2.7. [Remote system(s)](nrpe.md#remotesystem)

10.2.8. [Prerequisites on the remote
host(s)](nrpe.md#prerequisitesremotehost)

10.2.9. [Second test](nrpe.md#secondtest)

10.2.10. [Installation on the remote host](nrpe.md#remotehostinstall)

10.2.11. [Third test](nrpe.md#thirdtest)

10.2.12. [Troubleshooting](nrpe.md#troubleshooting)

10.2.13. [Security](nrpe.md#security)

10.2.14. [Definition of local checks](nrpe.md#localcheckdefinition)

10.2.15. [Definitions on the Icinga
server](nrpe.md#icingaserverdefinitions)

10.2.16. [More Troubleshooting](nrpe.md#moretroubleshooting)

10.2.17. [Upgrading](nrpe.md#upgrading)

10.3. [NSCA](nsca.md)

10.3.1. [Introduction](nsca.md#introduction)

10.3.2. [Prerequisites](nsca.md#prerequisites)

10.3.3. [Download and compile](nsca.md#downloadcompile)

10.3.4. [Customise](nsca.md#customise)

10.3.5. [First test](nsca.md#firsttest)

10.3.6. [Install](nsca.md#installnsca)

10.3.7. [Remote system(s)](nsca.md#remotesystem)

10.3.8. [Copy files](nsca.md#copyfiles)

10.3.9. [Second test](nsca.md#secondtest)

10.3.10. [Troubleshooting](nsca.md#troubleshooting)

10.3.11. [Security](nsca.md#security)

10.3.12. [Operation](nsca.md#operation)

10.3.13. [Integration into Icinga](nsca.md#icingaintegration)

​11. [Development](ch11.md)

11.1. [Icinga Plugin API](pluginapi.md)

11.1.1. [Other Resources](pluginapi.md#otherresources)

11.1.2. [Plugin Overview](pluginapi.md#overview)

11.1.3. [Return Code](pluginapi.md#returncode)

11.1.4. [Plugin Output Spec](pluginapi.md#outputspec)

11.1.5. [Plugin Output Examples](pluginapi.md#outputexamples)

11.1.6. [Plugin Output Length
Restrictions](pluginapi.md#outputlengthrestrictions)

11.1.7. [Examples](pluginapi.md#examples)

11.1.8. [Perl Plugins](pluginapi.md#perlplugins)

11.2. [Developing Plugins For Use With Embedded Perl](epnplugins.md)

11.2.1. [Introduction](epnplugins.md#introduction)

11.2.2. [Target Audience](epnplugins.md#targetaudience)

11.2.3. [Things you should do when developing a Perl Plugin (ePN or
not)](epnplugins.md#todo)

11.2.4. [Things you must do to develop a Perl plugin for
ePN](epnplugins.md#nottodo)

11.3. [No Icinga API to install anymore](icinga-api.md)

11.3.1. [Installation and use of the Icinga
API](icinga-api.md#idp16727776)

11.4. [The Icinga Web REST API](icinga-web-api.md)

11.4.1. [Why should I use the API?](icinga-web-api.md#why)

11.4.2. [Features of the Icinga Web REST
API](icinga-web-api.md#features)

11.4.3. [What's the difference between the Icinga API and the Icinga Web
REST API?](icinga-web-api.md#difference)

11.4.4. [Prerequisites](icinga-web-api.md#prerequisites)

11.4.5. [Reference](icinga-web-api.md#reference)

11.4.6. [GET](icinga-web-api.md#get)

11.4.7. [The structure of the URL:](icinga-web-api.md#geturlstructure)

11.4.8. [The Parameters en detail:](icinga-web-api.md#getparamdetails)

11.4.9. [Example for GET](icinga-web-api.md#getexample)

11.4.10. [POST](icinga-web-api.md#post)

11.4.11. [Parameters en detail](icinga-web-api.md#postparamdetail)

11.4.12. [Example for POST](icinga-web-api.md#postexample)

​12. [IDOUtils](ch12.md)

12.1. [Introduction](db_intro.md)

12.1.1. [Purpose](db_intro.md#purpose)

12.1.2. [Design Overview](db_intro.md#design)

12.1.3. [Instances](db_intro.md#instances)

12.1.4. [Installation](db_intro.md#install)

12.2. [Components](db_components.md)

12.2.1. [Overview](db_components.md#overview)

12.2.2. [IDOMOD](db_components.md#idomod)

12.2.3. [LOG2IDO](db_components.md#log2ido)

12.2.4. [FILE2SOCK](db_components.md#file2sock)

12.2.5. [IDO2DB](db_components.md#ido2db)

12.3. [Configuration of IDOUtils](configido.md)

12.3.1. [IDOMOD config options](configido.md#configido-idomod_options)

12.3.2. [IDO2DB config options](configido.md#configido-ido2db_options)

12.4. [Example Configurations](db_example-configs.md)

12.4.1. [Single Server, Single Instance
Setup](db_example-configs.md#singleserversingleinstance)

12.4.2. [Single Server, Multiple Instance
Setup](db_example-configs.md#singleservermultipleinstance)

12.4.3. [Single Server, Single Instance Log File
Import](db_example-configs.md#singleserversingleinstancelogfile)

12.5. [IDOUtils Database Model](db_model.md)

12.5.1. [Central Tables](db_model.md#dbm_ct)

12.5.2. [Debugging Tables](db_model.md#dbm_dt)

12.5.3. [Historical Tables](db_model.md#dbm_ht)

12.5.4. [Current Status Tables](db_model.md#statustables)

12.5.5. [Configuration Tables](db_model.md#dbm_cf)

12.6. [Database changes/alterations](db_changes.md)

​13. [Icinga Samples](ch13.md)

13.1. [Sample configuration files and definitions](sample-config.md)

13.2. [icinga.cfg](sample-icinga.md)

13.3. [cgi.cfg](sample-cgi.md)

13.4. [resource.cfg](sample-resource.md)

13.5. [httpd.conf](sample-httpd.md)

13.6. [commands.cfg](sample-commands.md)

13.7. [commands.cfg](sample-contacts.md)

13.8. [localhost.cfg](sample-localhost.md)

13.9. [notifications.cfg](sample-notifications.md)

13.10. [printer.cfg](sample-printer.md)

13.11. [switch.cfg](sample-switch.md)

13.12. [templates.cfg](sample-templates.md)

13.13. [timeperiods.cfg](sample-timeperiods.md)

13.14. [windows.cfg](sample-windows.md)

[Index](ix01.md)

**List of Figures**

3.1. [Example of new header](configcgi.md#idp6694144)

6.1. [Icinga Web instance down](icinga-web-config.md#idp12745120)

6.2. [Icinga Web login screen](icinga-web-introduction.md#idp12808128)

6.3. [Icinga Web overview](icinga-web-introduction.md#idp12811648)

6.4. [Icinga Web top menu](icinga-web-introduction.md#idp12816512)

6.5. [Icinga Web live search](icinga-web-introduction.md#idp12820688)

6.6. [Icinga Web status cronk](icinga-web-introduction.md#idp12827872)

6.7. [Icinga Web data cronks](icinga-web-introduction.md#idp12832544)

6.8. [Icinga Web tactical overview
cronks](icinga-web-introduction.md#idp12836720)

6.9. [Icinga Web reporting
cronk](icinga-web-introduction.md#idp12840688)

6.10. [Icinga Web misc cronks](icinga-web-introduction.md#idp12842224)

6.11. [Icinga Web Cronk Menu Style
Change](icinga-web-introduction.md#idp12846256)

6.12. [Icinga Web main screen](icinga-web-introduction.md#idp12852016)

6.13. [Icinga Web host status](icinga-web-introduction.md#idp12856512)

6.14. [Expander icon / icon
bar](icinga-web-introduction.md#idp12860432)

6.15. [Move icon into grid](icinga-web-introduction.md#idp12864032)

6.16. [Icinga Web New icons in
grid](icinga-web-introduction.md#idp12867856)

6.17. [Icinga Web Reset icon
view](icinga-web-introduction.md#idp12871504)

6.18. [Icinga Web host object
information](icinga-web-introduction.md#idp12876240)

6.19. [Icinga Web service
status](icinga-web-introduction.md#idp12880176)

6.20. [Icinga Web service object
Information](icinga-web-introduction.md#idp12884256)

6.21. [Icinga Web hostgroup
status](icinga-web-introduction.md#idp12888080)

6.22. [Icinga Web log](icinga-web-introduction.md#idp12892000)

6.23. [Icinga Web cronk bar](icinga-web-introduction.md#idp12896288)

6.24. [Icinga Web cronk bar](icinga-web-introduction.md#idp12902336)

6.25. [Icinga Web host
commands](icinga-web-introduction.md#idp12911552)

6.26. [Icinga Web service
commands](icinga-web-introduction.md#idp12915600)

6.27. [Icinga Web filter
restriction](icinga-web-introduction.md#idp12920096)

6.28. [Icinga Web drag
filters](icinga-web-introduction.md#idp12925536)

6.29. [Icinga Web drop
filters](icinga-web-introduction.md#idp12929408)

6.30. [Icinga Web filter attribute
selection](icinga-web-introduction.md#idp12933648)

6.31. [Icinga Web filter
active](icinga-web-introduction.md#idp12936528)

6.32. [Icinga Web filter advanced
filters](icinga-web-introduction.md#idp12939792)

6.33. [Icinga Web top menu
admin](icinga-web-introduction.md#idp12945344)

6.34. [Icinga Web user admin](icinga-web-introduction.md#idp12948992)

6.35. [Icinga Web edit user](icinga-web-introduction.md#idp12956480)

6.36. [Icinga Web group admin](icinga-web-introduction.md#idp12960624)

6.37. [Icinga Web groups](icinga-web-introduction.md#idp12964016)

6.38. [Icinga Web logs](icinga-web-introduction.md#idp12969920)

6.39. [Icinga Web Tasks](icinga-web-introduction.md#idp12971888)

6.40. [Expander icon](icinga-web-pnp.md#idp12978784)

6.41. [Icon bar](icinga-web-pnp.md#idp12982528)

6.42. [Move icons to grid](icinga-web-pnp.md#idp12985728)

6.43. [New icons in grid](icinga-web-pnp.md#idp12989488)

6.44. [Reset icon view](icinga-web-pnp.md#idp12993504)

7.1. [Cached checks](cachedchecks.md#idp14963568)

8.1. [Average Host / Service Check Latency](perfgraphs.md#idp15912064)

8.2. [Service Statistics](perfgraphs.md#idp15930864)

8.3. [Host Statistics](perfgraphs.md#idp15941184)

8.4. [Average Execution Times](perfgraphs.md#idp15949184)

8.5. [External Commands](perfgraphs.md#idp15963744)

8.6. [External Command Buffers](perfgraphs.md#idp15972640)

8.7. [Cached Host and Service Checks](perfgraphs.md#idp15979200)

8.8. [Average State Changes](perfgraphs.md#idp15986928)

9.1. [Icinga reporting datasource IDO](reporting.md#idp16162240)

9.2. [Icinga reporting datasource ido mysql](reporting.md#idp16166592)

9.3. [Icinga reporting](reporting.md#idp16158080)

10.1. [NRPE](nrpe.md#idp16285728)

10.2. [NRPE remote](nrpe.md#idp16290448)

10.3. [NSCA](nsca.md#idp16451296)

12.1. [Multiple instances](db_intro.md#idp16875536)

12.2. [Future development: One Instance, multiple
databases](db_intro.md#idp16878736)

12.3. [Instance names based on geographical
locations](db_intro.md#idp16883696)

12.4. [Instance names based on their purpose](db_intro.md#idp16885424)

12.5. [Loaded IDOMOD Event broker
Module](db_components.md#idp16901856)

12.6. [IDOMOD Capabilities](db_components.md#idp16905824)

12.7. [LOG2IDO Utility](db_components.md#idp16912752)

12.8. [FILE2SOCK Utility](db_components.md#idp16916864)

12.9. [IDO2DB Daemon](db_components.md#idp16923008)

12.10. [IDO2DB with multiple Clients](db_components.md#idp16926224)

12.11. [Single Server, Single Instance
Setup](db_example-configs.md#idp17233424)

12.12. [Single Server, Multiple Instance
Setup](db_example-configs.md#idp17670208)

12.13. [Single Server, Single Instance Log File
Import](db_example-configs.md#idp17683536)

12.14. [Relationship of Central Tables](db_model.md#idp17721040)

12.15. [Relationship of Debugging Tables](db_model.md#idp17774736)

12.16. [Relationship of Historical Tables](db_model.md#idp17855152)

12.17. [Relationship of Current Status
Tables](db_model.md#idp18634352)

12.18. [Relationship of Configuration Tables](db_model.md#idp19198176)

**List of Tables**

2.1. [Screenshots Icinga classic web](beginners.md#idp190384)

2.2. [Screenshots Icinga new web](beginners.md#idp240352)

6.1. [Configuration files](icinga-web-config.md#idp12565344)

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
