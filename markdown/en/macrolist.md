[Prev](macros.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](hostchecks.md)

* * * * *

5.3. Standard Macros in Icinga
------------------------------

5.3.1. [Macro Validity](macrolist.md#validity)

5.3.2. [Macro Availability Chart](macrolist.md#availabilitychart)

Standard macros that are available in Icinga are listed here. On-demand
macros and macros for custom variables are described
[here](macros.md "5.2. Understanding Macros and How They Work").

### 5.3.1. Macro Validity

Although macros can be used in all commands you define, not all macros
may be "valid" in a particular type of command. For example, some macros
may only be valid during service notification commands, whereas other
may only be valid during host check commands. There are ten types of
commands that Icinga recognizes and treats differently. They are as
follows:










10. Host [performance data](perfdata.md "7.15. Performance Data")

The tables below list all macros currently available in Icinga, along
with a brief description of each and the types of commands in which they
are valid. If a macro is used in a command in which it is invalid, it is
replaced with an empty string. It should be noted that macros consist of
all uppercase characters and are enclosed in **\$** characters.

### 5.3.2. Macro Availability Chart

**Legend:**

No

The macro is not available

Yes

The macro is available

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Host Macros: [^3^](macrolist.md#macrolist-note3)

 

 

 

 

 

 

 

 

[\$HOSTNAME\$](macrolist.md#macrolist-hostname)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTDISPLAYNAME\$](macrolist.md#macrolist-hostdisplayname)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTALIAS\$](macrolist.md#macrolist-hostalias)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTADDRESS\$](macrolist.md#macrolist-hostaddress)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTADDRESS6\$](macrolist.md#macrolist-hostaddress6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTSTATE\$](macrolist.md#macrolist-hoststate)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$HOSTSTATEID\$](macrolist.md#macrolist-hoststateid)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTSTATE\$](macrolist.md#macrolist-lasthoststate)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTSTATEID\$](macrolist.md#macrolist-lasthoststateid)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTSTATETYPE\$](macrolist.md#macrolist-hoststatetype)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$HOSTATTEMPT\$](macrolist.md#macrolist-hostattempt)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$MAXHOSTATTEMPTS\$](macrolist.md#macrolist-maxhostattempts)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTEVENTID\$](macrolist.md#macrolist-hosteventid)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTEVENTID\$](macrolist.md#macrolist-lasthosteventid)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTPROBLEMID\$](macrolist.md#macrolist-hostproblemid)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTPROBLEMID\$](macrolist.md#macrolist-lasthostproblemid)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTLATENCY\$](macrolist.md#macrolist-hostlatency)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTEXECUTIONTIME\$](macrolist.md#macrolist-hostexecutiontime)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$HOSTDURATION\$](macrolist.md#macrolist-hostduration)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTDURATIONSEC\$](macrolist.md#macrolist-hostdurationsec)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTDOWNTIME\$](macrolist.md#macrolist-hostdowntime)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTPERCENTCHANGE\$](macrolist.md#macrolist-hostpercentchange)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPNAME\$](macrolist.md#macrolist-hostgroupname)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPNAMES\$](macrolist.md#macrolist-hostgroupnames)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTCHECK\$](macrolist.md#macrolist-lasthostcheck)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTSTATECHANGE\$](macrolist.md#macrolist-lasthoststatechange)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTUP\$](macrolist.md#macrolist-lasthostup)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTDOWN\$](macrolist.md#macrolist-lasthostdown)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LASTHOSTUNREACHABLE\$](macrolist.md#macrolist-lasthostunreachable)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTOUTPUT\$](macrolist.md#macrolist-hostoutput)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$LONGHOSTOUTPUT\$](macrolist.md#macrolist-longhostoutput)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$HOSTPERFDATA\$](macrolist.md#macrolist-hostperfdata)

Yes

Yes

Yes [^1^](macrolist.md#macrolist-note1)

Yes

Yes

Yes

Yes

Yes

[\$HOSTCHECKCOMMAND\$](macrolist.md#macrolist-hostcheckcommand)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTACKAUTHOR\$](macrolist.md#macrolist-hostackauthor)
[^8^](macrolist.md#macrolist-note8)

No

No

No

Yes

No

No

No

No

[\$HOSTACKAUTHORNAME\$](macrolist.md#macrolist-hostackauthorname)
[^8^](macrolist.md#macrolist-note8)

No

No

No

Yes

No

No

No

No

[\$HOSTACKAUTHORALIAS\$](macrolist.md#macrolist-hostackauthoralias)
[^8^](macrolist.md#macrolist-note8)

No

No

No

Yes

No

No

No

No

[\$HOSTACKCOMMENT\$](macrolist.md#macrolist-hostackcomment)
[^8^](macrolist.md#macrolist-note8)

No

No

No

Yes

No

No

No

No

[\$HOSTACTIONURL\$](macrolist.md#macrolist-hostactionurl)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTNOTESURL\$](macrolist.md#macrolist-hostnotesurl)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTNOTES\$](macrolist.md#macrolist-hostnotes)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TOTALHOSTSERVICES\$](macrolist.md#macrolist-totalhostservices)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TOTALHOSTSERVICESOK\$](macrolist.md#macrolist-totalhostservicesok)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TOTALHOSTSERVICESWARNING\$](macrolist.md#macrolist-totalhostserviceswarning)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TOTALHOSTSERVICESUNKNOWN\$](macrolist.md#macrolist-totalhostservicesunknown)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TOTALHOSTSERVICESCRITICAL\$](macrolist.md#macrolist-totalhostservicescritical)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

**Macro Name**

Host Group Macros:

 

 

 

 

 

 

 

[\$HOSTGROUPALIAS\$](macrolist.md#macrolist-hostgroupalias)
[^5^](macrolist.md#macrolist-note5)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPMEMBERS\$](macrolist.md#macrolist-hostgroupmembers)
[^5^](macrolist.md#macrolist-note5)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPNOTES\$](macrolist.md#macrolist-hostgroupnotes)
[^5^](macrolist.md#macrolist-note5)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPNOTESURL\$](macrolist.md#macrolist-hostgroupnotesurl)
[^5^](macrolist.md#macrolist-note5)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTGROUPACTIONURL\$](macrolist.md#macrolist-hostgroupactionurl)
[^5^](macrolist.md#macrolist-note5)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Service Macros:

 

 

 

 

 

 

 

 

[\$SERVICEDESC\$](macrolist.md#macrolist-servicedesc)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEDISPLAYNAME\$](macrolist.md#macrolist-servicedisplayname)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICESTATE\$](macrolist.md#macrolist-servicestate)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$SERVICESTATEID\$](macrolist.md#macrolist-servicestateid)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICESTATE\$](macrolist.md#macrolist-lastservicestate)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICESTATEID\$](macrolist.md#macrolist-lastservicestateid)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICESTATETYPE\$](macrolist.md#macrolist-servicestatetype)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEATTEMPT\$](macrolist.md#macrolist-serviceattempt)

Yes

Yes

No

No

Yes

No

Yes

No

[\$MAXSERVICEATTEMPTS\$](macrolist.md#macrolist-maxserviceattempts)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEISVOLATILE\$](macrolist.md#macrolist-serviceisvolatile)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEEVENTID\$](macrolist.md#macrolist-serviceeventid)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICEEVENTID\$](macrolist.md#macrolist-lastserviceeventid)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEPROBLEMID\$](macrolist.md#macrolist-serviceproblemid)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICEPROBLEMID\$](macrolist.md#macrolist-lastserviceproblemid)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICELATENCY\$](macrolist.md#macrolist-servicelatency)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEEXECUTIONTIME\$](macrolist.md#macrolist-serviceexecutiontime)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$SERVICEDURATION\$](macrolist.md#macrolist-serviceduration)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEDURATIONSEC\$](macrolist.md#macrolist-servicedurationsec)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEDOWNTIME\$](macrolist.md#macrolist-servicedowntime)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEPERCENTCHANGE\$](macrolist.md#macrolist-servicepercentchange)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEGROUPNAME\$](macrolist.md#macrolist-servicegroupname)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEGROUPNAMES\$](macrolist.md#macrolist-servicegroupnames)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICECHECK\$](macrolist.md#macrolist-lastservicecheck)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICESTATECHANGE\$](macrolist.md#macrolist-lastservicestatechange)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICEOK\$](macrolist.md#macrolist-lastserviceok)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICEWARNING\$](macrolist.md#macrolist-lastservicewarning)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICEUNKNOWN\$](macrolist.md#macrolist-lastserviceunknown)

Yes

Yes

No

No

Yes

No

Yes

No

[\$LASTSERVICECRITICAL\$](macrolist.md#macrolist-lastservicecritical)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$LONGSERVICEOUTPUT\$](macrolist.md#macrolist-longserviceoutput)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)

Yes [^2^](macrolist.md#macrolist-note2)

Yes

No

No

Yes

No

Yes

No

[\$SERVICECHECKCOMMAND\$](macrolist.md#macrolist-servicecheckcommand)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICEACKAUTHOR\$](macrolist.md#macrolist-serviceackauthor)
[^8^](macrolist.md#macrolist-note8)

No

Yes

No

No

No

No

No

No

[\$SERVICEACKAUTHORNAME\$](macrolist.md#macrolist-serviceackauthorname)
[^8^](macrolist.md#macrolist-note8)

No

Yes

No

No

No

No

No

No

[\$SERVICEACKAUTHORALIAS\$](macrolist.md#macrolist-serviceackauthoralias)
[^8^](macrolist.md#macrolist-note8)

No

Yes

No

No

No

No

No

No

[\$SERVICEACKCOMMENT\$](macrolist.md#macrolist-serviceackcomment)
[^8^](macrolist.md#macrolist-note8)

No

Yes

No

No

No

No

No

No

[\$SERVICEACTIONURL\$](macrolist.md#macrolist-serviceactionurl)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICENOTESURL\$](macrolist.md#macrolist-servicenotesurl)

Yes

Yes

No

No

Yes

No

Yes

No

[\$SERVICENOTES\$](macrolist.md#macrolist-servicenotes)

Yes

Yes

No

No

Yes

No

Yes

No

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Service Group Macros:

 

 

 

 

 

 

 

 

[\$SERVICEGROUPALIAS\$](macrolist.md#macrolist-servicegroupalias)
[^6^](macrolist.md#macrolist-note6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SERVICEGROUPMEMBERS\$](macrolist.md#macrolist-servicegroupmembers)
[^6^](macrolist.md#macrolist-note6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SERVICEGROUPNOTES\$](macrolist.md#macrolist-servicegroupnotes)
[^6^](macrolist.md#macrolist-note6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SERVICEGROUPNOTESURL\$](macrolist.md#macrolist-servicegroupnotesurl)
[^6^](macrolist.md#macrolist-note6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SERVICEGROUPACTIONURL\$](macrolist.md#macrolist-servicegroupactionurl)
[^6^](macrolist.md#macrolist-note6)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Contact Macros:

 

 

 

 

 

 

 

 

[\$CONTACTNAME\$](macrolist.md#macrolist-contactname)

No

Yes

No

Yes

No

No

No

No

[\$CONTACTALIAS\$](macrolist.md#macrolist-contactalias)

No

Yes

No

Yes

No

No

No

No

[\$CONTACTEMAIL\$](macrolist.md#macrolist-contactemail)

No

Yes

No

Yes

No

No

No

No

[\$CONTACTPAGER\$](macrolist.md#macrolist-contactpager)

No

Yes

No

Yes

No

No

No

No

[\$CONTACTADDRESSn\$](macrolist.md#macrolist-contactaddress)

No

Yes

No

Yes

No

No

No

No

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Contact Group Macros:

 

 

 

 

 

 

 

 

[\$CONTACTGROUPALIAS\$](macrolist.md#macrolist-contactgroupalias)
[^7^](macrolist.md#macrolist-note7)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$CONTACTGROUPMEMBERS\$](macrolist.md#macrolist-contactgroupmembers)
[^7^](macrolist.md#macrolist-note7)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

 

 

 

 

 

 

 

 

[\$TOTALHOSTSUP\$](macrolist.md#macrolist-totalhostsup)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTSDOWN\$](macrolist.md#macrolist-totalhostsdown)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTSUNREACHABLE\$](macrolist.md#macrolist-totalhostsunreachable)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTSDOWNUNHANDLED\$](macrolist.md#macrolist-totalhostsdownunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTSUNREACHABLEUNHANDLED\$](macrolist.md#macrolist-totalhostsunreachableunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTPROBLEMS\$](macrolist.md#macrolist-totalhostproblems)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALHOSTPROBLEMSUNHANDLED\$](macrolist.md#macrolist-totalhostproblemsunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESOK\$](macrolist.md#macrolist-totalservicesok)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESWARNING\$](macrolist.md#macrolist-totalserviceswarning)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESCRITICAL\$](macrolist.md#macrolist-totalservicescritical)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESUNKNOWN\$](macrolist.md#macrolist-totalservicesunknown)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESWARNINGUNHANDLED\$](macrolist.md#macrolist-totalserviceswarningunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESCRITICALUNHANDLED\$](macrolist.md#macrolist-totalservicescriticalunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICESUNKNOWNUNHANDLED\$](macrolist.md#macrolist-totalservicesunknownunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICEPROBLEMS\$](macrolist.md#macrolist-totalserviceproblems)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

[\$TOTALSERVICEPROBLEMSUNHANDLED\$](macrolist.md#macrolist-totalserviceproblemsunhandled)
[^10^](macrolist.md#macrolist-note10)

Yes

Yes [^4^](macrolist.md#macrolist-note4)

Yes [^4^](macrolist.md#macrolist-note4)

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Notification Macros:

 

 

 

 

 

 

 

 

[\$NOTIFICATIONTYPE\$](macrolist.md#macrolist-notificationtype)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONRECIPIENTS\$](macrolist.md#macrolist-notificationrecipients)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONISESCALATED\$](macrolist.md#macrolist-notificationisescalated)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONAUTHOR\$](macrolist.md#macrolist-notificationauthor)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONAUTHORNAME\$](macrolist.md#macrolist-notificationauthorname)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONAUTHORALIAS\$](macrolist.md#macrolist-notificationauthoralias)

No

Yes

No

Yes

No

No

No

No

[\$NOTIFICATIONCOMMENT\$](macrolist.md#macrolist-notificationcomment)

No

Yes

No

Yes

No

No

No

No

[\$HOSTNOTIFICATIONNUMBER\$](macrolist.md#macrolist-hostnotificationnumber)

No

Yes

No

Yes

No

No

No

No

[\$HOSTNOTIFICATIONID\$](macrolist.md#macrolist-hostnotificationid)

No

Yes

No

Yes

No

No

No

No

[\$SERVICENOTIFICATIONNUMBER\$](macrolist.md#macrolist-servicenotificationnumber)

No

Yes

No

Yes

No

No

No

No

[\$SERVICENOTIFICATIONID\$](macrolist.md#macrolist-servicenotificationid)

No

Yes

No

Yes

No

No

No

No

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Date/Time Macros:

 

 

 

 

 

 

 

 

[\$LONGDATETIME\$](macrolist.md#macrolist-longdatetime)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SHORTDATETIME\$](macrolist.md#macrolist-shortdatetime)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$DATE\$](macrolist.md#macrolist-date)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TIME\$](macrolist.md#macrolist-time)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TIMET\$](macrolist.md#macrolist-timet)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$ISVALIDTIME:\$](macrolist.md#macrolist-isvalidtime)
[^9^](macrolist.md#macrolist-note9)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$NEXTVALIDTIME:\$](macrolist.md#macrolist-nextvalidtime)
[^9^](macrolist.md#macrolist-note9)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

File Macros:

 

 

 

 

 

 

 

 

[\$MAINCONFIGFILE\$](macrolist.md#macrolist-mainconfigfile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$STATUSDATAFILE\$](macrolist.md#macrolist-statusdatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$COMMENTDATAFILE\$](macrolist.md#macrolist-commentdatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes[^5^](macrolist.md#macrolist-note5)

[\$DOWNTIMEDATAFILE\$](macrolist.md#macrolist-downtimedatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$RETENTIONDATAFILE\$](macrolist.md#macrolist-retentiondatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$OBJECTCACHEFILE\$](macrolist.md#macrolist-objectcachefile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TEMPFILE\$](macrolist.md#macrolist-tempfile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$TEMPPATH\$](macrolist.md#macrolist-temppath)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$LOGFILE\$](macrolist.md#macrolist-logfile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$RESOURCEFILE\$](macrolist.md#macrolist-resourcefile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$COMMANDFILE\$](macrolist.md#macrolist-commandfile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$HOSTPERFDATAFILE\$](macrolist.md#macrolist-hostperfdatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$SERVICEPERFDATAFILE\$](macrolist.md#macrolist-serviceperfdatafile)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

 

 

 

 

 

 

 

 

 

**Macro Name**

**Service Checks**

**Service Notifications**

**Host Checks**

**Host Notifications**

**Service Event Handlers and
[OCSP](configmain.md#configmain-ocsp_command)**

**Host Event Handlers and
[OCHP](configmain.md#configmain-ochp_command)**

**Service Perf Data**

**Host Perf Data**

Misc Macros:

 

 

 

 

 

 

 

 

[\$PROCESSSTARTTIME\$](macrolist.md#macrolist-processstarttime)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$EVENTSTARTTIME\$](macrolist.md#macrolist-eventstarttime)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$ADMINEMAIL\$](macrolist.md#macrolist-adminemail)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$ADMINPAGER\$](macrolist.md#macrolist-adminpager)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$ARGn\$](macrolist.md#macrolist-arg)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

[\$USERn\$](macrolist.md#macrolist-user)

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

**Macro Descriptions**

Host Macros: [^3^](macrolist.md#macrolist-note3)

 

\$HOSTNAME\$

Short name for the host (i.e. "biglinuxbox"). This value is taken from
the *host\_name* directive in the [host
definition](objectdefinitions.md#objectdefinitions-host).

\$HOSTDISPLAYNAME\$

An alternate display name for the host. This value is taken from the
*display\_name* directive in the [host
definition](objectdefinitions.md#objectdefinitions-host).

\$HOSTALIAS\$

Long name/description for the host. This value is taken from the *alias*
directive in the [host
definition](objectdefinitions.md#objectdefinitions-host).

\$HOSTADDRESS\$

Address of the host. This value is taken from the *address* directive in
the [host definition](objectdefinitions.md#objectdefinitions-host).

\$HOSTADDRESS6\$

Secondary/IPv6 address of the host. This value is taken from the
*address6* directive in the [host
definition](objectdefinitions.md#objectdefinitions-host) (starting
with Icinga 1.3).

\$HOSTSTATE\$

A string indicating the current state of the host ("UP", "DOWN", or
"UNREACHABLE").

\$HOSTSTATEID\$

A number that corresponds to the current state of the host: 0=UP,
1=DOWN, 2=UNREACHABLE.

\$LASTHOSTSTATE\$

A string indicating the last state of the host ("UP", "DOWN", or
"UNREACHABLE").

\$LASTHOSTSTATEID\$

A number that corresponds to the last state of the host: 0=UP, 1=DOWN,
2=UNREACHABLE.

\$HOSTSTATETYPE\$

A string indicating the [state type](statetypes.md "5.8. State Types")
for the current host check ("HARD" or "SOFT"). Soft states occur when
host checks return a non-OK (non-UP) state and are in the process of
being retried. Hard states result when host checks have been checked a
specified maximum number of times.

\$HOSTATTEMPT\$

The number of the current host check retry. For instance, if this is the
second time that the host is being rechecked, this will be the number
two. Current attempt number is really only useful when writing host
event handlers for "soft" states that take a specific action based on
the host retry number.

\$MAXHOSTATTEMPTS\$

The max check attempts as defined for the current host. Useful when
writing host event handlers for "soft" states that take a specific
action based on the host retry number.

\$HOSTEVENTID\$

A globally unique number associated with the host's current state. Every
time a host (or service) experiences a state change, a global event ID
number is incremented by one (1). If a host has experienced no state
changes, this macro will be set to zero (0).

\$LASTHOSTEVENTID\$

The previous (globally unique) event number that was given to the host.

\$HOSTPROBLEMID\$

A globally unique number associated with the host's current problem
state. Every time a host (or service) transitions from an UP or OK state
to a problem state, a global problem ID number is incremented by one
(1). This macro will be non-zero if the host is currently a non-UP
state. State transitions between non-UP states (e.g. DOWN to
UNREACHABLE) do not cause this problem id to increase. If the host is
currently in an UP state, this macro will be set to zero (0). Combined
with event handlers, this macro could be used to automatically open
trouble tickets when hosts first enter a problem state.

\$LASTHOSTPROBLEMID\$

The previous (globally unique) problem number that was given to the
host. Combined with event handlers, this macro could be used for
automatically closing trouble tickets, etc. when a host recovers to an
UP state.

\$HOSTLATENCY\$

A (floating point) number indicating the number of seconds that a
*scheduled* host check lagged behind its scheduled check time. For
instance, if a check was scheduled for 03:14:15 and it didn't get
executed until 03:14:17, there would be a check latency of 2.0 seconds.
On-demand host checks have a latency of zero seconds.

\$HOSTEXECUTIONTIME\$

A (floating point) number indicating the number of seconds that the host
check took to execute (i.e. the amount of time the check was executing).

\$HOSTDURATION\$

A string indicating the amount of time that the host has spent in its
current state. Format is "XXh YYm ZZs", indicating hours, minutes and
seconds.

\$HOSTDURATIONSEC\$

A number indicating the number of seconds that the host has spent in its
current state.

\$HOSTDOWNTIME\$

A number indicating the current "downtime depth" for the host. If this
host is currently in a period of [scheduled
downtime](downtime.md "7.16. Scheduled Downtime"), the value will be
greater than zero. If the host is not currently in a period of downtime,
this value will be zero.

\$HOSTPERCENTCHANGE\$

A (floating point) number indicating the percent state change the host
has undergone. Percent state change is used by the [flap
detection](flapping.md "7.8. Detection and Handling of State Flapping")
algorithm.

\$HOSTGROUPNAME\$

The short name of the hostgroup that this host belongs to. This value is
taken from the *hostgroup\_name* directive in the [hostgroup
definition](objectdefinitions.md#objectdefinitions-hostgroup). If the
host belongs to more than one hostgroup this macro will contain the name
of just one of them.

\$HOSTGROUPNAMES\$

A comma separated list of the short names of all the hostgroups that
this host belongs to.

\$LASTHOSTCHECK\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which a check of the host was last performed.

\$LASTHOSTSTATECHANGE\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time the host last changed state.

\$LASTHOSTUP\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the host was last detected as being in an
UP state.

\$LASTHOSTDOWN\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the host was last detected as being in a
DOWN state.

\$LASTHOSTUNREACHABLE\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the host was last detected as being in an
UNREACHABLE state.

\$HOSTOUTPUT\$

The first line of text output from the last host check (i.e. "Ping OK").

\$LONGHOSTOUTPUT\$

The full text output (aside from the first line) from the last host
check.

\$HOSTPERFDATA\$

This macro contains any [performance
data](perfdata.md "7.15. Performance Data") that may have been
returned by the last host check.

\$HOSTCHECKCOMMAND\$

This macro contains the name of the command (along with any arguments
passed to it) used to perform the host check.

\$HOSTACKAUTHOR\$[^8^](macrolist.md#macrolist-note8)

A string containing the name of the user who acknowledged the host
problem. This macro is only valid in notifications where the
\$NOTIFICATIONTYPE\$ macro is set to "ACKNOWLEDGEMENT".

\$HOSTACKAUTHORNAME\$[^8^](macrolist.md#macrolist-note8)

A string containing the short name of the contact (if applicable) who
acknowledged the host problem. This macro is only valid in notifications
where the \$NOTIFICATIONTYPE\$ macro is set to "ACKNOWLEDGEMENT".

\$HOSTACKAUTHORALIAS\$[^8^](macrolist.md#macrolist-note8)

A string containing the alias of the contact (if applicable) who
acknowledged the host problem. This macro is only valid in notifications
where the \$NOTIFICATIONTYPE\$ macro is set to "ACKNOWLEDGEMENT".

\$HOSTACKCOMMENT\$[^8^](macrolist.md#macrolist-note8)

A string containing the acknowledgement comment that was entered by the
user who acknowledged the host problem. This macro is only valid in
notifications where the \$NOTIFICATIONTYPE\$ macro is set to
"ACKNOWLEDGEMENT".

\$HOSTACTIONURL\$

Action URL for the host. This macro may contain other macros (e.g.
\$HOSTNAME\$), which can be useful when you want to pass the host name
to a web page.

\$HOSTNOTESURL\$

Notes URL for the host. This macro may contain other macros (e.g.
\$HOSTNAME\$), which can be useful when you want to pass the host name
to a web page.

\$HOSTNOTES\$

Notes for the host. This macro may contain other macros (e.g.
\$HOSTNAME\$), which can be useful when you want to host-specific status
information, etc. in the description.

\$TOTALHOSTSERVICES\$

The total number of services associated with the host.

\$TOTALHOSTSERVICESOK\$

The total number of services associated with the host that are in an OK
state.

\$TOTALHOSTSERVICESWARNING\$

The total number of services associated with the host that are in a
WARNING state.

\$TOTALHOSTSERVICESUNKNOWN\$

The total number of services associated with the host that are in an
UNKNOWN state.

\$TOTALHOSTSERVICESCRITICAL\$

The total number of services associated with the host that are in a
CRITICAL state.

 

 

Host Group Macros: [^5^](macrolist.md#macrolist-note5)

 

\$HOSTGROUPALIAS\$[^5^](macrolist.md#macrolist-note5)

The long name / alias of either 1) the hostgroup name passed as an
on-demand macro argument or 2) the primary hostgroup associated with the
current host (if not used in the context of an on-demand macro). This
value is taken from the *alias* directive in the [hostgroup
definition](objectdefinitions.md#objectdefinitions-hostgroup).

\$HOSTGROUPMEMBERS\$[^5^](macrolist.md#macrolist-note5)

A comma-separated list of all hosts that belong to either 1) the
hostgroup name passed as an on-demand macro argument or 2) the primary
hostgroup associated with the current host (if not used in the context
of an on-demand macro).

\$HOSTGROUPNOTES\$[^5^](macrolist.md#macrolist-note5)

The notes associated with either 1) the hostgroup name passed as an
on-demand macro argument or 2) the primary hostgroup associated with the
current host (if not used in the context of an on-demand macro). This
value is taken from the *notes* directive in the [hostgroup
definition](objectdefinitions.md#objectdefinitions-hostgroup).

\$HOSTGROUPNOTESURL\$[^5^](macrolist.md#macrolist-note5)

The notes URL associated with either 1) the hostgroup name passed as an
on-demand macro argument or 2) the primary hostgroup associated with the
current host (if not used in the context of an on-demand macro). This
value is taken from the *notes\_url* directive in the [hostgroup
definition](objectdefinitions.md#objectdefinitions-hostgroup).

\$HOSTGROUPACTIONURL\$[^5^](macrolist.md#macrolist-note5)

The action URL associated with either 1) the hostgroup name passed as an
on-demand macro argument or 2) the primary hostgroup associated with the
current host (if not used in the context of an on-demand macro). This
value is taken from the *action\_url* directive in the [hostgroup
definition](objectdefinitions.md#objectdefinitions-hostgroup).

 

 

Service Macros:

 

\$SERVICEDESC\$

The long name/description of the service (i.e. "Main Website"). This
value is taken from the *service\_description* directive of the [service
definition](objectdefinitions.md#objectdefinitions-service).

\$SERVICEDISPLAYNAME\$

An alternate display name for the service. This value is taken from the
*display\_name* directive in the [service
definition](objectdefinitions.md#objectdefinitions-service).

\$SERVICESTATE\$

A string indicating the current state of the service ("OK", "WARNING",
"UNKNOWN", or "CRITICAL").

\$SERVICESTATEID\$

A number that corresponds to the current state of the service: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN.

\$LASTSERVICESTATE\$

A string indicating the last state of the service ("OK", "WARNING",
"UNKNOWN", or "CRITICAL").

\$LASTSERVICESTATEID\$

A number that corresponds to the last state of the service: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN.

\$SERVICESTATETYPE\$

A string indicating the [state type](statetypes.md "5.8. State Types")
for the current service check ("HARD" or "SOFT"). Soft states occur when
service checks return a non-OK state and are in the process of being
retried. Hard states result when service checks have been checked a
specified maximum number of times.

\$SERVICEATTEMPT\$

The number of the current service check retry. For instance, if this is
the second time that the service is being rechecked, this will be the
number two. Current attempt number is really only useful when writing
service event handlers for "soft" states that take a specific action
based on the service retry number.

\$MAXSERVICEATTEMPTS\$

The max check attempts as defined for the current service. Useful when
writing host event handlers for "soft" states that take a specific
action based on the service retry number.

\$SERVICEISVOLATILE\$

Indicates whether the service is marked as being volatile or not: 0 =
not volatile, 1 = volatile.

\$SERVICEEVENTID\$

A globally unique number associated with the service's current state.
Every time a a service (or host) experiences a state change, a global
event ID number is incremented by one (1). If a service has experienced
no state changes, this macro will be set to zero (0).

\$LASTSERVICEEVENTID\$

The previous (globally unique) event number that given to the service.

\$SERVICEPROBLEMID\$

A globally unique number associated with the service's current problem
state. Every time a service (or host) transitions from an OK or UP state
to a problem state, a global problem ID number is incremented by one
(1). This macro will be non-zero if the service is currently a non-OK
state. State transitions between non-OK states (e.g. WARNING to
CRITICAL) do not cause this problem id to increase. If the service is
currently in an OK state, this macro will be set to zero (0). Combined
with event handlers, this macro could be used to automatically open
trouble tickets when services first enter a problem state.

\$LASTSERVICEPROBLEMID\$

The previous (globally unique) problem number that was given to the
service. Combined with event handlers, this macro could be used for
automatically closing trouble tickets, etc. when a service recovers to
an OK state.

\$SERVICELATENCY\$

A (floating point) number indicating the number of seconds that a
scheduled service check lagged behind its scheduled check time. For
instance, if a check was scheduled for 03:14:15 and it didn't get
executed until 03:14:17, there would be a check latency of 2.0 seconds.

\$SERVICEEXECUTIONTIME\$

A (floating point) number indicating the number of seconds that the
service check took to execute (i.e. the amount of time the check was
executing).

\$SERVICEDURATION\$

A string indicating the amount of time that the service has spent in its
current state. Format is "XXh YYm ZZs", indicating hours, minutes and
seconds.

\$SERVICEDURATIONSEC\$

A number indicating the number of seconds that the service has spent in
its current state.

\$SERVICEDOWNTIME\$

A number indicating the current "downtime depth" for the service. If
this service is currently in a period of [scheduled
downtime](downtime.md "7.16. Scheduled Downtime"), the value will be
greater than zero. If the service is not currently in a period of
downtime, this value will be zero.

\$SERVICEPERCENTCHANGE\$

A (floating point) number indicating the percent state change the
service has undergone. Percent state change is used by the [flap
detection](flapping.md "7.8. Detection and Handling of State Flapping")
algorithm.

\$SERVICEGROUPNAME\$

The short name of the servicegroup that this service belongs to. This
value is taken from the *servicegroup\_name* directive in the
[servicegroup](objectdefinitions.md#objectdefinitions-servicegroup)
definition. If the service belongs to more than one servicegroup this
macro will contain the name of just one of them.

\$SERVICEGROUPNAMES\$

A comma separated list of the short names of all the servicegroups that
this service belongs to.

\$LASTSERVICECHECK\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which a check of the service was last performed.

\$LASTSERVICESTATECHANGE\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time the service last changed state.

\$LASTSERVICEOK\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the service was last detected as being in
an OK state.

\$LASTSERVICEWARNING\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the service was last detected as being in a
WARNING state.

\$LASTSERVICEUNKNOWN\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the service was last detected as being in
an UNKNOWN state.

\$LASTSERVICECRITICAL\$

This is a timestamp in time\_t format (seconds since the UNIX epoch)
indicating the time at which the service was last detected as being in a
CRITICAL state.

\$SERVICEOUTPUT\$

The first line of text output from the last service check (i.e. "Ping
OK").

\$LONGSERVICEOUTPUT\$

The full text output (aside from the first line) from the last service
check.

\$SERVICEPERFDATA\$

This macro contains any [performance
data](perfdata.md "7.15. Performance Data") that may have been
returned by the last service check.

\$SERVICECHECKCOMMAND\$

This macro contains the name of the command (along with any arguments
passed to it) used to perform the service check.

\$SERVICEACKAUTHOR\$[^8^](macrolist.md#macrolist-note8)

A string containing the name of the user who acknowledged the service
problem. This macro is only valid in notifications where the
\$NOTIFICATIONTYPE\$ macro is set to "ACKNOWLEDGEMENT".

\$SERVICEACKAUTHORNAME\$[^8^](macrolist.md#macrolist-note8)

A string containing the short name of the contact (if applicable) who
acknowledged the service problem. This macro is only valid in
notifications where the \$NOTIFICATIONTYPE\$ macro is set to
"ACKNOWLEDGEMENT".

\$SERVICEACKAUTHORALIAS\$[^8^](macrolist.md#macrolist-note8)

A string containing the alias of the contact (if applicable) who
acknowledged the service problem. This macro is only valid in
notifications where the \$NOTIFICATIONTYPE\$ macro is set to
"ACKNOWLEDGEMENT".

\$SERVICEACKCOMMENT\$[^8^](macrolist.md#macrolist-note8)

A string containing the acknowledgement comment that was entered by the
user who acknowledged the service problem. This macro is only valid in
notifications where the \$NOTIFICATIONTYPE\$ macro is set to
"ACKNOWLEDGEMENT".

\$SERVICEACTIONURL\$

Action URL for the service. This macro may contain other macros (e.g.
\$HOSTNAME\$ or \$SERVICEDESC\$), which can be useful when you want to
pass the service name to a web page.

\$SERVICENOTESURL\$

Notes URL for the service. This macro may contain other macros (e.g.
\$HOSTNAME\$ or \$SERVICEDESC\$), which can be useful when you want to
pass the service name to a web page.

\$SERVICENOTES\$

Notes for the service. This macro may contain other macros (e.g.
\$HOSTNAME\$ or \$SERVICESTATE\$), which can be useful when you want to
service-specific status information, etc. in the description

 

 

Service Group Macros: [^6^](macrolist.md#macrolist-note6)

 

\$SERVICEGROUPALIAS\$[^6^](macrolist.md#macrolist-note6)

The long name / alias of either 1) the servicegroup name passed as an
on-demand macro argument or 2) the primary servicegroup associated with
the current service (if not used in the context of an on-demand macro).
This value is taken from the *alias* directive in the [servicegroup
definition](objectdefinitions.md#objectdefinitions-servicegroup).

\$SERVICEGROUPMEMBERS\$[^6^](macrolist.md#macrolist-note6)

A comma-separated list of all services that belong to either 1) the
servicegroup name passed as an on-demand macro argument or 2) the
primary servicegroup associated with the current service (if not used in
the context of an on-demand macro).

\$SERVICEGROUPNOTES\$[^6^](macrolist.md#macrolist-note6)

The notes associated with either 1) the servicegroup name passed as an
on-demand macro argument or 2) the primary servicegroup associated with
the current service (if not used in the context of an on-demand macro).
This value is taken from the *notes* directive in the [servicegroup
definition](objectdefinitions.md#objectdefinitions-servicegroup).

\$SERVICEGROUPNOTESURL\$[^6^](macrolist.md#macrolist-note6)

The notes URL associated with either 1) the servicegroup name passed as
an on-demand macro argument or 2) the primary servicegroup associated
with the current service (if not used in the context of an on-demand
macro). This value is taken from the *notes\_url* directive in the
[servicegroup
definition](objectdefinitions.md#objectdefinitions-servicegroup).

\$SERVICEGROUPNOTES\$[^6^](macrolist.md#macrolist-note6)

The action URL associated with either 1) the servicegroup name passed as
an on-demand macro argument or 2) the primary servicegroup associated
with the current service (if not used in the context of an on-demand
macro). This value is taken from the *action\_url* directive in the
[servicegroup
definition](objectdefinitions.md#objectdefinitions-servicegroup).

 

 

Contact Macros:

 

\$CONTACTNAME\$

Short name for the contact (i.e. "jdoe") that is being notified of a
host or service problem. This value is taken from the *contact\_name*
directive in the [contact
definition](objectdefinitions.md#objectdefinitions-contact).

\$CONTACTALIAS\$

Long name/description for the contact (i.e. "John Doe") being notified.
This value is taken from the *alias* directive in the [contact
definition](objectdefinitions.md#objectdefinitions-contact).

\$CONTACTEMAIL\$

Email address of the contact being notified. This value is taken from
the *email* directive in the [contact
definition](objectdefinitions.md#objectdefinitions-contact).

\$CONTACTPAGER\$

Pager number/address of the contact being notified. This value is taken
from the *pager* directive in the [contact
definition](objectdefinitions.md#objectdefinitions-contact).

\$CONTACTADDRESSn\$

Address of the contact being notified. Each contact can have six
different addresses (in addition to email address and pager number). The
\$CONTACTADDRESS6\$. This value is taken from the *addressx* directive
in the [contact
definition](objectdefinitions.md#objectdefinitions-contact).

\$CONTACTGROUPNAME\$

The short name of the contactgroup that this contact is a member of.
This value is taken from the *contactgroup\_name* directive in the
[contactgroup](objectdefinitions.md#objectdefinitions-contactgroup)
definition. If the contact belongs to more than one contactgroup this
macro will contain the name of just one of them.

\$CONTACTGROUPNAMES\$

A comma separated list of the short names of all the contactgroups that
this contact is a member of.

 

 

Contact Group Macros: [^5^](macrolist.md#macrolist-note5)

 

\$CONTACTGROUPALIAS\$[^7^](macrolist.md#macrolist-note7)

The long name / alias of either 1) the contactgroup name passed as an
on-demand macro argument or 2) the primary contactgroup associated with
the current contact (if not used in the context of an on-demand macro).
This value is taken from the *alias* directive in the [contactgroup
definition](objectdefinitions.md#objectdefinitions-contactgroup).

\$CONTACTGROUPMEMBERS\$[^7^](macrolist.md#macrolist-note7)

A comma-separated list of all contacts that belong to either 1) the
contactgroup name passed as an on-demand macro argument or 2) the
primary contactgroup associated with the current contact (if not used in
the context of an on-demand macro).

 

 

SUMMARY Macros:

 

\$TOTALHOSTSUP\$

This macro reflects the total number of hosts that are currently in an
UP state.

\$TOTALHOSTSDOWN\$

This macro reflects the total number of hosts that are currently in a
DOWN state.

\$TOTALHOSTSUNREACHABLE\$

This macro reflects the total number of hosts that are currently in an
UNREACHABLE state.

\$TOTALHOSTSDOWNUNHANDLED\$

This macro reflects the total number of hosts that are currently in a
DOWN state that are not currently being "handled". Unhandled host
problems are those that are not acknowledged, are not currently in
scheduled downtime, and for which checks are currently enabled.

\$TOTALHOSTSUNREACHABLEUNHANDLED\$

This macro reflects the total number of hosts that are currently in an
UNREACHABLE state that are not currently being "handled". Unhandled host
problems are those that are not acknowledged, are not currently in
scheduled downtime, and for which checks are currently enabled.

\$TOTALHOSTPROBLEMS\$

This macro reflects the total number of hosts that are currently either
in a DOWN or an UNREACHABLE state.

\$TOTALHOSTPROBLEMSUNHANDLED\$

This macro reflects the total number of hosts that are currently either
in a DOWN or an UNREACHABLE state that are not currently being
"handled". Unhandled host problems are those that are not acknowledged,
are not currently in scheduled downtime, and for which checks are
currently enabled.

\$TOTALSERVICESOK\$

This macro reflects the total number of services that are currently in
an OK state.

\$TOTALSERVICESWARNING\$

This macro reflects the total number of services that are currently in a
WARNING state.

\$TOTALSERVICESCRITICAL\$

This macro reflects the total number of services that are currently in a
CRITICAL state.

\$TOTALSERVICESUNKNOWN\$

This macro reflects the total number of services that are currently in
an UNKNOWN state.

\$TOTALSERVICESWARNINGUNHANDLED\$

This macro reflects the total number of services that are currently in a
WARNING state that are not currently being "handled". Unhandled services
problems are those that are not acknowledged, are not currently in
scheduled downtime, and for which checks are currently enabled.

\$TOTALSERVICESCRITICALUNHANDLED\$

This macro reflects the total number of services that are currently in a
CRITICAL state that are not currently being "handled". Unhandled
services problems are those that are not acknowledged, are not currently
in scheduled downtime, and for which checks are currently enabled.

\$TOTALSERVICESUNKNOWNUNHANDLED\$

This macro reflects the total number of services that are currently in
an UNKNOWN state that are not currently being "handled". Unhandled
services problems are those that are not acknowledged, are not currently
in scheduled downtime, and for which checks are currently enabled.

\$TOTALSERVICEPROBLEMS\$

This macro reflects the total number of services that are currently
either in a WARNING, CRITICAL, or UNKNOWN state.

\$TOTALSERVICEPROBLEMSUNHANDLED\$

This macro reflects the total number of services that are currently
either in a WARNING, CRITICAL, or UNKNOWN state that are not currently
being "handled". Unhandled services problems are those that are not
acknowledged, are not currently in scheduled downtime, and for which
checks are currently enabled.

 

 

Notification Macros:

 

\$NOTIFICATIONTYPE\$

A string identifying the type of notification that is being sent
("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART",
"FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND", or
"DOWNTIMECANCELLED").

\$NOTIFICATIONRECIPIENTS\$

A comma-separated list of the short names of all contacts that are being
notified about the host or service.

\$NOTIFICATIONISESCALATED\$

An integer indicating whether this was sent to normal contacts for the
host or service or if it was escalated. 0 = Normal (non-escalated)
notification , 1 = Escalated notification.

\$NOTIFICATIONAUTHOR\$

A string containing the name of the user who authored the notification.
If the \$NOTIFICATIONTYPE\$ macro is set to "DOWNTIMESTART" or
"DOWNTIMEEND", this will be the name of the user who scheduled downtime
for the host or service. If the \$NOTIFICATIONTYPE\$ macro is
"ACKNOWLEDGEMENT", this will be the name of the user who acknowledged
the host or service problem. If the \$NOTIFICATIONTYPE\$ macro is
"CUSTOM", this will be name of the user who initated the custom host or
service notification.

\$NOTIFICATIONAUTHORNAME\$

A string containing the short name of the contact (if applicable)
specified in the \$NOTIFICATIONAUTHOR\$ macro.

\$NOTIFICATIONAUTHORALIAS\$

A string containing the alias of the contact (if applicable) specified
in the \$NOTIFICATIONAUTHOR\$ macro.

\$NOTIFICATIONCOMMENT\$

A string containing the comment that was entered by the notification
author. If the \$NOTIFICATIONTYPE\$ macro is set to "DOWNTIMESTART" or
"DOWNTIMEEND", this will be the comment entered by the user who
scheduled downtime for the host or service. If the \$NOTIFICATIONTYPE\$
macro is "ACKNOWLEDGEMENT", this will be the comment entered by the user
who acknowledged the host or service problem. If the
\$NOTIFICATIONTYPE\$ macro is "CUSTOM", this will be comment entered by
the user who initated the custom host or service notification.

\$HOSTNOTIFICATIONNUMBER\$

The current notification number for the host. The notification number
increases by one (1) each time a new notification is sent out for the
host (except for acknowledgements). The notification number is reset to
0 when the host recovers (*after* the recovery notification has gone
out). Acknowledgements do not cause the notification number to increase,
nor do notifications dealing with flap detection or scheduled downtime.

\$HOSTNOTIFICATIONID\$

A unique number identifying a host notification. Notification ID numbers
are unique across both hosts and service notifications, so you could
potentially use this unique number as a primary key in a notification
database. Notification ID numbers should remain unique across restarts
of the Icinga process, so long as you have state retention enabled. The
notification ID number is incremented by one (1) each time a new host
notification is sent out, and regardless of how many contacts are
notified.

\$SERVICENOTIFICATIONNUMBER\$

The current notification number for the service. The notification number
increases by one (1) each time a new notification is sent out for the
service (except for acknowledgements). The notification number is reset
to 0 when the service recovers (*after* the recovery notification has
gone out). Acknowledgements do not cause the notification number to
increase, nor do notifications dealing with flap detection or scheduled
downtime.

\$SERVICENOTIFICATIONID\$

A unique number identifying a service notification. Notification ID
numbers are unique across both hosts and service notifications, so you
could potentially use this unique number as a primary key in a
notification database. Notification ID numbers should remain unique
across restarts of the Icinga process, so long as you have state
retention enabled. The notification ID number is incremented by one (1)
each time a new service notification is sent out, and regardless of how
many contacts are notified.

 

 

Date/Time Macros:

 

\$LONGDATETIME\$

Current date/time stamp (i.e. *Fri Oct 13 00:30:28 CDT 2000*). Format of
date is determined by
[date\_format](configmain.md#configmain-date_format) directive.

\$SHORTDATETIME\$

Current date/time stamp (i.e. *10-13-2000 00:30:28*). Format of date is
determined by [date\_format](configmain.md#configmain-date_format)
directive.

\$DATE\$

Date stamp (i.e. *10-13-2000*). Format of date is determined by
[date\_format](configmain.md#configmain-date_format) directive.

\$TIME\$

Current time stamp (i.e. *00:30:28*).

\$TIMET\$

Current time stamp in time\_t format (seconds since the UNIX epoch).

\$ISVALIDTIME:\$[^9^](macrolist.md#macrolist-note9)

This is a special on-demand macro that returns a 1 or 0 depending on
whether or not a particular time is valid within a specified timeperiod.
There are two ways of using this macro:



\$NEXTVALIDTIME:\$[^9^](macrolist.md#macrolist-note9)

This is a special on-demand macro that returns the next valid time (in
time\_t format) for a specified timeperiod. There are two ways of using
this macro:



If a next valid time cannot be found in the specified timeperiod, the
macro will be set to "0".

 

 

File Macros:

 

\$MAINCONFIGFILE\$

The location of the [main config
file](configmain.md "3.2. Main Configuration File Options").

\$STATUSDATAFILE\$

The location of the [status data
file](configmain.md#configmain-status_file).

\$COMMENTDATAFILE\$

The location of the comment data file.

\$DOWNTIMEDATAFILE\$

The location of the downtime data file.

\$RETENTIONDATAFILE\$

The location of the [retention data
file](configmain.md#configmain-state_retention_file).

\$OBJECTCACHEFILE\$

The location of the [object cache
file](configmain.md#configmain-object_cache_file).

\$TEMPFILE\$

The location of the [temp file](configmain.md#configmain-temp_file).

\$TEMPPATH\$

The directory specified by the [temp
path](configmain.md#configmain-temp_path) variable.

\$LOGFILE\$

The location of the [log file](configmain.md#configmain-log_file).

\$RESOURCEFILE\$

The location of the [resource
file](configmain.md#configmain-resource_file).

\$COMMANDFILE\$

The location of the [command
file](configmain.md#configmain-command_file).

\$HOSTPERFDATAFILE\$

The location of the host performance data file (if defined).

\$SERVICEPERFDATAFILE\$

The location of the service performance data file (if defined).

 

 

Misc Macros:

 

\$PROCESSSTARTTIME\$

Time stamp in time\_t format (seconds since the UNIX epoch) indicating
when the Icinga process was last (re)started. You can determine the
number of seconds that Icinga has been running (since it was last
restarted) by subtracting \$PROCESSSTARTTIME\$ from
[\$TIMET\$](macrolist.md#macrolist-timet).

\$EVENTSTARTTIME\$

Time stamp in time\_t format (seconds since the UNIX epoch) indicating
when the Icinga process starting process events (checks, etc.). You can
determine the number of seconds that it took for Icinga to startup by
subtracting \$PROCESSSTARTTIME\$ from \$EVENTSTARTTIME\$.

\$ADMINEMAIL\$

Global administrative email address. This value is taken from the
[admin\_email](configmain.md#configmain-admin_email) directive.

\$ADMINPAGER\$

Global administrative pager number/address. This value is taken from the
[admin\_pager](configmain.md#configmain-admin_pager) directive.

\$ARGn\$

The *n*th argument passed to the command (notification, event handler,
service check, etc.). Icinga supports up to 32 argument macros (\$ARG1\$
through \$ARG32\$).

\$USERn\$

The *n*th user-definable macro. User macros can be defined in one or
more [resource files](configmain.md#configmain-resource_file). Icinga
supports up to 256 user macros (\$USER1\$ through \$USER256\$).

**Notes**

**^1^** These macros are not valid for the host they are associated with
when that host is being checked (i.e. they make no sense, as they
haven't been determined yet).

**^2^** These macros are not valid for the service they are associated
with when that service is being checked (i.e. they make no sense, as
they haven't been determined yet).

**^3^** When host macros are used in service-related commands (i.e.
service notifications, event handlers, etc) they refer to they host that
they service is associated with.

**^4^** When host and service summary macros are used in notification
commands, the totals are filtered to reflect only those hosts and
services for which the contact is authorized (i.e. hosts and services
they are configured to receive notifications for).

**^5^** These macros are normally associated with the first/primary
hostgroup associated with the current host. They could therefore be
considered host macros in many cases. However, these macros are not
available as on-demand host macros. Instead, they can be used as
on-demand hostgroup macros when you pass the name of a hostgroup to the
macro. For example: \$HOSTGROUPMEMBERS:hg1\$ would return a
comma-delimited list of all (host) members of the hostgroup *hg1*.

**^6^** These macros are normally associated with the first/primary
servicegroup associated with the current service. They could therefore
be considered service macros in many cases. However, these macros are
not available as on-demand service macros. Instead, they can be used as
on-demand servicegroup macros when you pass the name of a servicegroup
to the macro. For example: \$SERVICEGROUPMEMBERS:sg1\$ would return a
comma-delimited list of all (service) members of the servicegroup *sg1*.

**^7^** These macros are normally associated with the first/primary
contactgroup associated with the current contact. They could therefore
be considered contact macros in many cases. However, these macros are
not available as on-demand contact macros. Instead, they can be used as
on-demand contactgroup macros when you pass the name of a contactgroup
to the macro. For example: \$CONTACTGROUPMEMBERS:cg1\$ would return a
comma-delimited list of all (contact) members of the contactgroup *cg1*.

**^8^** These acknowledgement macros are deprecated. Use the more
generic \$NOTIFICATIONAUTHOR\$, \$NOTIFICATIONAUTHORNAME\$,
\$NOTIFICATIONAUTHORALIAS\$ or \$NOTIFICATIONCOMMENT\$ macros instead.

must supply an additional argument with them in order to use them. These
macros are not available as environment variables.

**^10^** Summary macros are not available as environment variables if
the
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
option is enabled, as they are quite CPU-intensive to calculate.

* * * * *

[Prev](macros.md) | [Up](ch05.md) | [Next](hostchecks.md)

5.2. Understanding Macros and How They Work  |<=== [Index](index.md) ===>|  5.4. Host Checks

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
