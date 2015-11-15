![Icinga](../images/logofullsize.png "Icinga")

5.3. Standard-Makros in Icinga

[Zurück](macros.md) 

Kapitel 5. Die Grundlagen

 [Weiter](hostchecks.md)

* * * * *

5.3. Standard-Makros in Icinga
------------------------------

5.3.1. [Makro-Geltungsbereich](macrolist.md#validity)

5.3.2.
[Makroverfügbarkeits-Aufstellung](macrolist.md#availabilitychart)

In Icinga verfügbare Standard-Makros sind hier aufgelistet.
On-Demand-Makros und Makros für Benutzervariablen sind
[hier](macros.md "5.2. Makros verstehen und wie sie arbeiten")
beschrieben.

### 5.3.1. Makro-Geltungsbereich

Obwohl Makros in allen Befehlen benutzt werden können, die Sie
definieren, sind sie ggf. nicht "gültig" innerhalb eines bestimmten
Befehlstyps. Zum Beispiel sind einige Makros vielleicht nur gültig bei
Service-Benachrichtigungen, andere vielleicht nur bei Host-Prüfungen. Es
gibt zehn Arten von Befehlen, die Icinga erkennt und unterschiedlich
behandelt. Dies sind:

1.  Service-Prüfungen

2.  Service-Benachrichtigungen

3.  Host-Prüfungen

4.  Host-Benachrichtigungen

5.  Service-[Eventhandler](eventhandlers.md "7.3. Eventhandler")
    und/oder ein globaler Service-Eventhandler

6.  Host-[Eventhandler](eventhandlers.md "7.3. Eventhandler") und/oder
    ein globaler Host-Eventhandler

7.  [OCSP](configmain.md#configmain-ocsp_command) Befehl

8.  [OCHP](configmain.md#configmain-ochp_command) Befehl

9.  Service-[Performance-Daten](perfdata.md "7.15. Performance-Daten")
    Befehle

10. Host-[Performance-Daten](perfdata.md "7.15. Performance-Daten")
    Befehle

Die nachfolgenden Aufstellungen enthalten alle aktuell in Icinga
verfügbaren Makros zusammen mit einer kurzen Beschreibung und den
Befehlstypen, in denen sie gelten. Wenn ein Makro in einem Befehl
benutzt wird, in dem es nicht gültig ist, wird es durch eine leere
Zeichenkette ersetzt. Es ist zu beachten, dass Makros aus Großbuchstaben
bestehen und in Dollarzeichen (\$) eingeschlossen werden.

### 5.3.2. Makroverfügbarkeits-Aufstellung

**Legende:**

Nein

Das Makro ist nicht verfügbar

Ja

Das Makro ist verfügbar

**Makroname**

**Service-Prüfungen**

**Service-Benachrichtigungen**

**Host-Prüfungen**

**Host-Benachrichtigungen**

**Service-Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host-Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service-Perf-Daten**

**Host-Perf-Daten**

Host-Makros: [^3^](macrolist.md#macrolist-note3)

[\$HOSTNAME\$](macrolist.md#macrolist-hostname)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTDISPLAYNAME\$](macrolist.md#macrolist-hostdisplayname)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTALIAS\$](macrolist.md#macrolist-hostalias)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTADDRESS\$](macrolist.md#macrolist-hostaddress)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTADDRESS6\$](macrolist.md#macrolist-hostaddress6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTSTATE\$](macrolist.md#macrolist-hoststate)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$HOSTSTATEID\$](macrolist.md#macrolist-hoststateid)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTSTATE\$](macrolist.md#macrolist-lasthoststate)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTSTATEID\$](macrolist.md#macrolist-lasthoststateid)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTSTATETYPE\$](macrolist.md#macrolist-hoststatetype)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$HOSTATTEMPT\$](macrolist.md#macrolist-hostattempt)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$MAXHOSTATTEMPTS\$](macrolist.md#macrolist-maxhostattempts)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTEVENTID\$](macrolist.md#macrolist-hosteventid)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTEVENTID\$](macrolist.md#macrolist-lasthosteventid)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTPROBLEMID\$](macrolist.md#macrolist-hostproblemid)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTPROBLEMID\$](macrolist.md#macrolist-lasthostproblemid)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTLATENCY\$](macrolist.md#macrolist-hostlatency)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTEXECUTIONTIME\$](macrolist.md#macrolist-hostexecutiontime)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$HOSTDURATION\$](macrolist.md#macrolist-hostduration)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTDURATIONSEC\$](macrolist.md#macrolist-hostdurationsec)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTDOWNTIME\$](macrolist.md#macrolist-hostdowntime)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTPERCENTCHANGE\$](macrolist.md#macrolist-hostpercentchange)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPNAME\$](macrolist.md#macrolist-hostgroupname)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPNAMES\$](macrolist.md#macrolist-hostgroupnames)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTCHECK\$](macrolist.md#macrolist-lasthostcheck)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTSTATECHANGE\$](macrolist.md#macrolist-lasthoststatechange)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTUP\$](macrolist.md#macrolist-lasthostup)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTDOWN\$](macrolist.md#macrolist-lasthostdown)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LASTHOSTUNREACHABLE\$](macrolist.md#macrolist-lasthostunreachable)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTOUTPUT\$](macrolist.md#macrolist-hostoutput)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$LONGHOSTOUTPUT\$](macrolist.md#macrolist-longhostoutput)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$HOSTPERFDATA\$](macrolist.md#macrolist-hostperfdata)

Ja

Ja

Ja [^1^](macrolist.md#macrolist-note1)

Ja

Ja

Ja

Ja

Ja

[\$HOSTCHECKCOMMAND\$](macrolist.md#macrolist-hostcheckcommand)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTACKAUTHOR\$](macrolist.md#macrolist-hostackauthor)
[^8^](macrolist.md#macrolist-note8)

Nein

Nein

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTACKAUTHORNAME\$](macrolist.md#macrolist-hostackauthorname)
[^8^](macrolist.md#macrolist-note8)

Nein

Nein

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTACKAUTHORALIAS\$](macrolist.md#macrolist-hostackauthoralias)
[^8^](macrolist.md#macrolist-note8)

Nein

Nein

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTACKCOMMENT\$](macrolist.md#macrolist-hostackcomment)
[^8^](macrolist.md#macrolist-note8)

Nein

Nein

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTACTIONURL\$](macrolist.md#macrolist-hostactionurl)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTNOTESURL\$](macrolist.md#macrolist-hostnotesurl)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTNOTES\$](macrolist.md#macrolist-hostnotes)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TOTALHOSTSERVICES\$](macrolist.md#macrolist-totalhostservices)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TOTALHOSTSERVICESOK\$](macrolist.md#macrolist-totalhostservicesok)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TOTALHOSTSERVICESWARNING\$](macrolist.md#macrolist-totalhostserviceswarning)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TOTALHOSTSERVICESUNKNOWN\$](macrolist.md#macrolist-totalhostservicesunknown)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TOTALHOSTSERVICESCRITICAL\$](macrolist.md#macrolist-totalhostservicescritical)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Hostgroup-Makros:

[\$HOSTGROUPALIAS\$](macrolist.md#macrolist-hostgroupalias)
[^5^](macrolist.md#macrolist-note5)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPMEMBERS\$](macrolist.md#macrolist-hostgroupmembers)
[^5^](macrolist.md#macrolist-note5)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPNOTES\$](macrolist.md#macrolist-hostgroupnotes)
[^5^](macrolist.md#macrolist-note5)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPNOTESURL\$](macrolist.md#macrolist-hostgroupnotesurl)
[^5^](macrolist.md#macrolist-note5)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTGROUPACTIONURL\$](macrolist.md#macrolist-hostgroupactionurl)
[^5^](macrolist.md#macrolist-note5)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Service-Makros:

[\$SERVICEDESC\$](macrolist.md#macrolist-servicedesc)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEDISPLAYNAME\$](macrolist.md#macrolist-servicedisplayname)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICESTATE\$](macrolist.md#macrolist-servicestate)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICESTATEID\$](macrolist.md#macrolist-servicestateid)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICESTATE\$](macrolist.md#macrolist-lastservicestate)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICESTATEID\$](macrolist.md#macrolist-lastservicestateid)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICESTATETYPE\$](macrolist.md#macrolist-servicestatetype)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEATTEMPT\$](macrolist.md#macrolist-serviceattempt)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$MAXSERVICEATTEMPTS\$](macrolist.md#macrolist-maxserviceattempts)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEISVOLATILE\$](macrolist.md#macrolist-serviceisvolatile)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEEVENTID\$](macrolist.md#macrolist-serviceeventid)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICEEVENTID\$](macrolist.md#macrolist-lastserviceeventid)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEPROBLEMID\$](macrolist.md#macrolist-serviceproblemid)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICEPROBLEMID\$](macrolist.md#macrolist-lastserviceproblemid)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICELATENCY\$](macrolist.md#macrolist-servicelatency)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEEXECUTIONTIME\$](macrolist.md#macrolist-serviceexecutiontime)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEDURATION\$](macrolist.md#macrolist-serviceduration)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEDURATIONSEC\$](macrolist.md#macrolist-servicedurationsec)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEDOWNTIME\$](macrolist.md#macrolist-servicedowntime)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEPERCENTCHANGE\$](macrolist.md#macrolist-servicepercentchange)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEGROUPNAME\$](macrolist.md#macrolist-servicegroupname)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEGROUPNAMES\$](macrolist.md#macrolist-servicegroupnames)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICECHECK\$](macrolist.md#macrolist-lastservicecheck)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICESTATECHANGE\$](macrolist.md#macrolist-lastservicestatechange)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICEOK\$](macrolist.md#macrolist-lastserviceok)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICEWARNING\$](macrolist.md#macrolist-lastservicewarning)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICEUNKNOWN\$](macrolist.md#macrolist-lastserviceunknown)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LASTSERVICECRITICAL\$](macrolist.md#macrolist-lastservicecritical)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$LONGSERVICEOUTPUT\$](macrolist.md#macrolist-longserviceoutput)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)

Ja [^2^](macrolist.md#macrolist-note2)

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICECHECKCOMMAND\$](macrolist.md#macrolist-servicecheckcommand)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICEACKAUTHOR\$](macrolist.md#macrolist-serviceackauthor)
[^8^](macrolist.md#macrolist-note8)

Nein

Ja

Nein

Nein

Nein

Nein

Nein

Nein

[\$SERVICEACKAUTHORNAME\$](macrolist.md#macrolist-serviceackauthorname)
[^8^](macrolist.md#macrolist-note8)

Nein

Ja

Nein

Nein

Nein

Nein

Nein

Nein

[\$SERVICEACKAUTHORALIAS\$](macrolist.md#macrolist-serviceackauthoralias)
[^8^](macrolist.md#macrolist-note8)

Nein

Ja

Nein

Nein

Nein

Nein

Nein

Nein

[\$SERVICEACKCOMMENT\$](macrolist.md#macrolist-serviceackcomment)
[^8^](macrolist.md#macrolist-note8)

Nein

Ja

Nein

Nein

Nein

Nein

Nein

Nein

[\$SERVICEACTIONURL\$](macrolist.md#macrolist-serviceactionurl)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICENOTESURL\$](macrolist.md#macrolist-servicenotesurl)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

[\$SERVICENOTES\$](macrolist.md#macrolist-servicenotes)

Ja

Ja

Nein

Nein

Ja

Nein

Ja

Nein

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Servicegroup-Makros:

[\$SERVICEGROUPALIAS\$](macrolist.md#macrolist-servicegroupalias)
[^6^](macrolist.md#macrolist-note6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SERVICEGROUPMEMBERS\$](macrolist.md#macrolist-servicegroupmembers)
[^6^](macrolist.md#macrolist-note6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SERVICEGROUPNOTES\$](macrolist.md#macrolist-servicegroupnotes)
[^6^](macrolist.md#macrolist-note6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SERVICEGROUPNOTESURL\$](macrolist.md#macrolist-servicegroupnotesurl)
[^6^](macrolist.md#macrolist-note6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SERVICEGROUPACTIONURL\$](macrolist.md#macrolist-servicegroupactionurl)
[^6^](macrolist.md#macrolist-note6)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Contact-Makros:

[\$CONTACTNAME\$](macrolist.md#macrolist-contactname)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$CONTACTALIAS\$](macrolist.md#macrolist-contactalias)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$CONTACTEMAIL\$](macrolist.md#macrolist-contactemail)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$CONTACTPAGER\$](macrolist.md#macrolist-contactpager)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$CONTACTADDRESSn\$](macrolist.md#macrolist-contactaddress)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Contactgroup-Makros:

[\$CONTACTGROUPALIAS\$](macrolist.md#macrolist-contactgroupalias)
[^7^](macrolist.md#macrolist-note7)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$CONTACTGROUPMEMBERS\$](macrolist.md#macrolist-contactgroupmembers)
[^7^](macrolist.md#macrolist-note7)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Auswertungsmakros:

[\$TOTALHOSTSUP\$](macrolist.md#macrolist-totalhostsup)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTSDOWN\$](macrolist.md#macrolist-totalhostsdown)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTSUNREACHABLE\$](macrolist.md#macrolist-totalhostsunreachable)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTSDOWNUNHANDLED\$](macrolist.md#macrolist-totalhostsdownunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTSUNREACHABLEUNHANDLED\$](macrolist.md#macrolist-totalhostsunreachableunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTPROBLEMS\$](macrolist.md#macrolist-totalhostproblems)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALHOSTPROBLEMSUNHANDLED\$](macrolist.md#macrolist-totalhostproblemsunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESOK\$](macrolist.md#macrolist-totalservicesok)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESWARNING\$](macrolist.md#macrolist-totalserviceswarning)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESCRITICAL\$](macrolist.md#macrolist-totalservicescritical)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESUNKNOWN\$](macrolist.md#macrolist-totalservicesunknown)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESWARNINGUNHANDLED\$](macrolist.md#macrolist-totalserviceswarningunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESCRITICALUNHANDLED\$](macrolist.md#macrolist-totalservicescriticalunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICESUNKNOWNUNHANDLED\$](macrolist.md#macrolist-totalservicesunknownunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICEPROBLEMS\$](macrolist.md#macrolist-totalserviceproblems)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

[\$TOTALSERVICEPROBLEMSUNHANDLED\$](macrolist.md#macrolist-totalserviceproblemsunhandled)
[^10^](macrolist.md#macrolist-note10)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja [^4^](macrolist.md#macrolist-note4)

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Benachrichtigungsmakros:

[\$NOTIFICATIONTYPE\$](macrolist.md#macrolist-notificationtype)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONRECIPIENTS\$](macrolist.md#macrolist-notificationrecipients)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONISESCALATED\$](macrolist.md#macrolist-notificationisescalated)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONAUTHOR\$](macrolist.md#macrolist-notificationauthor)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONAUTHORNAME\$](macrolist.md#macrolist-notificationauthorname)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONAUTHORALIAS\$](macrolist.md#macrolist-notificationauthoralias)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$NOTIFICATIONCOMMENT\$](macrolist.md#macrolist-notificationcomment)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTNOTIFICATIONNUMBER\$](macrolist.md#macrolist-hostnotificationnumber)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$HOSTNOTIFICATIONID\$](macrolist.md#macrolist-hostnotificationid)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$SERVICENOTIFICATIONNUMBER\$](macrolist.md#macrolist-servicenotificationnumber)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

[\$SERVICENOTIFICATIONID\$](macrolist.md#macrolist-servicenotificationid)

Nein

Ja

Nein

Ja

Nein

Nein

Nein

Nein

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Datums-/Zeitmakros:

[\$LONGDATETIME\$](macrolist.md#macrolist-longdatetime)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SHORTDATETIME\$](macrolist.md#macrolist-shortdatetime)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$DATE\$](macrolist.md#macrolist-date)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TIME\$](macrolist.md#macrolist-time)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TIMET\$](macrolist.md#macrolist-timet)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$ISVALIDTIME:\$](macrolist.md#macrolist-isvalidtime)
[^9^](macrolist.md#macrolist-note9)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$NEXTVALIDTIME:\$](macrolist.md#macrolist-nextvalidtime)
[^9^](macrolist.md#macrolist-note9)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

Dateimakros:

[\$MAINCONFIGFILE\$](macrolist.md#macrolist-mainconfigfile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$STATUSDATAFILE\$](macrolist.md#macrolist-statusdatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$COMMENTDATAFILE\$](macrolist.md#macrolist-commentdatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja [^5^](macrolist.md#macrolist-note5)

[\$DOWNTIMEDATAFILE\$](macrolist.md#macrolist-downtimedatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$RETENTIONDATAFILE\$](macrolist.md#macrolist-retentiondatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$OBJECTCACHEFILE\$](macrolist.md#macrolist-objectcachefile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TEMPFILE\$](macrolist.md#macrolist-tempfile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$TEMPPATH\$](macrolist.md#macrolist-temppath)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$LOGFILE\$](macrolist.md#macrolist-logfile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$RESOURCEFILE\$](macrolist.md#macrolist-resourcefile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$COMMANDFILE\$](macrolist.md#macrolist-commandfile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$HOSTPERFDATAFILE\$](macrolist.md#macrolist-hostperfdatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$SERVICEPERFDATAFILE\$](macrolist.md#macrolist-serviceperfdatafile)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

 

**Makroname**

**Service- Prüfungen**

**Service- Benachrichtigungen**

**Host- Prüfungen**

**Host- Benachrichtigungen**

**Service- Eventhandler und
[OCSP](configmain.md#configmain-ocsp_command)**

**Host- Eventhandler und
[OCHP](configmain.md#configmain-ochp_command)**

**Service- Perf-Daten**

**Host- Perf-Daten**

verschiedene Makros:

[\$PROCESSSTARTTIME\$](macrolist.md#macrolist-processstarttime)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$EVENTSTARTTIME\$](macrolist.md#macrolist-eventstarttime)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$ADMINEMAIL\$](macrolist.md#macrolist-adminemail)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$ADMINPAGER\$](macrolist.md#macrolist-adminpager)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$ARGn\$](macrolist.md#macrolist-arg)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

[\$USERn\$](macrolist.md#macrolist-user)

Ja

Ja

Ja

Ja

Ja

Ja

Ja

Ja

**Makrobeschreibungen**

Host-Makros: [^3^](macrolist.md#macrolist-note3)

\$HOSTNAME\$

Kurzname für den Host (z.B. "biglinuxbox"). Dieser Wert wird aus der
*host\_name*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
genommen.

\$HOSTDISPLAYNAME\$

Ein alternativer Anzeigename für den Host. Dieser Wert wird aus der
*display\_name*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
genommen.

\$HOSTALIAS\$

Langname/Beschreibung für den Host. Dieser Wert wird aus der
*alias*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
genommen.

\$HOSTADDRESS\$

Adresse des Hosts. Dieser Wert wird aus der *address*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
genommen.

\$HOSTADDRESS\$

Sekundäre/IPv6-Adresse des Hosts. Dieser Wert wird aus der
*address6*-Direktive in der
[Host-Definition](objectdefinitions.md#objectdefinitions-host)
genommen.

\$HOSTSTATE\$

Eine Zeichenkette, die den aktuellen Status des Hosts angibt ("UP",
"DOWN" oder "UNREACHABLE").

\$HOSTSTATEID\$

Eine Zahl, die dem aktuellen Status des Hosts entspricht: 0=UP, 1=DOWN,
2=UNREACHABLE.

\$LASTHOSTSTATE\$

Eine Zeichenkette, die den letzten Status des Hosts angibt ("UP", "DOWN"
oder "UNREACHABLE").

\$LASTHOSTSTATEID\$

Eine Zahl, die dem letzten Status des Hosts entspricht: 0=UP, 1=DOWN,
2=UNREACHABLE.

\$HOSTSTATETYPE\$

Eine Zeichenkette, die den
[Statustyp](statetypes.md "5.8. Statustypen") der aktuellen
Host-Prüfung angibt ("HARD" oder "SOFT"). Ein Soft-Status tritt auf,
wenn eine Host-Prüfung einen nicht-OK (nicht-UP) Status zurückliefert
und noch Wiederholungen anstehen. Ein Hard-Status liegt vor, wenn die
Anzahl der Host-Prüfungs-Wiederholungen einen maximal definierten Wert
erreicht hat.

\$HOSTATTEMPT\$

Die Anzahl der aktuellen Host-Prüfungs-Wiederholungen. Wenn dies
beispielsweise das zweite Mal ist, dass der Host erneut geprüft wird,
dann steht hier die Zahl zwei. Die aktuelle Wiederholungsanzahl ist
eigentlich nur dann sinnvoll, wenn man Eventhandler für Soft-Zustände
schreibt, die auf einer bestimmten Aktion für diese entsprechende Zahl
basieren.

\$MAXHOSTATTEMPTS\$

Die max. Prüfversuche, wie sie für den aktuellen Host definiert sind.
Nützlich, wenn man Host-Eventhandler für "Soft"-Zustände schreibt, die
eine bestimmte Aktion ausführen basierend auf der
Host-Wiederholungsanzahl.

\$HOSTEVENTID\$

Eine global eindeutige Zahl verbunden mit dem aktuellen Status des
Hosts. Jedes Mal, wenn eine Host- (oder Service-) Statusänderung
eintritt, wird eine globale Ereignis-ID-Nummer um eins (1) erhöht. Falls
bei einem Host keine Statusänderung eintritt, wird dieses Makro auf Null
(0) gesetzt.

\$LASTHOSTEVENTID\$

Die vorherige (global eindeutige) Ereigniszahl, die für den Host
vergeben wurde.

\$HOSTPROBLEMID\$

Eine global eindeutige Zahl verbunden mit dem aktuellen Problemstatus
des Hosts. Jedes Mal, wenn ein Host (oder Service) von einem UP- oder
OK-Status in einen Problemzustand wechselt, wird eine globale Problem-ID
um eins (1) erhöht. Dieses Makro wird ungleich Null sein, wenn der Host
sich gerade in einem Zustand ungleich UP befindet. Statuswechsel
zwischen Zuständen ungleich UP (z.B. DOWN oder UNREACHABLE) erhöhen
diese Problem-ID nicht. Wenn sich der Host gerade in einem UP-Zustand
befindet, wird dieses Makro auf Null (0) gesetzt. In Kombination mit
Eventhandlern kann dieses Makro benutzt werden, um automatisch ein
Trouble-Ticket zu eröffnen, wenn Hosts das erste Mal einen
Problemzustand erreichen.

\$LASTHOSTPROBLEMID\$

Die vorherige (global eindeutige) Ereigniszahl, die für den Host
vergeben wurde. In Kombination mit Eventhandlern kann dieses Makro
benutzt werden, um automatisch ein Trouble-Ticket zu schließen, wenn
Hosts in einen UP-Status zurückkehren.

\$HOSTLATENCY\$

Eine (Fließkomma-) Zahl, die die Anzahl von Sekunden angibt, um die eine
*geplante* Host-Prüfung nach der eigentlichen Planungszeit stattfand.
Wenn beispielsweise eine Prüfung für 03:14:15 geplant war und erst um
03:14:17 ausgeführt wurde, dann beträgt die Verzögerung 2.0 Sekunden.
On-Demand-Host-Prüfungen haben eine Verzögerung von null Sekunden.

\$HOSTEXECUTIONTIME\$

Eine (Fließkomma-) Zahl, die die Dauer der Ausführung einer Host-Prüfung
in Sekunden angibt.

\$HOSTDURATION\$

Eine Zeichenkette, die die Zeitdauer angibt, die sich der Host im
aktuellen Status befindet. Das Format ist "XXh YYm ZZs" und gibt die
Stunden, Minuten und Sekunden an.

\$HOSTDURATIONSEC\$

Eine Zahl, die die Zeitdauer in Sekunden angibt, die sich der Host im
aktuellen Status befindet.

\$HOSTDOWNTIME\$

Eine Zahl, die die aktuelle "Downtime-Tiefe" für den Host angibt. Wenn
dieser Host sich gerade in einer Phase einer [geplanten
Downtime](downtime.md "7.16. Geplante Ausfallzeiten") befindet, ist
dieser Wert größer als Null. Ist der Host nicht gerade in einer
Downtime-Phase, ist dieser Wert Null.

\$HOSTPERCENTCHANGE\$

Eine (Fließkomma-) Zahl, die den prozentualen Statuswechsel angibt, dem
der Host unterworfen war. Dieser Wert wird vom [flap
detection](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")-Algorithmus
benutzt.

\$HOSTGROUPNAME\$

Der Kurzname der Hostgruppe, zu der dieser Host gehört. Dieser Wert wird
aus der *hostgroup\_name*-Direktive in der
[hostgroup-Definition](objectdefinitions.md#objectdefinitions-hostgroup)
entnommen. Wenn der Host zu mehreren Hostgruppen gehört, enthält dieses
Makro nur einen der Namen.

\$HOSTGROUPNAMES\$

Eine Komma-separierte Liste der Kurznamen aller Hostgruppen, zu denen
dieser Host gehört.

\$LASTHOSTCHECK\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt eine Prüfung des Hosts
stattfand.

\$LASTHOSTSTATECHANGE\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt ein Statuswechsel des
Hosts stattfand.

\$LASTHOSTUP\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Host in einem UP-Zustand befand.

\$LASTHOSTDOWN\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Host in einem DOWN-Zustand befand.

\$LASTHOSTUNREACHABLE\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Host in einem UNREACHABLE-Zustand befand.

\$HOSTOUTPUT\$

Die erste Zeile von Textausgaben der letzten Host-Prüfung (z.B. "Ping
OK")

\$LONGHOSTOUTPUT\$

Die vollständige Textausgabe (außer der ersten Zeile) der letzten
Host-Prüfung.

\$HOSTPERFDATA\$

Dieses Makro enthält jegliche
[Performance-Daten](perfdata.md "7.15. Performance-Daten"), die von
der letzten Host-Prüfung geliefert worden sein könnten.

\$HOSTCHECKCOMMAND\$

Dieses Makro enthält den Namen des Befehls (zusammen mit übergebenen
Argumenten), der zur Host-Prüfung benutzt wurde.

\$HOSTACKAUTHOR\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Namen des Benutzers enthält, der das
Host-Problem bestätigt hat. Dieses Makro ist nur gültig bei
Benachrichtigungen, bei denen das Makro \$NOTIFICATIONTYPE\$ auf
"ACKNOWLEDGEMENT" gesetzt ist.

\$HOSTACKAUTHORNAME\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Kurznamen der Kontaktperson (falls
zutreffend) enthält, die das Host-Problem bestätigt hat. Dieses Makro
ist nur gültig bei Benachrichtigungen, bei denen das Makro
\$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

\$HOSTACKAUTHORALIAS\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Alias der Kontaktperson (falls zutreffend)
enthält, die das Host-Problem bestätigt hat. Dieses Makro ist nur gültig
bei Benachrichtigungen, bei denen das Makro \$NOTIFICATIONTYPE\$ auf
"ACKNOWLEDGEMENT" gesetzt ist.

\$HOSTACKCOMMENT\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Bestätigungskommentar enthält, den der
Benutzer eingegeben hat, der das Host-Problem bestätigt hat. Dieses
Makro ist nur gültig bei Benachrichtigungen, bei denen das Makro
\$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

\$HOSTACTIONURL\$

Der Action-URL für den Host. Dieses Makro kann andere Makros enthalten
(z.B. \$HOSTNAME\$), was nützlich sein kann, wenn man den Hostnamen an
eine Web-Seite übergeben will.

\$HOSTNOTESURL\$

Der Anmerkungs-URL für den Host. Dieses Makro kann andere Makros
enthalten (z.B. \$HOSTNAME\$), was nützlich sein kann, wenn man den
Hostnamen an eine Web-Seite übergeben will.

\$HOSTNOTES\$

Anmerkungen für den Host. Dieses Makro kann andere Makros enthalten
(z.B. \$HOSTNAME\$), was nützlich sein kann, wenn man Hostspezifische
Statusinformationen in der Beschreibung haben möchte.

\$TOTALHOSTSERVICES\$

Die Gesamtzahl von Services, die mit dem Host verbunden sind.

\$TOTALHOSTSERVICESOK\$

Die Gesamtzahl von Services im OK-Zustand, die mit dem Host verbunden
sind.

\$TOTALHOSTSERVICESWARNING\$

Die Gesamtzahl von Services im WARNING-Zustand, die mit dem Host
verbunden sind.

\$TOTALHOSTSERVICESUNKNOWN\$

Die Gesamtzahl von Services im UNKNOWN-Zustand, die mit dem Host
verbunden sind.

\$TOTALHOSTSERVICESCRITICAL\$

Die Gesamtzahl von Services im CRITICAL-Zustand, die mit dem Host
verbunden sind.

 

Hostgroup-Makros: [^5^](macrolist.md#macrolist-note5)

\$HOSTGROUPALIAS\$[^5^](macrolist.md#macrolist-note5)

Der Langname / Alias entweder des 1) Hostgruppennamens, der als
On-Demand-Makro-Argument übergeben wurde oder 2) der primären
Hostgruppe, die mit dem aktuellen Host verbunden ist (falls sie nicht im
Zusammenhang mit einem On-Demand-Makro benutzt wurde). Dieser Wert wird
aus der *alias*-Direktive in der
[hostgroup-Definition](objectdefinitions.md#objectdefinitions-hostgroup)
genommen.

\$HOSTGROUPMEMBERS\$[^5^](macrolist.md#macrolist-note5)

Eine Komma-separierte Liste aller Hosts, die entweder 1) zu dem
Hostgruppennamen gehören, der als On-Demand-Makro-Argument übergeben
wurde, oder 2) zu der primären Hostgruppe gehören, die mit dem aktuellen
Host verbunden ist (falls sie nicht im Zusammenhang mit einem
On-Demand-Makro benutzt wurde).

\$HOSTGROUPNOTES\$[^5^](macrolist.md#macrolist-note5)

Die Anmerkungen, die verbunden sind mit entweder 1) dem Hostgroup-Namen,
der als On-Demand-Makro-Argument übergeben wurde oder 2) der primären
Hostgruppe, die mit dem aktuellen Host verbunden ist (falls sie nicht im
Zusammenhang mit einem On-Demand-Makro benutzt wurde). Dieser Wert wird
aus der *notes*-Direktive in der
[hostgroup-Definition](objectdefinitions.md#objectdefinitions-hostgroup)
genommen.

\$HOSTGROUPNOTESURL\$[^5^](macrolist.md#macrolist-note5)

Der Anmerkungs-URL, der verbunden ist mit entweder 1) dem
Hostgroup-Namen, der als On-Demand-Makro-Argument übergeben wurde oder
2) der primären Hostgruppe, die mit dem aktuellen Host verbunden ist
(falls sie nicht im Zusammenhang mit einem On-Demand-Makro benutzt
wurde). Dieser Wert wird aus der *notes\_url*-Direktive in der
[hostgroup-Definition](objectdefinitions.md#objectdefinitions-hostgroup)
genommen.

\$HOSTGROUPACTIONURL\$[^5^](macrolist.md#macrolist-note5)

Der Action-URL, der verbunden ist mit entweder 1) dem Hostgroup-Namen,
der als On-Demand-Makro-Argument übergeben wurde oder 2) der primären
Hostgruppe, die mit dem aktuellen Host verbunden ist (falls sie nicht im
Zusammenhang mit einem On-Demand-Makro benutzt wurde). Dieser Wert wird
aus der *action\_url*-Direktive in der
[hostgroup-Definition](objectdefinitions.md#objectdefinitions-hostgroup)
genommen.

 

Service-Makros:

\$SERVICEDESC\$

Der Langname/die Beschreibung des Service (z.B. "Main Website"). Dieser
Wert wird aus der *description*-Direktive der
[Service-Definition](objectdefinitions.md#objectdefinitions-service)
genommen.

\$SERVICEDISPLAYNAME\$

Ein alternativer Anzeigename für den Service. Dieser Wert wird aus der
*display\_name*-Direktive der
[Service-Definition](objectdefinitions.md#objectdefinitions-service)
genommen.

\$SERVICESTATE\$

Eine Zeichenkette, die den aktuellen Status des Service anzeigt ("OK",
"WARNING", "UNKNOWN" oder "CRITICAL").

\$SERVICESTATEID\$

Eine Zahl, die dem aktuellen Status des Service entspricht: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN.

\$LASTSERVICESTATE\$

Eine Zeichenkette, die den letzten Status des Service angibt ("OK",
"WARNING", "UNKNOWN" oder "CRITICAL").

\$LASTSERVICESTATEID\$

Eine Zahl, die dem letzten Status des Service entspricht: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN.

\$SERVICESTATETYPE\$

Eine Zeichenkette, die den
[Statustyp](statetypes.md "5.8. Statustypen") für die aktuelle
Service-Prüfung anzeigt ("HARD" oder "SOFT"). Ein Soft-Status tritt auf,
wenn eine Service-Prüfung einen nicht-OK Status zurückliefert und noch
Wiederholungen anstehen. Ein Hard-Status liegt vor, wenn die Anzahl der
Service-Prüfungswiederholungen einen maximal definierten Wert erreicht
hat.

\$SERVICEATTEMPT\$

Die Anzahl der aktuellen Service-Prüfungswiederholungen. Wenn dies
beispielsweise das zweite Mal ist, dass der Service erneut geprüft wird,
dann steht hier die Zahl zwei. Die aktuelle Wiederholungsanzahl ist
eigentlich nur dann sinnvoll, wenn man Eventhandler für Soft-Zustände
schreibt, die auf einer bestimmten Aktion für diese entsprechende Zahl
basieren.

\$MAXSERVICEATTEMPTS\$

Die max. Prüfversuche, wie sie für den aktuellen Service definiert sind.
Nützlich, wenn man Service-Eventhandler für "Soft"-Zustände schreibt,
die eine bestimmte Aktion ausführen basierend auf der
Service-Wiederholungsanzahl.

\$SERVICEISVOLATILE\$

Zeigt an, ob der Service als sprunghaft ("volatile") markiert ist: 0 =
not volatile, 1 = volatile.

\$SERVICEEVENTID\$

Eine global eindeutige Zahl verbunden mit dem aktuellen Status des
Service. Jedes Mal, wenn eine Service- (oder Host-) Statusänderung
eintritt, wird eine globale Ereignis-ID-Nummer um eins (1) erhöht. Falls
bei einem Service keine Statusänderung eintritt, wird dieses Makro auf
Null (0) gesetzt.

\$LASTSERVICEEVENTID\$

Die vorherige (global eindeutige) Ereigniszahl, die für den Service
vergeben wurde.

\$SERVICEPROBLEMID\$

Eine global eindeutige Zahl verbunden mit dem aktuellen Problemstatus
des Service. Jedes Mal, wenn ein Service (oder Host) von einem UP- oder
OK-Status in einen Problemzustand wechselt, wird eine globale Problem-ID
um eins (1) erhöht. Dieses Makro wird ungleich Null sein, wenn der
Service sich gerade in einem Zustand ungleich OK befindet. Statuswechsel
zwischen Zuständen ungleich OK (z.B. DOWN oder UNREACHABLE) erhöhen
diese Problem-ID nicht. Wenn sich der Service gerade in einem OK-Zustand
befindet, wird dieses Makro auf Null (0) gesetzt. In Kombination mit
Eventhandlern kann dieses Makro benutzt werden, um automatisch ein
Trouble-Ticket zu eröffnen, wenn Services das erste Mal einen
Problemzustand erreichen.

\$LASTSERVICEPROBLEMID\$

Die vorherige (global eindeutige) Ereigniszahl, die für den Service
vergeben wurde. In Kombination mit Eventhandlern kann dieses Makro
benutzt werden, um automatisch ein Trouble-Ticket zu schließen, wenn
Services zu einem Up-Status zurückkehren.

\$SERVICELATENCY\$

Eine (Fließkomma-) Zahl, die die Anzahl von Sekunden angibt, um die eine
*geplante* Service-Prüfung nach der eigentlichen Planungszeit stattfand.
Wenn beispielsweise eine Prüfung für 03:14:15 geplant war und erst um
03:14:17 ausgeführt wurde, dann beträgt die Verzögerung 2.0 Sekunden.

\$SERVICEEXECUTIONTIME\$

Eine (Fließkomma-) Zahl, die die Dauer der Ausführung einer
Service-Prüfung in Sekunden angibt.

\$SERVICEDURATION\$

Eine Zeichenkette, die die Zeitdauer angibt, die sich der Service im
aktuellen Status befindet. Das Format ist "XXh YYm ZZs" und gibt die
Stunden, Minuten und Sekunden an.

\$SERVICEDURATIONSEC\$

Eine Zahl, die die Zeitdauer in Sekunden angibt, die sich der Service im
aktuellen Status befindet.

\$SERVICEDOWNTIME\$

Eine Zahl, die die aktuelle "Downtime-Tiefe" für den Service angibt.
Wenn dieser Service sich gerade in einer Phase einer [geplanten
Downtime](downtime.md "7.16. Geplante Ausfallzeiten") befindet, ist
dieser Wert größer als Null. Ist der Service nicht gerade in einer
Downtime-Phase, ist dieser Wert Null.

\$SERVICEPERCENTCHANGE\$

Eine (Fließkomma-) Zahl, die den prozentualen Statuswechsel angibt, der
der Service unterworfen war. Dieser Wert wird vom [flap
detection](flapping.md "7.8. Erkennung und Behandlung von Status-Flattern")-Algorithmus
benutzt.

\$SERVICEGROUPNAME\$

Der Kurzname der Servicegruppe, zu der dieser Service gehört. Dieser
Wert wird aus der *servicegroup\_name*-Direktive in der
[servicegroup-Definition](objectdefinitions.md#objectdefinitions-servicegroup)
entnommen. Wenn der Service zu mehreren Servicegruppen gehört, enthält
dieses Makro nur einen der Namen.

\$SERVICEGROUPNAMES\$

Eine Komma-separierte Liste von Kurznamen aller Servicegruppen, zu denen
dieser Service gehört.

\$LASTSERVICECHECK\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt eine Prüfung des
Service stattfand.

\$LASTSERVICESTATECHANGE\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt ein Statuswechsel des
Service stattfand.

\$LASTSERVICEOK\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Service in einem OK-Zustand befand.

\$LASTSERVICEWARNING\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Service in einem WARNING-Zustand befand.

\$LASTSERVICEUNKNOWN\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Service in einem UNKNOWN-Zustand befand.

\$LASTSERVICECRITICAL\$

Dieses ist ein Zeitstempel im time\_t-Format (Sekunden seit der
UNIX-Epoche), der die Zeit angibt, zu der zuletzt festgestellt wurde,
dass sich der Service in einem CRITICAL-Zustand befand.

\$SERVICEOUTPUT\$

Die erste Zeile von Textausgaben der letzten Service-Prüfung (z.B. "Ping
OK")

\$LONGSERVICEOUTPUT\$

Die vollständige Textausgabe (außer der ersten Zeile) der letzten
Service-Prüfung.

\$SERVICEPERFDATA\$

Dieses Makro enthält jegliche
[Performance-Daten](perfdata.md "7.15. Performance-Daten"), die von
der letzten Service-Prüfung geliefert worden sein könnten.

\$SERVICECHECKCOMMAND\$

Dieses Makro enthält den Namen des Befehls (zusammen mit übergebenen
Argumenten), der zur Service-Prüfung benutzt wurde.

\$SERVICEACKAUTHOR\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Namen des Benutzers enthält, der das
Service-Problem bestätigt hat. Dieses Makro ist nur gültig bei
Benachrichtigungen, bei denen das Makro \$NOTIFICATIONTYPE\$ auf
"ACKNOWLEDGEMENT" gesetzt ist.

\$SERVICEACKAUTHORNAME\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Kurznamen der Kontaktperson (falls
zutreffend) enthält, die das Service-Problem bestätigt hat. Dieses Makro
ist nur gültig bei Benachrichtigungen, bei denen das Makro
\$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

\$SERVICEACKAUTHORALIAS\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Alias der Kontaktperson (falls zutreffend)
enthält, die das Service-Problem bestätigt hat. Dieses Makro ist nur
gültig bei Benachrichtigungen, bei denen das Makro \$NOTIFICATIONTYPE\$
auf "ACKNOWLEDGEMENT" gesetzt ist.

\$SERVICEACKCOMMENT\$[^8^](macrolist.md#macrolist-note8)

Eine Zeichenkette, die den Bestätigungskommentar enthält, den der
Benutzer eingegeben hat, der das Service-Problem bestätigt hat. Dieses
Makro ist nur gültig bei Benachrichtigungen, bei denen das Makro
\$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

\$SERVICEACTIONURL\$

Der Action-URL für den Service. Dieses Makro kann andere Makros
enthalten (z.B. \$HOSTNAME\$ oder \$SERVICEDESC\$), was nützlich sein
kann, wenn man den Servicenamen an eine Web-Seite übergeben will.

\$SERVICENOTESURL\$

Der Anmerkungs-URL für den Service. Dieses Makro kann andere Makros
enthalten (z.B. \$HOSTNAME\$ oder \$SERVICEDESC\$), was nützlich sein
kann, wenn man den Servicenamen an eine Web-Seite übergeben will.

\$SERVICENOTES\$

Anmerkungen für den Service. Dieses Makro kann andere Makros enthalten
(z.B. \$HOSTNAME\$ oder \$SERVICEDESC\$), was nützlich sein kann, wenn
man Servicespezifische Statusinformationen in der Beschreibung haben
möchte.

 

Servicegroup-Makros: [^6^](macrolist.md#macrolist-note6)

\$SERVICEGROUPALIAS\$[^6^](macrolist.md#macrolist-note6)

Der Langname / Alias entweder des 1) Servicegroup-Namens, der als
On-Demand-Makro-Argument übergeben wurde oder 2) der primären
Servicegruppe, die mit dem aktuellen Service verbunden ist (falls sie
nicht im Zusammenhang mit einem On-Demand-Makro benutzt wurde). Dieser
Wert wird aus der *alias*-Direktive in der
[servicegroup-Definition](objectdefinitions.md#objectdefinitions-servicegroup)
genommen.

\$SERVICEGROUPMEMBERS\$[^6^](macrolist.md#macrolist-note6)

Eine Komma-separierte Liste aller Services, die entweder 1) zu dem
Servicegruppennamen gehören, der als On-Demand-Makro-Argument übergeben
wurde, oder 2) zu der primären Servicegruppe gehören, die mit dem
aktuellen Service verbunden ist (falls sie nicht im Zusammenhang mit
einem On-Demand-Makro benutzt wurde).

\$SERVICEGROUPNOTES\$[^6^](macrolist.md#macrolist-note6)

Die Anmerkungen, die verbunden sind mit entweder 1) dem
Servicegroup-Namen, der als On-Demand-Makro-Argument übergeben wurde
oder 2) der primären Servicegruppe, die mit dem aktuellen Host verbunden
ist (falls sie nicht im Zusammenhang mit einem On-Demand-Makro benutzt
wurde). Dieser Wert wird aus der *notes*-Direktive in the
[servicegroup-Definition](objectdefinitions.md#objectdefinitions-servicegroup)
genommen.

\$SERVICEGROUPNOTESURL\$[^6^](macrolist.md#macrolist-note6)

Der Anmerkungs-URL, der verbunden sind mit entweder 1) dem
Servicegroup-Namen, der als On-Demand-Makro-Argument übergeben wurde
oder 2) der primären Servicegruppe, die mit dem aktuellen Service
verbunden ist (falls sie nicht im Zusammenhang mit einem On-Demand-Makro
benutzt wurde). Dieser Wert wird aus der *notes\_url*-Direktive in der
[servicegroup-Definition](objectdefinitions.md#objectdefinitions-servicegroup)
genommen.

\$SERVICEGROUPACTIONURL\$[^6^](macrolist.md#macrolist-note6)

Der Action-URL, der verbunden sind mit entweder 1) dem
Servicegroup-Namen, der als On-Demand-Makro-Argument übergeben wurde
oder 2) der primären Servicegruppe, die mit dem aktuellen Service
verbunden ist (falls sie nicht im Zusammenhang mit einem On-Demand-Makro
benutzt wurde). Dieser Wert wird aus der *action\_url*-Direktive in der
[servicegroup-Definition](objectdefinitions.md#objectdefinitions-servicegroup)
genommen.

 

Contact-Makros:

\$CONTACTNAME\$

Kurzname für den Kontakt (z.B. "mmustermann"), der über ein Host- oder
Service-Problem informiert wird. Dieser Wert wird aus der
*contact\_name*-Direktive in der
[contact-Definition](objectdefinitions.md#objectdefinitions-contact)
genommen.

\$CONTACTALIAS\$

Langname/Beschreibung für den Kontakt, der informiert wird. Dieser Wert
wird aus der *alias*-Direktive in der
[contact-Definition](objectdefinitions.md#objectdefinitions-contact)
genommen.

\$CONTACTEMAIL\$

e-Mail-Adresse für den Kontakt, der informiert wird. Dieser Wert wird
aus der *email*-Direktive in der
[contact-Definition](objectdefinitions.md#objectdefinitions-contact)
genommen.

\$CONTACTPAGER\$

Pager-Nummer/-Adresse für den Kontakt, der informiert wird. Dieser Wert
wird aus der *pager*-Direktive in der
[contact-Definition](objectdefinitions.md#objectdefinitions-contact)
genommen.

\$CONTACTADDRESSn\$

Adresse für den Kontakt, der informiert wird. Jeder Kontakt kann sechs
verschiedene Adressen haben (zusätzlich zur e-Mail-Adresse und
Pager-Nummer). Die Makros für diese Adressen sind \$CONTACTADDRESS1\$ -
\$CONTACTADDRESS6\$. Dieser Wert wird aus der *addressx*-Direktive in
der
[contact-Definition](objectdefinitions.md#objectdefinitions-contact)
genommen.

\$CONTACTGROUPNAME\$

Der Kurzname für die Kontaktgruppe, deren Mitglied der Kontakt ist.
Dieser Wert wird aus der *contact\_group*-Direktive in der
[contactgroup-Definition](objectdefinitions.md#objectdefinitions-contactgroup)
genommen.

\$CONTACTGROUPNAMES\$

Eine Komma-separierte Liste der Kurznamen aller Kontaktgruppen, deren
Mitglied dieser Kontakt ist.

 

Contactgroup-Makros: [^5^](macrolist.md#macrolist-note5)

\$CONTACTGROUPALIAS\$[^7^](macrolist.md#macrolist-note7)

Der Langname / Alias entweder des 1) Contactgroup-Namens, der als
On-Demand-Makro-Argument übergeben wurde oder 2) der primären
Kontaktgruppe, die mit dem aktuellen Kontakt verbunden ist (falls sie
nicht im Zusammenhang mit einem On-Demand-Makro benutzt wurde). Dieser
Wert wird aus der *alias*-Direktive in der
[contactgroup-Definition](objectdefinitions.md#objectdefinitions-contactgroup)
genommen.

\$CONTACTGROUPMEMBERS\$[^7^](macrolist.md#macrolist-note7)

Eine Komma-separierte Liste aller Kontakte, die entweder 1) zu dem
Kontaktgruppennamen gehören, der als On-Demand-Makro-Argument übergeben
wurde, oder 2) zu der primären Kontaktgruppe gehören, die mit dem
aktuellen Kontakt verbunden ist (falls sie nicht im Zusammenhang mit
einem On-Demand-Makro benutzt wurde).

 

Auswertungs-Makros:

\$TOTALHOSTSUP\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem
UP-Zustand befinden.

\$TOTALHOSTSDOWN\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem
DOWN-Zustand befinden.

\$TOTALHOSTSUNREACHABLE\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem
UNREACHABLE-Zustand befinden.

\$TOTALHOSTSDOWNUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem
DOWN-Status befinden und "unbehandelt" sind. Unbehandelte Host-Probleme
sind solche, die nicht bestätigt sind, sich nicht in einer geplanten
Downtime befinden, und für die Prüfungen momentan aktiviert sind.

\$TOTALHOSTSUNREACHABLEUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem
UNREACHABLE-Status befinden und "unbehandelt" sind. Unbehandelte
Host-Probleme sind solche, die nicht bestätigt sind, sich nicht in einer
geplanten Downtime befinden, und für die Prüfungen momentan aktiviert
sind.

\$TOTALHOSTPROBLEMS\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem DOWN-
oder UNREACHABLE-Status befinden.

\$TOTALHOSTPROBLEMSUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Hosts an, die sich in einem DOWN-
oder UNREACHABLE-Status befinden und "unbehandelt" sind. Unbehandelte
Host-Probleme sind solche, die nicht bestätigt sind, sich nicht in einer
geplanten Downtime befinden, und für die Prüfungen momentan aktiviert
sind.

\$TOTALSERVICESOK\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
OK-Status befinden.

\$TOTALSERVICESWARNING\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
WARNING-Status befinden.

\$TOTALSERVICESCRITICAL\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
CRITICAL-Status befinden.

\$TOTALSERVICESUNKNOWN\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
UNKNOWN-Status befinden.

\$TOTALSERVICESWARNINGUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
WARNING-Status befinden und "unbehandelt" sind. Unbehandelte
Service-Probleme sind solche, die nicht bestätigt sind, sich nicht in
einer geplanten Downtime befinden, und für die Prüfungen momentan
aktiviert sind.

\$TOTALSERVICESCRITICALUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
CRITICAL-Status befinden und "unbehandelt" sind. Unbehandelte
Service-Probleme sind solche, die nicht bestätigt sind, sich nicht in
einer geplanten Downtime befinden, und für die Prüfungen momentan
aktiviert sind.

\$TOTALSERVICESUNKNOWNUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
UNKNOWN-Status befinden und "unbehandelt" sind. Unbehandelte
Service-Probleme sind solche, die nicht bestätigt sind, sich nicht in
einer geplanten Downtime befinden, und für die Prüfungen momentan
aktiviert sind.

\$TOTALSERVICEPROBLEMS\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
WARNING-, CRITICAL- oder UNKNOWN-Status befinden.

\$TOTALSERVICEPROBLEMSUNHANDLED\$

Dieses Makro gibt die Gesamtzahl der Services an, die sich in einem
WARNING-, CRITICAL- oder UNKNOWN-Status befinden und "unbehandelt" sind.
Unbehandelte Service-Probleme sind solche, die nicht bestätigt sind,
sich nicht in einer geplanten Downtime befinden, und für die Prüfungen
momentan aktiviert sind.

 

Benachrichtigungs-Makros:

\$NOTIFICATIONTYPE\$

Eine Zeichenkette, die den Typ der Benachrichtigung angibt, die versandt
wird ("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART",
"FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND" oder
"DOWNTIMECANCELLED").

\$NOTIFICATIONRECIPIENTS\$

Eine Komma-separierte Liste der Kurznamen von allen Kontakten, die über
den Host oder Service benachrichtigt werden.

\$NOTIFICATIONISESCALATED\$

Eine Ganzzahl, die angibt, ob diese Benachrichtigung an normale Kontakte
für den Host oder Service versandt wurde, oder ob sie eskaliert wurde. 0
= normale (nicht-eskalierte) Benachrichtigung, 1 = eskalierte
Benachrichtigung

\$NOTIFICATIONAUTHOR\$

Eine Zeichenkette, die den Namen des Benutzers angibt, der die
Benachrichtigung geschrieben hat. Falls das \$NOTIFICATIONTYPE\$-Makro
auf "DOWNTIMESTART" oder "DOWNTIMEEND" gesetzt ist, wird es der Name des
Benutzers sein, der die Downtime für den Host oder Service geplant hat.
Falls das \$NOTIFICATIONTYPE\$-Makro auf "ACKNOWLEDGEMENT" gesetzt ist,
wird es der Name des Benutzers sein, der das Problem für den Host oder
Service bestätigt hat. Falls das \$NOTIFICATIONTYPE\$-Makro auf "CUSTOM"
gesetzt ist, wird es der Name des Benutzers sein, der die
benutzerdefinierte Benachrichtigung für den Host oder Service ausgelöst
hat.

\$NOTIFICATIONAUTHORNAME\$

Eine Zeichenkette, die den Kurznamen des Kontakts (falls zutreffend)
enthält, der im Makro \$NOTIFICATIONAUTHOR\$ angegeben wurde.

\$NOTIFICATIONAUTHORALIAS\$

Eine Zeichenkette, die den Alias des Kontakts (falls zutreffend)
enthält, der im Makro \$NOTIFICATIONAUTHOR\$ angegeben wurde.

\$NOTIFICATIONCOMMENT\$

Eine Zeichenkette, die den Kommentar des Benutzers angibt, der die
Benachrichtigung geschrieben hat. Falls das \$NOTIFICATIONTYPE\$-Makro
auf "DOWNTIMESTART" oder "DOWNTIMEEND" gesetzt ist, wird es der
Kommentar des Benutzers sein, der die Downtime für den Host oder Service
geplant hat. Falls das \$NOTIFICATIONTYPE\$-Makro auf "ACKNOWLEDGEMENT"
gesetzt ist, wird es der Kommentar des Benutzers sein, der das Problem
für den Host oder Service bestätigt hat. Falls das
\$NOTIFICATIONTYPE\$-Makro auf "CUSTOM" gesetzt ist, wird es der
Kommentar des Benutzers sein, der die benutzerdefinierte
Benachrichtigung für den Host oder Service ausgelöst hat.

\$HOSTNOTIFICATIONNUMBER\$

Die aktuelle Benachrichtigungsnummer für den Host. Die
Benachrichtigungsnummer wird jedes Mal um eins (1) erhöht, wenn eine
neue Benachrichtigung für den Host versandt wird (außer bei
Bestätigungen). Die Benachrichtigungsnummer wird auf Null (0)
zurückgesetzt, wenn der Host wieder im UP-Zustand ist (*nachdem* die
Benachrichtigung versandt wurde). Die Benachrichtungsnummer wird weder
durch Bestätigungen noch durch Benachrichtigungen über "Flap detection"
oder geplante Downtimes erhöht.

\$HOSTNOTIFICATIONID\$

Eine eindeutige Zahl, die eine Host-Benachrichtigung identifiziert.
Benachrichtigungsnummern sind eindeutig sowohl für Host- als auch
Service-Benachrichtigungen, so dass Sie diese eindeutige Zahl als
primären Schlüssel in einer Benachrichtigungs-Datenbank benutzen können.
Benachrichtigungsnummern sollten über den Restart des Icinga- Prozesses
hinweg eindeutig bleiben, solange Sie "state retention" aktiviert haben.
Die Benachrichtigungsnummer wird für jede neue Host-Benachrichtigung um
eins (1) erhöht, unabhängig von der Anzahl der benachrichtigten
Kontakte.

\$SERVICENOTIFICATIONNUMBER\$

Die aktuelle Benachrichtigungsnummer für den Service. Die
Benachrichtigungsnummer wird jedes Mal um eins (1) erhöht, wenn eine
neue Benachrichtigung für den Service versandt wird (außer bei
Bestätigungen). Die Benachrichtigungsnummer wird auf Null (0)
zurückgesetzt, wenn der Service wieder im OK-Zustand ist (*nachdem* die
Benachrichtigung versandt wurde). Die Benachrichtungsnummer wird weder
durch Bestätigungen noch durch Benachrichtigungen über "Flap detection"
oder geplante Downtimes erhöht.

\$SERVICENOTIFICATIONID\$

Eine eindeutige Zahl, die eine Service-Benachrichtigung identifiziert.
Benachrichtigungsnummern sind eindeutig sowohl für Host- als auch
Service-Benachrichtigungen, so dass Sie diese eindeutige Zahl als
primären Schlüssel in einer Benachrichtigungs-Datenbank benutzen können.
Benachrichtigungsnummern sollten über den Restart des Icinga- Prozesses
hinweg eindeutig bleiben, solange Sie "state retention" aktiviert haben.
Die Benachrichtigungsnummer wird für jede neue Service-Benachrichtigung
um eins (1) erhöht, unabhängig von der Anzahl der benachrichtigten
Kontakte.

 

Datum-/Zeit-Makros:

\$LONGDATETIME\$

Aktueller Datum-/Zeitstempel (z.B. *Fri Oct 13 00:30:28 CDT 2000*). Das
Datum-Format ist festgelegt durch die
[date\_format](configmain.md#configmain-date_format)-Direktive.

\$SHORTDATETIME\$

Aktueller Datum-/Zeitstempel (z.B. *10-13-2000 00:30:28*). Das
Datum-Format ist festgelegt durch die
[date\_format](configmain.md#configmain-date_format)-Direktive.

\$DATE\$

Aktueller Datumstempel (z.B. *10-13-2000*). Das Datum-Format ist
festgelegt durch die
[date\_format](configmain.md#configmain-date_format)-Direktive.

\$TIME\$

Aktueller Zeitstempel (z.B. *00:30:28*).

\$TIMET\$

Aktueller Zeitstempel im time\_t-Format (Sekunden seit der UNIX-Epoche).

\$ISVALIDTIME:\$[^9^](macrolist.md#macrolist-note9)

Dies ist ein spezielles On-Demand-Makro, das 1 oder 0 zurückliefert,
abhängig davon, ob eine bestimmte Zeit innerhalb einer angegebenen
Zeitperiode gültig ist. Es gibt zwei Arten, dieses Makro zu benutzen:

1.  **\$ISVALIDTIME:24x7\$** wird auf "1" gesetzt, wenn die aktuelle
    Zeit innerhalb der "24x7"-Zeitperiode gültig ist. Falls nicht, wird
    es auf "0" gesetzt.

2.  **\$ISVALIDTIME:24x7:timestamp\$** wird auf "1" gesetzt, wenn die
    durch das "timestamp"-Argument angegebene Zeit (die im
    time\_t-Format sein muss) innerhalb der "24x7"-Zeitperiode gültig
    ist. Falls nicht, wird es auf "0" gesetzt.

\$NEXTVALIDTIME:\$[^9^](macrolist.md#macrolist-note9)

Dies ist ein spezielles On-Demand-Makro, das die nächste gültige Zeit
(im time\_t-Format) für eine angebene Zeitperiode zurückliefert. Es gibt
zwei Arten, dieses Makro zu benutzen:

1.  **\$NEXTVALIDTIME:24x7\$** wird die nächste gültige Zeit
    zurückliefern - ab der aktuellen Zeit - innerhalb der
    "24x7"-Zeitperiode.

2.  **\$NEXTVALIDTIME:24x7:timestamp\$** wird die nächste gültige Zeit
    zurückliefern - ab der durch das "timestamp"-Argument angegebenen
    Zeit (die im time\_t-Format sein muss) - innerhalb der
    "24x7"-Zeitperiode.

Falls keine gültige Zeit innerhalb der angegebenen Zeitperiode gefunden
werden kann, wird das Makro auf "0" gesetzt.

 

Datei-Makros:

\$MAINCONFIGFILE\$

Der Standort der
[Hauptkonfigurationsdatei](configmain.md "3.2. Optionen der Hauptkonfigurationsdatei")
(main config file).

\$STATUSDATAFILE\$

Der Standort der
[Statusdaten-Datei](configmain.md#configmain-status_file) (main config
file).

\$COMMENTDATAFILE\$

Der Standort der Kommentardaten-Datei (comment data file).

\$DOWNTIMEDATAFILE\$

Der Standort der Ausfallzeitendaten-Datei (downtime data file).

\$RETENTIONDATAFILE\$

Der Standort der
[Aufbewahrungsdaten-Datei](configmain.md#configmain-state_retention_file)
(retention data file).

\$OBJECTCACHEFILE\$

Der Standort der
[Objektzwischenspeicherungs-Datei](configmain.md#configmain-object_cache_file)
(object cache file).

\$TEMPFILE\$

Der Standort der [temporären
Datei](configmain.md#configmain-temp_file) (temp file).

\$TEMPPATH\$

Das durch die [temp path](configmain.md#configmain-temp_path)-Variable
festgelegte Verzeichnis.

\$LOGFILE\$

Der Standort der [Protokolldatei](configmain.md#configmain-log_file)
(log file).

\$RESOURCEFILE\$

Der Standort der
[Ressource-Datei](configmain.md#configmain-resource_file) (resource
file).

\$COMMANDFILE\$

Der Standort der [Befehlsdatei](configmain.md#configmain-command_file)
(command file).

\$HOSTPERFDATAFILE\$

Der Standort der Host-Performancedaten-Datei (host performance data
file; falls definiert).

\$SERVICEPERFDATAFILE\$

Der Standort der Service-Performancedaten-Datei (service performance
data file; falls definiert).

 

Verschiedene Makros:

\$PROCESSSTARTTIME\$

Zeitstempel im time\_t-Format (Sekunden seit der UNIX-Epoche), die
angibt, wann der Icinga-Prozess das letzte Mal neu/wieder gestartet
wurde. Sie können die Laufzeit durch Subtraktion von
\$PROCESSSTARTTIME\$ von [\$TIMET\$](macrolist.md#macrolist-timet)
ermitteln.

\$EVENTSTARTTIME\$

Zeitstempel im time\_t-Format (Sekunden seit der UNIX-Epoche), die
angibt, wann der Icinga-Prozess begann, Ereignisse (Prüfungen, usw.) zu
verarbeiten. Sie können die Zeit, die Icinga zum Start benötigte, durch
Subtraktion von \$PROCESSSTARTTIME\$ von \$EVENTSTARTTIMET\$ ermitteln.

\$ADMINEMAIL\$

Globale administrative e-Mail-Adresse. Dieser Wert wird aus der
[admin\_email](configmain.md#configmain-admin_email)-Direktive
genommen.

\$ADMINPAGER\$

Globale administrative Pager-Nummer/-Adresse. Dieser Wert wird aus der
[admin\_pager](configmain.md#configmain-admin_email)-Direktive
genommen.

\$ARGn\$

Das *n*-te an den Befehl (Benachrichtigung, Eventhandler,
Service-Prüfungen, usw.) übergebene Argument. Icinga unterstützt bis zu
32 Argument-Makros (\$ARG1\$ bis \$ARG32\$).

\$USERn\$

Das *n*-te benutzerdefinierbare Makro. Benutzermakros können in ein oder
mehreren [resource files](configmain.md#configmain-resource_file)
definiert werden. Icinga unterstützt bis zu 256 User-Makros (\$USER1\$
bis \$USER256\$).

**Anmerkungen**

**^1^** Diese Makros sind nicht gültig für den Host, dem sie zugeordnet
sind, wenn der Host gerade geprüft wird (denn die Werte konnten noch
nicht ermittelt werden).

**^2^** Diese Makros sind nicht gültig für den Service, dem sie
zugeordnet sind, wenn der Service gerade geprüft wird (denn die Werte
konnten noch nicht ermittelt werden).

**^3^** Wenn Host-Makros in Service-bezogenen Befehlen benutzt werden
(z.B. Service-Benachrichtigungen, Eventhandler, usw.) verweisen sie auf
den Host, dem der Service zugeordnet ist.

**^4^** Wenn Host- und Service-Auswertungsmakros in Benachrichtigungen
benutzt werden, werden die Summen gefiltert, um so nur die Hosts und
Services zu berücksichtigen, für die die Kontaktperson berechtigt ist
(z.B. Hosts und Services, für die sie Benachrichtigungen erhalten soll).

**^5^** Diese Makros sind normalerweise der ersten/primären Hostgruppe
des aktuellen Hosts zugeordnet. Sie können deshalb in vielen Fällen als
Host-Makros angesehen werden. Allerdings sind diese Makros nicht als
On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Hostgroup-Makros benutzt werden, wenn Sie den Namen einer
Hostgruppe an das Makro übergeben. Beispielsweise würde
\$HOSTGROUPMEMBERS:hg1\$ eine komma-separierte Liste aller
(Host)-Mitglieder der Hostgruppe *hg1* zurückliefern.

**^6^** Diese Makros sind normalerweise der ersten/primären
Servicegruppe des aktuellen Service zugeordnet. Sie können deshalb in
vielen Fällen als Service-Makros angesehen werden. Allerdings sind diese
Makros nicht als On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Servicegroup-Makros benutzt werden, wenn Sie den Namen einer
Servicegruppe an das Makro übergeben. Beispielsweise würde
\$SERVICEGROUPMEMBERS:sg1\$ eine komma-separierte Liste aller
(Service)-Mitglieder der Servicegruppe *sg1* zurückliefern.

**^7^** Diese Makros sind normalerweise der ersten/primären
Kontaktgruppe des aktuellen Kontakts zugeordnet. Sie können deshalb in
vielen Fällen als Kontakt-Makros angesehen werden. Allerdings sind diese
Makros nicht als On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Contaktgroup-Makros benutzt werden, wenn Sie den Namen einer
Kontaktgruppe an das Makro übergeben. Beispielsweise würde
\$CONTACTGROUPMEMBERS:cg1\$ eine komma-separierte Liste aller
(Kontakt)-Mitglieder der Kontaktgruppe *cg1* zurückliefern.

**^8^** Diese Bestätigungsmakros sind veraltet. Nutzen Sie statt dessen
die mehr generischen Makros \$NOTIFICATIONAUTHOR\$,
\$NOTIFICATIONAUTHORNAME\$, \$NOTIFICATIONAUTHORALIAS\$ oder
\$NOTIFICATIONCOMMENT\$

**^9^** Diese Makros sind nur als On-Demand-Makros verfügbar - d.h. Sie
müssen ein zusätzliches Argument übergeben, um sie zu nutzen. Diese
Makros sind nicht als Umgebungsvariablen verfügbar.

**^10^** Auswertungsmakros sind nicht als Umgebungsvariablen verfügbar,
wenn die Option
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
aktiviert ist, weil sie ziemlich CPU-intensiv zu berechnen sind.

* * * * *

  --------------------------------------------- -------------------------- ------------------------------------
  [Zurück](macros.md)                         [Nach oben](ch05.md)      [Weiter](hostchecks.md)
  5.2. Makros verstehen und wie sie arbeiten    [Zum Anfang](index.md)    5.4. Host-Prüfungen (Host checks)
  --------------------------------------------- -------------------------- ------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
