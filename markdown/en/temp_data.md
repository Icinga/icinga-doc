[Prev](perfgraphs.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch09.md)

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

















You may want to use the RAM disk for other files like the check results
as well. Please increase the size of the RAM disk if necessary and
change the directive in the main config file

<pre><code>
 check_result_path=/var/icinga/ramdisk/checkresults
</code></pre>

Please make sure that addons like check\_mk are aware of this change.

* * * * *

[Prev](perfgraphs.md) | [Up](ch08.md) | [Next](ch09.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
