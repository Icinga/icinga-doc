![Icinga](../images/logofullsize.png "Icinga")

9.2. SNMP-Trap-Integration

[Zurück](integration.md) 

Kapitel 9. Integration mit anderer Software

 [Weiter](int-tcpwrappers.md)

* * * * *

9.2. SNMP-Trap-Integration
--------------------------

**Einführung**

![](../images/note.gif) Hinweis: Icinga ist nicht als Ersatz für eine
ausgewachsene SNMP-Management-Applikation wie HP-OpenView oder
[OpenNMS](http://www.opennms.org/) gedacht. Allerdings können Sie die
Dinge so einrichten, dass SNMP-Traps, die von einem Host in Ihrem
Netzwerk empfangen werden, Alarme in Icinga zu generieren.

Als wenn es dazu gemacht wäre, die Götter der Scheinheiligkeit vor
Lachen sterben zu lassen, ist SNMP alles andere als einfach. SNMP-Traps
zu übersetzen und sie in Icinga zu bekommen (als passive Prüfresultate)
kann ein wenig mühselig sein. Um diese Aufgabe zu erleichtern, empfehlen
wir, dass Sie sich Alex Burger's SNMP Trap Translator Projekt unter
[http://www.snmptt.org](http://www.snmptt.org/) ansehen. Wenn es mit
Net-SNMP kombiniert wird, liefert SNMPTT ein fortgeschrittenes
Trap-Behandlungssystem, das mit Icinga integriert werden kann.

Yep, das ist alles.

* * * * *

  ----------------------------- -------------------------- ---------------------------------
  [Zurück](integration.md)    [Nach oben](ch09.md)      [Weiter](int-tcpwrappers.md)
  9.1. Integrationsüberblick    [Zum Anfang](index.md)    9.3. TCP-Wrapper-Integration
  ----------------------------- -------------------------- ---------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
