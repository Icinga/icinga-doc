[Prev](nrpe.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch11.md)

* * * * *

10.3. NSCA
----------

10.3.1. [Introduction](nsca.md#introduction)

10.3.2. [Prerequisites](nsca.md#prerequisites)

10.3.3. [Download and compile](nsca.md#downloadcompile)

10.3.4. [Customise](nsca.md#customise)

10.3.5. [First test](nsca.md#firsttest)

10.3.6. [Install](nsca.md#installnsca)

10.3.7. [Remote system(s)](nsca.md#remotesystem)

10.3.8. [Copy files](nsca.md#copyfiles)

10.3.9. [Second test](nsca.md#secondtest)

10.3.10. [Troubleshooting](nsca.md#troubleshooting)

10.3.11. [Security](nsca.md#security)

10.3.12. [Operation](nsca.md#operation)

10.3.13. [Integration into Icinga](nsca.md#icingaintegration)

### 10.3.1. Introduction

Nagios Service Check Acceptor (or NSCA for short) is an addon to
transmit check results from one system to another. It consists of two
modules: the sender (send\_nsca) and the receiver (nsca). The data is
sent in a secure manner. Despite its name host check results are
transmitted as well.

![[Note]](../images/note.png)

Note

Please consider using [NSCA-ng](http://www.nsca-ng.org/) instead which
is a replacement for NSCA.

**Figure 10.3. NSCA**

![NSCA](../images/nsca.png)

\

NSCA is running as a daemon on the Icinga server. It listens for
information sent from remote machines using the send\_nsca program (on
Unix/Linux machines) or NSClient++ (often used on Windows machines). The
data will be encrypted using the method specified in send\_nsca.cfg (or
nsc.ini in the case of NSClient++). The daemon will validate the data in
a \*very\* basic manner by decrypting the information using the password
which is stored in the local nsca.cfg file. If the data looks like it
was encrypted using the same password then the daemon will try to output
the data as external commands into the local Icinga command pipe.

The following instructions are mainly based on the README included in
the NSCA package.

### 10.3.2. Prerequisites







### 10.3.3. Download and compile

![[Note]](../images/note.png)

Note

Instead of installing NSCA from scratch you may want to use a package
which might be available for your OS.

If you are planning to install from source then please use the official
release tarball using something like

<pre><code>
 #> wget http://sourceforge.net/projects/nagios/files/nsca-2.x/nsca-2.9.1/nsca-2.9.1.tar.gz -O nsca-2.9.1.tar.gz
</code></pre>

![[Important]](../images/important.png)

Important

Please don't use snapshots unless you have an issue which might be
solved in the current developer version.

The maximum length of data to be transmitted is set to 2,048 bytes, the
maximal length of plugin output is set to 512 bytes. If that is not
sufficient then you have to alter the appropriate value in
`icinga-nsca/include/common.h`.

<pre><code>
</code></pre>

Please keep in mind that you have to recompile the programs if you
change this values at a later stage.

Due to the setting of the following define in include/common.h (in
Icinga core) the max. value cannot exceed 8,192 bytes.

<pre><code>
</code></pre>

After setting the owner change to the newly created directory and call
configure and make

<pre><code>
 #> chown -R icinga icinga-nsca
 #> cd icinga-nsca
 #> make all
</code></pre>

Afterwards two programs (send and send\_nsca) are created in the
`src` directory.

![[Caution]](../images/caution.png)

Caution

If the libmcrypt packages are not found "./configure" will complain but
will NOT end with a non-zero return code so please check *config.log*
using

<pre><code>
 #> grep mcrypt.h: config.log
</code></pre>

This command should return no lines.

If the libmcrypt modules are not found, the user or group deviate from
"icinga" or the port to be used is not the default 5667 you can use
several options to specify different values. Call
"`./configure -h`" to see the options available.

After changing to "nsca\_tests" you can try to execute "./runtests".
Please note that these tests require several Perl modules described in
the README file.

### 10.3.4. Customise

The sample-config directory contains `nsca.cfg` and
`send_nsca.cfg`. At least the settings of the directives
"password" and "encryption\_method" / "decryption\_method" should be
reviewed/altered before copying the files. Remember to set the same
password in all copies of these config files. If you want to have
different passwords on different remote servers you have to run multiple
nsca daemons on the Icinga server listening on different ports. This
doesn't work if you start the daemon using inetd/xinetd.

### 10.3.5. First test

Switch to the Icinga user and run a first test

<pre><code>
 $> cd /usr/src/icinga-nsca/src
 $> ./nsca -c ../sample-config/nsca.cfg
 $> echo -e "A\tB\tC\tD\n" | ./send_nsca -H localhost -c ../sample-config/send_nsca.cfg
 $> exit
</code></pre>

This should return the message "1 data packet(s) sent to host
successfully.". In the first place it only means that send\_nsca and
nsca are able to communicate with each other on the local host using the
sample config files as it works perfectly without a running Icinga
instance. But it is important nevertheless: If this test fails then
there is no sense in continuing. Instead verify the settings in nsca.cfg
and send\_nsca.cfg. Check for messages in your syslog (e.g.
`/var/log/messages`) as well.

If the prerequisites are fulfilled then you should see some warnings in
`icinga.log` complaining that host "A" and service "B" are not
found in the Icinga configuration. This means that nsca has sufficient
permissions to write to the Icinga command file. Check if the nsca
daemon and Icinga are running with different users if there are no
messages in icinga.log. If there are no messages check the setting of
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

### 10.3.6. Install

"make install" will do nothing (yet) so you have to copy some files to
new locations. The following commands will copy the nsca module to the
directory where the Icinga binary is located and the config file to the
Icinga config folder. We assume that you installed Icinga using one of
the quickstart guides.

<pre><code>
 #> cp -p nsca /usr/local/icinga/bin/
 #> cp ../sample-config/nsca.cfg /usr/local/icinga/etc/
</code></pre>





















### 10.3.7. Remote system(s)

You're done on the local system but apparently send\_nsca has to be
copied to the remote system(s).

Please note that you have to compile send\_nsca for the platform it
should run upon so you might have to install the libmcrypt packages and
configure/make as described above on multiple servers.

### 10.3.8. Copy files

You're free where to place binary and config file. We assume that you
have a directory structure similar to the Icinga server

<pre><code>
 #> scp -p <Icinga server>:/usr/local/icinga-nsca/src/send_nsca /usr/local/icinga/bin/
 #> scp -p <Icinga server>:/usr/local/icinga-nsca/sample-config/send_nsca.cfg /usr/local/icinga/etc/
</code></pre>

### 10.3.9. Second test

Now you can rerun the test on the remote system(s)

<pre><code>
 $> echo -e "A\tB\tC\tD\n" | /usr/local/icinga/bin/send_nsca -H <Icinga server> -c /usr/local/icinga/etc/send_nsca.cfg
</code></pre>

This as well should return the message "1 data packet(s) sent to host
successfully." and there should be warnings in icinga.log on the Icinga
server similar to the ones mentioned above. If there are no messages
check the setting of
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

### 10.3.10. Troubleshooting

If the daemon is not permitted to write to the command pipe then the
data will be lost! You should run the daemon using the same user you
specified for Icinga.

If the object (host and/or service) is not included in the running
configuration then the data will be rejected.

Host name (and service description, if applicable) are case sensitive
and have to match the definition in Icinga.

Check if you specified the same password in nsca.cfg and send\_nsca.cfg.
Otherwise the transmission will fail.

Check if you used the same encryption/decryption method. Otherwise the
transmission will fail.

Check if your firewall setting allow the communication on the port
specified (default is 5667)

If you are using xinetd check if the IP address(es) specified after
"only\_from=" match to the remote system(s) or remove this line (and
restart xinetd)

Activate "debug=1" in `nsca.cfg`, restart the daemon (if
applicable) and look for messages in the syslog / `nsca.log`.

### 10.3.11. Security

There are some security implications with allowing remote clients to
provide check results to Icinga. Because of this, you have the option of
encrypting the packets that the NSCA client sends to the NSCA daemon.
Read the SECURITY file for more information on the security risks of
running NSCA, along with an explanation of what kind of protection the
encryption provides you.

### 10.3.12. Operation

send\_nsca is used to send the check results from the remote host to the
Icinga server. The syntax differs depending on the object type. To
submit service check information use

\<host\_name\>[tab]\<svc\_description\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

where:

\<host\_name\>=short name of the host that the service is associated
with (as defined in the host\_name directive of the service definition)

\<svc\_description\>=description of the service (as defined in the
service\_description directive of the service definition)

\<return\_code\>=numeric return code (0,1,2,3 as explained
[here](pluginapi.md "11.1. Icinga Plugin API"))

\<plugin\_output\>=output from host/service check

out the service description:

\<host\_name\>[tab]\<return\_code\>[tab]\<plugin\_output\>[newline]

### 10.3.13. Integration into Icinga

So far you only created some prerequisites for running passive checks
but didn't define any host or service actually using the functionality.

Although you only receive check results you still need to specify the
"check\_command" directive in your definitions. There is a plugin called
"check\_dummy" which can be used for this purpose. You may have to add a
command definition if it's not already included. The second argument is
optional and might contain an explanatory text.

<pre><code>
 define command{
</code></pre>

You may want to create a service template. The host template might look
similiar to that (just replace "service" by "host")

<pre><code>
 define service{
</code></pre>

Using the template above the service definition might look like

<pre><code>
 define service{
</code></pre>

Restart Icinga to include the definitions in your running configuration

<pre><code>
 #> /etc/init.d/icinga restart
</code></pre>

Change to your remote host, switch to the Icinga user and execute
send\_nsca replacing \<Icinga server\> by the IP address of the server
running Icinga

<pre><code>
 $> echo -e "remotehost\tDiskspace\t0\t/var=78%\n" | /usr/local/icinga/bin/send_nsca -H <Icinga server> -c /usr/local/icinga/etc/send_nsca.cfg
</code></pre>

Please keep in mind to specify the host name and service description
exactly as defined in your Icinga definition (because the processing is
case sensitive). Otherwise you'll get messages in icinga.log that the
object could not be found. If there are no messages check the setting of
[log\_passive\_checks](configmain.md#configmain-log_passive_checks) in
`icinga.cfg`.

After a short while you should see messages in icinga.log showing that
the information submitted was processed. You should see the information
in the classic UI as well turning the service state from "Pending" to
"OK" and containing the data you specified.

![[Note]](../images/note.png)

Note

If you have a distributed setup using several Icinga you should take
look at "[Distributed
monitoring](distributed.md "7.6. Distributed Monitoring")" as well.

* * * * *

[Prev](nrpe.md) | [Up](ch10.md) | [Next](ch11.md)

10.2. NRPE  |<=== [Index](index.md) ===>|  Chapter 11. Development

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
