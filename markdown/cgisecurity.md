Verbesserte CGI-Sicherheit und Authentifizierung
================================================

Einführung
----------

![](../images/security.png)

Dies ist als eine Einführung für die Implementierung stärkerer
Authentifizierung und Server-Sicherheit bezogen auf das
CGI-Web-Interface gedacht.

Es gibt viele Wege, die Sicherheit Ihres Überwachungs-Servers und des
NAME-ICINGA-Umfeldes zu verbessern. Dies sollte nicht als das Ende aller
Bemühungen angesehen werden. Nehmen Sie es statt dessen als eine
Einführung für einige der Techniken, die Sie nutzen können, um die
Sicherheit Ihres System zu verstärken. Wie immer sollten Sie forschen
und die besten Techniken nutzen, die verfügbar sind. Behandeln Sie Ihren
Überwachungs-Server, als wäre es der wichtigste Server in Ihrem Netzwerk
und Sie werden belohnt werden.

Zusätzliche Techniken
---------------------

-   **Stärkere Authentifizierung durch Digest Authentication**. Wenn Sie
    den [Schnellstartanleitungen](quickstart) gefolgt sind, werden Sie
    wahrscheinlich NAME-APACHEs [Basic
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_basic.html)
    nutzen. "Basic Authentication" wird Benutzer und Password bei jedem
    HTTP-Request im Klartext übertragen. Ziehen Sie eine sicherere
    Authentifierungsmethode wie z.B. [Digest
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_digest.html)
    in Betracht, die aus Ihrem Benutzernamen und Passwort einen MD5-Hash
    erzeugt, der bei jeder Anfrage gesendet wird.

-   **Erzwingen von TLS/SSL für jede Web-Kommunikation**. NAME-APACHE
    bietet
    [TLS/SSL](http://de.wikipedia.org/wiki/Transport_Layer_Security)
    durch das
    [mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html)-Modul.
    TLS/SSL bietet einen sicheren Tunnel zwischen Client und Server, der
    Abhören und Verfälschung durch starke
    publickey/privatekey-Kryptographie verhindert.

-   **Beschränken Sie NAME-APACHE mit Hilfe von Zugangskontrollen**.
    Überlegen Sie, ob Sie den Zugang zur NAME-ICINGA-Box auf Ihre
    IP-Adresse, IP-Adressbereich oder IP-Subnetz beschränken. Wenn Sie
    Zugang von außen auf Ihr Netzwerk benötigen, können Sie VPN und
    SSH-Tunnel nutzen. Es ist einfach, den Zugang zu Ihrem System auf
    HTTP/HTTPS zu begrenzen.

Implementieren der Digest Authentication
----------------------------------------

Die Implementierung der Digest Authentication ist einfach. Dazu müssen
Sie den neuen Typ der Passwort-Datei mit dem
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest.html)-Tool
anlegen, dann die NAME-APACHE-Konfiguration für NAME-ICINGA anpassen
(typischerweise URL-ICINGA-WEB).

