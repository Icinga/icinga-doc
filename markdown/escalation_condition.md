Eskalations-Bedingung
=====================

Einleitung
----------

Ab NAME-ICINGA 1.0.1 ist ein Patch implementiert, so dass Sie nun eine
Eskalations-Bedingung definieren können (ähnlich wie escalation\_options
[w,u,c,r]). Eine Eskalation mit einer definierten Bedingung wird nur
dann eskalieren, wenn der aktuelle Zustand eines bestimmten
Hosts/Services mit der angegebenen Bedingung übereinstimmt. Ein
mögliches Anwendungsbeispiel könnte das folgende Szenario sein:

Stellen Sie sich zwei verschiedene Eskalationen für den selben Service
*foo* vor. Eine soll nur dann eskalieren, wenn der Service *bar* OK ist,
die andere soll eskalieren, wenn *bar* CRITICAL oder WARNING ist. Nun
stellen Sie sich vor, dass *foo* der zentrale Service einer Firma ist
und der Administrator sofort reagieren muss, wenn der Service down ist.
*bar* könnte ein Service sein, der angibt, ob der Admin im Büro oder zu
Hause ist. Die Eskalation würde wie folgt reagieren:

-   wenn der Administrator im Büro ist, dann sende zuerst eine e-Mail,
    nach 5 Minuten dann eine SMS

-   wenn der Administrator zu Hause ist, dann sende zuerst eine SMS und
    nach 30 Minuten eine zweite SMS an den Administrator sowie eine SMS
    an den Abteilungsleiter

Dies kann erreicht werden, ohne Icinga neu zu starten bzw. die
Konfiguration neu zu laden.

Syntax
------

Die Direktive escalation\_condition ist komplett optional und kann
sowohl für Host- als auch für Service-Eskalationen definiert werden. Die
Syntax lautet:

`escalation_condition <condition> ( [ & / | ] <condition> )`

wobei \<condition\> entweder `host hostname = [u,d,o]` oder
`service hostname.service_description =
    [w,u,c,o]` ist.

Wie Sie sehen können, akzeptiert escalation\_condition eine Liste von
einer oder mehreren Bedingungen, die durch "&" (logisches UND) oder "|"
(logisches ODER) getrennt sind. Die Bedeutungen von [w,u,c,o,d]
unterscheiden sich geringfügig von denen, die bei escalation\_options
benutzt werden:

-   w = WARNING

-   u = UNKNOWN

-   c = CRITICAL

-   o = OK für Services oder UP für hosts (man könnte an ONLINE denken)

-   d = Down für hosts

Beispiel
--------

    define serviceescalation {
       host_name               localhost
       service_description     HTTP
       first_notification      5
       contact_groups          admins, managers
       escalation_condition    host linux=d | service linux.SSH=w,c
       }

Diese Beispiel-Eskalation würde eskalieren, wenn der HOST 'linux' DOWN
ist oder der Service 'linux.SSH' WARNING oder CRITICAL.

[ Thanks to: Vitali Voroth, DECOIT GmbH \* http://www.decoit.de ]

Escalations
Escalation condition
