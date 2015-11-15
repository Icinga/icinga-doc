![Icinga](../images/logofullsize.png "Icinga")

8.2. Verbesserte Classic UI Modul-Sicherheit und Authentifizierung

[Zurück](security.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](tuning.md)

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

-   **Stärkere Authentifizierung durch Digest Authentication**. Wenn Sie
    den [Schnellstartanleitungen](quickstart) gefolgt sind, werden Sie
    wahrscheinlich Apaches [Basic
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_basic.md)
    nutzen. "Basic Authentication" wird Benutzer und Password bei jedem
    HTTP-Request im Klartext übertragen. Ziehen Sie eine sicherere
    Authentifierungsmethode wie z.B. [Digest
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_digest.md)
    in Betracht, die aus Ihrem Benutzernamen und Passwort einen MD5-Hash
    erzeugt, der bei jeder Anfrage gesendet wird.

-   **Erzwingen von TLS/SSL für jede Web-Kommunikation**. Apache bietet
    [TLS/SSL](http://de.wikipedia.org/wiki/Transport_Layer_Security)
    durch das
    [mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl.md)-Modul.
    TLS/SSL bietet einen sicheren Tunnel zwischen Client und Server, der
    Abhören und Verfälschung durch starke
    publickey/privatekey-Kryptographie verhindert.

-   **Beschränken Sie Apache mit Hilfe von Zugangskontrollen**.
    Überlegen Sie, ob Sie den Zugang zur Icinga-Box auf Ihre IP-Adresse,
    IP-Adressbereich oder IP-Subnetz beschränken. Wenn Sie Zugang von
    außen auf Ihr Netzwerk benötigen, können Sie VPN und SSH-Tunnel
    nutzen. Es ist einfach, den Zugang zu Ihrem System auf HTTP/HTTPS zu
    begrenzen.

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

~~~~ {.screen}
 htdigest -c /usr/local/icinga/etc/.digest_pw "Icinga Access" icingaadmin
~~~~

Als nächstes editieren Sie die Apache-Konfigurationsdatei für Icinga
(typischerweise /etc/httpd/conf.d/icinga.conf) mit Hilfe des folgenden
Beispiels:

~~~~ {.screen}
 ## BEGIN APACHE CONFIG SNIPPET - Icinga.CONF
 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
    Options ExecCGI
    AllowOverride None
    Order allow,deny
    Allow from all
    AuthType Digest
    AuthName "Icinga Access"
    AuthDigestFile /usr/local/icinga/etc/.digest_pw
    Require valid-user
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
    Options None
    AllowOverride None
    Order allow,deny
    Allow from all
    AuthType Digest
    AuthName "Icinga Access"
    AuthDigestFile /usr/local/icinga/etc/.digest_pw
    Require valid-user
 </Directory>
 ## END APACHE CONFIG SNIPPETS
~~~~

Danach starten Sie den Apache-Service, damit die neuen Einstellungen
aktiv werden können.

~~~~ {.screen}
 /etc/init.d/httpd restart
~~~~

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

~~~~ {.screen}
 ## BEGIN APACHE CONFIG SNIPPET - Icinga.CONF
 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
    ...
    SSLRequireSSL
    ...
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
    ...
    SSLRequireSSL
    ...
 </Directory>
 ## END APACHE CONFIG SNIPPETS
~~~~

Danach starten Sie den Apache-Service, damit die neuen Einstellungen
aktiv werden können.

~~~~ {.screen}
 /etc/init.d/httpd restart
~~~~

### 8.2.5. Implementieren von IP-Subnetz-Beschränkung

Das folgende Beispiel zeigt, wie Sie den Zugang auf die Icinga-Module
auf eine bestimmte IP-Adresse, einen IP-Adressbereich oder ein
IP-Subnetz mit Hilfe von Apaches [Access
Controls](http://httpd.apache.org/docs/2.2/howto/access.md)
beschränken.

Danach editieren Sie die Apache-Konfigurationsdatei für Icinga
(typischerweise /etc/httpd/conf.d/icinga.conf) und fügen Sie die
'Allow'-, 'Deny'- und 'Order'-Direktiven hinzu. Dazu folgendes Beispiel:

~~~~ {.screen}
 ## BEGIN APACHE CONFIG SNIPPET - Icinga.CONF
 ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
 <Directory "/usr/local/icinga/sbin">
    ...
    AllowOverride None
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1 10.0.0.25               # Allow single IP addresses
    Allow from 10.0.0.0/255.255.255.0            # Allow network/netmask pair
    Allow from 10.0.0.0/24                       # Allow network/nnn CIDR spec
    ...
 </Directory>
 Alias /icinga "/usr/local/icinga/share"
 <Directory "/usr/local/icinga/share">
    ...
    AllowOverride None
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1 10.0.0.25               # Allow single IP addresses
    Allow from 10.0.0.0/255.255.255.0            # Allow network/netmask pair
    Allow from 10.0.0.0/24                       # Allow network/nnn CIDR spec
    ...
 </Directory>
 ## END APACHE CONFIG SNIPPET
~~~~

### 8.2.6. Wichtige Anmerkungen

-   **Digest Authentication sendet Daten im Klartext, aber nicht Ihren
    Benutzernamen und Passwort** .

-   **Digest Authentication ist nicht ganz so gut unterstützt wie Basic
    Authentication** .

-   **TLS/SSL hat das Potential für einen "Man-in-the-middle-Angriff"**.
    MITM-Angriffe machen verletzbar, wenn ein Angreifer in der Lage ist,
    sich zwischen Server und Client zu schieben wie bei einem
    Phishing-Angriff, ISP-Monitoring oder Resignierung von
    Unternehmens-LAN Firewall-Zertifikaten. Bitte machen Sie sich kundig
    zu Zertifikats-Verifikation!

-   **Apache Access Controls schützen nur die HTTP/HTTPS-Protokolle** .
    Sehen Sie sich
    [IPtables](http://www.netfilter.org/projects/iptables/index.md)
    für eine starke systemweite Firewall-Kontrolle an.

-   **Am wichtigsten: Sicherheit ist ein bewegliches Ziel, also bleiben
    Sie informiert und forschen Sie** ! Vielleicht durch das Anhören
    eines Podcasts wie z.B. "[Security
    Now!](http://www.grc.com/securitynow.htm)".

* * * * *

  ------------------------------- -------------------------- -----------------------------------------------
  [Zurück](security.md)         [Nach oben](ch08.md)      [Weiter](tuning.md)
  8.1. Sicherheitsüberlegungen    [Zum Anfang](index.md)    8.3. Icinga für maximale Leistung optimieren
  ------------------------------- -------------------------- -----------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
