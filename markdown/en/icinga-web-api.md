![Icinga](../images/logofullsize.png "Icinga")

11.4. The Icinga Web REST API

[Prev](icinga-api.md) 

Chapter 11. Development

 [Next](ch12.md)

* * * * *

11.4. The Icinga Web REST API
-----------------------------

11.4.1. [Why should I use the API?](icinga-web-api.md#why)

11.4.2. [Features of the Icinga Web REST
API](icinga-web-api.md#features)

11.4.3. [What's the difference between the Icinga API and the Icinga Web
REST API?](icinga-web-api.md#difference)

11.4.4. [Prerequisites](icinga-web-api.md#prerequisites)

11.4.5. [Reference](icinga-web-api.md#reference)

11.4.6. [GET](icinga-web-api.md#get)

11.4.7. [The structure of the URL:](icinga-web-api.md#geturlstructure)

11.4.8. [The Parameters en detail:](icinga-web-api.md#getparamdetails)

11.4.9. [Example for GET](icinga-web-api.md#getexample)

11.4.10. [POST](icinga-web-api.md#post)

11.4.11. [Parameters en detail](icinga-web-api.md#postparamdetail)

11.4.12. [Example for POST](icinga-web-api.md#postexample)

In this document we'll describe the Icinga Web REST API (yes, we know
that the term is not yet completed) which allows you to request your
monitoring information via GET or POST requests (in the future (\>1.2),
you will also be able to send commands via PUT).

### 11.4.1. Why should I use the API?

For most people, the combination Icinga/Icinga Web will fit most needs.
You can watch your monitoring status, act on problems and extend it to
suit your needs (Modules/Cronks).

But sometimes, you have another piece of software that is interested in
some monitoring data (for example:
[Icinga-Chromed-Status](http://www.icinga.org/2010/07/16/icinga-chromed-status-for-google-chromechromium/)).
You could parse the cgi output of Icinga (many programs do that at this
time), but that's not really a high performance solution - and certainly
no fun for the developer. The goal of the REST API is to return the data
you want (and only the data you want) in a standardized,
machine-readable format like JSON or XML

### 11.4.2. Features of the Icinga Web REST API

Currently supported (v1.2):

-   Availability of almost all monitoring fields via GET or POST.

-   Return data as xml or json.

-   AND & OR search filtergroups with unlimited nesting levels (AND)).

-   You choose which columns you want returned, not the API (less
    overhead).

-   Support of limit, offset, order, group by.

-   Return an additional total count field.

-   Authorization via auth\_key in request or cookies.

-   Respects Icinga-web principals (for example, limit to specific
    hostgroups).

Planned in future(\> 1.2):

-   Send commands via PUT

### 11.4.3. What's the difference between the Icinga API and the Icinga Web REST API?

The Icinga API can at this point considered as an internal toolkit to
access the database informations. In fact, the REST API acts on top of
this API and extends it via the HTTP protocol. In the future, the Icinga
API will be merged into Icinga Web.

### 11.4.4. Prerequisites

In order to use the API, you first have to enable the Auth provider for
it. This can be done under
icinga-web/app/modules/AppKit/config/auth.xml.

Change "auth\_enabled" to 'true' in this section:

~~~~ {.programlisting}
<ae:parameter name="auth_key">
    <ae:parameter name="auth_module">AppKit</ae:parameter>
    <ae:parameter name="auth_provider">Auth.Provider.AuthKey</ae:parameter>
    <ae:parameter name="auth_enable">true</ae:parameter>
    <ae:parameter name="auth_authoritative">true</ae:parameter>
</ae:parameter>
~~~~

![[Note]](../images/note.png)

Note

If you edit any \*.xml file you have to clear the cache afterwards!

~~~~ {.programlisting}
rm -f app/cache/config/*.php
~~~~

or

~~~~ {.programlisting}
icinga-web/bin/clearcache.sh
~~~~

Now, in Icinga Web, you have to add a user with API access:

-   Create a new user

-   Choose auth\_key in the Auth\_via field

-   Insert an API key to use

-   Under principals, add the appkit.api.access principal

That's it, now you can start.

### 11.4.5. Reference

So, here are the goodies. In the next few points we'll explain how the
API can be accessed:

### 11.4.6. GET

Advantages:

-   Easy to use, it's just an URL!

-   You always see what parameters have been requested.

Disadvantages:

-   If you request it in a browser your API key could be in the browser
    history.

-   In a browser, you cannot add URLs with unlimited size (2,083
    characters for Internet explorer, for example).

-   Especially when parameters are escaped, the parameter list lacks a
    bit of clarity.

### 11.4.7. The structure of the URL:

To access the api, the URL should look as in the following (italics are
optional, bold ones are required) host.com/icinga-web/web/api/
**TARGET** / **COLUMNS** / FILTER / ORDER / GROUPING / LIMIT /
COUNTFIELD / **OUTPUT\_TYPE**

### 11.4.8. The Parameters en detail:

-   TARGET: Which field to request, is a simple string like host.

-   COLUMNS: A listing of columns to return, must look like this:
    columns[COL1|COL2|COL3|...]

-   FILTER: Defines which filters to use in the request. Must always be
    nested in AND or OR groups.

    The filter itself looks like this:

    ~~~~ {.programlisting}
    filters[AND/OR(COLUMN|OPERATOR|VALUE;COLUMN2|OPERATOR2|VALUE2;OR(...),AND]
    ~~~~

    Example: Select all services with smtp in the name, but only if
    they're ok or unknown

    Wrong:

    ~~~~ {.programlisting}
    filters[SERVICE_NAME|like|*smtp*;OR(SERVICE_CURRENT_STATE|=|0;SERVICE_CURRENT_STATE|=|3)]
    ~~~~

    You always need a nesting level at the beginning, see:

    Correct:

    ~~~~ {.programlisting}
    filters[AND ( SERVICE_NAME|like|*smtp*;OR ( SERVICE_CURRENT_STATE|=|0;SERVICE_CURRENT_STATE|=|3 ) )]
    ~~~~

-   ORDER: Defines which field to use for ordering and if ascending or
    descending ordering should be used. Example: order[COLUMN| ASC or
    DESC]

-   GROUPING: Defines a field to group by: group[COL]

-   LIMIT: Defines a starting offset and/or a limit: limit[START;END (
    if needed ) ]

-   COUNTFIELD: Adds a total field to the result which counts by this
    field (in most cases, the id): countColumn=COL

-   OUTPUT: At this time either json or xml

### 11.4.9. Example for GET

Get all services that are critical or warning, but have a host that is
ok. Sort descending by the service state and count the services.
Authentification is done via authkey (here APITEST123456). The request
is broken into pieces for better readability, XML:

~~~~ {.programlisting}
http://localhost/icinga-web/web/api/service/filter[AND(HOST_CURRENT_STATE|=|0;OR(SERVICE_CURRENT_STATE|=|1;SERVICE_CURRENT_STATE|=|2))]/
columns[SERVICE_NAME|HOST_NAME|SERVICE_CURRENT_STATE|HOST_NAME|HOST_CURRENT_STATE|HOSTGROUP_NAME]/
order(SERVICE_CURRENT_STATE;DESC)/countColumn=SERVICE_ID/authkey=APITEST123456/xml
~~~~

This would return something like:

~~~~ {.programlisting}
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
~~~~

If you change the xml to json you get the same information (plus
additional infos for ExtJS, which you can ignore if you're not using it)
in json format:

~~~~ {.programlisting}
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
       "SERVICE_OUTPUT":"Connection refused",
       "SERVICE_PERFDATA":"" 
   }],
   "success":"true",
   "total":"2" 
}
*CAUTION*: If you're not using the countField parameter, you'll get a flat json with the result.
~~~~

### 11.4.10. POST

Advantages:

-   Unlimited parameter size, as it's made for big requests.

-   Your parameters don't appear in the browser history, only the base
    url.

-   It's easier to implement in applications (ok, that's my opinion :) )

Disadvantages:

-   POST will be send via the header, so you can't request it easily
    from the browser's address field.

### 11.4.11. Parameters en detail

The link is almost the same like the GET baselink, but with the output
type in it: For example, host.com/icinga-web/web/api/json. The following
parameters are supported:

-   'target': The search target, like host

-   'columns[]': An array of columns

    Example:

    columns [0] = SERVICE\_NAME

    columns [1] = SERVICE\_ID

-   'groups[]' : Group by this field

-   'filters\_json' : A json describing how to filter

    Example:

    ~~~~ {.programlisting}
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
    ~~~~

-   'order\_col' : Column to order by

-   'order\_dir' : Order direction (asc oder desc)

-   'limit\_start' : The offset of the records to start

-   'limit' : Limits the result to x responses

-   'countColumn' : Add a total field with this column

### 11.4.12. Example for POST

Let's take the example from Example for GET and use a post request this
time. We're going to use curl, so the example can be repeated from the
console:

~~~~ {.programlisting}
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
~~~~

This would return the same result as the GET request shown before.

* * * * *

  ----------------------------------------- -------------------- -----------------------
  [Prev](icinga-api.md)                   [Up](ch11.md)       [Next](ch12.md)
  11.3. No Icinga API to install anymore    [Home](index.md)    Chapter 12. IDOUtils
  ----------------------------------------- -------------------- -----------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
