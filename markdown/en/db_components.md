[Prev](db_intro.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](configido.md)

* * * * *

12.2. Components
----------------

12.2.1. [Overview](db_components.md#overview)

12.2.2. [IDOMOD](db_components.md#idomod)

12.2.3. [LOG2IDO](db_components.md#log2ido)

12.2.4. [FILE2SOCK](db_components.md#file2sock)

12.2.5. [IDO2DB](db_components.md#ido2db)

### 12.2.1. Overview

There are four main components that make up the IDO utilities:





Each component is described in more detail on the following pages.

### 12.2.2. IDOMOD

The IDO utilities includes an Icinga event broker module (IDOMOD.O) that
exports data from the Icinga daemon.

Assuming that Icinga has been compiled with the event broker enabled
(this is the default), you can configure Icinga to load the IDOMOD
module during runtime. Once the module has been loaded by the Icinga
daemon, it can access all of the data and logic present in the running
Icinga process.

**Figure 12.5. Loaded IDOMOD Event broker Module**

![Loaded IDOMOD Event broker Module](../images/fig5.png)

\

The IDOMOD module has been designed to export configuration data, as
well as information about various runtime events that occur in the
monitoring process, from the Icinga daemon. The module can send this
data to a standard file, a Unix domain socket, or a TCP socket.

**Figure 12.6. IDOMOD Capabilities**

![IDOMOD Capabilities](../images/fig6.png)

\

The IDOMOD module writes data in a format that the IDO2DB daemon
(described later) can understand.

If the IDOMOD module is writing its output to a file, you can configure
it to periodically rotate and/or process the output file using a
predefined Icinga command. This can be useful if you want to transfer
the output file to another physical machine (using SSH, etc. ) and send
its contents to the IDO2DB daemon using the FILE2SOCK utility (described
later).

If the IDOMOD module is writing its output to a TCP or Unix domain
socket, it has some resistance to connection dropouts. The module will
attempt to cache its output until it can (re)connect to the socket for
writing. This is helpful if the process that creates and listens on the
socket needs to be restarted, etc.

### 12.2.3. LOG2IDO

The LOG2IDO utility has been designed to allow you to import historical
Icinga, Nagios and NetSaint log files into a database via the IDO2DB
daemon ([described later](db_components.md#ido2db "12.2.5. IDO2DB")).
The utility works by sending historical log file data to a standard
file, a Unix domain socket, or a TCP socket in a format the IDO2DB
daemon understands. The IDO2DB daemon can then be used to process that
output and store the historical logfile information in a database.

**Figure 12.7. LOG2IDO Utility**

![LOG2IDO Utility](../images/fig7.png)

\

### 12.2.4. FILE2SOCK

The FILE2SOCK utility is quite simple. It reads input from a standard
file (or STDIN) and writes all of that data to either a Unix domain
socket or TCP socket. The data that is read is not processed in any way
before it is sent to the socket.

**Figure 12.8. FILE2SOCK Utility**

![FILE2SOCK Utility](../images/fig8.png)

\

This utility is useful if you are directing the output of the IDOMOD
event broker module and/or LOG2IDO utility to a standard file. Once
these components finish writing their output to a file, you can use the
FILE2SOCK utility to send the contents of the file to the IDO2DB
daemon's TCP or Unix domain socket.

### 12.2.5. IDO2DB

The IDO2DB utility is designed to take the data output from the IDOMOD
and LOG2IDO components and store it in a MySQL, Oracle, or PostgreSQL
database.

When it starts, the IDO2DB daemon creates either a TCP or Unix domain
socket and waits for clients to connect. IDO2DB can run either as a
standalone, multi-process daemon or under INETD (if using a TCP socket).

**Figure 12.9. IDO2DB Daemon**

![IDO2DB Daemon](../images/fig9.png)

\

Multiple clients can connect to the IDO2DB daemon's socket and transmit
data simultaneously. A separate IDO2DB process is spawned to handle each
new client that connects. Data is read from each client and stored in a
user-specified database for later retrieval and processing.

**Figure 12.10. IDO2DB with multiple Clients**

![IDO2DB with multiple Clients](../images/fig10.png)

\

The IDO2DB daemon currently supports MySQL, Oracle, and PostgreSQL
databases.

* * * * *

[Prev](db_intro.md) | [Up](ch12.md) | [Next](configido.md)

12.1. Introduction  |<=== [Index](index.md) ===>|  12.3. Configuration of IDOUtils

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
