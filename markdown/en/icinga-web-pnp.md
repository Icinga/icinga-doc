[Prev](icinga-web-introduction.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch07.md)

* * * * *

6.9. Integration of PNP4Nagios into Icinga Web
----------------------------------------------

6.9.1. [Install PNP4Nagios](icinga-web-pnp.md#installpnp)

6.9.2. [Templates Extension](icinga-web-pnp.md#templateextension)

6.9.3. [Clearing the cache](icinga-web-pnp.md#clearcache)

Here we'll give you some instructions on how to integrate PNP4Nagios
into the Icinga Web frontend. If you want to integrate PNP4Nagios into
the Icinga Classic UI please follow the PNP4Nagios
[documentation](http://docs.pnp4nagios.org/pnp-0.6/start).

**Figure 6.40. Expander icon**

![Expander icon](../images/icinga-web-exp_1.png)

\

On the left you will see the expander icon. Clicking on it opens a bar
(shown below the OK sign).

**Figure 6.41. Icon bar**

![Icon bar](../images/icinga-web-exp_2.png)

\

On the right in the "PNP4Nagios" section there are two buttons.

**Figure 6.42. Move icons to grid**

![Move icons to grid](../images/icinga-web-exp_3.png)

\

Right-clicking on either of them and selecting "Move into grid" will
move the appropriate icon into the grid.

**Figure 6.43. New icons in grid**

![New icons in grid](../images/icinga-web-exp_4.png)

\

Selecting the new icon opens the PNP graph in a small window showing
only one time frame or it will create a new tab showing the usual PNP
view.

Clicking on "Setting" and selecting "Reset grid action icons" will
remove the inserted icons restoring the default view.

**Figure 6.44. Reset icon view**

![Reset icon view](../images/icinga-web-exp_5.png)

\

### 6.9.1. Install PNP4Nagios












### 6.9.2. Templates Extension

PNP integration is made with these extensions to be upgrade safe.

Excerpt from the `INSTALL` in
`contrib/PNP_Integration/`

#> cat contrib/PNP_Integration/INSTALL

</code></pre>

*Install Script*

Because it's only copying the two files mentioned there is no script.
Sorry.

![[Note]](../images/note.png)

Note

Please note that you will have to reinstall the addon after Icinga-Web
upgrade.

### 6.9.3. Clearing the cache

![[Note]](../images/note.png)

Note

If you edit any \*.xml file you have to clear the cache afterwards!

#> rm -f app/cache/config/*.php
</code></pre>

or /path/to/clearcache.sh

#> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

That's all, you're done!

* * * * *

[Prev](icinga-web-introduction.md) | [Up](ch06.md) | [Next](ch07.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
