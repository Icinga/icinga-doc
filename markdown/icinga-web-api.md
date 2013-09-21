Die NAME-WEB REST API
=====================

In dieser Anleitung beschreiben wir Ihnen die NAME-WEB REST API. Sie
erlaubt Ihnen Ihre Überwachungsinformationen via GET oder POST
abzufragen (in Zukunft (\>1.2) auch via PUT).

Warum sollten Sie die API benutzen?
-----------------------------------

Den meisten Anwendern genügt der Einsatz von NAME-ICINGA und NAME-WEB.
Sie können den Status Ihres Monitoring sehen, auf aktuelle Probleme
reagieren und NAME-WEB um gewünschte Module und Cronks erweitern.

Wenn Sie allerdings eine zusätzliche Software einsetzen möchten, die
Ihre Monitoring-Daten abfragen soll (zum Beispiel:
[Icinga-Chromed-Status](http://www.icinga.org/2010/07/16/icinga-chromed-status-for-google-chromechromium/)),
kann Ihnen die NAME-WEB API sehr dienlich sein.

Sie können natürlich die Ausgabe des NAME-UI analysieren (parsen) (so
verfahren zur Zeit viele Programme, wie zum Beispiel nagstamon oder das
Firefox Plugin Nagios Checker), aber das ist keine wirklich performante
Lösung- und außerdem keine Freude für den Entwickler :-).

Die NAME-WEB REST API stellt Ihnen die Daten zur Verfügung, die Sie
benötigen (und auch nur diese). Die Daten werden in einem
standardisierten, maschinenlesbaren Format wie JSON oder XML zur
Verfügung gestellt.

Features der NAME-WEB REST API
------------------------------

Derzeit unterstützt (v1.2):

-   Verfügbarkeit von nahezu allen Überwachungsdaten via GET oder POST.

-   Rückgabe der Daten als xml oder json.

-   AND & OR- Suche über Filtergruppen mit unbegrenzten
    Verschachtelungsebenen (AND)).

-   Sie wählen, welche Spalten zurückgegeben werden sollen, nicht die
    API (weniger Overhead).

-   Unterstützung von "of limit, offset, order oder group by".

-   Rückgabe eines zusätzlichen Gesamtwert-Feldes.

-   Autorisierung über auth\_key in Requests oder Cookies.

-   Respektiert NAME-WEB Prinzipien (z.B. die Begrenzung auf bestimmte
    Hostgruppen).

Zukünftig unterstützt(\> 1.2):

-   Senden von Kommandos via PUT

Was ist der Unterschied zwischen der NAME-API und der NAME-WEB REST API?
------------------------------------------------------------------------

Die NAME-API kann als ein internes Toolkit für den Zugriff auf die
Datenbankinformationen angesehen werden. In der Tat wirkt die REST-API
im oberen Teil der API und bedient sich des HTTP-Protokolls. In Zukunft
wird die NAME-API mit NAME-WEB zusammengeführt werden.

Voraussetzungen
---------------

Um die API verwenden zu können, müssen Sie zunächst den Auth-Provider
aktivieren icinga-web/app/modules/AppKit/config/auth.xml .

Ändern von "auth\_enabled" zu 'true':

    ># vi icinga-web/app/modules/AppKit/config/auth.xml

    <ae:parameter name="auth_key">
        <ae:parameter name="auth_module">AppKit</ae:parameter>
        <ae:parameter name="auth_provider">Auth.Provider.AuthKey</ae:parameter>
        <ae:parameter name="auth_enable">true</ae:parameter>
        <ae:parameter name="auth_authoritative">true</ae:parameter>
    </ae:parameter>

