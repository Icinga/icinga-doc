![Icinga](../images/logofullsize.png "Icinga")

12.4. Example Configurations

[Prev](configido.md) 

Chapter 12. IDOUtils

 [Next](db_model.md)

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

1.  The IDOMOD module is configured with an instance name of "default"
    since there is only one instance of Icinga that is running on the
    network.

2.  While the Icinga daemon is running and performing its usual business
    of monitoring the network, the IDOMOD module is sending
    configuration data and event information to the TCP or Unix domain
    socket that was created by the IDO2DB daemon.

3.  The IDO2DB daemon reads data that is coming into the socket from the
    IDOMOD module.

4.  The IDO2DB daemon processes and transforms data that has been
    received from the IDOMOD module.

5.  The processed data is stored in a database for later retrieval and
    processing.

This example assumes that:

1.  Icinga is configured to load the IDOMOD module at startup.

2.  The IDO2DB daemon (which is a separate process from the Icinga
    daemon) is running.

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

1.  Each Icinga daemon loads the IDOMOD module at startup with a unique
    instance name. In this example the instances are simply named
    "Icinga1", "Icinga2" and "Icinga3".

2.  Each IDOMOD module sends configuration data and event information
    for its specific instance of the Icinga daemon to the TCP or Unix
    domain socket that was created by the IDO2DB daemon.

3.  The IDO2DB daemon reads data that is coming into the socket from the
    three IDOMOD modules.

4.  The IDO2DB daemon processes and transforms data that has been
    received from the IDOMOD modules.

5.  The processed data is stored in a database for later retrieval and
    processing. Data from each instance of Icinga is kept separate
    (using the instance names as unique identifiers) in the database.

### 12.4.3. Single Server, Single Instance Log File Import

There are two reasons you'll probably want to import your Icinga log
files into the same database that Icinga configuration and event data is
stored in:

1.  Historical log file data isn't imported into the database by default
    and having a record of events that occurred before you implemented
    the IDOUtils addon is probably desireable.

2.  The IDOMOD module is not able to process realtime log entries from
    the time right after the Icinga daemon starts to the time that the
    IDOMOD module is loaded by the Icinga daemon. This "blackout period"
    is unavoidable and causing log entries such as "Icinga 1.0
    starting..." to be missed by the IDOMOD module. Thus, importing
    day-old Icinga log files on a daily basis (via a cron job) is
    recommended.

**Figure 12.13. Single Server, Single Instance Log File Import**

![Single Server, Single Instance Log File Import](../images/fig13.png)

\

Here's a description of what's happening at each point in the diagram:

1.  Historical Icinga log files are read by the LOG2IDO utility.

2.  The LOG2IDO utility processes the contents of the log files and tags
    them with an instance name of "default". This instance name must
    match the same instance name used by the IDOMOD module in the Icinga
    daemon.

3.  Historical log file data is sent to the TCP or Unix domain socket in
    a format that the IDO2DB daemon can understand.

4.  The IDO2DB daemon reads the log file data from the Unix domain
    socket.

5.  The IDO2DB daemon processes the log file data.

6.  Historical log file data is stored in a database for later retrieval
    and processing. The IDO2DB daemon will perform some checks to make
    sure it doesn't re-import duplicate historical log entries, so
    running the LOG2IDO utility on the same historical log file multiple
    times shouldn't have any negative side effects.

That's it! Pretty simple.

* * * * *

  ---------------------------------- -------------------- --------------------------------
  [Prev](configido.md)             [Up](ch12.md)       [Next](db_model.md)
  12.3. Configuration of IDOUtils    [Home](index.md)    12.5. IDOUtils Database Model
  ---------------------------------- -------------------- --------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
