[Prev](configido.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](db_model.md)

* * * * *

12.4. Example Configurations
----------------------------

12.4.1. [Single Server, Single Instance
Setup](db_example-configs.md#singleserversingleinstance)

12.4.2. [Single Server, Multiple Instance
Setup](db_example-configs.md#singleservermultipleinstance)

12.4.3. [Single Server, Single Instance Log File
Import](db_example-configs.md#singleserversingleinstancelogfile)

### 12.4.1. Single Server, Single Instance Setup

The easiest configuration occurs when you have a single Icinga instance
running on your network. In this case, installing and configuring the
various components of the IDOUtils addon is fairly straightforward.

The following diagram illustrates how the various components can fit
together in a single server, single Icinga instance setup...

**Figure 12.11. Single Server, Single Instance Setup**

![Single Server, Single Instance Setup](../images/fig11.png)

\

Here's a description of what's happening at each point in the diagram:






This example assumes that:



### 12.4.2. Single Server, Multiple Instance Setup

Another simple configuration can be used when you have multiple Icinga
instances running on a single server. Installing and configuring the
various components of the IDOUtils addon is similiar as to what was
shown in the previous example.

The following diagram illustrates how the various components can fit
together in a single server, multiple Icinga instance setup...

**Figure 12.12. Single Server, Multiple Instance Setup**

![Single Server, Multiple Instance Setup](../images/fig12.png)

\

You'll notice that the diagram above is similiar to the one for the
single-server, single instance configuration. The main difference is
that there are now three (3) different Icinga daemons instead of just
one.






### 12.4.3. Single Server, Single Instance Log File Import

There are two reasons you'll probably want to import your Icinga log
files into the same database that Icinga configuration and event data is
stored in:



**Figure 12.13. Single Server, Single Instance Log File Import**

![Single Server, Single Instance Log File Import](../images/fig13.png)

\

Here's a description of what's happening at each point in the diagram:







That's it! Pretty simple.

* * * * *

[Prev](configido.md) | [Up](ch12.md) | [Next](db_model.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
