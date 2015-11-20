[Prev](cgisecurity.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](faststartup.md)

* * * * *

8.3. Tuning Icinga For Maximum Performance
------------------------------------------

8.3.1. [Introduction](tuning.md#introduction)

8.3.2. [Optimization Tips](tuning.md#optimizationtips)

### 8.3.1. Introduction

![](../images/tuning.png)

So you've finally got Icinga up and running and you want to know how you
can tweak it a bit. Tuning Icinga to increase performance can be
necessary when you start monitoring a large number (\> 1,000) of hosts
and services. Here are a few things to look at for optimizing Icinga...

### 8.3.2. Optimization Tips










10. **Use the embedded Perl interpreter** . If you're using a lot of

11. **Optimize host check commands** . If you're checking host states

12. **Schedule regular host checks** . Scheduling regular checks of

13. **Enable cached host checks** . On-demand host checks can benefit

14. **Don't use agressive host checking**. Unless you're having problems

15. **External command optimizations** . If you're processing a lot of

16. **Optimize hardware for maximum performance** . NOTE: Hardware

17. **Use a RAM disk for temporary data** . Several files are created

* * * * *

[Prev](cgisecurity.md) | [Up](ch08.md) | [Next](faststartup.md)

8.2. Enhanced Classic UI Security and Authentication  |<=== [Index](index.md) ===>|  8.4. Fast Startup Options

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
