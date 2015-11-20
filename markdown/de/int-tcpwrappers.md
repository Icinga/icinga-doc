 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

9.3. TCP-Wrapper-Integration
----------------------------

9.3.1. [Einführung](int-tcpwrappers.md#introduction)

9.3.2. [Einen Service
definieren](int-tcpwrappers.md#servicedefinitiontcpwrapper)

9.3.3. [TCP-Wrapper
konfigurieren](int-tcpwrappers.md#configtcpwrappers)

9.3.4. [Das Script schreiben](int-tcpwrappers.md#tcpwrapperscript)

9.3.5. [Aufräumen](int-tcpwrappers.md#finish)

### 9.3.1. Einführung

![](../images/tcpwrappers.png)

Dieses Dokument erklärt, wie einfach in Icinga Alarme für
Verbindungsversuche generiert werden können, die von TCP-Wrappern
zurückgewiesen werden. Wenn zum Beispiel ein unautorisierter Host
versucht, sich mit Ihrem SSH-Server zu verbinden, können Sie in Icinga
einen Alarm empfangen, der den Namen des Hosts enthält, der
zurückgewiesen wurde. Wenn Sie das auf Ihren Linux/Unix-Boxen
installieren, dann werden Sie erstaunt sein, wie viele Port-Scans Sie in
Ihrem Netzwerk entdecken.

Diese Anweisungen gehen davon aus, dass





### 9.3.2. Einen Service definieren

Wenn Sie es nicht bereits getan haben, erstellen Sie eine
[Host-Definition](objectdefinitions.md#objectdefinitions-host) für den
entfernten Host (*firestorm*).

Als nächstes definieren Sie einen Service in einer Ihrer
[Objektkonfigurationsdateien](configobject.md "3.3. Überblick Objektkonfiguration")
für die TCP-Wrapper-Alarme auf dem Host *firestorm*. Die
Service-Definition könnte wie folgt aussehen:

<pre><code>
 define service{
</code></pre>

Es gibt einige wichtige Dinge zu der obigen Service-Definition
anzumerken:




### 9.3.3. TCP-Wrapper konfigurieren

Nun müssen Sie die */etc/hosts.deny*-Datei auf *firestorm* editieren.
Damit die TCP-Wrapper einen Alarm an den Überwachungs-Host senden,
sobald ein Verbindungsversuch verweigert wird, müssen Sie eine Zeile
hinzufügen, die der folgenden ähnlich ist.

 ALL: ALL: RFC931: twist (/usr/local/icinga/libexec/eventhandlers/handle_tcp_wrapper %h %d) &
</code></pre>

Diese Zeile nimmt an, dass es ein Script namens *handle\_tcp\_wrapper*
im */usr/local/icinga/libexec/eventhandlers/*-Verzeichnis auf
*firestorm* gibt. Wir werden dieses Script als nächstes schreiben.

### 9.3.4. Das Script schreiben

Als letztes müssen Sie das *handle\_tcp\_wrapper*-Script auf *firestorm*
schreiben, das den Alarm zurück an den Icinga-Server schickt. Es könnte
ungefähr so aussehen:

<pre><code>
/usr/local/icinga/libexec/eventhandlers/submit_check_result firestorm "TCP Wrappers" 2 "Denied $2-$1" > /dev/null 2> /dev/null
</code></pre>

Beachten Sie, dass das *handle\_tcp\_wrapper*-Script das
*submit\_check\_result*-Script aufruft, um den Alarm zurück an den
Überwachungs-Host zu schicken. Angenommen, Ihr Icinga-Server heißt
*monitor*, dann könnte das *submit check\_result*-Script wie folgt
aussehen:

<pre><code>
 #!/bin/sh
 # Arguments
 /bin/echo -e "$1\t$2\t$3\t$4\n" | /usr/local/icinga/bin/send_nsca monitor -c /usr/local/icinga/etc/send_nsca.cfg
</code></pre>

### 9.3.5. Aufräumen

Sie haben nun alles konfiguriert, was Sie brauchen, so dass Sie nur noch
den *inetd*-Prozess auf *firestorm* und Icinga auf Ihrem
Überwachungs-Server neu starten müssen. Das war's! Wenn die TCP-Wrapper
auf *firestorm* einen Verbindungsversuch verweigern, dann sollten Sie
Alarme in Icinga erhalten. Die Plugin-Ausgabe für den Alarm könnte wie
folgt aussehen:

 Denied sshd2-sdn-ar-002mnminnP321.dialsprint.net
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
