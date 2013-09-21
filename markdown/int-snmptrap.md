SNMP-Trap-Integration
=====================

**Einführung**

![](../images/note.gif) Hinweis: NAME-ICINGA ist nicht als Ersatz für
eine ausgewachsene SNMP-Management-Applikation wie NAME-HP-OpenView oder
[OpenNMS](http://www.opennms.org/) gedacht. Allerdings können Sie die
Dinge so einrichten, dass SNMP-Traps, die von einem Host in Ihrem
Netzwerk empfangen werden, Alarme in NAME-ICINGA zu generieren.

Als wenn es dazu gemacht wäre, die Götter der Scheinheiligkeit vor
Lachen sterben zu lassen, ist SNMP alles andere als einfach. SNMP-Traps
zu übersetzen und sie in NAME-ICINGA zu bekommen (als passive
Prüfresultate) kann ein wenig mühselig sein. Um diese Aufgabe zu
erleichtern, empfehlen wir, dass Sie sich Alex Burger's SNMP Trap
Translator Projekt unter [URL-SNMPTT](http://www.snmptt.org/) ansehen.
Wenn es mit Net-SNMP kombiniert wird, liefert SNMPTT ein
fortgeschrittenes Trap-Behandlungssystem, das mit NAME-ICINGA integriert
werden kann.

Yep, das ist alles.

Integration
SNMP-Trap-Integration
