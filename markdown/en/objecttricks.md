[Prev](objectinheritance.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch08.md)

* * * * *

7.27. Time-Saving Tricks For Object Definitions
-----------------------------------------------

**Introduction**

This documentation attempts to explain how you can exploit the
(somewhat) hidden features of [template-based object
definitions](objectdefinitions.md "3.4. Object Definitions") to save
your sanity. How so, you ask? Several types of objects allow you to
specify multiple host names and/or hostgroup names in definitions,
allowing you to "copy" the object defintion to multiple hosts or
services. We'll cover each type of object that supports these features
separately. For starters, the object types which support this
time-saving feature are as follows:







Object types that are not listed above (i.e. timeperiods, commands,
etc.) do not support the features we're about to describe.

**Regular Expression Matching**

The examples we give below use "standard" matching of object names. If
you wish, you can enable regular expression matching for object names by
using the
[use\_regexp\_matching](configmain.md#configmain-use_regexp_matching)
config option. By default, regular expression matching will only be used
in object names that contain **\***, **?**, **+**, or **\\.**. If you
want regular expression matching to be used on all object names, enable
the
[use\_true\_regexp\_matching](configmain.md#configmain-use_true_regexp_matching)
config option. Regular expressions can be used in any of the fields used
in the examples below (host names, hostgroup names, service names, and
servicegroup names).

![[Note]](../images/note.png)

Note

change your config file, since some directives that you might not want
to be interpreted as a regular expression just might be! Any problems
should become evident once you verify your configuration.

If you intend to use regular expressions
(`use_regexp_matching=1`) then please make sure that you have
read and understood the appropriate manual page (`man regex`).

**Service Definitions**

**Multiple Hosts:**

If you want to create identical
[services](objectdefinitions.md#objectdefinitions-service) that are
assigned to multiple hosts, you can specify multiple hosts in the
*host\_name* directive. The definition below would create a service
called *SOMESERVICE* on hosts *HOST1* through *HOSTN*. All the instances
of the *SOMESERVICE* service would be identical (i.e. have the same
check command, max check attempts, notification period, etc.).

</code></pre>

**All Hosts In Multiple Hostgroups:**

If you want to create identical services that are assigned to all hosts
in one or more hostgroups, you can do so by creating a single service
definition. How? The *hostgroup\_name* directive allows you to specify
the name of one or more hostgroups that the service should be created
for. The definition below would create a service called *SOMESERVICE* on
all hosts that are members of hostgroups *HOSTGROUP1* through
*HOSTGROUPN*. All the instances of the *SOMESERVICE* service would be
identical (i.e. have the same check command, max check attempts,
notification period, etc.).

</code></pre>

**All Hosts:**

If you want to create identical services that are assigned to all hosts
that are defined in your configuration files, you can use a wildcard in
the *host\_name* directive. The definition below would create a service
called *SOMESERVICE* on **all hosts** that are defined in your
configuration files. All the instances of the *SOMESERVICE* service
would be identical (i.e. have the same check command, max check
attempts, notification period, etc.).

</code></pre>

**Excluding Hosts:**

If you want to create identical services on numerous hosts or
hostgroups, but would like to exclude some hosts from the definition,
this can be accomplished by preceding the host or hostgroup with a !
symbol.

</code></pre>

**Service Escalation Definitions**

**Multiple Hosts:**

If you want to create [service
escalations](objectdefinitions.md#objectdefinitions-serviceescalation)
for services of the same name/description that are assigned to multiple
hosts, you can specify multiple hosts in the *host\_name* directive. The
definition below would create a service escalation for services called
*SOMESERVICE* on hosts *HOST1* through *HOSTN*. All the instances of the
service escalation would be identical (i.e. have the same contact
groups, notification interval, etc.).

</code></pre>

**All Hosts In Multiple Hostgroups:**

If you want to create service escalations for services of the same
name/description that are assigned to all hosts in in one or more
hostgroups, you can do use the *hostgroup\_name* directive. The
definition below would create a service escalation for services called
*SOMESERVICE* on all hosts that are members of hostgroups *HOSTGROUP1*
through *HOSTGROUPN*. All the instances of the service escalation would
be identical (i.e. have the same contact groups, notification interval,
etc.).

</code></pre>

**All Hosts:**

If you want to create identical service escalations for services of the
same name/description that are assigned to all hosts that are defined in
your configuration files, you can use a wildcard in the *host\_name*
directive. The definition below would create a service escalation for
all services called *SOMESERVICE* on **all hosts** that are defined in
your configuration files. All the instances of the service escalation
would be identical (i.e. have the same contact groups, notification
interval, etc.).

</code></pre>

**Excluding Hosts:**

If you want to create identical services escalations for services on
numerous hosts or hostgroups, but would like to exclude some hosts from
the definition, this can be accomplished by preceding the host or
hostgroup with a ! symbol.

</code></pre>

**All Services On Same Host:**

If you want to create [service
escalations](objectdefinitions.md#objectdefinitions-serviceescalation)
for all services assigned to a particular host, you can use a wildcard
in the *service\_description* directive. The definition below would
create a service escalation for **all** services on host *HOST1*. All
the instances of the service escalation would be identical (i.e. have
the same contact groups, notification interval, etc.).

If you feel like being particularly adventurous, you can specify a
wildcard in both the *host\_name* and *service\_description* directives.
Doing so would create a service escalation for **all services** that
you've defined in your configuration files.

</code></pre>

**Multiple Services On Same Host:**

If you want to create [service
escalations](objectdefinitions.md#objectdefinitions-serviceescalation)
for all multiple services assigned to a particular host, you can use a
specify more than one service description in the *service\_description*
directive. The definition below would create a service escalation for
services *SERVICE1* through *SERVICEN* on host *HOST1*. All the
instances of the service escalation would be identical (i.e. have the
same contact groups, notification interval, etc.).

</code></pre>

**All Services In Multiple Servicegroups:**

If you want to create service escalations for all services that belong
in one or more servicegroups, you can do use the *servicegroup\_name*
directive. The definition below would create service escalations for all
services that are members of servicegroups *SERVICEGROUP1* through
*SERVICEGROUPN*. All the instances of the service escalation would be
identical (i.e. have the same contact groups, notification interval,
etc.).

</code></pre>

**Service Dependency Definitions**

**Multiple Hosts:**

If you want to create [service
dependencies](objectdefinitions.md#objectdefinitions-servicedependency)
for services of the same name/description that are assigned to multiple
hosts, you can specify multiple hosts in the *host\_name* and or
*dependent\_host\_name* directives. In the example below, service
*SERVICE2* on hosts *HOST3* and *HOST4* would be dependent on service
*SERVICE1* on hosts *HOST1* and *HOST2*. All the instances of the
service dependencies would be identical except for the host names (i.e.
have the same notification failure criteria, etc.).

</code></pre>

**All Hosts In Multiple Hostgroups:**

If you want to create service dependencies for services of the same
name/description that are assigned to all hosts in in one or more
hostgroups, you can do use the *hostgroup\_name* and/or
*dependent\_hostgroup\_name* directives. In the example below, service
*SERVICE2* on all hosts in hostgroups *HOSTGROUP3* and *HOSTGROUP4*
would be dependent on service *SERVICE1* on all hosts in hostgroups
*HOSTGROUP1* and *HOSTGROUP2*. Assuming there were five hosts in each of
the hostgroups, this definition would be equivalent to creating 100
single service dependency definitions! All the instances of the service
dependency would be identical except for the host names (i.e. have the
same notification failure criteria, etc.).

</code></pre>

**All Services On A Host:**

If you want to create service dependencies for all services assigned to
a particular host, you can use a wildcard in the *service\_description*
and/or *dependent\_service\_description* directives. In the example
below, **all services** on host *HOST2* would be dependent on **all
services** on host *HOST1*. All the instances of the service
dependencies would be identical (i.e. have the same notification failure
criteria, etc.).

</code></pre>

**Multiple Services On A Host:**

If you want to create service dependencies for multiple services
assigned to a particular host, you can specify more than one service
description in the *service\_description* and/or
*dependent\_service\_description* directives as follows:

</code></pre>

**All Services In Multiple Servicegroups:**

If you want to create service dependencies for all services that belong
to one or more servicegroups, you can use the *servicegroup\_name*
and/or *dependent\_servicegroup\_name* directive as follows:

</code></pre>

**Same Host Dependencies:**

If you want to create service dependencies for multiple services that
are dependent on services on the same host, leave the
*dependent\_host\_name* and *dependent\_hostgroup\_name* directives
empty. The example below assumes that hosts *HOST1* and *HOST2* have at
least the following four services associated with them: *SERVICE1*,
*SERVICE2*, *SERVICE3*, and *SERVICE4*. In this example, *SERVICE3* and
*SERVICE4* on *HOST1* will be dependent on both *SERVICE1* and
*SERVICE2* on *HOST1*. Similiarly, *SERVICE3* and *SERVICE4* on *HOST2*
will be dependent on both *SERVICE1* and *SERVICE2* on *HOST2*.

</code></pre>

**Same Host Dependencies With Servicegroups:**

If you want to create service dependencies for all services that belong
to one or more servicegroups of a service on the same host running the
dependent service, leave the *host\_name* and *hostgroup\_name*
directives empty. The example below assumes that hosts running services
belonging to *SERVICEGROUP1* and *SERVICEGROUP2* have the following
service associated with them: *SERVICE1*. In this example, all services
belonging to *SERVICEGROUP1* and *SERVICEGROUP2* will be dependent on
*SERVICE1* on the same host running the dependent service.

</code></pre>

**Host Escalation Definitions**

**Multiple Hosts:**

If you want to create [host
escalations](objectdefinitions.md#objectdefinitions-hostescalation)
for multiple hosts, you can specify multiple hosts in the *host\_name*
directive. The definition below would create a host escalation for hosts
*HOST1* through *HOSTN*. All the instances of the host escalation would
be identical (i.e. have the same contact groups, notification interval,
etc.).

</code></pre>

**All Hosts In Multiple Hostgroups:**

If you want to create host escalations for all hosts in in one or more
hostgroups, you can do use the *hostgroup\_name* directive. The
definition below would create a host escalation on all hosts that are
members of hostgroups *HOSTGROUP1* through *HOSTGROUPN*. All the
instances of the host escalation would be identical (i.e. have the same
contact groups, notification interval, etc.).

</code></pre>

**All Hosts:**

If you want to create identical host escalations for all hosts that are
defined in your configuration files, you can use a wildcard in the
*host\_name* directive. The definition below would create a hosts
escalation for **all hosts** that are defined in your configuration
files. All the instances of the host escalation would be identical (i.e.
have the same contact groups, notification interval, etc.).

</code></pre>

**Excluding Hosts:**

If you want to create identical host escalations on numerous hosts or
hostgroups, but would like to exclude some hosts from the definition,
this can be accomplished by preceding the host or hostgroup with a !
symbol.

</code></pre>

**Host Dependency Definitions**

**Multiple Hosts:**

If you want to create [host
dependencies](objectdefinitions.md#objectdefinitions-hostdependency)
for multiple hosts, you can specify multiple hosts in the *host\_name*
and/or *dependent\_host\_name* directives. The definition below would be
equivalent to creating six separate host dependencies. In the example
above, hosts *HOST3*, *HOST4* and *HOST5* would be dependent upon both
*HOST1* and *HOST2*. All the instances of the host dependencies would be
identical except for the host names (i.e. have the same notification
failure criteria, etc.).

</code></pre>

**All Hosts In Multiple Hostgroups:**

If you want to create host escalations for all hosts in in one or more
hostgroups, you can do use the *hostgroup\_name* and /or
*dependent\_hostgroup\_name* directives. In the example below, all hosts
in hostgroups *HOSTGROUP3* and *HOSTGROUP4* would be dependent on all
hosts in hostgroups *HOSTGROUP1* and *HOSTGROUP2*. All the instances of
the host dependencies would be identical except for host names (i.e.
have the same notification failure criteria, etc.).

</code></pre>

**Hostgroups**

**All Hosts:**

If you want to create a hostgroup that has all hosts that are defined in
your configuration files as members, you can use a wildcard in the
*members* directive. The definition below would create a hostgroup
called *HOSTGROUP1* that has all **all hosts** that are defined in your
configuration files as members.

</code></pre>

* * * * *

[Prev](objectinheritance.md) | [Up](ch07.md) | [Next](ch08.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
