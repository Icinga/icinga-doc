![Icinga](../images/logofullsize.png "Icinga")

9.1. Integrationsüberblick

[Zurück](ch09.md) 

Kapitel 9. Integration mit anderer Software

 [Weiter](int-snmptrap.md)

* * * * *

9.1. Integrationsüberblick
--------------------------

9.1.1. [Einführung](integration.md#introduction)

9.1.2. [Integrationsstellen](integration.md#points)

9.1.3. [Integrationsbeispiele](integration.md#examples)

### 9.1.1. Einführung

Einer der Gründe, warum Icinga solch eine populäre
Überwachungsapplikation ist, liegt in der Tatsache, dass es einfach in
Ihre vorhandene Infrastruktur integriert werden kann. Es gibt mehrere
Methoden, um Icinga mit der Management-Software zu integrieren, die Sie
bereits nutzen und Sie können fast jede Art von neuer oder angepasster
Hardware, Service oder Applikation überwachen, die Sie haben.

### 9.1.2. Integrationsstellen

![](../images/integrationoverview.png)

Um neue Hardware, Services oder Applikationen zu überwachen, prüfen Sie
die Dokumentationen zu:

-   [Plugins](plugins.md "5.1. Icinga Plugins")

-   [Plugin API](pluginapi.md "11.1. Nagios Plugin API")

-   [Passive
    Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")

-   [Eventhandler](eventhandlers.md "7.3. Eventhandler")

Um Daten aus externen Applikationen in Icinga zu bekommen, prüfen Sie
die Dokumentationen zu:

-   [Passive
    Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")

-   [Externe Befehle](extcommands.md "7.1. Externe Befehle")

Um Zustands-, Leistungs- oder Benachrichtigungsinformationen von Icinga
an externe Applikationen zu senden, prüfen Sie die Dokumentationen zu:

-   [Eventhandlers](eventhandlers.md "7.3. Eventhandler")

-   [OCSP](configmain.md#configmain-ocsp_command) - und
    [OCHP](configmain.md#configmain-ochp_command)-Befehlen

-   [Performance-Daten](perfdata.md "7.15. Performance-Daten")

-   [Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")

### 9.1.3. Integrationsbeispiele

Wir haben ein paar Beispiele dokumentiert, wie Icinga mit externen
Applikationen integriert wird:

-   [TCP-Wrappers](int-tcpwrappers.md "9.3. TCP-Wrapper-Integration")
    (Sicherheitsalarme)

-   [SNMP-Traps](int-snmptrap.md "9.2. SNMP-Trap-Integration")
    (Arcserve Backup-Job-Status)

-   [mklivestatus](int-mklivestatus.md "9.4. MKLiveStatus-Integration")
    (Interface von Icinga zu verschiedenen Addons wie [NagVis]() und
    [Thruk]())

* * * * *

  ---------------------------------------------- -------------------------- ------------------------------
  [Zurück](ch09.md)                            [Nach oben](ch09.md)      [Weiter](int-snmptrap.md)
  Kapitel 9. Integration mit anderer Software    [Zum Anfang](index.md)    9.2. SNMP-Trap-Integration
  ---------------------------------------------- -------------------------- ------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
