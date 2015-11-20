[Prev](integration.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](int-tcpwrappers.md)

* * * * *

9.2. SNMP Trap Integration
--------------------------

**Introduction**

![[Note]](../images/note.png)

Note

Icinga is not designed to be a replacement for a full-blown SNMP
management application like HP OpenView or
[OpenNMS](http://www.opennms.org). However, you can set things up so
that SNMP traps received by a host on your network can generate alerts
in Icinga.

As if designed to make the Gods of Hypocrisy die of laughter, SNMP is
anything but simple. Translating SNMP traps and getting them into Icinga
(as passive check results) can be a bit tedious. To make this task
easier, we suggest you check out Alex Burger's SNMP Trap Translator
project located at [http://www.snmptt.org](http://www.snmptt.org). When
combined with Net-SNMP, SNMPTT provides an enhanced trap handling system
that can be integrated with Icinga.

Yep, that's all.

* * * * *

[Prev](integration.md) | [Up](ch09.md) | [Next](int-tcpwrappers.md)

9.1. Integration Overview  |<=== [Index](index.md) ===>|  9.3. TCP Wrapper Integration

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
