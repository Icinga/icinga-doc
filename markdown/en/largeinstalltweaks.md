![Icinga](../images/logofullsize.png "Icinga")

8.5. Large Installation Tweaks

[Prev](faststartup.md) 

Chapter 8. Security and Performance Tuning

 [Next](icingastats.md)

* * * * *

8.5. Large Installation Tweaks
------------------------------

8.5.1. [Introduction](largeinstalltweaks.md#introduction)

8.5.2. [Effects](largeinstalltweaks.md#effects)

### 8.5.1. Introduction

Users with large Icinga installations may benefit from the
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
configuration option. Enabling this option allows the Icinga daemon to
take certain shortcuts which result in lower system load and better
performance.

### 8.5.2. Effects

When you enable the
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
option in your main Icinga config file, several changes are made to the
way the Icinga daemon operates:

1.  **No Summary Macros In Environment Variables** - The [summary
    macros](macrolist.md#macrolist-summary_macros) will not be
    available to you as environment variables. Calculating the values of
    these macros can be quite time-intensive in large configurations, so
    they are not available as environment variables when use this
    option. Summary macros will still be available as regular macros if
    you pass them to to your scripts as arguments.

    ![[Note]](../images/note.png)

    Note

    Since 1.9, [host](macrolist.md#macrolist-hostgroupmembers) and
    [service](macrolist.md#macrolist-servicegroupmembers)group member
    macros won't be exported either, as they may become huge and break
    the entire environment.

2.  **Different Memory Cleanup** - Normally Icinga will free all
    allocated memory in child processes before they exit. This is
    probably best practice, but is likely unnecessary in most
    installations, as most OSes will take care of freeing allocated
    memory when processes exit. The OS tends to free allocated memory
    faster than can be done within Icinga itself, so Icinga won't
    attempt to free memory in child processes if you enable this option.

3.  **Checks fork() Less** - Normally Icinga will fork() twice when it
    executes host and service checks. This is done to (1) ensure a high
    level of resistance against plugins that go awry and segfault and
    (2) make the OS deal with cleaning up the grandchild process once it
    exits. The extra fork() is not really necessary, so it is skipped
    when you enable this option. As a result, Icinga will itself clean
    up child processes that exit (instead of leaving that job to the
    OS). This feature should result in significant load savings on your
    Icinga installation.

* * * * *

  ---------------------------- -------------------- -------------------------------------
  [Prev](faststartup.md)     [Up](ch08.md)       [Next](icingastats.md)
  8.4. Fast Startup Options    [Home](index.md)    8.6. Using The Icingastats Utility
  ---------------------------- -------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
