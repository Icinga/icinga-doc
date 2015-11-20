 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

11.4. Die Icinga Web REST API
-----------------------------

11.4.1. [Warum sollten Sie die API benutzen?](icinga-web-api.md#why)

11.4.2. [Features der Icinga Web REST API](icinga-web-api.md#features)

11.4.3. [Was ist der Unterschied zwischen der Icinga API und der Icinga
Web REST API?](icinga-web-api.md#difference)

11.4.4. [Voraussetzungen](icinga-web-api.md#prerequisites)

11.4.5. [Referenzen](icinga-web-api.md#reference)

11.4.6. [GET](icinga-web-api.md#get)

11.4.7. [Die Struktur der URL:](icinga-web-api.md#geturlstructure)

11.4.8. [Die Parameter en Detail:](icinga-web-api.md#getparamdetails)

11.4.9. [Beispiele für GET](icinga-web-api.md#getexample)

11.4.10. [POST](icinga-web-api.md#post)

11.4.11. [Die Parameter en Detail](icinga-web-api.md#postparamdetail)

11.4.12. [Beispiele für POST](icinga-web-api.md#postexample)

In dieser Anleitung beschreiben wir Ihnen die Icinga Web REST API. Sie
erlaubt Ihnen Ihre Überwachungsinformationen via GET oder POST
abzufragen (in Zukunft (\>1.2) auch via PUT).

### 11.4.1. Warum sollten Sie die API benutzen?

Den meisten Anwendern genügt der Einsatz von Icinga und Icinga Web. Sie
können den Status Ihres Monitoring sehen, auf aktuelle Probleme
reagieren und Icinga Web um gewünschte Module und Cronks erweitern.

Wenn Sie allerdings eine zusätzliche Software einsetzen möchten, die
Ihre Monitoring-Daten abfragen soll (zum Beispiel:
[Icinga-Chromed-Status](http://www.icinga.org/2010/07/16/icinga-chromed-status-for-google-chromechromium/)),
kann Ihnen die Icinga Web API sehr dienlich sein.

Sie können natürlich die Ausgabe des Icinga Classic UI analysieren
(parsen) (so verfahren zur Zeit viele Programme, wie zum Beispiel
nagstamon oder das Firefox Plugin Nagios Checker), aber das ist keine
wirklich performante Lösung- und außerdem keine Freude für den
Entwickler :-).

Die Icinga Web REST API stellt Ihnen die Daten zur Verfügung, die Sie
benötigen (und auch nur diese). Die Daten werden in einem
standardisierten, maschinenlesbaren Format wie JSON oder XML zur
Verfügung gestellt.

### 11.4.2. Features der Icinga Web REST API

Derzeit unterstützt (v1.2):









Zukünftig unterstützt(\> 1.2):


### 11.4.3. Was ist der Unterschied zwischen der Icinga API und der Icinga Web REST API?

Die Icinga API kann als ein internes Toolkit für den Zugriff auf die
Datenbankinformationen angesehen werden. In der Tat wirkt die REST-API
im oberen Teil der API und bedient sich des HTTP-Protokolls. In Zukunft
wird die Icinga API mit Icinga Web zusammengeführt werden.

### 11.4.4. Voraussetzungen

Um die API verwenden zu können, müssen Sie zunächst den Auth-Provider
aktivieren icinga-web/app/modules/AppKit/config/auth.xml .

Ändern von "auth\_enabled" zu 'true':

<pre><code>
># vi icinga-web/app/modules/AppKit/config/auth.xml
</code></pre>

<pre><code>
<ae:parameter name="auth_key">
</ae:parameter>
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie ein \*.xml-File editieren, müssen Sie anschließend den Cache
leeren!

<pre><code>
rm -f app/cache/config/*.php
</code></pre>

oder

<pre><code>
icinga-web/bin/clearcache.sh
</code></pre>

Nun brauchen Sie in Icinga Web einen Benutzer mit
API-Zugriffsberechtigung, bitte anlegen in Ihrem Icinga Web :





Das war es, nun können Sie starten.

### 11.4.5. Referenzen

In den nächsten Sätzen erläutern wir, wie auf die API zugegriffen werden
kann:

### 11.4.6. GET

Vorteile:



Nachteile:



### 11.4.7. Die Struktur der URL:

Um die API anzusprechen, sollte die URL folgendermaßen aufgebaut sein
(Fett markierte Werte sind erforderlich) host.com/icinga-web/web/api/
**TARGET** / **COLUMNS** / FILTER / ORDER / GROUPING / LIMIT /
COUNTFIELD / **OUTPUT\_TYPE**

### 11.4.8. Die Parameter en Detail:

















### 11.4.9. Beispiele für GET

GET alle Dienste die kritisch oder warning sind und deren Host im Status
ok ist. Absteigend sortiert nach Dienststatus und Hochzählen der
Services. Authentifikation via authkey (hier: APITEST123456). Für die
bessere Lesbarkeit ist die Anfrage in mehrere Zeilen aufgeteilt, XML:

<pre><code>
http://localhost/icinga-web/web/api/service/filter[AND(HOST_CURRENT_STATE|=|0;OR(SERVICE_CURRENT_STATE|=n|1;SERVICE_CURRENT_STATE|=|2))]/
columns[SERVICE_NAME|HOST_NAME|SERVICE_CURRENT_STATE|HOST_NAME|HOST_CURRENT_STATE|HOSTGROUP_NAME]/
order(SERVICE_CURRENT_STATE;DESC)/countColumn=SERVICE_ID/authkey=APITEST123456/xml
</code></pre>

So sieht die Rückgabe aus:

<pre><code>
<results>
</code></pre>

Wenn Sie das Format von xml zu json ändern, bekommen Sie die gleichen
Informationen (plus zusätzliche Informationen für ExtJS, falls Sie sie
nicht benötigen, können Sie diese ignorieren) im json Format:

<pre><code>
{"metaData":
}
</code></pre>

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie den countField-Parameter nicht verwenden, bekommen Sie eine
"flat" json-Datei mit diesem Ergebnis.

### 11.4.10. POST

Vorteile:




Nachteile:


### 11.4.11. Die Parameter en Detail

Der Link entspricht dem GET-Basislink, allerdings mit der Angabe des
Ausgabeformates: Zum Beispiel: host.com/icinga-web/web/api/json.
Folgende Parameter werden unterstützt:















### 11.4.12. Beispiele für POST

Nehmen wir das Beispiel aus "Beispiel für GET" und benutzen nun eine
POST-Anfrage. Wir werden curl verwenden, so dass das Beispiel auf der
Konsole wiederholt werden kann:

<pre><code>
</code></pre>

Dies gibt uns das gleiche Ergebnis zurück, wie zuvor in der GET-Anfrage.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
