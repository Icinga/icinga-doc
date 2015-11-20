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
1.2. [What's New in Icinga 1.13](whatsnew.md)

​2. [Getting Started](ch02.md)

2.1. [Advice for beginners](beginners.md)
2.2. [I'm a newbie to ...](newbie.md)
2.3. [Quickstart Installation Guides](quickstart.md)\
2.4. [Icinga Quickstart](quickstart-icinga.md)
2.5. [Icinga Quickstart FreeBSD](quickstart-icinga-freebsd.md)\
2.6. [Icinga with IDOUtils Quickstart](quickstart-idoutils.md)
2.7. [Icinga and IDOUtils Quickstart on FreeBSD](quickstart-idoutils-freebsd.md)\
2.8. [Icinga Packages for Linux Distributions](icinga_packages.md)\
2.9. [Links to other published Howtos](howtos.md)\
2.10. [Upgrading (to) Icinga](upgrading.md)
2.11. [Upgrading IDOUtils Database](upgrading_idoutils.md)\
2.12. [Monitoring Overview](monitoring-overview.md)\
2.13. [Monitoring Windows Machines](monitoring-windows.md)
2.14. [Monitoring Linux/Unix Machines](monitoring-linux.md)
2.15. [Monitoring Netware Servers](monitoring-netware.md)\
2.16. [Monitoring Network Printers](monitoring-printers.md)
2.17. [Monitoring Routers and Switches](monitoring-routers.md)
2.18. [Monitoring Publicly Available Services](monitoring-publicservices.md)

​3. [Configuring Icinga](ch03.md)

3.1. [Configuration Overview](config.md)

3.2. [Main Configuration File Options](configmain.md)

3.3. [Object Configuration Overview](configobject.md)

3.4. [Object Definitions](objectdefinitions.md)

3.5. [Custom Object Variables](customobjectvars.md)

3.6. [CGI Configuration File Options](configcgi.md)

​4. [Running Icinga](ch04.md)

4.1. [Verifying Your Configuration](verifyconfig.md)

4.2. [Starting and Stopping Icinga](startstop.md)

​5. [The Basics](ch05.md)

5.1. [Icinga Plugins](plugins.md)
5.2. [Understanding Macros and How They Work](macros.md)
5.3. [Standard Macros in Icinga](macrolist.md)
5.4. [Host Checks](hostchecks.md)
5.5. [Service Checks](servicechecks.md)
5.6. [Active Checks](activechecks.md)
5.7. [Passive Checks](passivechecks.md)
5.8. [State Types](statetypes.md)
5.9. [Time Periods](timeperiods.md)
5.10. [Determining Status and Reachability of Network Hosts](networkreachability.md)
5.11. [Notifications](notifications.md)
5.12. [Notifications: Examples and troubleshooting](notifications2.md)

​6. [User Interfaces](ch06.md)

6.1. [Icinga Classic UI: Information On The Modules](cgis.md)\
6.2. [Authentication And Authorization In The Classic UI](cgiauth.md)
6.3. [Information On Classic UI parameters](cgiparams.md)
6.4. [Executing Classic UI modules (CGIs) on the command line](cgicmd.md)
6.5. [Installation of the Icinga Web Frontend](icinga-web-scratch.md)
6.6. [Upgrading Icinga Web and Icinga Web Database](upgrading_icingaweb.md)
6.7. [Configuration Overview of Icinga Web](icinga-web-config.md)
6.8. [Introduction to Icinga Web](icinga-web-introduction.md)\
6.9. [Integration of PNP4Nagios into Icinga Web](icinga-web-pnp.md)

​7. [Advanced Topics](ch07.md)

7.1. [External Commands](extcommands.md)

7.2. [List of External Commands](extcommands2.md)

7.3. [Event Handlers](eventhandlers.md)

7.4. [Volatile Services](volatileservices.md)

7.5. [Service and Host Freshness Checks](freshness.md)

7.6. [Distributed Monitoring](distributed.md)

7.7. [Redundant and Failover Network Monitoring](redundancy.md)

7.8. [Detection and Handling of State Flapping](flapping.md)

7.9. [Notification Escalations](escalations.md)

7.10. [Escalation Condition](escalation_condition.md)

7.11. [On-Call Rotations](oncallrotation.md)

7.12. [Monitoring Service and Host Clusters](clusters.md)

7.13. [Host and Service Dependencies](dependencies.md)

7.14. [State Stalking](stalking.md)

7.15. [Performance Data](perfdata.md)

7.16. [Scheduled Downtime](downtime.md)

7.17. [Recurring Downtimes](recurring_downtimes.md)

7.18. [Using The Embedded Perl Interpreter](embeddedperl.md)

7.19. [Adaptive Monitoring](adaptive.md)

7.20. [Predictive Dependency Checks](dependencychecks.md)

7.21. [Cached Checks](cachedchecks.md)

7.22. [Passive Host State Translation](passivestatetranslation.md)

7.23. [Service and Host Check Scheduling](checkscheduling.md)

7.24. [Custom CGI Headers and Footers (Classic UI)](cgiincludes.md)

7.25. [Modified attributes](modified_attr.md)

7.26. [Object Inheritance](objectinheritance.md)

7.27. [Time-Saving Tricks For Object Definitions](objecttricks.md)

​8. [Security and Performance Tuning](ch08.md)

8.1. [Security Considerations](security.md)

8.2. [Enhanced Classic UI Security and Authentication](cgisecurity.md)

8.3. [Tuning Icinga For Maximum Performance](tuning.md)

8.4. [Fast Startup Options](faststartup.md)

8.5. [Large Installation Tweaks](largeinstalltweaks.md)

8.6. [Using The Icingastats Utility](icingastats.md)

8.7. [Graphing Performance Info With PNP4Nagios](perfgraphs.md)

8.8. [Temporary Data](temp_data.md)

​9. [Integration With Other Software](ch09.md)

9.1. [Integration Overview](integration.md)
9.2. [SNMP Trap Integration](int-snmptrap.md)\
9.3. [TCP Wrapper Integration](int-tcpwrappers.md)
9.4. [MKLiveStatus Integration](int-mklivestatus.md)
9.5. [Installation of the Icinga Reporting with JasperReports Server](reporting.md)

​10. [Additional software](ch10.md)

10.1. [Icinga Addons](addons.md)\
10.2. [NRPE](nrpe.md)
10.3. [NSCA](nsca.md)

​11. [Development](ch11.md)

11.1. [Icinga Plugin API](pluginapi.md)
11.2. [Developing Plugins For Use With Embedded Perl](epnplugins.md)
11.3. [No Icinga API to install anymore](icinga-api.md)\
11.4. [The Icinga Web REST API](icinga-web-api.md)

​12. [IDOUtils](ch12.md)

12.1. [Introduction](db_intro.md)

12.2. [Components](db_components.md)

12.3. [Configuration of IDOUtils](configido.md)

12.4. [Example Configurations](db_example-configs.md)

12.5. [IDOUtils Database Model](db_model.md)

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
