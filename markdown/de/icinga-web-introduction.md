 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

6.8. Einführung in Icinga Web
-----------------------------

6.8.1. [Einführung in Icinga Web (\>=
1.13)](icinga-web-introduction.md#icinga-web-intro)

**Überblick**

Diese Einführung wird Sie auf eine kurze Tour einladen, um diverse
Aspekte von Icinga Web zu skizzieren. Es besteht kein Anspruch auf
Vollständigkeit, da dieses Dokument stetig erweitert wird.

Bedingt durch ständige Weiterentwicklung ändern sich einige Dinge mit
der Zeit und Optionen werden hinzugefügt. Bitte werfen Sie einen Blick
auf die aktuelle [Version
1.10](icinga-web-introduction.md#icinga-web-intro "6.8.1. Einführung in Icinga Web (>= 1.13)").

### 6.8.1. Einführung in Icinga Web (\>= 1.13)

Wenn Sie den Schnellstart-Anleitungen
([IDOUtils](quickstart-idoutils.md "2.6. Icinga-Schnellstart mit IDOUtils")
und [Icinga
Web](icinga-web-scratch.md "6.5. Installation des Icinga Web Frontend"))
gefolgt sind, sollten Sie nun http://\<icinga server\>/icinga-web
aufrufen können und den Login-Bildschirm sehen

**Abbildung 6.2. Icinga Web Login-Bildschirm**

![Icinga Web Login-Bildschirm](../images/icinga-web-login.png)

\

Sie können sich mittels "root" und "password" einloggen. Dies wird Sie
auf eine Überblickseite weiterleiten, wo der Status von überwachten
Hosts und Services dargestellt wird.

**Abbildung 6.3. Icinga Web Überblick**

![Icinga Web Überblick](../images/icinga-web-overview.png)

\

*Oberes Menü*

Das obere Menü beherbergt generelle Informationen zu Icinga sowie ein
Benutzer-, Gruppen-, Log- sowie Task-Administrierungsmenü. Die Live-Such
öffnet sich, wenn Sie auf das Vergrößerungsglas neben der Uhrzeit
klicken. Rechts oben können Sie den gerade eingeloggten Benutzer
bearbeiten oder sich aus Icinga Web ausloggen.

**Abbildung 6.4. Icinga Web Top-Menü**

![Icinga Web Top-Menü](../images/icinga-web-topmenu1.png)

\

*Suche*

Die Suche zeigt live Resultate, während Sie tippen. Diese werden in
einem eigenen Inlay-Fenster angezeigt. Indem Sie ein Ergebnis anklicken,
wird ein neuer Tab mit näheren Informationen geöffnet. Die Suche beginnt
am Anfang der Zeichenkette, aber Sie können auch Wildcards benutzen.

**Abbildung 6.5. Icinga Web Live-Suche**

![Icinga Web Live-Suche](../images/icinga-web-search1.png)

\

*Status-Cronk*

Der Status-Cronk zeigt die aktuelle Anzahl von Hosts und Services
aufgeteilt nach ihren aktuellen Zuständen. Sofern ein Zähler Null (0)
ist, wird dieser grau hinterlegt angezeigt. Klicken Sie auf einen
Zustand, um einen neuen Tab zu öffnen, der nur den gewählten Zustand
anzeigt. Daneben finden Sie die Anzahl und den Zustand der
Icinga-Instanzen. Der verbleibende Platz wird für die Anzeige
allgemeiner Informationen benutzt, das sind:




**Abbildung 6.6. Icinga Web Status-Cronk**

![Icinga Web Status-Cronk](../images/icinga-web-statuscronk.png)

\

*Linkes Menü*

Im linken (versteckbaren) Menü können Sie aus verschiedenen Widgets (wir
nennen diese "Cronks") auswählen, die das Arbeiten mit Icinga Web
erleichtern werden. Sie können entweder einen Cronk doppelklicken oder
diesen mit dem Mauszeiger in die zentrale Tab-Leiste ziehen. Die
Kategorien sind wie folgt aufgeteilt:

















Sie können im Settings-Menü auch zur alten Ansicht mit den größeren
Icons wechseln. In der Konfigurationsdatei
`userpreferences.xml` können Sie einen globalen Defaultwert
setzen.

**Abbildung 6.11. Icinga Web Cronk Menü Umschalter**

![Icinga Web Cronk Menü
Umschalter](../images/icinga-web-cronks-settings.png)

\

*Zentrale Übersicht*

Hier findet sich alles zusammen: Sie können mittels drag-and-drop neue
Fenster hereinziehen. Die Ansichten für den aktuellen Benutzer sind
konfigurierbar (diese sind persistent), z.B. durch verschieben der
Spaltenüberschrift an die gewünschte Stelle. Rechtsklicken auf die
Spaltenüberschrift ermöglicht die Einstellung der Sortierreihenfolge
oder das Verstecken von Spalten. Zu öffnende Suchresultate werden
ebenfalls hier in einem neuen Tab geöffnet; das gilt auch für das Öffnen
verfügbarer Cronks.

**Abbildung 6.12. Icinga Web Zentrale Übersicht**

![Icinga Web Zentrale Übersicht](../images/icinga-web-mainscreen.png)

\

*Host Status*

Die HostStatus-Ansicht zeigt den Host-Status und darunter die Anzahl von
Warning/Critical der zugehörigen Services. Über die erweitere Ansicht
können Sie in die Servicestatus- Ansicht und die Historie des Hosts
wechseln, die Statusmap ansehen sowie die Performancedaten des Hosts
anzeigen lassen, sofern Sie PNP4Nagios nutzen.

**Abbildung 6.13. Icinga Web Host-Status**

![Icinga Web Host-Status](../images/icinga-web-host.png)

\

Links sehen Sie das "Expander"-Icon. Nach dem Klicken öffnet sich
darunter ein Balken.

**Abbildung 6.14. Icon-Balken**

![Icon-Balken](../images/icinga-web-exp_2.png)

\

Nach Rechts-Klick auf eins der neuen Icons und auswählen von "Move into
grid" wird das entsprechende Icon ins Raster verschoben.

**Abbildung 6.15. Verschieben von Icons**

![Verschieben von Icons](../images/icinga-web-exp_3.png)

\

Auswählen des neuen Icons öffnet ein kleinen Fenster oder es wird ein
neuer Reiter erstellt, in dem die gewünschten Informationen zu sehen
sind.

**Abbildung 6.16. Neue Icons im Raster**

![Neue Icons im Raster](../images/icinga-web-exp_4.png)

\

Klicken auf "Setting" und auswählen von "Reset grid action icons"
entfernt die eingefügten Icons und stellt die Standardansicht wieder
her.

**Abbildung 6.17. Zurücksetzen der Icon-Einstellungen**

![Zurücksetzen der Icon-Einstellungen](../images/icinga-web-exp_5.png)

\

*Host Informationen*

Über Details in der erweiterten HostStatus-Ansicht sehen Sie
detaillierte Host- Status Informationen, zugeordnete Kontakte und
Hostgruppen und externe Referenzen.

**Abbildung 6.18. Icinga Web Objekt-Information**

![Icinga Web Objekt-Information](../images/icinga-web-host-obj.png)

\

*Service Status*

Die ServiceStatus-Ansicht zeigt die Services für jeden Host.

**Abbildung 6.19. Icinga Web Service-Status**

![Icinga Web Service-Status](../images/icinga-web-srv.png)

\

*Service Informationen*

Über die erweitere ServiceStatus-Ansicht können Sie detaillierte
Service- Status- und Host- Status- Informationen ansehen, die Historie
des Services aufrufen und in die HostStatus- Ansicht wechseln.

**Abbildung 6.20. Icinga Web Service Information**

![Icinga Web Service Information](../images/icinga-web-srv_obj.png)

\

*Hostgroup Status*

Die Hostgroup-Ansicht zeigt den Status und die Anzahl der Hosts mit dem
jeweiligen Status gruppiert nach den Hostgruppen.

**Abbildung 6.21. Icinga Web Hostgruppenstatus**

![Icinga Web Hostgruppenstatus](../images/icinga-web-hostgroup.png)

\

*Log*

Am unteren Fensterrand wird das aktuelle Icinga-Protokoll eingeblendet.
Das Log wird automatisch aktualisiert, und kann auch minimiert werden,
um mehr Platz für die zentrale Übersicht zu schaffen.

**Abbildung 6.22. Icinga Web Log**

![Icinga Web Log](../images/icinga-web-log.png)

\

**Cronks und Views**

Icinga Web erlaubt es, mehrere Cronks für verschiedene Anwendungsgebiete
zu öffnen und zu verwalten. Damit können Sie Daten einsehen, Filter für
unterschiedliche Views setzen oder Kommandos absenden. Die folgende
Übersicht fasst die generellen Möglichkeiten zusammen (einige Cronks
bieten zusätzliche Items, wie etwas das Senden von Kommandos).

**Abbildung 6.23. Icinga Web Cronk-Leiste**

![Icinga Web Cronk-Leiste](../images/icinga-web-main_bar.png)

\






**Abbildung 6.24. Icinga Web Cronk-Leiste**

![Icinga Web Cronk-Leiste](../images/icinga-web-settings.png)

\



*Commands*

In Icinga Web gibt es verschiedene Kommandos (siehe Kapitel ["External
Commands"](extcommands.md "7.1. Externe Befehle") für mehr
Informationen), die an den Core geschickt werden können. Selektieren Sie
die Einträge, die davon betroffen sein sollen, und dann das Kommando,
das ausgeführt werden soll.

Host Commands

**Abbildung 6.25. Icinga Web Host-Befehle**

![Icinga Web Host-Befehle](../images/icinga-web-commands_hst.png)

\

Service Commands

**Abbildung 6.26. Icinga Web Service-Befehle**

![Icinga Web Service-Befehle](../images/icinga-web-commands_svc.png)

\

*Filter*

Filter erlauben Icinga Web eigene, angepasste Ansichten (Views) die auch
in eigenen persistenten Cronks gespeichert werden können. Als erstes
wählen Sie bitte "View Filter". Auf der linken Seite öffnet sich an
Stelle des Cronk Menüs die Auswahl der Filterattribute und -bedingungen
im unteren Bereich, sowie die Anzeige des aktuellen Filters im oberen
Bereich.

**Abbildung 6.27. Icinga Web Filtereinschränkung**

![Icinga Web Filtereinschränkung](../images/icinga-web-filter1.png)

\

Anschließend spezifizieren Sie die Bedingung(en), unter welchen der
Filter die Anzeige generieren soll, indem Sie Filterattribute und
-bedingung mittels Drag and Drop verschieben.

drag filter

**Abbildung 6.28. Icinga Web drag filter**

![Icinga Web drag filter](../images/icinga-web-filter2.png)

\

drop filter

**Abbildung 6.29. Icinga Web drop filter**

![Icinga Web drop filter](../images/icinga-web-filter3.png)

\

Sobald Sie den Attributfilter auf eine Bedingung gezogen haben, können
Sie dessen Werte einstellen (abhängig vom Attribut. Das Beispiel zeigt
lediglich jene Auswahl des Status an). Klicken Sie "Add filter" an
sobald Sie fertig sind.

**Abbildung 6.30. Icinga Web Filter Attribut Selektierung**

![Icinga Web Filter Attribut
Selektierung](../images/icinga-web-filter4.png)

\

Der aktive Filter zeigt nun nur die gefilterte Ansicht und dessen
Einträge.

**Abbildung 6.31. Icinga Web Filter aktiv**

![Icinga Web Filter aktiv](../images/icinga-web-filter5.png)

\

Sie können auch mehrere Filter (auch desselben Typs) durch Bedingungen
miteinander verknüpfen. DAs Beispiel zeigt eine Oder-Verknüpfung
zwischen dem Status Critical und Warning.

**Abbildung 6.32. Icinga Web filter advanced filters**

![Icinga Web filter advanced filters](../images/icinga-web-filter6.png)

\

****

**Administration**

Steigen Sie in die Administrationsübersicht ein, indem Sie "Admin" im
oberen Menü auswählen. Danach wählen Sie "Users", "Groups", "Logs" oder
"Tasks".

**Abbildung 6.33. Icinga Web Top-Menü Admin**

![Icinga Web Top-Menü Admin](../images/icinga-web-topmenu2.png)

\

*Benutzer*

Sie können Benutzer hinzufügen, löschen oder editieren. Sie können auch
Benutzer suchen.

**Abbildung 6.34. Icinga Web Benutzer-Administration**

![Icinga Web
Benutzer-Administration](../images/icinga-web-admin_users1.png)

\

Doppelklicken Sie einen Benutzer um ein neues Inlay Fenster zu öffnen,
das Ihnen erlaubt, weitere Details zu spezifizieren. Dieselben Optionen
stehen zur Verfügung, wenn Sie einen neuen Benutzer anlegen. Sie können
die Größe des Fensters mittels Mauszeigerbewegung an den Ecken
beeinflussen.





**Abbildung 6.35. Icinga Web Benutzer editieren**

![Icinga Web Benutzer editieren](../images/icinga-web-admin_users2.png)

\

*Gruppen*

Sie können Gruppen hinzufügen, löschen oder editieren. Die
Gruppenvererbung lässt sich direkt im Gruppenbaum auf der rechten Seite
anpassen. Sie können auch nach Gruppen suchen.

**Abbildung 6.36. Icinga Web Gruppen-Administration**

![Icinga Web
Gruppen-Administration](../images/icinga-web-admin_groups1.png)

\

Doppelklicken Sie eine Gruppe, um ein neues Inlay-Fenster zu öffnen, das
Ihnen erlaubt, weitere Details zu spezifizieren. Dieselben Optionen
stehen zur Verfügung, wenn Sie eine neue Gruppe anlegen. Sie können die
Größe des Fensters mittels Mauszeigerbewegung an den Ecken beeinflussen.

**Abbildung 6.37. Icinga Web Gruppen**

![Icinga Web Gruppen](../images/icinga-web-admin_groups2.png)

\

*Rollen*

In der Benutzer- und Gruppenübersicht im Administrationsbereich können
Sie Rollen hinzufügen/entfernen/editieren. Nachfolgend eine Liste der
verfügbaren Rollen:

**Abbildung 6.38. Icinga Web Rollen**

![Icinga Web Rollen](../images/icinga-web-admin_principals.png)

\

![[Anmerkung]](../images/note.png)

Anmerkung

Weitere Informationen zum Berechtigungskonzept von Icinga Web finden Sie
im
[Wiki.](https://wiki.icinga.org/display/Dev/Object+Credentials+-+How+they+work)

*Logs*

Hier können Sie verschiedene Logs betrachten, um diese als Hilfe bei
Ihrer Fehlersuche zu verwenden.

**Abbildung 6.39. Icinga Web logs**

![Icinga Web logs](../images/icinga-web-admin_logs1.png)

\

*Task*

Verschiedene Dinge erfordern das Löschen des Cache. Anstatt auf die
Kommandozeile zu wechseln können Sie den Befehl über das "Tasks"-Menü
ausführen.

**Abbildung 6.40. Icinga Web Tasks**

![Icinga Web Tasks](../images/icinga-web-admin_tasks.png)

\

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
