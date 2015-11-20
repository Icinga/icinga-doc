 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

6.5. Installation des Icinga Web Frontend
-----------------------------------------

6.5.1. [Einleitung](icinga-web-scratch.md#introduction)

6.5.2. [Voraussetzungen](icinga-web-scratch.md#prerequisites)

6.5.3. [Die Installation](icinga-web-scratch.md#install)

6.5.4. [Einstellungen](icinga-web-scratch.md#settings)

6.5.5. [Testen](icinga-web-scratch.md#useit)

6.5.6. [Test & Fehler?](icinga-web-scratch.md#webtroubleshooting)

### 6.5.1. Einleitung

Das neue Icinga Web wird aktuell sehr stark weiterentwickelt, sodass
sich diese Dokumentation unter Umständen noch ändern kann/wird. Falls
Sie eine detaillierte Installationsanleitung benötigen, konsultieren Sie
bitte `doc/INSTALL` aus dem Source-Paket. Mehr Informationen
über die gesamte Architektur können Sie auf unserer Webseite nachlesen:
[https://www.icinga.org/architecture/](http://www.icinga.org/architecture/)
Falls Sie mehr über das Icinga Web-Development und die Modularchitektur
wissen wollen, verfolgen Sie bitte stetig aktualisierte Einträge im
Development-Wiki von Icinga Web: [Icinga
Wiki](https://dev.icinga.org/projects/icinga-development/wiki#24-Icinga-Web)

Diese Installationsanleitung beschreibt die Installation von Icinga Web
mit MySQL bzw. PostgreSQL als verwendeter Datenbank, außerdem wird
Oracle unterstützt.

### 6.5.2. Voraussetzungen










































Die Installation von Icinga mit den IDOUtils ist in der
[Icinga-Schnellstartanleitung](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
beschrieben

### 6.5.3. Die Installation







































































































### 6.5.4. Einstellungen



































































### 6.5.5. Testen

![[Anmerkung]](../images/note.png)

Anmerkung

Bitte achten Sie darauf, dass Ihre Datenbank, Apache, IDOUtils und
Icinga gestartet sind!

Öffnen Sie im Webbrowser http://localhost/icinga-web. Überprüfen Sie, ob
das Webinterface ohne Fehler ("exceptions") startet, und loggen Sie sich
mit dem User 'root' und dem Passwort 'password' ein.

Viel Spaß :-)

### 6.5.6. Test & Fehler?

![[Anmerkung]](../images/note.png)

Anmerkung

Der folgende Abschnitt versucht, einige Hinweise zu üblichen Problemen
zu geben, aber aufgrund der Natur von "geschriebenem" Material wird die
[Wiki-Seite](https://wiki.icinga.org/display/testing/Icinga+Web+Testing)
höchstwahrscheinlich aktueller sein, so dass es dort ggf. eine Lösung
gibt, die Sie hier nicht finden.

Diese Sammlung enthält einige nützliche Informationen, wie Sie Fehler
finden und lösen können. Ebenso wird darauf hingewiesen, welche
Informationen Sie im Fehlerfall angeben sollten, wenn Sie eine Frage auf
den Mailinglisten oder auf
[http://www.icinga-portal.org](http://www.icinga-portal.org) stellen.




Wo können Sie nachsehen?



Änderungen an der Icinga Web-Konfiguration (z.B.
API/IDOUtils-Einstellungen geändert) werden nicht aktualisiert?


</code></pre> 
 /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

Icinga-Web zeigt eine leere Seite?












IDOUtils-Datenbank wird nicht gefüllt?





**Testing the Web (stellen Sie sicher, dass PHPUnit installiert ist):**

</code></pre> 
 $> make test
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Falls Sie Ihren root-Benutzer zum Testen benutzen, dann stellen Sie
vorher sicher, dass für den angegebenen Web-Benutzer in der
`/etc/passwd` eine gültige Shell eingetragen ist.
Anderenfalls werden verschiedene Tests fehlschlagen. Abhängig von der
verwendeten Icinga-Web-Version kann es sein, dass die Berechtigungen für
die Dateien in `/usr/local/icinga-web/log` falsch gesetzt
sind, so dass Icinga-Web mit der Meldung "Loading" stehenbleibt.

![[Anmerkung]](../images/note.png)

Anmerkung

`php.ini` erfordert einen Apache reload/restart!















Sofern Sie Fragen oder Updates haben, zögern Sie bitte nicht, uns diese
mitzuteilen! :-)

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
