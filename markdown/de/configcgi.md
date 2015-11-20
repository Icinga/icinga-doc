 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

3.6. Optionen CGI-Konfigurationsdatei
-------------------------------------

**Anmerkungen**

Wenn Sie Konfigurationsdateien erstellen oder anpassen, beachten Sie
bitte folgendes:




**Beispielkonfiguration**

![](../images/tip.gif) Hinweis: eine Beispiel-CGI-Konfigurationsdatei
(*/usr/local/icinga/etc/cgi.cfg*) wird für Sie installiert, wenn Sie der
[Schnellstart-Anleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
folgen.

**Position der Konfigurationsdatei**

Als Standard erwartet Icinga, dass die CGI-Konfigurationsdatei
**cgi.cfg** heißt und zusammen mit der
[Hauptkonfigurationsdatei](configmain.md "3.2. Optionen der Hauptkonfigurationsdatei")
im Verzeichnis für die Konfigurationsdateien liegt. Wenn Sie den Namen
der Datei oder die Position ändern müssen, dann können Sie Apache so
konfigurieren, dass eine Umgebungsvariable namens ICINGA\_CGI\_CONFIG
übergeben wird (die auf die korrekte Position der CGIs verweist). Lesen
Sie in der Apache-Dokumentation nach, wie das zu tun ist.

**Variablen der Konfigurationsdatei**

Nachfolgend finden Sie Beschreibungen jeder Option der
Hauptkonfigurationsdatei...

**Position der Hauptkonfigurationsdatei**

Format:

**main\_config\_file=\<file\_name\>**

Beispiel:

**main\_config\_file=/usr/local/icinga/etc/icinga.cfg**

Dies gibt die Position Ihrer
[Hauptkonfigurationsdatei](configmain.md "3.2. Optionen der Hauptkonfigurationsdatei")
an. Die CGIs müssen wissen, wo sie zu finden ist, um Informationen zu
Konfigurationsinformationen, aktuellen Host- und Service-Zuständen usw.
zu bekommen.

**vollständiger (physical) HTML-Pfad**

Format:

**physical\_html\_path=\<Pfad\>**

Beispiel:

**physical\_html\_path=/usr/local/icinga/share**

Dies ist der *vollständige* Pfad zu den HTML-Dateien von Icinga auf
Ihrer Workstation oder Ihrem Server. Icinga nimmt an, dass die
Dokumentation und die Bilddateien (die von den CGIs benutzt werden) in
Unterverzeichnissen namens *docs/* und *images/* gespeichert sind.

**URL-HTML-Pfad**

Format:

**url\_html\_path=\<Pfad\>**

Beispiel:

**url\_html\_path=/icinga**

Wenn Sie Icinga über einen Web-Browser mit einem URL wie
**http://www.myhost.com/icinga**, aufrufen, sollte dieser Wert */icinga*
sein. Grundsätzlich ist es der Pfadanteil des URL, der zum Aufruf der
Icinga-HTML-Seiten benutzt wird.

**URL CGI Path**

Format:

**url\_cgi\_path=\<path\>**

Example:

**url\_cgi\_path=/icinga/cgi-bin**

Diese Option erlaubt Ihnen die Angabe einer alternativen CGI URL. Dieser
Pfad wird vom cmd.cgi CSRF-Schutz ausgewertet. Diese Option ist
nützlich, wenn auf die CGI Dateien unter einem anderen Pfad zugegriffen
wird als diese installiert worden sind. Wird sie nicht gesetzt, wird der
Standard-Speicherort verwendet (url\_cgi\_path=url\_html\_path/cgi-bin).

**URL Stylesheet Path**

Format:

**url\_stylesheet\_path=\<path\>/stylesheets**

Beispiel:

**url\_stylesheet\_path=/icinga/stylesheets**

Diese Option erlaubt Ihnen die Angabe einer alternativen Stylesheet URL.
Dies ist nützlich, wenn Sie benutzerdefinierte Stylesheets aus einem
anderen Verzeichnis hinzufügen möchten. Wird sie nicht gesetzt, wird der
Standard-Speicherort verwendet
(url\_stylesheets\_path=url\_html\_path/stylesheets).

**Nutzung der Authentifizierung**

Format:

**use\_authentication=[0/1]**

Beispiel:

**use\_authentication=1**

Diese Option kontrolliert, ob die CGIs die Authentifizierungs- und
Autorisierungsfunktionalität nutzen, um den Zugang von Benutzern zu
Informationen und Befehlen zu prüfen oder nicht. Wir möchten dringend
raten, dass Sie die Authentifizierungsfunktionalität für die CGIs
nutzen. Wenn Sie sich entscheiden, die Authentifizierung nicht zu
nutzen, dann stellen Sie sicher, dass das [command
CGI](cgis.md#cgis-cmd_cgi) entfernt wird, um nicht autorisierte
Benutzer an der Ausführung von Icinga-Befehlen zu hindern. Das CGI wird
keine Befehle ausführen, wenn Authentifizierung deaktiviert ist, aber
wir würden trotzdem dazu raten, das CGI zu entfernen, damit man auf der
sicheren Seite ist. Mehr Informationen zur Einstellung der
Authentifizierung und der Konfiguration von Autorisierung für die CGIs
finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").



**Nutzung von Client-Zertifikaten**

Format:

**use\_ssl\_authentication=[0/1]**

Beispiel:

**use\_ssl\_authentication=0**

Diese Option kontrolliert, ob der Inhalt der
Web-Server-Umgebungsvariable `REMOTE_USER` oder
`SSL_CLIENT_S_DN_CN` benutzt wird. Der Name der Direktive ist
ein wenig irreführend, denn solange Sie keine Client-Zertifikate
einsetzen, muss der Wert auf Null (0) gesetzt werden. Das Setzen des
Wertes auf Eins (1) erfordert
"`SSLUserName SSL_CLIENT_S_DN_CN`" und verschiedene andere
Optionen in Ihrer Web-Server-Konfiguration. Bitte lesen Sie die
Web-Server-Dokumentation für weitere Einzelheiten..



**Standard-Benutzername**

Format:

**default\_user\_name=\<username\>**

Beispiel:

**default\_user\_name=guest**

Das Setzen dieser Variable definiert einen Standard-Benutzernamen, der
die CGIs aufrufen kann. Dies erlaubt es Leuten in einer sicheren Domäne
(d.h. hinter einer Firewall) die CGIs aufzurufen, ohne dass sie sich am
Web-Server authentifizieren müssen. Sie können das benutzen, um die
Basis-Authentifizierung zu verhindern, wenn Sie keinen sicheren Server
einsetzen, weil Basis-Authentifizierung Passwörter im Klartext über das
Internet überträgt.

**Wichtig:** Definieren Sie *keinen* Standard-Benutzernamen, solange Sie
nicht einen sicheren Web-Server haben und sicher sind, dass sich jeder,
der die CGIs aufruft, in irgendeiner Weise authentifiziert hat. Wenn Sie
diese Variable definieren, dann wird jeder, der sich am Web-Server
authentifiziert, alle Rechte dieses Benutzers erben!

**Zugang zu System/Prozessinformationen**

Format:

**authorized\_for\_system\_information=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_system\_information=icingaadmin,theboss**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die System/Prozessinformationen im [extended information
CGI](cgis.md#cgis-extinfo_cgi) ansehen können. Benutzer in dieser
Liste sind *nicht* automatisch autorisiert, System/Prozessbefehle zu
erteilen. Wenn Sie möchten, dass Benutzer auch System/Prozessbefehle
erteilen können, dann müssen Sie diese der
[authorized\_for\_system\_commands](configcgi.md#configcgi-authorized_for_system_commands)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_system_information` angeben, um
statt eines contact eine contactgroup zu autorisieren.

**Zugang zu System/Prozessbefehlen**

Format:

**authorized\_for\_system\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_system\_commands=icingaadmin**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die System/Prozessbefehle über das [command
CGI](cgis.md#cgis-extinfo_cgi) erteilen können. Benutzer in dieser
Liste sind *nicht* automatisch autorisiert, System/Prozessinformationen
anzusehen. Wenn Sie möchten, dass Benutzer auch
System/Prozessinformationen ansehen können, dann müssen Sie diese der
[authorized\_for\_system\_information](configcgi.md#configcgi-authorized_for_system_information)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_system_commands` angeben, um
statt eines contact eine contactgroup zu autorisieren.

**Zugang zu Konfigurationsinformationen**

Format:

**authorized\_for\_configuration\_information=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_configuration\_information=icingaadmin**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Konfigurationsinformationen im [configuration
CGI](cgis.md#cgis-config_cgi) ansehen können. Benutzer in dieser Liste
können Informationen zu allen konfigurierten Hosts, Hostgruppen,
Kontakten, Kontaktgruppen, Zeitfenstern und Befehlen ansehen. Mehr
Informationen, wie man Authentifizierung einrichtet und Autorisierung
für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_configartion_information`
angeben, um statt eines contact eine contactgroup zu autorisieren.

**Global Host Information Access**

Format:

**authorized\_for\_all\_hosts=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_all\_hosts=icingaadmin,theboss**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Status- und Konfigurationsinformationen im für alle
Hosts ansehen können. Benutzer in dieser Liste sind automatisch
autorisiert, Informationen zu allen Services anzusehen. Benutzer in
dieser Liste sind *nicht* automatisch berechtigt, Befehle für alle Hosts
oder Services zu erteilen. Wenn Sie möchten, dass Benutzer auch Befehle
für alle Hosts oder Services erteilen können, dann müssen Sie diese der
[authorized\_for\_all\_host\_commands](configcgi.md#configcgi-authorized_for_all_host_commands)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_all_hosts` angeben, um statt
eines contact eine contactgroup zu autorisieren.

**Zugang zu globalen Host-Befehlen**

Format:

**authorized\_for\_all\_host\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_all\_host\_commands=icingaadmin**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Befehle für alle Hosts über das [command
CGI](cgis.md#cgis-cmd_cgi) erteilen können. Benutzer in dieser Liste
sind auch automatisch autorisiert, Befehle für alle Services zu
erteilen. Benutzer in dieser Liste sind *nicht* automatisch berechtigt,
Status- oder Konfigurationsinformationen für alle Hosts oder Services
anzusehen. Wenn Sie möchten, dass Benutzer auch Status- und
Konfigurationsinformationen für alle Hosts oder Services ansehen können,
dann müssen Sie diese der
[authorized\_for\_all\_hosts](configcgi.md#configcgi-authorized_for_all_hosts)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_all_host_commands` angeben, um
statt eines contact eine contactgroup zu autorisieren.

**Zugang zu globalen Service-Informationen**

Format:

**authorized\_for\_all\_services=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_all\_services=icingaadmin,theboss**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Status- und Konfigurationsinformationen für alle
Services ansehen können. Benutzer in dieser Liste sind *nicht*
automatisch autorisiert, Informationen zu allen Hosts anzusehen.
Benutzer in dieser Liste sind *nicht* automatisch berechtigt, Befehle
für alle Services zu erteilen. Wenn Sie möchten, dass Benutzer auch
Befehle für alle Services erteilen können, dann müssen Sie diese der
[authorized\_for\_all\_service\_commands](configcgi.md#configcgi-authorized_for_all_service_commands)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_all_services` angeben, um statt
eines contact eine contactgroup zu autorisieren.

**Zugang zu globalen Service-Befehlen**

Format:

**authorized\_for\_all\_service\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_all\_service\_commands=icingaadmin**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Befehle für alle Services über das [command
CGI](cgis.md#cgis-cmd_cgi) erteilen können. Benutzer in dieser Liste
sind *nicht* automatisch autorisiert, Befehle für alle Hosts zu
erteilen. Benutzer in dieser Liste sind *nicht* automatisch berechtigt,
Status- oder Konfigurationsinformationen für alle Hosts anzusehen. Wenn
Sie möchten, dass Benutzer auch Status- und Konfigurationsinformationen
für alle Services ansehen können, dann müssen Sie diese der
[authorized\_for\_all\_services](configcgi.md#configcgi-authorized_for_all_services)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_all_service_commands` angeben, um
statt eines contact eine contactgroup zu autorisieren.

**Zeige alle Services für einen berechtigten Host**

Format:

**show\_all\_services\_host\_is\_authorized\_for=[0|1]**

Beispiel:

**show\_all\_services\_host\_is\_authorized\_for=1**

Per Default kann ein Benutzer alle Services eines Hosts sehen, wenn er
als Kontakt für den Host autorisiert ist. Durch deaktivieren dieser
Option muss der Benutzer auch autorisierter Kontakt des Service sein, um
diesen ansehen zu können. Bitte beachten Sie, dass diese Option keine
Auswirkung hat, wenn die Option authorized\_for\_all\_services für den
Benutzer gesetzt ist.

**Zugang zu Befehlen und Kommentaren verweigern**

Format:

**authorized\_for\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_read\_only=icingalook**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern*, die Nur-Lesen-Zugriff auf die CGIs haben. Dies blockiert
jegliche Host- oder Service-Befehle. Es werden auch keine Kommentare
angezeigt. Benutzer in dieser Liste sind *nicht* automatisch
autorisiert, Befehle für alle Hosts zu erteilen. Benutzer in dieser
Liste sind *nicht* automatisch berechtigt, Status- oder
Konfigurationsinformationen für alle Hosts anzusehen. Wenn Sie möchten,
dass Benutzer auch Status- und Konfigurationsinformationen für alle
Services ansehen können, dann müssen Sie diese der
[authorized\_for\_all\_services](configcgi.md#configcgi-authorized_for_all_services)-Variable
hinzufügen. Mehr Informationen, wie man Authentifizierung einrichtet und
Autorisierung für die CGIs konfiguriert, finden Sie
[hier](cgiauth.md "6.2. Authentifizierung und Autorisierung im Classic UI").

![[Anmerkung]](../images/note.png)

Anmerkung

Ab Icinga 1.5.0 können Sie alternativ
`authorized_contactgroup_for_read_only` angeben, um statt
eines contact eine contactgroup zu autorisieren.

**Read-Only für Kommentare**

Format:

**authorized\_for\_comments\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

**authorized\_contactgroup\_for\_comments\_read\_only=\<contactgroup1\>,\<contactgroup2\>,...\<contactgroupn\>**

Beispiel:

**authorized\_for\_comments\_read\_only=icingalook**

**authorized\_contactgroup\_for\_comments\_read\_only=readonlyusers**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern* die Nur-Lesen-Zugriff auf die Kommentare der CGIs haben. Wenn
der Benutzer bzw. die Benutzergruppe als "authorized\_for\_read\_only"
definiert wurde, kann er bzw. die Gruppe mit dieser Option berechtigt
werden die Kommentare zu lesen. Wird bei dieser Option ein Benutzer bzw.
eine Gruppe angegeben die NICHT als "authorized\_for\_read\_only"
definiert wurde, bewirkt "authorized\_for\_comments\_read\_only", dass
der Benutzer nur noch lesenden Zugriff auf die Kommentare hat.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist ab Icinga 1.8 verfügbar.

**Read-Only für Downtimes**

Format:

**authorized\_for\_downtimes\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

**authorized\_contactgroup\_for\_downtimes\_read\_only=\<contactgroup1\>,\<contactgroup2\>,...\<contactgroupn\>**

Beispiel:

**authorized\_for\_downtimes\_read\_only=icingalook**

**authorized\_contactgroup\_for\_downtimes\_read\_only=readonlyusers**

Dies ist eine Komma-separierte Liste von Namen von *authentifizierten
Benutzern* die Lesen-Zugriff auf die Downtimes der CGIs haben. Wenn der
Benutzer bzw. die Benutzergruppe als "authorized\_for\_read\_only"
definiert wurde, kann er bzw. die Gruppe mit dieser Option berechtigt
werden die Downtimes anzusehen.Wird bei dieser Option ein Benutzer bzw.
eine Gruppe angegeben die NICHT als "authorized\_for\_read\_only"
definiert wurde, bewirkt "authorized\_for\_downtimes\_read\_only", dass
der Benutzer keine Downtimes mehr löschen kann, die Option delete
downtime in der extinfo.cgi wird nicht mehr angezeigt.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist ab Icinga 1.8 verfügbar.

**Autorennamen sperren**

Format:

**lock\_author\_names=[0/1]**

Beispiel:

**lock\_author\_names=1**

Diese Option erlaubt es Ihnen, Benutzer daran zu hindern, den
Autorennamen zu ändern, wenn sie Kommentare, Bestätigungen und geplanten
Ausfallzeiten über das Web-Interface eingeben. Wenn diese Option
aktiviert ist, können Benutzer nicht mit der Befehlsanfrage verbundene
Autorennamen ändern.



**Standard- Verfallsdauer für global deaktivierte Benachrichtigungen**

Format:

**default\_expiring\_disabled\_notifications\_duration=[seconds]**

Beispiel:

******default\_expiring\_disabled\_notifications\_duration=86400******

Ab Icinga 1.8 kann die globale Deaktivierung von Benachrichtigungen mit
einer Ablaufzeit versehen werden. Der Standardwert ist 86400 Sekunden
(1Tag), wünschen Sie eine kürzere oder längere Dauer passen Sie diesen
Wert an. Wenn Sie in den CGI's (Process Info, extinfo.cgi) die
Benachrichtigungen global deaktivieren und die Option **Expire time**
verwenden, werden nach 1 Tag die Benachrichtigungen wieder global
aktiviert.

**Status Show Long Plugin Output**

Format:

**status\_show\_long\_plugin\_output=[0/1]**

Beispiel:

**status\_show\_long\_plugin\_output=1**

Diese Option erlaubt es Ihnen, den Umfang der Statusinformationen von
Plugins festzulegen, die in der status.cgi angezeigt werden. Wenn Sie
den Wert auf 1 setzen, dann wird die komplette Ausgabe angezeigt, sonst
nur die erste Zeile.



![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.0.3.

**Statusmap CGI Background Image**

Format:

**statusmap\_background\_image=\<image\_file\>**

Beispiel:

**statusmap\_background\_image=smbackground.gd2**

Diese Option erlaubt es Ihnen, ein Bild anzugeben, das als Hintergrund
im [statusmap CGI](cgis.md#cgis-statusmap_cgi) benutzt wird, wenn Sie
die Layout-Methode mit benutzerdefinierten Koordinaten benutzen. Das
Hintergrundbild ist nicht in anderen Layout-Methoden verfügbar. Es wird
angenommen, dass sich das Bild im HTML-Image-Pfad befindet (d.h. in
/usr/local/icinga/share/images). Dieser Pfad wird automatisch durch das
Anhängen von "/images" an den in der
[physical\_html\_path](configcgi.md#configcgi-physical_html_path)-Direktive
ermittelt. Anmerkung: Die Bilddatei kann im GIF-, JPEG-, PNG- oder
GD2-Format sein. Das GD2-Format (vorzugsweise im unkomprimierten Format)
wird empfohlen, weil es die CPU-Belastung reduziert, wenn das CGI das
Kartenbild generiert.

**Statusmap Transparency Index Colour**

Format:

**color\_transparency\_index\_r=\<0...255\>**

**color\_transparency\_index\_g=\<0...255\>**

**color\_transparency\_index\_b=\<0...255\>**

Beispiel:

**color\_transparency\_index\_r=255**

Diese Optionen geben die RGB-Werte der Hintergrundfarbe an, die in der
Statusmap-CGI benutzt werden soll, so dass bei Browsern, die keine
PNG-Transparenz anzeigen können, stattdessen diese Farbe angezeigt wird.
Default ist weiß: (R,G,B) = (255,255,255).

**Standard-Statusmap-Layout-Methode**

Format:

**default\_statusmap\_layout=\<layout\_number\>**

Beispiel:

**default\_statusmap\_layout=4**

Gültige Werte sind:

**\<layout\_number\>-Wert**

**Layout-Methode**

0

User-defined coordinates

1

Depth layers

2

Collapsed tree

3

Balanced tree

4

Circular

5

Circular (Marked Up)

6

Circular (Balloon)

**CGI-Aktualisierungsrate**

Format:

**refresh\_rate=\<rate\_in\_seconds\>**

Beispiel:

**refresh\_rate=90**

Diese Option erlaubt es Ihnen, die Anzahl von Sekunden zwischen
Seitenaktualisierungen für die [status](cgis.md#cgis-status_cgi)-,
[statusmap](cgis.md#cgis-statusmap_cgi)- und
[extinfo](cgis.md#cgis-extinfo_cgi)-CGIs festzulegen.

**CGI-Refresh-Typ**

Format:

**refresh\_type=\<0|1\>**

Beispiel:

**refresh\_type=1**

Diese Option legt fest, welche Art von Refresh benutzt wird. Sie können
zwischen HTTP-Header und JavaScript wählen. Als Standard ist JavaScript
(1) aktiviert. Falls Sie Schwierigkeiten damit haben, dann sollten Sie
HTTP-Header (0) einstellen.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.7.

**Audio-Alarme**

Format:

**host\_unreachable\_sound=\<sound\_file\>**

**host\_down\_sound=\<sound\_file\>**

**service\_critical\_sound=\<sound\_file\>**

**service\_warning\_sound=\<sound\_file\>**

**service\_unknown\_sound=\<sound\_file\>**

**normal\_sound=\<sound\_file\>**

Beispiele:

**host\_unreachable\_sound=hostu.wav**

**host\_down\_sound=hostd.wav**

**service\_critical\_sound=critical.wav**

**service\_warning\_sound=warning.wav**

**service\_unknown\_sound=unknown.wav**

**normal\_sound=noproblem.wav**

Diese Option erlaubt es Ihnen, eine Audio-Datei anzugeben, die in Ihrem
Browser abgespielt wird, wenn es ein Problem gibt, während Sie das
[status CGI](cgis.md#cgis-status_cgi) ansehen. Wenn es mehrere
Probleme gibt, wird die Datei für das kritischste Problem abgespielt.
Das kritischste Problem sind ein oder mehrere nicht erreichbare Host,
während das am wenigsten kritische Problem Services in einem
UNKNOWN-Zustand sind (beachten Sie die Reihenfolge im obigen Beispiel).
Audio-Dateien werden im **media**-Unterverzeichnis Ihres
HTML-Verzeichnisses erwartet (d.h. */usr/local/icinga/share/media*).

**Escape HTML Tags Option**

Format:

**escape\_html\_tags=[0/1]**

Beispiel:

**escape\_html\_tags=1**

Diese Option legt fest, ob HTML-Tags in Host- und
Service-(Plugin-)Ausgaben in CGIs unberücksichtigt bleiben oder nicht.
Wenn Sie diese Option aktivieren, wird die Plugin-Ausgabe keine
anklickbaren Hyperlinks enthalten.

**Notes URL Target**

Format:

**notes\_url\_target=[target]**

Beispiel:

**notes\_url\_target=\_blank**

Diese Option legt den Namen des Ziel-Frames fest, in dem Anmerkungs-URLs
angezeigt werden sollen. Gültige Optionen umfassen *\_blank*, *\_self*,
*\_top*, *\_parent* oder jeden anderen gültigen Zielnamen.

**Action URL Target**

Format:

**action\_url\_target=[target]**

Beispiel:

**action\_url\_target=\_blank**

Diese Option legt den Namen des Ziel-Frames fest, in dem Aktions-URLs
angezeigt werden sollen. Gültige Optionen umfassen *\_blank*, *\_self*,
*\_top*, *\_parent* oder jeden anderen gültigen Zielnamen.

**Tac Show Only Hard State**

Format:

**tac\_show\_only\_hard\_state=[0/1]**

Beispiel:

**tac\_show\_only\_hard\_state=1**

Diese Option erlaubt Ihnen in der Tactical Overview nur HARD States von
Host und Services anzeigen zu lassen. Standardmäßig ist diese Option
deaktiviert. Setzen Sie tac\_show\_only\_hard\_state=1, werden in der
Tactical Overview nur noch HARD States angezeigt.

**Splunk-Integrationsoption**

Format:

**enable\_splunk\_integration=[0/1]**

Beispiel:

**enable\_splunk\_integration=1**

Diese Option legt fest, ob die Integration mit Splunk im Web-Interface
aktiviert ist oder nicht. Wenn sie aktiviert ist, werden an
verschiedenen Stellen "Splunk It"-Links in den CGIs angezeigt
(Log-Datei, Alarmhistorie, Host-/Service-Details, usw.). Das ist
nützlich, wenn Sie nach den Ursachen suchen, warum ein bestimmtes
Problem auftrat. Für mehr Informationen über Splunk besuchen Sie
[http://www.splunk.com/](http://www.splunk.com/).

**Splunk-URL**

Format:

**splunk\_url=\<path\>**

Beispiel:

**splunk\_url=http://127.0.0.1:8000/**

Diese Option wird benutzt, um den Basis-URL zu Ihrem Splunk-Interface zu
definieren. Dieser URL wird von den CGIs benutzt, wenn Links erzeugt
werden, falls die
[enable\_splunk\_integration](configcgi.md#configcgi-enable_splunk_integration)-Option
aktiviert ist.

**Persistente Bestätigungskommentare**

Format:

**persistent\_ack\_comments=\<0|1\>**

Beispiel:

**persistent\_ack\_comments=1**

Diese Option legt fest, ob die Check-Box "persistent comment" zur
Bestätigung von Problem-Hosts oder -Services aktiviert ist. Sie kann
benutzt werden, um das Verhalten von Nagios 2 wiederherzustellen.
Default ist "0", um kompatibel mit Nagios 3 zu sein.



**Feldtrennzeichen für CSV-Export setzen**

Format:

**csv\_delimiter=\<char\>**

Beispiel:

**csv\_delimiter=,**

Diese Option legt fest, welche Zeichen als Feldtrenner benutzt werden
soll. Default ist Semikolon (;).

**Set field enclosure character for CSV export**

Format:

**csv\_data\_enclosure=\<char\>**

Beispiel:

**csv\_data\_enclosure='**

Diese Option legt fest, mit welchem Zeichen Felder begrenzt werden
sollen. Default ist ein Apostroph (').

**Initialen Status anzeigen**

Format:

**showlog\_initial\_states=\<0|1\>**

Beispiel:

**showlog\_initial\_states=1**

Diese Option legt fest, ob die initialen Zustände von Hosts und Services
in showlog.cgi angezeigt werden sollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option hat nur Auswirkungen, wenn die Option
"log\_initial\_states" in der icinga.cfg gesetzt wurde.



**Aktuellen Status anzeigen**

Format:

**showlog\_current\_states=\<0|1\>**

Beispiel:

**showlog\_current\_states=1**

Diese Option legt fest, ob die aktuellen Zustände von Hosts und Services
in showlog.cgi angezeigt werden sollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option hat nur Auswirkungen, wenn die Option
"log\_current\_states" in der icinga.cfg gesetzt wurde.



**Objekttyp in Tab-Titel anzeigen**

Format:

**tab\_friendly\_titles=\<0|1\>**

Beispiel:

**tab\_friendly\_titles=1**

Durch Aktivieren dieser Option ändern sich die Titel der Reiter im
Browser, um den jeweiligen Objekttyp anzuzeigen. Sie zeigen dann:





Diese sind einfache zu lesen (und zu finden), wenn Sie (viele) Reiter in
Ihrem Browser anzeigen.



**Service-Zustand und Benachrichtigungsnummer anzeigen**

Format:

**add\_notif\_num\_hard=n**

**add\_notif\_num\_soft=n**

Beispiel:

**add\_notif\_num\_hard=28**

Wenn der Wert der Direktive(n) größer Null ist, werden in der status.cgi
neben dem "Versuch" (z.B. "3/3" für einen Hard-Nicht-OK-Zustand mit
max\_check\_attempts=3) auch die aktuelle Benachrichtigungsnummer
("(\#0)" falls noch keine Benachrichtigung versandt wurde) angezeigt.
Dies ist hilfreich, um Services zu identifizieren, die oft zwischen
verschiedenen Nicht-OK-Zuständen wechseln, oder Services, bei denen
first\_notification\_delay gesetzt ist, die aber noch nicht "in
Schwierigkeiten" sind.

Relevante Werte aus include/statusdata.h (sehen Sie \*dort\* nach, um
\*wirklich\* sicher zu sein):

<pre><code>
</code></pre>

Sie werden wahrscheinlich add\_notif\_num\_hard=0 (Default) oder
add\_notif\_num\_hard=28 (warn+crit+unknown) setzen.

Der Vollständigkeit halber gibt es auch add\_notif\_num\_soft für
Services im SOFT-Zustand.

**HTTP-Zeichensatz einstellen**

Format:

**http\_charset=\<Zeichensatz\>**

Beispiel:

**http\_charset=utf-8**

Hiermit kann der Zeichensatz eingestellt werden, der mit den
HTTP-Headern gesendet wird. Default ist utf-8.

**Ersten Tag der Woche setzen**

Format:

**first\_day\_of\_week=\<0|1\>**

Beispiel:

**first\_day\_of\_week=1**

Diese Option legt den ersten Tag der Woche fest, der in verschiedenen
CGI-Reports benutzt wird. Default ist 0 = Sonntag. 1 = Montag gilt für
Länder, die sich nach ISO 8601 richten.

**CGI-Protokoll** (use logging)

Format:

**use\_logging=\<0|1\>**

Beispiel:

**use\_logging=1**

Diese Variable gibt an, ob die CGI-Kommandos protokolliert werden
sollen. 0 = nicht protokollieren (Default), 1 = protokollieren.

**CGI-Protokolldatei** (CGI-Log File)

Format:

**cgi\_log\_file=\<file\_name\>**

Beispiel:

**cgi\_log\_file=/usr/local/icinga/share/log/icinga-cgi.log**

Diese Variable gibt an, wo Icinga die CGI-Protokolldatei anlegen soll.

**CGI-Protokollrotationsmethode** (CGI Log Rotation Method)

Format:

**cgi\_log\_rotation\_method=\<d/w/m\>**

Beispiel:

**cgi\_log\_rotation\_method=d**

Dies ist die Rotationsmethode, die Icinga für Ihre CGI-Protokolldatei
nutzen soll. Die Werte sind wie folgt:






**CGI-Protokollarchiv-Pfad** (CGI Log Archiv Path)

Format:

**cgi\_log\_archive\_path=\<path\>**

Beispiel:

**cgi\_log\_archive\_path=/usr/local/icinga/share/log/**

Dies ist das Verzeichnis, in dem Icinga die CGI-Protokolldateien ablegen
soll, die rotiert wurden. Diese Option wird ignoriert, wenn Sie die
Funktionalität der
[CGI-Protokollrotation](configcgi.md#configcgi-cgi_log_rotation_method)
(CGI log rotation) nicht nutzen.

**Erzwingen von Kommentaren bei Aktionen**

Format:

**enforce\_comments\_on\_actions=\<0|1\>**

Beispiel:

**enforce\_comments\_on\_actions=1**

Erzwingt die Notwendigkeit zur Eingabe eines Kommentares bei Aktionen
per CGI. 0 = keine Kommentare erzwingen (Default), 1 = Kommentar
erzwingen.

![[Anmerkung]](../images/note.png)

Anmerkung

Die Option use\_logging muss aktiviert sein, anderenfalls werden keine
Kommentare protokolliert.

**Tactical Overview-Header anzeigen**

Format:

**show\_tac\_header=\<0|1\>**

Beispiel:

**show\_tac\_header=0**

Innerhalb der CGIs gibt es einen neuen Header, der per Default aktiviert
ist. Die neue Ansicht hat ein ähnliches Aussehen wie der Header in
Icinga Web und enthält wichtige taktische und
Überwachungs-Performance-Informationen, so dass Sie immer über die
aktuelle Situation informiert sind.

Wenn Sie die alte minimalistische Ansicht beibehalten möchte, dann kann
der neue Header durch folgenden Eintrag deaktiviert werden:
`show_tac_header=0`

Das Layout der Anzeige für die Einträge jedes Typs lautet "X / Y / Z",
wobei:

X = Aktiv, unbestätigt (active unacknowledged)

Y = Passiv, unbestätigt (passive unacknowledged)

Z = Bestätigt (acknowledged)

Die X/Y/Z-Zahlen selbst sind anklickbar und führen Sie zu einer Liste
mit allen Hosts bzw. Services mit der o.g. Eigenschaft.

Die Farbgebung dieser Einträge richtet sich nach folgendem Schema:

<pre><code>
</code></pre>

Diese Farben sind in `html/stylesheets/tacheader.css`
abgelegt, damit sie einfach angepasst werden können. Wenn Sie z.B. eine
verteilte Umgebung haben und primär passive Prüfungen einsetzen, dann
möchten Sie ggf., dass passive Prüfungen farblich wie aktive Prüfungen
dargestellt werden.

**Abbildung 3.1. Beispiel des neuen Headers**

![Beispiel des neuen Headers](../images/tac_header2.png)

\

**Pending-Anzahlen in Tactical Overview-Header anzeigen**

Format:

**show\_tac\_header\_pending=\<0|1\>**

Beispiel:

**show\_tac\_header\_pending=0**

Diese Option aktiviert die Anzeige von Pending-Anzahlen im
Tactical-Overview-Header. Wenn Ihre Auflösung kleiner als 1024x768 und
diese Option aktiviert ist, dann passen die taktischen Informationen
ggf. nicht in den verfügbaren Platz. Diese Option ist per Default
deaktiviert.

**Default-Ausfallzeit-Dauer setzen**

Format:

**default\_downtime\_duration=n**

Beispiel:

**default\_downtime\_duration=7200**

Diese Option setzt die Default-Dauer (in Sekunden) von festen und
flexiblen Ausfallzeiten. Default ist 7200 Sekunden (2 Stunden).

**Maintenance/Downtime anzeigen**

Format:

**suppress\_maintenance\_downtime=\<0|1\>**

Beispiel:

**suppress\_maintenance\_downtime=0**

Die aktuelle Classic-UI-Ansicht zeigt den Status von Hosts zusammen mit
Aufmerksamkeit erregenden Farben, selbst wenn der Host/ Service sich in
einer Ausfallzeit befindet. Dies führt zur Ablenkung von tatsächlich
existierenden Problemen durch geplante oder erwartete Ausfälle. Die
Option ist per Default deaktiviert, um das alte Verhalten beizubehalten.
Falls die Option aktiviert ist, werden die Ausgaben nicht mehr in der
regulären Farbe, sondern in grau angezeigt (wie im Pending-Status). Der
Status jedoch zeigt weiterhin den tatsächlichen Zustand und das ist
beabsichtigt, damit der Benutzer den Zustand sieht, bevor die
Ausfallzeit endet. Ein sinnvolles Beispiel dafür ist, dass ein
Host/Service wieder online ist, an dem gearbeitet wird. Außerdem werden
Hosts in einer geplanten Ausfallzeit in der statusmap.cgi in grau
dargestellt.

**Unvollständige Hostgruppen anzeigen**

Format:

**show\_partial\_hostgroups=\<0|1\>**

Beispiel:

**show\_partial\_hostgroups=1**

Per Default (gleichbedeutend mit einer nicht vorhandenen oder
deaktivierten Direktive) sieht ein Benutzer eine Hostgruppe und deren
Hosts nur, wenn er ein autorisierter Kontakt für *alle* Hosts der
jeweiligen Gruppe ist. Das Verhalten kann mit der Direktive
`show_partial_hostgroups=1` geändert werden.

Wenn sie aktiviert ist, wird der Hostgruppen-Überblick auch
unvollständige Hostgruppen aufführen, bei denen lediglich die Hosts
angezeigt werden, für die der Benutzer ein autorisierter Kontakt ist.

Außerdem wird der Hinweis "(Partial Hostgroups Enabled)" oberhalb des
Hostgruppen-Überblicks angezeigt, damit keine Verwirrung darüber
entsteht, ob diese Direktive aktiviert ist oder nicht. Aus
Geheimhaltungsgründen werden unvollständige Hostgruppen nicht als solche
gekennzeichnet.

KOMPATIBILITÄTSHINWEIS: Wie bei jeder Änderung an der Ausgabe der CGIs
kann die Aktivierung dieser Direktive die Funktion von
Drittanbieter-Tools beeinträchtigen, die sich auf eine bestimmte
(Bildschirm-)Struktur verlassen. Wenn Sie auf ein solches Problem
stoßen, dann deaktivieren Sie diese Option wieder und ermuntern Sie
den/die Entwickler des Programms, statt dessen JSON zur Ermittlung der
Daten zu nutzen.

**Zeilen in status.cgi hervorheben**

Format:

**highlight\_table\_rows=\<0|1\>**

Beispiel:

**highlight\_table\_rows=0**

Mit dieser Option können Zeilen in der status.cgi hervorgehoben werden.
Das kann bei vielen Zeilen oder einer hohen Bildschirmauflösung nützlich
sein. Werte: 0 = deaktivieren der Hervorhebung, 1 = aktivieren der
Hervorhebung (Default).

**Anzeige für PENDING-Status auswählen**

Format:

**use\_pending\_states=\<0|1\>**

Beispiel:

**use\_pending\_states=0**

Diese Option legt fest, welcher Zustand im Web-Interface für
Hosts/Services angezeigt werden soll, die bisher noch nicht geprüft
wirden. Werte: 0 = Hosts/Services, die noch nicht geprüft wurden, in
ihrem ursprünglichen Zustand belassen; 1 = Hosts/Services, die noch
nicht geprüft wurden, als PENDING anzeigen (default).

**Verfallszeit von Bestätigungen setzen**

Format:

**default\_expiring\_acknowledgement\_duration=\<n\>**

Beispiel:

**default\_expiring\_acknowledgement\_duration=86400**

Mit dieser Option kann die Verfallszeit von Bestätigungen
(acknowledgements) festgelegt werden. Nach Ablauf dieser Zeit werden
Bestätigungen automatisch gelöscht. Default ist 86.400 Sekunden (ein
Tag).

**Child-Host(s) zeigen**

Format:

**extinfo\_show\_child\_hosts=\<0|1|2\>**

Beispiel:

**extinfo\_show\_child\_hosts=1**

Mit dieser Option wird festgelegt, ob Child-Host(s) für den ausgewählten
Host im Hostextinfo-CGI angezeigt werden.




![[Wichtig]](../images/important.png)

Wichtig

Option 2 kann ein richtiger Performance-Killer in großen Installationen
sein, deshalb bitte mit Vorsicht einsetzen.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist per Default deaktiviert, da sie die gesamte Performance
beeinträchtigen kann.

**Benutzer(n) VOLLEN Zugriff auf Kommandozeilenanzeigen erlauben**

Format:

**authorized\_for\_full\_command\_resolution=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Beispiel:

**authorized\_for\_full\_command\_resolution=icingaadmin**

Diese Option ist eine kommaseparierte Liste von Benutzern, die im
"Config Command Expander" den Befehl so sehen, wie er von Icinga
ausgeführt würde. Damit alle MACROS aufgelöst werden können, benötigt
der Web-Server zusätzlich Lesezugriff auf `resource.cfg`.

Alternativ können Sie auch Kontaktgruppen angeben.

![[Wichtig]](../images/important.png)

Wichtig

\$USERn\$- und benutzerdefinierte Variable können sensible Daten
enthalten, so dass Sie den Zugriff strikt begrenzen sollten.

**Host-/Service-Status-Gesamtanzahlen anzeigen**

Format:

**display\_status\_totals=0|1**

Beispiel:

**display\_status\_totals=0**

Diese Option legt fest, ob die Gesamtanzahlen von
Host-/Service-Zuständen angezeigt werden sollen. Default ist 0.

**Anzahl anzuzeigender Seiteneinträge beschränken**

Format:

**result\_limit=\<n\>**

Beispiel:

**result\_limit=50**

Mit dieser Option können Sie die Anzahl von Einträgen pro Seite in
diversen CGI's einstellen. Um standardmäßig alle Einträge anzeigen zu
lassen, setzen Sie diese Option auf 0.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.8

**Benutzername in Kleinbuchstaben umwandeln**

Format:

**lowercase\_user\_name=0|1**

Beispiel:

**lowercase\_user\_name=1**

Diese Option legt fest, ob der Benutzername in Kleinbuchstaben
umgewandelt werden soll. Das kann sinnvoll sein, wenn der Benutzername
im Active Directory gespeichert wird.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.8

**Initialwert für "send notifications"-Checkbox setzen**

Format:

**send\_ack\_notifications=0|1**

Beispiel:

**send\_ack\_notifications=1**

Diese Option legt den Initialwert der "send notification"-Checkbox fest,
wenn ein Problem bestätigt wird. Setzen Sie den Wert auf 1, um
standardmäßig Benachrichtigungen zu versenden bzw. auf 0, damit das
nicht passiert. Dieser Standardwert kann ggf. durch den CGI-Dialog
übersteuert werden. Der Standard ist 1 (Benachrichtigungen bei
Problembestätigungen versenden).

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.9

**Initialwert für "set expire time"-Checkbox setzen**

Format:

**set\_expire\_ack\_by\_default=0|1**

Beispiel:

**set\_expire\_ack\_by\_default=1**

Diese Option legt den Initialwert der "set expire time"-Checkbox fest,
wenn ein Problem bestätigt wird. Setzen Sie den Wert auf 1, um
Bestätigungen automatisch verfallen zu lassen bzw. auf 0, damit das
nicht passiert. Dieser Standardwert kann ggf. durch den CGI-Dialog
übersteuert werden. Der Standard ist 0 (Bestätigungen nicht automatisch
verfallen zu lassen).

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.9

**Classic UI Standalone Installation**

Format:

**standalone\_installation=0|1**

Beispiel:

**standalone\_installation=1**

Diese Option legt fest, ob die Classic UI "standalone" installiert und
verwendet wird. Diese Option wurde mehrheitlich für Icinga 2 und dessen
Compat Layer implementiert, kann aber auch in anderen Installationen
verwendet werden, beispielsweise als zusätzliches Dashboard. Wenn Sie
diese Option aktivieren, wird die Classic UI die Option
main\_config\_file ignorieren, und stattdessen alle benötigten
Einstellungen in der cgi.cfg suchen. Sie finden diese in der
Beispielkonfiguration in der Sektion "Standalone (Icinga 2)".

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.9

**Ansehen von partiellen Service-Gruppen erlauben**

Format:

**show\_partial\_servicegroups=0|1**

Beispiel:

**show\_partial\_servicegroups=1**

Als Standard (d.h., wenn die Direktive nicht gesetzt oder deaktiviert
ist) kann ein Benutzer eine Service-Gruppe und die darin enthaltenen
Hosts bzw. Service nur dann sehen, wenn er ein autorisierter Kontakt für
alle Hosts und Services der Gruppe ist. Dieses Verhalten kann mit der
Direktive `show_partial_servicegroups=1` geändert werden. Wenn
sie aktiviert ist, wird die Service-Gruppen-Übersicht für alle
Service-Gruppen eine partielle Auflistung von Hosts und Services zeigen,
bei denen der Benutzer als autorisierter Kontakt eingetragen ist. Sie
zeigt außerdem den Hinweis "(Partial Servicegroups Enabled)" oben in der
Service-Gruppen-Übersicht, um Verwirrung darüber zu verhindern, ob die
Direktive gesetzt ist oder nicht. Allerdings werden Service-Gruppen
nicht extra gekennzeichnet, bei denen nur eine partielle Auflistung
gezeigt wird.



![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.10

**Deaktivieren des Schutzes von cmd.cgi gegen CRSF-Attacken**

Format:

**disable\_cmd\_cgi\_csrf\_protection=0|1**

Beispiel:

**disable\_cmd\_cgi\_csrf\_protection=1**

Als Standard (d.h., wenn die Direktive nicht gesetzt oder deaktiviert
ist) wird ein Befehl zurückgewiesen, wenn ein externen Programm (wie
z.B. Nagstamon) versucht, cmd.cgi direkt anzusprechen. Auf diese Weise
sollen CRSF-Attacken (Cross-Site Request Forgery) verhindert werden.
Aktivieren Sie diese Option nur, wenn Sie diese Funktionalität
benötigen.



![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.11

**Ansehen von benutzerdefinierten Variablennamen unterdrücken**

Format:

**exclude\_customvar\_name=\<name1[,name2,...]|\*\>**

Beispiel:

**exclude\_customvar\_name=\<password\>**

Benutzerdefinierte Variablennamen sind im Classic UI sichtbar (seit
Icinga 1.11). Weil einige Namen sensitive Informationen enthalten,
sollen diese Daten vor dem Benutzer verborgen werden. Die Direktive
"exclude\_customvar\_name" gibt eine kommaseparierte Liste von Strings
an. Variablennamen, die diese Strings enthalten, werden nicht angezeigt.
Die Angabe von "\*" anstatt einer Liste wird alle benutzerdefinierten
Variablennamen unterdrücken.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.11

**Statusdaten per Default sortieren**

Format:

**sort\_status\_data\_by\_default=\<0|1\>**

Beispiel:

**sort\_status\_data\_by\_default=\<0\>**

Diese Option zwingt status.cgi, die Datei per Default zu sortieren.
Dabei erfolgt die Sortierung aufsteigend, zuerst nach Hostnamen, dann
nach Service-Beschreibung. Dies ist hilfreich, wenn die Statusdaten in
status.dat nicht sortiert sind. Das kann besonders beim Einsatz von
Icinga2 auftreten. Normalerweise ist diese Option ausgeschaltet (0), um
mögliche höhere CPU-Belastungen bei großen Umgebungen zu vermeiden.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.12

**Voreinstellung von "sticky"-Bestätigungen**

Format:

**set\_sticky\_acknowledgment=\<0|1\>**

Beispiel:

**set\_sticky\_acknowledgment=\<0\>**

Diese Option kontrolliert den Anfangszustand der "Sticky
Acknowledgment:"-Checkbox, wenn ein Problem bestätigt wird. Der Default
ist 1 (Bestätigungen sind "sticky"), 0 deaktiviert
"sticky"-Bestätigungen. Dies kann im CGI-Dialog überschrieben werden.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Option ist verfügbar ab Icinga 1.12

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
