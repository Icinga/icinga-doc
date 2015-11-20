[Prev](epnplugins.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](icinga-web-api.md)

* * * * *

11.3. No Icinga API to install anymore
--------------------------------------

11.3.1. [Installation and use of the Icinga
API](icinga-api.md#idp16727776)

![[Important]](../images/important.png)

Important

In the days leading up to the v1.5 release, we bid our Icinga API
goodbye and ushered in a new API and Web concept.

You may ask yourself, what was this API anyway? Indeed, if you weren’t
developing or adapting extensions for the new web interface, you
wouldn’t have had much contact with this important project component.
When Icinga was conceived, one of the main missions was to facilitate
the development of addons and plugins. The API provided a set of
commonly used request operations, removing the need to write sql-queries
and generally a lot of excess code.

All was well until we decided to offer some extra database flexibility.
When we added support for Oracle and PostgreSQL on top of MySQL, we also
gave our Icinga API team some extra work. With each change, bug fix or
new feature, Marius, Michael L and Jannis had to edit the queries for
each database back-end separately. This process was not only complicated
and error-prone, but also a sign that we needed a more flexible
architecture.

As of Icinga 1.5, the external Icinga API was replaced by an internal
database layer Doctrine, and merged into Icinga Web. Much like before,
queries will run through this layer between the database (IDOUtils) and
the web interface. However, with Doctrine we can use several database
back-ends and querying the database is now much easier. In contrast to
SQL, its object relational mapper (ORM) uses Doctrine Query Language, so
we now have the flexibility minus the code duplication.

![](../images/Architecture_1.5_800px.png)

That being said, queries from the old API still exist, thanks to the
‘legacy layer’ which will transform old API queries into this new ORM
type. In this way, we maintain compatibility with addons designed for
older Icinga versions. The Rest API is also still there as part of
Icinga Web, extending on our Doctrine layer with HTTP for addons that
require only certain bits of monitoring info.

With the departure of a standalone API, the average Icinga user will
barely notice a change, apart from the fact that the configuration has
now been moved to the `databases.xml`. Best of all, every
module developer can now easily access the Icinga database without much
code overhead– so addon developers get hacking and let us know how you
go!

For more information see our Wiki:




![[Important]](../images/important.png)

Important

The following is deprecated and only kept for reference

### 11.3.1. Installation and use of the Icinga API

































































* * * * *

[Prev](epnplugins.md) | [Up](ch11.md) | [Next](icinga-web-api.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
