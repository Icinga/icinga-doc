![Icinga](../images/logofullsize.png "Icinga")

8.3. Tuning Icinga For Maximum Performance

[Prev](cgisecurity.md) 

Chapter 8. Security and Performance Tuning

 [Next](faststartup.md)

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

1.  **Graph performance statistics with PNP4Nagios** . In order to keep
    track of how well your Icinga installation handles load over time
    and how your configuration changes affect it, you should be graphing
    several important statistics with PNP4Nagios. This is really,
    really, really useful when it comes to tuning the performance of a
    Icinga installation. Really. Information on how to do this can be
    found
    [here](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios").

2.  **Use large installation tweaks** . Enabling the
    [use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
    option may provide you with better performance. Read more about what
    this option does
    [here](largeinstalltweaks.md "8.5. Large Installation Tweaks").

3.  **Disable environment macros** . Macros are normally made available
    to check, notification, event handler, etc. commands as environment
    variables. This can be a problem in a large Icinga installation, as
    it consumes some additional memory and (more importantly) more CPU.
    If your scripts don't need to access the macros as environment
    variables (e.g. you pass all necessary macros on the command line),
    you don't need this feature. You can prevent macros from being made
    available as environment variables by using the
    [enable\_environment\_macros](configmain.md#configmain-enable_environment_macros)
    option.

4.  **Check Result Reaper Frequency** . The
    [check\_result\_reaper\_frequency](configmain.md#configmain-check_result_reaper_frequency)
    variable determines how often Icinga should check for host and
    service check results that need to be processed. The maximum amount
    of time it can spend processing those results is determined by the
    max reaper time (see below). If your reaper frequency is too high
    (too infrequent), you might see high latencies for host and service
    checks.

5.  **Max Reaper Time** . The
    [max\_check\_result\_reaper\_time](configmain.md#configmain-max_check_result_reaper_time)
    variables determines the maximum amount of time the Icinga daemon
    can spend processing the results of host and service checks before
    moving on to other things - like executing new host and service
    checks. Too high of a value can result in large latencies for your
    host and service checks. Too low of a value can have the same
    effect. If you're experiencing high latencies, adjust this variable
    and see what effect it has. Again, you should be [graphing
    statistics](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios")
    in order to make this determination.

6.  **Adjust buffer slots** . You may need to adjust the value of the
    [external\_command\_buffer\_slots](configmain.md#configmain-external_command_buffer_slots)
    option. Graphing buffer slot statistics with
    [PNP4Nagios](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios")
    (see above) is critical in determining what values you should use
    for this option.

7.  **Check service latencies to determine best value for maximum
    concurrent checks** . Icinga can restrict the number of maximum
    concurrently executing service checks to the value you specify with
    the
    [max\_concurrent\_checks](configmain.md#configmain-max_concurrent_checks)
    option. This is good because it gives you some control over how much
    load Icinga will impose on your monitoring host, but it can also
    slow things down. If you are seeing high latency values (\> 10 or 15
    seconds) for the majority of your service checks (via the [extinfo
    CGI](cgis.md#cgis-extinfo_cgi)), you are probably starving Icinga
    of the checks it needs. That's not Icinga's fault - its yours. Under
    ideal conditions, all service checks would have a latency of 0,
    meaning they were executed at the exact time that they were
    scheduled to be executed. However, it is normal for some checks to
    have small latency values. We would recommend taking the minimum
    number of maximum concurrent checks reported when running Icinga
    with the **-s** command line argument and doubling it. Keep
    increasing it until the average check latency for your services is
    fairly low. More information on service check scheduling can be
    found
    [here](checkscheduling.md "7.23. Service and Host Check Scheduling").

8.  **Use passive checks when possible** . The overhead needed to
    process the results of [passive service
    checks](passivechecks.md "5.7. Passive Checks") is much lower than
    that of "normal" active checks, so make use of that piece of info if
    you're monitoring a slew of services. It should be noted that
    passive service checks are only really useful if you have some
    external application doing some type of monitoring or reporting, so
    if you're having Icinga do all the work, this won't help things.

9.  **Avoid using interpreted plugins** . One thing that will
    significantly reduce the load on your monitoring host is the use of
    compiled (C/C++, etc.) plugins rather than interpreted script (Perl,
    etc) plugins. While Perl scripts and such are easy to write and work
    well, the fact that they are compiled/interpreted at every execution
    instance can significantly increase the load on your monitoring host
    if you have a lot of service checks. If you want to use Perl
    plugins, consider compiling them into true executables using
    perlcc(1) (a utility which is part of the standard Perl
    distribution) or compiling Icinga with an embedded Perl interpreter
    (see below).

10. **Use the embedded Perl interpreter** . If you're using a lot of
    Perl scripts for service checks, etc., you will probably find that
    compiling the [embedded Perl
    interpreter](embeddedperl.md "7.18. Using The Embedded Perl Interpreter")
    into the Icinga binary will speed things up.

11. **Optimize host check commands** . If you're checking host states
    using the check\_ping plugin you'll find that host checks will be
    performed much faster if you break up the checks. Instead of
    specifying a *max\_attempts* value of 1 in the host definition and
    having the check\_ping plugin send 10 ICMP packets to the host, it
    would be much faster to set the *max\_attempts* value to 10 and only
    send out 1 ICMP packet each time. This is due to the fact that
    Icinga can often determine the status of a host after executing the
    plugin once, so you want to make the first check as fast as
    possible. This method does have its pitfalls in some situations
    (i.e. hosts that are slow to respond may be assumed to be down), but
    you'll see faster host checks if you use it. Another option would be
    to use a faster plugin (i.e. check\_fping) as the
    *host\_check\_command* instead of check\_ping.

12. **Schedule regular host checks** . Scheduling regular checks of
    hosts can actually help performance in Icinga. This is due to the
    way the [cached check
    logic](cachedchecks.md "7.21. Cached Checks") works (see below).
    Host checks are run in parallel - just like service checks. To
    schedule regular checks of a host, set the *check\_interval*
    directive in the [host
    definition](objectdefinitions.md#objectdefinitions-host) to
    something greater than 0.

13. **Enable cached host checks** . On-demand host checks can benefit
    from caching. On-demand host checks are performed whenever Icinga
    detects a service state change. These on-demand checks are executed
    because Icinga wants to know if the host associated with the service
    changed state. By enabling cached host checks, you can optimize
    performance. In some cases, Icinga may be able to used the
    old/cached state of the host, rather than actually executing a host
    check command. This can speed things up and reduce load on
    monitoring server. In order for cached checks to be effective, you
    need to schedule regular checks of your hosts (see above). More
    information on cached checks can be found
    [here](cachedchecks.md "7.21. Cached Checks").

14. **Don't use agressive host checking**. Unless you're having problems
    with Icinga recognizing host recoveries, We would recommend not
    enabling the
    [use\_aggressive\_host\_checking](configmain.md#configmain-use_agressive_host_checking)
    option. With this option turned off host checks will execute much
    faster, resulting in speedier processing of service check results.
    However, host recoveries can be missed under certain circumstances
    when this it turned off. For example, if a host recovers and all of
    the services associated with that host stay in non-OK states (and
    don't "wobble" between different non-OK states), Icinga may miss the
    fact that the host has recovered. A few people may need to enable
    this option, but the majority don't and we would recommend not using
    it unless you find it necessary...

15. **External command optimizations** . If you're processing a lot of
    external commands (i.e. passive checks in a [distributed
    setup](distributed.md "7.6. Distributed Monitoring"), you'll
    probably want to set the
    [command\_check\_interval](configmain.md#configmain-command_check_interval)
    variable to **-1**. This will cause Icinga to check for external
    commands as often as possible. You should also consider increasing
    the number of available [external command buffer
    slots](configmain.md#configmain-external_command_buffer_slots).
    Buffers slots are used to hold external commands that have been read
    from the [external command
    file](configmain.md#configmain-command_file) (by a separate
    thread) before they are processed by the Icinga daemon. If your
    Icinga daemon is receiving a lot of passive checks or external
    commands, you could end up in a situation where the buffers are
    always full. This results in child processes (external scripts, NSCA
    daemon, etc.) blocking when they attempt to write to the external
    command file. We would highly recommend that you graph external
    command buffer slot usage using PNP4Nagios and the nagiostats
    utility as described
    [here](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios"),
    so you understand the typical external command buffer usage of your
    Icinga installation.

16. **Optimize hardware for maximum performance** . NOTE: Hardware
    performance shouldn't be an issue unless: 1) you're monitoring
    thousands of services, 2) you're doing a lot of post-processing of
    performance data, etc. Your system configuration and your hardware
    setup are going to directly affect how your operating system
    performs, so they'll affect how Icinga performs. The most common
    hardware optimization you can make is with your hard drives. CPU and
    memory speed are obviously factors that affect performance, but disk
    access is going to be your biggest bottleneck. Don't store plugins,
    the status log, etc on slow drives (i.e. old IDE drives or NFS
    mounts). If you've got them, use UltraSCSI drives or fast IDE
    drives. An important note for IDE/Linux users is that many Linux
    installations do not attempt to optimize disk access. If you don't
    change the disk access parameters (by using a utility like
    **hdparam**), you'll loose out on a **lot** of the speedy features
    of the new IDE drives.

17. **Use a RAM disk for temporary data** . Several files are created
    and processed very often. That includes the current status stored in
    the [status file](configmain.md#configmain-status_file) and the
    configuration being cached in the [object cache
    file](configmain.md#configmain-object_cache_file). To reduce
    physical I/O it is advisable to have this data on a RAM disk. Data
    loss due to a power failure or something alike is not critical
    because the two files are created every time Icinga is (re)started.
    Setting up the RAM disk and the changes to the main config file is
    described [here](temp_data.md "8.8. Temporary Data").

* * * * *

  ------------------------------------------------------- -------------------- ----------------------------
  [Prev](cgisecurity.md)                                [Up](ch08.md)       [Next](faststartup.md)
  8.2. Enhanced Classic UI Security and Authentication    [Home](index.md)    8.4. Fast Startup Options
  ------------------------------------------------------- -------------------- ----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