> **Note**
>
> Wenn Sie ein \*.xml-File editieren, müssen Sie anschließend den Cache
> leeren!

    rm -f app/cache/config/*.php

oder

    icinga-web/bin/clearcache.sh

Nun brauchen Sie in NAME-WEB einen Benutzer mit
API-Zugriffsberechtigung, bitte anlegen in Ihrem NAME-WEB :

-   Anlegen eine neuen Benutzers

-   Auswählen von auth\_key in dem Auth\_via Feld

-   Einfügen des zu nutzenden API-Schlüssels

-   Unter principals, hinzufügen von appkit.api.access principal

Das war es, nun können Sie starten.

Referenzen
----------

In den nächsten Sätzen erläutern wir, wie auf die API zugegriffen werden
kann:

GET
---

Vorteile:

-   Leicht zu nutzen, es ist eine URL!

-   Sie können immer nachvollziehen, welche Parameter angefragt wurden.

Nachteile:

-   Wenn Sie in einem Browser Ihre Anfrage absetzen, könnte Ihr API-Key
    in der Browser-History gespeichert werden.

-   In einem Browser können Sie keine URLs mit unbegrenzter Größe
    ansprechen (2.083 Zeichen beim Internet Explorer).

Die Struktur der URL:
---------------------

Um die API anzusprechen, sollte die URL folgendermaßen aufgebaut sein
(Fett markierte Werte sind erforderlich) host.com/icinga-web/web/api/
**TARGET** / **COLUMNS** / FILTER / ORDER / GROUPING / LIMIT /
COUNTFIELD / **OUTPUT\_TYPE**

Die Parameter en Detail:
------------------------

-   TARGET: Welches Feld wird angesprochen, es ist ein einfacher String
    wie host.

-   COLUMNS: Liste der angefragten Spalten, die Syntax muss wie folgt
    aussehen: columns[COL1|COL2|COL3|...]

-   FILTER: Definiert welche Filter im Request verwendet werden. Gültig
    sind AND oder OR Gruppen.

    Der Filter sieht wie folgt aus:

        filters[AND/OR(COLUMN|OPERATOR|VALUE;COLUMN2|OPERATOR2|VALUE2;OR(...),AND]

    Beispiel: Select auf alle Services, deren Name "snmp" enthält, wenn
    sie sich im Status ok oder unknown befinden

    Falsch:

        filters[SERVICE_NAME|like|*smtp*;OR(SERVICE_CURRENT_STATE|=|0;SERVICE_CURRENT_STATE|=|3)]

    Sie benötigen immer eine Schachtelungsebene am Beginn:

    Korrekt:

        filters[AND ( SERVICE_NAME|like|*smtp*;OR ( SERVICE_CURRENT_STATE|=|0;SERVICE_CURRENT_STATE|=|3 ) )]

-   ORDER: Definiert welches Feld für die Ordnung verwendet wird und ob
    eine aufsteigende oder absteigende Sortierung verwendet wird.
    Beispiel: order[COLUMN|ASC or DESC]

-   GROUPING: Definiert ein Gruppierungsfeld: group[COL]

-   LIMIT: Definiert eine Start-Offset und / oder eine Begrenzung:
    limit[START;END ( if needed ) ]

-   COUNTFIELD: Fügt ein INSGESAMT-Feld dem Ergebnis hinzu, welches
    hochgezählt wird (in den meisten Fällen, die id): countColumn=COL

-   OUTPUT: zur Zeit json order xml

Beispiele für GET
-----------------

GET alle Dienste die kritisch oder warning sind und deren Host im Status
ok ist. Absteigend sortiert nach Dienststatus und Hochzählen der
Services. Authentifikation via authkey (hier: APITEST123456). Für die
bessere Lesbarkeit ist die Anfrage in mehrere Zeilen aufgeteilt, XML:

    http://localhost/icinga-web/web/api/service/filter[AND(HOST_CURRENT_STATE|=|0;OR(SERVICE_CURRENT_STATE|=n|1;SERVICE_CURRENT_STATE|=|2))]/
    columns(SERVICE_NAME|HOST_NAME|SERVICE_CURRENT_STATE|HOST_NAME|HOST_CURRENT_STATE|HOSTGROUP_NAME)/
    order(SERVICE_CURRENT_STATE;DESC)/countColumn=SERVICE_ID/authkey=APITEST123456/xml

So sieht die Rückgabe aus:

    <results>
       <result>
           <column name="SERVICE_ID">295</column>
           <column name="SERVICE_OBJECT_ID">139</column>
           <column name="SERVICE_IS_ACTIVE">1</column>
           <column name="SERVICE_INSTANCE_ID">1</column>
           <column name="SERVICE_NAME">MailQ</column>
           <column name="SERVICE_DISPLAY_NAME">MailQ</column>
           <column name="SERVICE_OUTPUT">Error occured:error=1:0:0</column>
           <column name="SERVICE_PERFDATA"></column>
       </result>
       <result>
           <column name="SERVICE_ID">311</column>
           <column name="SERVICE_OBJECT_ID">155</column>
           <column name="SERVICE_IS_ACTIVE">1</column>
           <column name="SERVICE_INSTANCE_ID">1</column>
           <column name="SERVICE_NAME">POP3</column>
           <column name="SERVICE_DISPLAY_NAME">POP3</column>
           <column name="SERVICE_OUTPUT">Verbindungsaufbau abgelehnt</column>
           <column name="SERVICE_PERFDATA"></column>
       </result>
       <total>2</total>
    </results> 

Wenn Sie das Format von xml zu json ändern, bekommen Sie die gleichen
Informationen (plus zusätzliche Informationen für ExtJS, falls Sie sie
nicht benötigen, können Sie diese ignorieren) im json Format:

    {"metaData":
       {"paramNames":{"start":"limit_start","limit":"limit"},
        "totalProperty":"total",
        "root":"result",
        "fields":null},
        "result": [{
           "SERVICE_ID":"295",
           "SERVICE_OBJECT_ID":"139",
           "SERVICE_IS_ACTIVE":"1",
           "SERVICE_INSTANCE_ID":"1",
           "SERVICE_NAME":"MailQ",
           "SERVICE_DISPLAY_NAME":"MailQ",
           "SERVICE_OUTPUT":"Error occured:error=1:0:0",
           "SERVICE_PERFDATA":"" 
       },{
           "SERVICE_ID":"311",
           "SERVICE_OBJECT_ID":"155",
           "SERVICE_IS_ACTIVE":"1",
           "SERVICE_INSTANCE_ID":"1",
           "SERVICE_NAME":"POP3",
           "SERVICE_DISPLAY_NAME":"POP3",
           "SERVICE_OUTPUT":"Verbindungsaufbau abgelehnt",
           "SERVICE_PERFDATA":"" 
       }],
       "success":"true",
       "total":"2" 
    }

> **Note**
>
> Wenn Sie den countField-Parameter nicht verwenden, bekommen Sie eine
> "flat" json-Datei mit diesem Ergebnis.

POST
----

Vorteile:

-   Unbegrenzte Parametergröße für große Anfragen.

-   Ihre verwendeten Parameter erscheinen nicht in der Browser-Historie,
    lediglich die Basis-URL.

-   Leichter in Applikationen zu integrieren

Nachteile:

-   Der POST wird über den Header gesendet, deshalb können Sie den
    Request nicht einfach über das Addressfeld des Browsers absetzen.

Die Parameter en Detail
-----------------------

Der Link entspricht dem GET-Basislink, allerdings mit der Angabe des
Ausgabeformates: Zum Beispiel: host.com/icinga-web/web/api/json.
Folgende Parameter werden unterstützt:

-   'target': Welches Feld wird angesprochen, es ist ein einfacher
    String wie "host"

-   'columns[]': Ein Array von Spalten

    Example:

    columns [0] = SERVICE\_NAME

    columns [1] = SERVICE\_ID

-   'groups[]' : nach diesem Feld gruppieren

-   'filters\_json' : Ein json beschreibender "how to" Filter

    Example:

        [{
           "type": "AND",
           "field": [{
              "type": 'atom',
              "field":  ['SERVICE_NAME'],
              "method": ['like'],
              "value":  ['*pop*']
           },{
              "type": 'OR',
              "field": [{
                  "type": 'atom',
                  "field": ['SERVICE_CURRENT_STATE'],
                  "method": ['>'],
                  "value": [0]
              },{
                  "type": 'atom',
                  "field": ['SERVICE_IS_FLAPPING'],
                  "method": ['='],
                  "value": [1]
              }]
           }]
        }]

-   'order\_col' : Spalte nach der sortiert wird

-   'order\_dir' : Sortierungsreihenfolge (asc oder desc)

-   'limit\_start' : Start-Offset des Records

-   'limit' : Begrenzt das Ergebnis auf x Antworten

-   'countColumn' : Fügt ein INSGESAMT-Feld dem Ergebnis hinzu

Beispiele für POST
------------------

Nehmen wir das Beispiel aus "Beispiel für GET" und benutzen nun eine
POST-Anfrage. Wir werden curl verwenden, so dass das Beispiel auf der
Konsole wiederholt werden kann:

    curl 
    -d target=service 
    -d 'filters_json={"type":"AND","field":[{"type":"atom","field":["HOST_CURRENT_STATE"],"method":["="],"value":[0]},{"type":"OR","field":[{"type":"atom","field":["SERVICE_CURRENT_STATE"],"method":["="],"value":[1]},{"type":"atom","field":["SERVICE_CURRENT_STATE"],"method":["="],"value" : [2] }]}]}' 
    -d columns[0]=SERVICE_NAME 
    -d columns[1]=HOST_NAME 
    -d columns[2]=SERVICE_CURRENT_STATE 
    -d columns[3]=HOST_NAME 
    -d columns[4]=HOST_CURRENT_STATE 
    -d columns[5]=HOSTGROUP_NAME 
    -d 'order=SERVICE_CURRENT_STATE;DESC' 
    -d countColumn=SERVICE_ID  
    -d 'authkey=API123456' 
    http://localhost/icinga-web/web/api/xml 

Dies gibt uns das gleiche Ergebnis zurück, wie zuvor in der GET-Anfrage.

NAME-API
API/NAME-WEB
