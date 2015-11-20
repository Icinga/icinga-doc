 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung
------------------------------------------------------------------

8.2.1. [Einführung](cgisecurity.md#introduction)

8.2.2. [Zusätzliche Techniken](cgisecurity.md#additionaltechniques)

8.2.3. [Implementieren der Digest
Authentication](cgisecurity.md#implementationdigest)

8.2.4. [Implementieren erzwungener
TLS/SSL-Kommunikation](cgisecurity.md#implementationssl)

8.2.5. [Implementieren von
IP-Subnetz-Beschränkung](cgisecurity.md#implementationlockdown)

8.2.6. [Wichtige Anmerkungen](cgisecurity.md#importantnotes)

### 8.2.1. Einführung

![](../images/security.png)

Dies ist als eine Einführung für die Implementierung stärkerer
Authentifizierung und Server-Sicherheit bezogen auf das Classic
UI-Web-Interface gedacht.

Es gibt viele Wege, die Sicherheit Ihres Überwachungs-Servers und des
Icinga-Umfeldes zu verbessern. Dies sollte nicht als das Ende aller
Bemühungen angesehen werden. Nehmen Sie es statt dessen als eine
Einführung für einige der Techniken, die Sie nutzen können, um die
Sicherheit Ihres System zu verstärken. Wie immer sollten Sie forschen
und die besten Techniken nutzen, die verfügbar sind. Behandeln Sie Ihren
Überwachungs-Server, als wäre es der wichtigste Server in Ihrem Netzwerk
und Sie werden belohnt werden.

### 8.2.2. Zusätzliche Techniken




### 8.2.3. Implementieren der Digest Authentication

Die Implementierung der Digest Authentication ist einfach. Dazu müssen
Sie den neuen Typ der Passwort-Datei mit dem
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest.md)-Tool
anlegen, dann die Apache-Konfiguration für Icinga anpassen
(typischerweise /etc/httpd/conf.d/icinga.conf).

Legen Sie eine neue Passwort-Datei mit dem
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest.md)-Tool
an. Den Unterschied, den Sie feststellen werden, wenn Sie mit dem
['htpasswd'](http://httpd.apache.org/docs/2.2/programs/htpasswd.md)-Tool
vertraut sind, ist die Anforderung, ein 'Realm'-Parameter anzugeben. In
diesem Fall bezieht sich 'realm' auf den Wert der 'AuthName'-Direktive
in der Apache-Konfiguration.

 htdigest -c /usr/local/icinga/etc/.digest_pw "Icinga Access" icingaadmin
</code></pre>

Als nächstes editieren Sie die Apache-Konfigurationsdatei für Icinga
(typischerweise /etc/httpd/conf.d/icinga.conf) mit Hilfe des folgenden
Beispiels:

 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
 </Directory>
 ## END APACHE CONFIG SNIPPETS
</code></pre>

Danach starten Sie den Apache-Service, damit die neuen Einstellungen
aktiv werden können.

 /etc/init.d/httpd restart
</code></pre>

### 8.2.4. Implementieren erzwungener TLS/SSL-Kommunikation

Stellen Sie sicher, dass Sie Apache und OpenSSL installiert haben.
Normalerweise sollten Sie
[mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl.md)-Unterstützung
haben. Falls Sie trotzdem Schwierigkeiten haben, finden Sie ggf. Hilfe
durch das Lesen von Apaches [TLS/SSL Encryption
Documentation](http://httpd.apache.org/docs/2.0/ssl).

Als nächstes prüfen Sie durch den Aufruf des Icinga-Web-Interfaces über
HTTPS (https://your.domain/Icinga), dass die TLS/SSL-Unterstützung
funktioniert. Wenn es funktioniert, können Sie mit den nächsten
Schritten fortfahren, die die Nutzung von HTTPS erzwingen und alle
HTTP-Anfragen an das Icinga-Web-Interface blockiert. Wenn Sie
Schwierigkeiten haben, lesen Sie bitte Apaches [TLS/SSL Encryption
Documentation](http://httpd.apache.org/docs/2.0/ssl) und nutzen Sie
[Google](http://www.google.com) für die Suche nach Lösungen zu Ihrer
Apache-Installation.

Danach editieren Sie die Apache-Konfigurationsdatei für Icinga
(typischerweise /etc/httpd/conf.d/icinga.conf) und fügen Sie den 'sbin'-
und 'share'-Verzeichnissen die 'SSLRequireSSL'-Direktive hinzu.

 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
 </Directory>
 ## END APACHE CONFIG SNIPPETS
</code></pre>

Danach starten Sie den Apache-Service, damit die neuen Einstellungen
aktiv werden können.

 /etc/init.d/httpd restart
</code></pre>

### 8.2.5. Implementieren von IP-Subnetz-Beschränkung

Das folgende Beispiel zeigt, wie Sie den Zugang auf die Icinga-Module
auf eine bestimmte IP-Adresse, einen IP-Adressbereich oder ein
IP-Subnetz mit Hilfe von Apaches [Access
Controls](http://httpd.apache.org/docs/2.2/howto/access.md)
beschränken.

Danach editieren Sie die Apache-Konfigurationsdatei für Icinga
(typischerweise /etc/httpd/conf.d/icinga.conf) und fügen Sie die
'Allow'-, 'Deny'- und 'Order'-Direktiven hinzu. Dazu folgendes Beispiel:

 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
 </Directory>
 ## END APACHE CONFIG SNIPPET
</code></pre>

### 8.2.6. Wichtige Anmerkungen






* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
