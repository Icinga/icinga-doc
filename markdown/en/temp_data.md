![Icinga](../images/logofullsize.png "Icinga")

8.8. Temporary Data

[Prev](perfgraphs.md) 

Chapter 8. Security and Performance Tuning

 [Next](ch09.md)

* * * * *

8.8. Temporary Data
-------------------

Several files are created while starting Icinga and processed very often
during runtime. Depending on the size of your configuration this may
lead to high I/O and therefore degraded responsiveness. To reduce
physical I/O operations it might be a good idea to place temporary files
on a RAM disk. The following lines show the steps to setup a RAM disk
and the changes to the main config file.

![[Note]](../images/note.png)

Note

Please keep in mind that these files will be lost if you reboot the
system. Also note that sometimes it is difficult to determine the size
of these files which may lead to a full RAM disk.

1.  Have a look at the current location of the [status
    file](configmain.md#configmain-status_file) (e.g.
    `/usr/local/icinga/var/status.dat`{.filename}) and the [object cache
    file](configmain.md#configmain-object_cache_file) (e.g.
    `/usr/local/icinga/var/objects.cache`{.filename}) and determine the
    size of both files. Add the size of the status file for temporary
    data ([temp\_file](configmain.md#configmain-temp_file)).

    ~~~~ {.programlisting}
     #> ls -la /usr/local/icinga/var/
     -rw-rw-r--   1 icinga icinga 8.2M Jun 10 11:57 status.dat
     -rw-r--r--   1 icinga icinga 5.9M Jun 10 11:58 objects.cache
    ~~~~

2.  Increase the number to a considerable value to allow for future
    growth (100 MB should be sufficient in this case) and create the RAM
    disk.

    ![[Caution]](../images/caution.png)

    Caution

    If the value is too high then this will throttle your system because
    it will start to swap resulting in physical I/O once again.

    ~~~~ {.programlisting}
     #> mkdir /var/icinga/ramdisk
     #> mount -t tmpfs tmpfs /var/icinga/ramdisk -o size=100m
     #> chown icinga:icinga /var/icinga/ramdisk
    ~~~~

    Adapt the values of user and group to the ones found in your
    configuration if necessary.

3.  Add an entry to `/etc/fstab`{.filename} to make the setting
    permanent so the RAM disk will be created automatically after the
    next reboot.

    ~~~~ {.programlisting}
    tmpfs                /var/icinga/ramdisk     tmpfs   size=100m        0 0
    ~~~~

4.  Edit the Icinga main configuration file and change the setting of
    the appropriate directives

    ~~~~ {.programlisting}
     #object_cache_file=/usr/local/icinga/var/objects.cache
     object_cache_file=/var/icinga/ramdisk/objects.cache

     #status_file=/usr/local/icinga/var/status.dat
     status_file=/var/icinga/ramdisk/status.dat

     #temp_file=/usr/local/icinga/var/icinga.tmp
     temp_file=/var/icinga/ramdisk/icinga.tmp
    ~~~~

5.  Restart Icinga to put the changes into effect

    ~~~~ {.programlisting}
     #> /etc/init.d/icinga restart
    ~~~~

You may want to use the RAM disk for other files like the check results
as well. Please increase the size of the RAM disk if necessary and
change the directive in the main config file

~~~~ {.programlisting}
 check_result_path=/var/icinga/ramdisk/checkresults
~~~~

Please make sure that addons like check\_mk are aware of this change.

* * * * *

  ------------------------------------------------- -------------------- ---------------------------------------------
  [Prev](perfgraphs.md)                           [Up](ch08.md)       [Next](ch09.md)
  8.7. Graphing Performance Info With PNP4Nagios    [Home](index.md)    Chapter 9. Integration With Other Software
  ------------------------------------------------- -------------------- ---------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
