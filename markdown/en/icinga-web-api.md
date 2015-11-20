[Prev](icinga-api.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch12.md)

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
no fun for the developer. The goal of the REST API is to return the data
you want (and only the data you want) in a standardized,
machine-readable format like JSON or XML

### 11.4.2. Features of the Icinga Web REST API

Currently supported (v1.2):









Planned in future(\> 1.2):


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

<pre><code>
<ae:parameter name="auth_key">
</ae:parameter>
</code></pre>

![[Note]](../images/note.png)

Note

If you edit any \*.xml file you have to clear the cache afterwards!

<pre><code>
rm -f app/cache/config/*.php
</code></pre>

or

<pre><code>
icinga-web/bin/clearcache.sh
</code></pre>

Now, in Icinga Web, you have to add a user with API access:





That's it, now you can start.

### 11.4.5. Reference

So, here are the goodies. In the next few points we'll explain how the
API can be accessed:

### 11.4.6. GET

Advantages:



Disadvantages:




### 11.4.7. The structure of the URL:

To access the api, the URL should look as in the following (italics are
optional, bold ones are required) host.com/icinga-web/web/api/
**TARGET** / **COLUMNS** / FILTER / ORDER / GROUPING / LIMIT /
COUNTFIELD / **OUTPUT\_TYPE**

### 11.4.8. The Parameters en detail:

















### 11.4.9. Example for GET

Get all services that are critical or warning, but have a host that is
ok. Sort descending by the service state and count the services.
Authentification is done via authkey (here APITEST123456). The request
is broken into pieces for better readability, XML:

<pre><code>
http://localhost/icinga-web/web/api/service/filter[AND(HOST_CURRENT_STATE|=|0;OR(SERVICE_CURRENT_STATE|=|1;SERVICE_CURRENT_STATE|=|2))]/
columns[SERVICE_NAME|HOST_NAME|SERVICE_CURRENT_STATE|HOST_NAME|HOST_CURRENT_STATE|HOSTGROUP_NAME]/
order(SERVICE_CURRENT_STATE;DESC)/countColumn=SERVICE_ID/authkey=APITEST123456/xml
</code></pre>

This would return something like:

<pre><code>
<results>
</code></pre>

If you change the xml to json you get the same information (plus
additional infos for ExtJS, which you can ignore if you're not using it)
in json format:

<pre><code>
{"metaData":
}
*CAUTION*: If you're not using the countField parameter, you'll get a flat json with the result.
</code></pre>

### 11.4.10. POST

Advantages:




Disadvantages:


### 11.4.11. Parameters en detail

The link is almost the same like the GET baselink, but with the output
type in it: For example, host.com/icinga-web/web/api/json. The following
parameters are supported:















### 11.4.12. Example for POST

Let's take the example from Example for GET and use a post request this
time. We're going to use curl, so the example can be repeated from the
console:

<pre><code>
</code></pre>

This would return the same result as the GET request shown before.

* * * * *

[Prev](icinga-api.md) | [Up](ch11.md) | [Next](ch12.md)

11.3. No Icinga API to install anymore  |<=== [Index](index.md) ===>|  Chapter 12. IDOUtils

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