Legen Sie eine neue Passwort-Datei mit dem
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest.html)-Tool
an. Den Unterschied, den Sie feststellen werden, wenn Sie mit dem
['htpasswd'](http://httpd.apache.org/docs/2.2/programs/htpasswd.html)-Tool
vertraut sind, ist die Anforderung, ein 'Realm'-Parameter anzugeben. In
diesem Fall bezieht sich 'realm' auf den Wert der 'AuthName'-Direktive
in der NAME-APACHE-Konfiguration.

     htdigest -c URL-ICINGA-BASE/etc/.digest_pw "NAME-ICINGA Access" icingaadmin

Als nächstes editieren Sie die NAME-APACHE-Konfigurationsdatei für
NAME-ICINGA (typischerweise URL-ICINGA-WEB) mit Hilfe des folgenden
Beispiels:

     ## BEGIN APACHE CONFIG SNIPPET - NAME-ICINGA.CONF
     ScriptAlias /icinga/cgi-bin "URL-ICINGA-BASE/sbin"
     <Directory "URL-ICINGA-BASE/sbin">
        Options ExecCGI
        AllowOverride None
        Order allow,deny
        Allow from all
        AuthType Digest
        AuthName "NAME-ICINGA Access"
        AuthDigestFile URL-ICINGA-BASE/etc/.digest_pw
        Require valid-user
     </Directory>
     Alias /icinga "URL-ICINGA-BASE/share"
     <Directory "URL-ICINGA-BASE/share">
        Options None
        AllowOverride None
        Order allow,deny
        Allow from all
        AuthType Digest
        AuthName "NAME-ICINGA Access"
        AuthDigestFile URL-ICINGA-BASE/etc/.digest_pw
        Require valid-user
     </Directory>
     ## END APACHE CONFIG SNIPPETS

Danach starten Sie den NAME-APACHE-Service, damit die neuen
Einstellungen aktiv werden können.

     /etc/init.d/httpd restart

Implementieren erzwungener TLS/SSL-Kommunikation
------------------------------------------------

Stellen Sie sicher, dass Sie NAME-APACHE und OpenSSL installiert haben.
Normalerweise sollten Sie
[mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html)-Unterstützung
haben. Falls Sie trotzdem Schwierigkeiten haben, finden Sie ggf. Hilfe
durch das Lesen von NAME-APACHEs [TLS/SSL Encryption
Documentation](http://httpd.apache.org/docs/2.0/ssl).

Als nächstes prüfen Sie durch den Aufruf des NAME-ICINGA-Web-Interfaces
über HTTPS (https://your.domain/NAME-ICINGA), dass die
TLS/SSL-Unterstützung funktioniert. Wenn es funktioniert, können Sie mit
den nächsten Schritten fortfahren, die die Nutzung von HTTPS erzwingen
und alle HTTP-Anfragen an das NAME-ICINGA-Web-Interface blockiert. Wenn
Sie Schwierigkeiten haben, lesen Sie bitte NAME-APACHEs [TLS/SSL
Encryption Documentation](http://httpd.apache.org/docs/2.0/ssl) und
nutzen Sie [Google](http://www.google.com) für die Suche nach Lösungen
zu Ihrer NAME-APACHE-Installation.

Danach editieren Sie die NAME-APACHE-Konfigurationsdatei für NAME-ICINGA
(typischerweise URL-ICINGA-WEB) und fügen Sie den 'sbin'- und
'share'-Verzeichnissen die 'SSLRequireSSL'-Direktive hinzu.

     ## BEGIN APACHE CONFIG SNIPPET - NAME-ICINGA.CONF
     ScriptAlias /icinga/cgi-bin "URL-ICINGA-BASE/sbin"
     <Directory "URL-ICINGA-BASE/sbin">
        ...
        SSLRequireSSL
        ...
     </Directory>
     Alias /icinga "URL-ICINGA-BASE/share"
     <Directory "URL-ICINGA-BASE/share">
        ...
        SSLRequireSSL
        ...
     </Directory>
     ## END APACHE CONFIG SNIPPETS

Danach starten Sie den NAME-APACHE-Service, damit die neuen
Einstellungen aktiv werden können.

     /etc/init.d/httpd restart

Implementieren von IP-Subnetz-Beschränkung
------------------------------------------

Das folgende Beispiel zeigt, wie Sie den Zugang auf die NAME-ICINGA-CGIs
auf eine bestimmte IP-Adresse, einen IP-Adressbereich oder ein
IP-Subnetz mit Hilfe von NAME-APACHEs [Access
Controls](http://httpd.apache.org/docs/2.2/howto/access.html)
beschränken.

Danach editieren Sie die NAME-APACHE-Konfigurationsdatei für NAME-ICINGA
(typischerweise URL-ICINGA-WEB) und fügen Sie die 'Allow'-, 'Deny'- und
'Order'-Direktiven hinzu. Dazu folgendes Beispiel:

     ## BEGIN APACHE CONFIG SNIPPET - NAME-ICINGA.CONF
     ScriptAlias /icinga/cgi-bin "URL-ICINGA-BASE/sbin"
     <Directory "URL-ICINGA-BASE/sbin">
        ...
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.1 10.0.0.25               # Allow single IP addresses
        Allow from 10.0.0.0/255.255.255.0            # Allow network/netmask pair
        Allow from 10.0.0.0/24                       # Allow network/nnn CIDR spec
        ...
     </Directory>
     Alias /icinga "URL-ICINGA-BASE/share"
     <Directory "URL-ICINGA-BASE/share">
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

Wichtige Anmerkungen
--------------------

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

-   **NAME-APACHE Access Controls schützen nur die
    HTTP/HTTPS-Protokolle** . Sehen Sie sich
    [IPtables](http://www.netfilter.org/projects/iptables/index.html)
    für eine starke systemweite Firewall-Kontrolle an.

-   **Am wichtigsten: Sicherheit ist ein bewegliches Ziel, also bleiben
    Sie informiert und forschen Sie** ! Vielleicht durch das Anhören
    eines Podcasts wie z.B. "[Security
    Now!](http://www.grc.com/securitynow.htm)".

CGI-Sicherheit
Verbesserte CGI-Sicherheit und Authentifizierung
CGI-Sicherheit
Zusätzliche Techniken
CGI-Sicherheit
Implementieren der Digest Authentication
CGI-Sicherheit
Implementieren erzwungener TLS/SSL-Kommunikation
CGI-Sicherheit
Implementieren von IP-Subnetz-Beschränkung
