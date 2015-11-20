[Prev](clusters.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](stalking.md)

* * * * *

7.13. Host and Service Dependencies
-----------------------------------

7.13.1. [Introduction](dependencies.md#introduction)

7.13.2. [Service Dependencies Overview](dependencies.md#overview)

7.13.3. [Defining Service Dependencies](dependencies.md#definition)

7.13.4. [Example Service Dependencies](dependencies.md#example)

7.13.5. [How Service Dependencies Are Tested](dependencies.md#test)

7.13.6. [Execution Dependencies](dependencies.md#execution)

7.13.7. [Notification Dependencies](dependencies.md#idp14493488)

7.13.8. [Dependency Inheritance](dependencies.md#inheritance)

7.13.9. [Host Dependencies](dependencies.md#dep_host)

7.13.10. [Example Host Dependencies](dependencies.md#examplehost)

### 7.13.1. Introduction

Service and host dependencies are an advanced feature of Icinga that
allow you to control the behavior of hosts and services based on the
status of one or more other hosts or services. We'll explain how
dependencies work, along with the differences between host and service
dependencies.

### 7.13.2. Service Dependencies Overview

There are a few things you should know about service dependencies:






### 7.13.3. Defining Service Dependencies

First, the basics. You create service dependencies by adding [service
dependency
definitions](objectdefinitions.md#objectdefinitions-servicedependency)
in your [object config
file(s)](configobject.md "3.3. Object Configuration Overview"). In
each definition you specify the *dependent* service, the service you are
*depending on*, and the criteria (if any) that cause the execution and
notification dependencies to fail (these are described later).

You can create several dependencies for a given service, but you must
add a separate service dependency definition for each dependency you
create.

### 7.13.4. Example Service Dependencies

The image below shows an example logical layout of service notification
and execution dependencies. Different services are dependent on other
services for notifications and check execution.

![](../images/service-dependencies.png)

In this example, the dependency definitions for *Service F* on *Host C*
would be defined as follows:

<pre><code>
 define servicedependency{

 define servicedependency{

 define servicedependency{
</code></pre>

The other dependency definitions shown in the image above would be
defined as follows:

<pre><code>
 define servicedependency{

 define servicedependency{

 define servicedependency{
</code></pre>

### 7.13.5. How Service Dependencies Are Tested

Before Icinga executes a service check or sends notifications out for a
service, it will check to see if the service has any dependencies. If it
doesn't have any dependencies, the check is executed or the notification
is sent out as it normally would be. If the service *does* have one or
more dependencies, Icinga will check each dependency entry as follows:





This cycle continues until either all dependencies for the service have
been checked or until one dependency check fails.

![[Note]](../images/note.png)

Note

^\*^One important thing to note is that by default, Icinga will use the
most current [hard state](statetypes.md "5.8. State Types") of the
service(s) that is/are being depended upon when it does the dependeny
checks. If you want Icinga to use the most current state of the services
(regardless of whether its a soft or hard state), enable the
[soft\_state\_dependencies](configmain.md#configmain-soft_state_dependencies)
option.

### 7.13.6. Execution Dependencies

Execution dependencies are used to restrict when [active
checks](activechecks.md "5.6. Active Checks") of a service can be
performed. [Passive checks](passivechecks.md "5.7. Passive Checks")
are not restricted by execution dependencies.

If *all* of the execution dependency tests for the service *passed*,
Icinga will execute the check of the service as it normally would. If
even just one of the execution dependencies for a service fails, Icinga
will temporarily prevent the execution of checks for that (dependent)
service. At some point in the future the execution dependency tests for
the service may all pass. If this happens, Icinga will start checking
the service again as it normally would. More information on the check
scheduling logic can be found
[here](checkscheduling.md "7.23. Service and Host Check Scheduling").

In the example above, **Service E** would have failed execution
dependencies if **Service B** is in a WARNING or UNKNOWN state. If this
was the case, the service check would not be performed and the check
would be scheduled for (potential) execution at a later time.

### 7.13.7. Notification Dependencies

If *all* of the notification dependency tests for the service *passed*,
Icinga will send notifications out for the service as it normally would.
If even just one of the notification dependencies for a service fails,
Icinga will temporarily repress notifications for that (dependent)
service. At some point in the future the notification dependency tests
for the service may all pass. If this happens, Icinga will start sending
out notifications again as it normally would for the service. More
information on the notification logic can be found
[here](notifications.md "5.11. Notifications").

In the example above, **Service F** would have failed notification
dependencies if **Service C** is in a CRITICAL state, *and/or***Service
D** is in a WARNING or UNKNOWN state, *and/or* if **Service E** is in a
WARNING, UNKNOWN, or CRITICAL state. If this were the case,
notifications for the service would not be sent out.

### 7.13.8. Dependency Inheritance

As mentioned before, service dependencies are *not* inherited by
default. In the example above you can see that Service F is dependent on
Service E. However, it does not automatically inherit Service E's
dependencies on Service B and Service C. In order to make Service F
dependent on Service C we had to add another service dependency
definition. There is no dependency definition for Service B, so Service
F is *not* dependent on Service B.

If you *do* wish to make service dependencies inheritable, you must use
the *inherits\_parent* directive in the [service
dependency](objectdefinitions.md#objectdefinitions-servicedependency)
definition. When this directive is enabled, it indicates that the
dependency inherits dependencies of the service *that is being depended
upon* (also referred to as the master service). In other words, if the
master service is dependent upon other services and any one of those
dependencies fail, this dependency will also fail.

In the example above, imagine that you want to add a new dependency for
service F to make it dependent on service A. You could create a new
dependency definition that specified service F as the *dependent*
service and service A as being the *master* service (i.e. the service
*that is being dependend on*). You could alternatively modify the
dependency definition for services D and F to look like this:

<pre><code>
 define servicedependency{
</code></pre>

Since the *inherits\_parent* directive is enabled, the dependency
between services A and D will be tested when the dependency between
services F and D are being tested.

Dependencies can have multiple levels of inheritence. If the dependency
definition between A and D had its *inherits\_parent* directive enable
and service A was dependent on some other service (let's call it service
G), the service F would be dependent on services D, A, and G (each with
potentially different criteria).

### 7.13.9. Host Dependencies

As you'd probably expect, host dependencies work in a similiar fashion
to service dependencies. The difference is that they're for hosts, not
services.

![[Tip]](../images/tip.png)

Tip

Do not confuse host dependencies with parent/child host relationships.
You should be using parent/child host relationships (defined with the
*parents* directive in
[host](objectdefinitions.md#objectdefinitions-host) definitions) for
most cases, rather than host dependencies. A description of how
parent/child host relationships work can be found in the documentation
on [network
reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts").

Here are the basics about host dependencies:





### 7.13.10. Example Host Dependencies

The image below shows an example of the logical layout of host
notification dependencies. Different hosts are dependent on other hosts
for notifications.

![](../images/host-dependencies.png)

In the example above, the dependency definitions for *Host C* would be
defined as follows:

<pre><code>
 define hostdependency{

 define hostdependency{
</code></pre>

As with service dependencies, host dependencies are not inherited. In
the example image you can see that Host C does not inherit the host
dependencies of Host B. In order for Host C to be dependent on Host A, a
new host dependency definition must be defined.

Host notification dependencies work in a similiar manner to service
notification dependencies. If *all* of the notification dependency tests
for the host *pass*, Icinga will send notifications out for the host as
it normally would. If even just one of the notification dependencies for
a host fails, Icinga will temporarily repress notifications for that
(dependent) host. At some point in the future the notification
dependency tests for the host may all pass. If this happens, Icinga will
start sending out notifications again as it normally would for the host.
More information on the notification logic can be found
[here](notifications.md "5.11. Notifications").

* * * * *

[Prev](clusters.md) | [Up](ch07.md) | [Next](stalking.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
