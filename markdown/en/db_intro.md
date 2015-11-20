[Prev](ch12.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](db_components.md)

* * * * *

12.1. Introduction
------------------

12.1.1. [Purpose](db_intro.md#purpose)

12.1.2. [Design Overview](db_intro.md#design)

12.1.3. [Instances](db_intro.md#instances)

12.1.4. [Installation](db_intro.md#install)

The IDOUtils addon is based on NDOUtils originally written by Ethan
Galstad, creator of Nagios(R), so the fundamentals apply to Nagios as
well as to Icinga.

### 12.1.1. Purpose

The IDOUtils (Icinga Data Output Utils) addon is designed to store all
configuration and event (status, historical) data from Icinga into a
relational database. Storing information from Icinga in an RDBMS will
allow for quicker retrieval and processing of that data. Icinga Web
relies on that data, as well as other addons such as NagVis.
Furthermore, Icinga Web provides its own REST API.

Until now MySQL, Oracle and PostgreSQL are supported by IDOUtils.
Support for other database servers may be added if there is sufficient
user interest and even more user who are interested in testing.

### 12.1.2. Design Overview

The IDOUtils addon was designed to work for users who have:




Data from each Icinga process (hereafter referred to as "instances") can
be stored either in the same database or different databases than data
from other Icinga instances.

**Figure 12.1. Multiple instances**

![Multiple instances](../images/fig1.png)

\

Although not yet supported, future development should allow for data
from any given Icinga instance to be stored in multiple databases if
desired.

**Figure 12.2. Future development: One Instance, multiple databases**

![Future development: One Instance, multiple
databases](../images/fig2.png)

\

### 12.1.3. Instances

Each Icinga process, whether it is a standalone monitoring server, or
part of a distributed, redundant, or fail over monitoring setup, is
referred to as an "instance". In order to maintain the integrity of
stored data, each Icinga instance must be labeled with a unique
identifier or name.

You can choose the name of each Icinga instance to suit your needs. For
instance, you could choose to name Icinga instances based on their
geographical location...

**Figure 12.3. Instance names based on geographical locations**

![Instance names based on geographical locations](../images/fig3.png)

\

Or you could name Icinga instances based on their purpose...

**Figure 12.4. Instance names based on their purpose**

![Instance names based on their purpose](../images/fig4.png)

\

How you name Icinga instances is up to you. The key point to remember is
that each and every Icinga process must have its own unique instance
name.

More information on how instance names come into play will be discussed
in the next sections.

### 12.1.4. Installation

The installation of the IDOUtils is described in the [Quickstart
IDOUtils](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")

* * * * *

[Prev](ch12.md) | [Up](ch12.md) | [Next](db_components.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
