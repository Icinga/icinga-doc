[Prev](oncallrotation.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](dependencies.md)

* * * * *

7.12. Monitoring Service and Host Clusters
------------------------------------------

7.12.1. [Introduction](clusters.md#introduction_clusters)

7.12.2. [Plan of Attack](clusters.md#planofattack)

7.12.3. [Using the check\_cluster
Plugin](clusters.md#checkclusterplugin)

7.12.4. [Monitoring Service Clusters](clusters.md#serviceclusters)

7.12.5. [Monitoring Host Clusters](clusters.md#hostclusters)

### 7.12.1. Introduction

Several people have asked how to go about monitoring clusters of hosts
or services, so this little documentation should provide you with some
information on how to do this. It's fairly straightforward, so hopefully
you find things easy to understand...

First off, we need to define what we mean by a "cluster". The simplest
way to understand this is with an example. Let's say that your
organization has five hosts which provide redundant DNS services to your
organization. If one of them fails, its not a major catastrophe because
the remaining servers will continue to provide name resolution services.
If you're concerned with monitoring the availability of DNS service to
your organization, you will want to monitor five DNS servers. This is
what is considered to be a *service* cluster. The service cluster
consists of five separate DNS services that you are monitoring. Although
you do want to monitor each individual service, your main concern is
with the overall status of the DNS service cluster, rather than the
availability of any one particular service.

If your organization has a group of hosts that provide a
high-availability (clustering) solution, that would be considered to be
a *host* cluster. If one particular host fails, another will step in to
take over all the duties of the failed server. As a side note, check out
the [High-Availability Linux Project](http://www.linux-ha.org) for
information on providing host and service redundancy with Linux.

### 7.12.2. Plan of Attack

There are several ways you could potentially monitor service or host
clusters. We'll describe one method to do that. Monitoring service or
host clusters involves two things:



Monitoring individual host or service cluster elements is easier than
you think. In fact, you're probably already doing it. For service
clusters, just make sure that you are monitoring each service element of
the cluster. If you've got a cluster of five DNS servers, make sure you
have five separate service definitions (probably using the *check\_dns*
plugin). For host clusters, make sure you have configured appropriate
host definitions for each member of the cluster (you'll also have to
define at least one service to be monitored for each of the hosts).
**Important:** You're going to want to disable notifications for the
individual cluster elements (host or service definitions). Even though
no notifications will be sent about the individual elements, you'll
still get a visual display of the individual host or service status in
the [status CGI](cgis.md#cgis-status_cgi). This will be useful for
pinpointing the source of problems within the cluster in the future.

Monitoring the overall cluster can be done by using the previously
cached results of cluster elements. Although you could re-check all
elements of the cluster to determine the cluster's status, why waste
bandwidth and resources when you already have the results cached? Where
are the results cached? Cached results for cluster elements can be found
in the [status file](configmain.md#configmain-status_file) (assuming
you are monitoring each element). The *check\_cluster* plugin is
designed specifically for checking cached host and service states in the
status file. **Important:** Although you didn't enable notifications for
individual elements of the cluster, you will want them enabled for the
overall cluster status check.

### 7.12.3. Using the check\_cluster Plugin

The check\_cluster plugin is designed to report the overall status of a
host or service cluster by checking the status information of each
individual host or service cluster elements.

More to come... The *check\_cluster* plugin can be found in the contrib
directory of the Monitoring Plugins release at
[https://www.monitoring-plugins.org](https://www.monitoring-plugins.org).

### 7.12.4. Monitoring Service Clusters

Let's say you have three DNS servers that provide redundant services on
your network. First off, you need to be monitoring each of these DNS
servers separately before you can monitor them as a cluster. We'll
assume that you already have three separate services (all called "DNS
Service") associated with your DNS hosts (called "host1", "host2" and
"host3").

In order to monitor the services as a cluster, you'll need to create a
new "cluster" service. However, before you do that, make sure you have a
service cluster check command configured. Let's assume that you have a
command called *check\_service\_cluster* defined as follows:

<pre><code>
 define command{
</code></pre>

Now you'll need to create the "cluster" service and use the
*check\_service\_cluster* command you just created as the cluster's
check command. The example below gives an example of how to do this. The
example below will generate a CRITICAL alert if 2 or more services in
the cluster are in a non-OK state, and a WARNING alert if only 1 of the
services is in a non-OK state. If all the individual service members of
the cluster are OK, the cluster check will return an OK state as well.

<pre><code>
 define service{
</code></pre>

It is important to notice that we are passing a comma-delimited list of
*on-demand* service state
[macros](macros.md "5.2. Understanding Macros and How They Work") to
the \$ARG4\$ macro in the cluster check command. That's important!
Icinga will fill those on-demand macros in with the current service
state IDs (numerical values, rather than text strings) of the individual
members of the cluster.

### 7.12.5. Monitoring Host Clusters

Monitoring host clusters is very similiar to monitoring service
clusters. Obviously, the main difference is that the cluster members are
hosts and not services. In order to monitor the status of a host
cluster, you must define a service that uses the *check\_cluster*
plugin. The service should *not* be associated with any of the hosts in
the cluster, as this will cause problems with notifications for the
cluster if that host goes down. A good idea might be to associate the
service with the host that Icinga is running on. After all, if the host
that Icinga is running on goes down, then Icinga isn't running anymore,
so there isn't anything you can do as far as monitoring (unless you've
setup [redundant monitoring
hosts](redundancy.md "7.7. Redundant and Failover Network Monitoring"))...

Anyway, let's assume that you have a *check\_host\_cluster* command
defined as follows:

<pre><code>
 define command{
</code></pre>

Let's say you have three hosts (named "host1", "host2" and "host3") in
the host cluster. If you want Icinga to generate a warning alert if one
host in the cluster is not UP or a critical alert if two or more hosts
are not UP, the the service you define to monitor the host cluster might
look something like this:

<pre><code>
 define service{
</code></pre>

It is important to notice that we are passing a comma-delimited list of
*on-demand* host state
[macros](macros.md "5.2. Understanding Macros and How They Work") to
the \$ARG4\$ macro in the cluster check command. That's important!
Icinga will fill those on-demand macros in with the current host state
IDs (numerical values, rather than text strings) of the individual
members of the cluster.

That's it! Icinga will periodically check the status of the host cluster
and send notifications to you when its status is degraded (assuming
you've enabled notification for the service). Note that for thehost
definitions of each cluster member, you will most likely want to disable
notifications when the host goes down . Remeber that you don't care as
much about the status of any individual host as you do the overall
status of the cluster. Depending on your network layout and what you're
trying to accomplish, you may wish to leave notifications for
unreachable states enabled for the host definitions.

* * * * *

[Prev](oncallrotation.md) | [Up](ch07.md) | [Next](dependencies.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
