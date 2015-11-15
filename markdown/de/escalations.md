![Icinga](../images/logofullsize.png "Icinga")

7.9. Benachrichtigungseskalationen

[Zurück](flapping.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](escalation_condition.md)

* * * * *

7.9. Benachrichtigungseskalationen
----------------------------------

7.9.1. [Einführung](escalations.md#introduction)

7.9.2. [Wann werden Benachrichtigungen
eskaliert?](escalations.md#notificationsescalated)

7.9.3. [Kontaktgruppen](escalations.md#contactgroups)

7.9.4. [Überlappende
Eskalationsbereiche](escalations.md#overlappingranges)

7.9.5.
[Erholungsbenachrichtigungen](escalations.md#recoverynotifications)

7.9.6.
[Benachrichtigungsintervalle](escalations.md#notificationintervals)

7.9.7.
[Zeitfenster-Beschränkungen](escalations.md#timeperiodrestrictions)

7.9.8. [Status-Beschränkungen](escalations.md#staterestrictions)

### 7.9.1. Einführung

![](../images/objects-contacts.png)

Icinga unterstützt optionale Eskalation von Kontakt-Benachrichtigungen
für Hosts und Services. Eskalationen von Host- oder
Service-Benachrichtigungen werden erreichen durch das Definieren von
[Host-Eskalationen](objectdefinitions.md#objectdefinitions-hostescalation)
bzw.
[Service-Eskalationen](objectdefinitions.md#objectdefinitions-serviceescalation)
in Ihrer/Ihren
[Objekt-Konfigurationsdatei(en)](configobject.md "3.3. Überblick Objektkonfiguration").

![](../images/note.gif) Anmerkung: Das Beispiel, das wir unten zeigen,
benutzt Service-Eskalationsdefinitionen, aber Host-Eskalationen arbeiten
genau so. Außer, dass sie für Hosts sind statt für Services. :-)

### 7.9.2. Wann werden Benachrichtigungen eskaliert?

Benachrichtigungen werden eskaliert, *wenn, und nur wenn* eine oder
mehrere Eskalationsdefinitionen mit der aktuellen Benachrichtigung
übereinstimmen, die gerade versandt wird. Wenn eine Host- oder
Service-Benachrichtigung *keine* gültige Eskalationsdefinition hat, die
auf sie zutrifft, dann wird die Benachrichtigung an die Kontaktgruppe(n)
verschickt, die in der Hostgroup- oder Service-Definition angegeben
wurde(n). Lassen Sie uns das untenstehende Beispiel betrachten:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   90
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       10
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

Beachten Sie, dass es "Lücken" in den
Benachrichtigungs-Eskalationsdefinitionen gibt. Im Besonderen werden
weder die Benachrichtigungen 1 und 2 von den Eskalationen behandelt noch
die Benachrichtigungen über 10. Für die ersten beiden und die
Benachrichtigungen über 10 werden die *Default*-Kontaktgruppen aus der
Service-Definition benutzt. Bei allen Beispielen, die wir benutzen,
nehmen wir an, dass die Default-Kontaktgruppe für die Service-Definition
*nt-admins* lautet.

### 7.9.3. Kontaktgruppen

Beim Definieren von Benachrichtigungs-Eskalationen ist es wichtig zu
wissen, dass alle Kontaktgruppen, die Mitglieder von "niedrigeren"
Eskalationen (d.h. mit niedrigeren Benachrichtigungsnummern-Bereichen)
sind, auch in den "höheren" Eskalationsdefinitionen enthalten sein
sollen. Das sollte passieren, um sicherzustellen, dass jeder, der über
ein Problem informiert wird, *weiterhin* informiert wird, wenn ein
Problem eskaliert. Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   90
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

Die erste (oder "niedrigste") Eskalationsstufe umfasst die *nt-admins*
und die *managers*-Kontaktgruppe. Die letzte (oder "höchste") umfasst
die *nt-admins*, *managers* und *everyone*-Kontaktgruppen. Beachten Sie,
dass die *nt-admins*-Kontaktgruppe in beiden Eskalationsdefinitionen
enthalten ist. Dies passiert, damit sie weiterhin per Pager informiert
werden, falls noch Probleme existieren, nachdem die ersten beiden
Service-Benachrichtigungen versandt wurden. Die *managers*-Kontaktgruppe
erscheint zuerst in der "niedrigen" Eskalationsdefinition - sie wird das
erste Mal benachrichtigt, wenn die dritte Benachrichtigung versandt
wird. Wir möchten, dass die *managers*-Gruppe weiterhin informiert wird,
wenn das Problem nach der fünften Benachrichtigung noch existiert, also
sind sie in der "höheren" Eskalationsdefinition enthalten.

### 7.9.4. Überlappende Eskalationsbereiche

Benachrichtigungs-Eskalationsdefinitionen können
Benachrichtigungs-Bereiche haben, die überlappen. Nehmen Sie das
folgende Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   20
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   30
        contact_groups          on-call-support
        }
~~~~

Im obigen Beispiel:

-   die *nt-admins*- und *managers*-Kontaktgruppen werden bei der
    dritten Benachrichtung informiert

-   alle drei Kontaktgruppen werden bei der vierten und fünften
    Benachrichtigung informiert

-   nur die *on-call-support*-Kontaktgruppe wird bei der sechsten (und
    höheren) Benachrichtigung informiert

### 7.9.5. Erholungsbenachrichtigungen

Erholungsbenachrichtigungen unterscheiden sich geringfügig von
Problembenachrichtigungen, wenn es um Eskalationen geht. Nehmen Sie das
folgende Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   20
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   30
        contact_groups          on-call-support
        }
~~~~

Falls nach drei Problembenachrichtigungen eine Erholungsbenachrichtigung
für den Service versandt wird: wer wird informiert? Die Erholung ist
eigentlich die vierte Benachrichtigung, die versandt wird. Allerdings
ist der Eskalationscode intelligent genug zu erkennen, dass nur die
Leute, die die dritte Problembenachrichtigung erhalten haben, auch über
die Erholung informiert werden. In diesem Fall würden die *nt-admins*-
und *managers*-Kontaktgruppen über die Erholung informiert werden.

### 7.9.6. Benachrichtigungsintervalle

Sie können die Häufigkeit, mit der eskalierte Benachrichtigungen für
einen bestimmten Host oder Service versandt werden, mit der
*notification\_interval*-Option in der Hostgroup- oder
Service-Eskalations-Definition ändern. Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

In diesem Beispiel sehen wir, dass das
Default-Benachrichtigungsintervall für den Service auf 240 Minuten
eingestellt ist (das ist der Wert in der Service-Definition). Wenn die
Service-Benachrichtigung bei der dritten, vierten und fünften
Benachrichtigung eskaliert, wird ein Intervall von 45 Minuten zwischen
den Benachrichtigungen genutzt. Bei der sechsten und folgenden
Benachrichtigungen ist das Benachrichtigungsintervall 60 Minuten, wie in
der zweiten Eskalationsdefinition angegeben.

Nachdem es möglich ist, überlappende Eskalationsdefinitonen für eine
bestimmte Hostgruppe oder einen Service zu haben, und der Tatsache, dass
ein Host Mitglied von mehreren Hostgruppen sein kann, muss Icinga eine
Entscheidung treffen, was zu tun ist, wenn die
Benachrichtigungs-Intervalle von Eskalationsdefinitionen überlappen. In
jedem Fall, wenn es mehrere gültige Eskalationsdefinitionen für eine
bestimmte Benachrichtigung gibt, wird Icinga das kleinste
Benachrichtigungs-Intervall wählen. Nehmen Sie das folgende Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

Wir sehen, dass die beiden Eskalationsdefinitionen bei der vierten und
fünften Benachrichtigung überlappen. Bei diesen Benachrichtigungen wird
Icinga ein Benachrichtigungsintervall von 45 Minuten benutzen, weil dies
das kleinste Intervall aller vorhandenen gültigen
Eskalationsdefinitionen für diese Benachrichtigungen ist.

Eine letzte Anmerkung zu Benachrichtigungsintervallen, die Intervalle
von 0 behandelt. Ein Intervall von 0 bedeutet, dass Icinga lediglich
eine Benachrichtigung für die erste gültige Benachrichtigung während der
Eskalationsdefinition versendet. Alle folgenden Benachrichtigungen für
die Hostgruppe oder den Service werden unterdrückt. Nehmen Sie dieses
Beispiel:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       6
        notification_interval   0
        contact_groups          nt-admins,managers,everyone
        }
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      7
        last_notification       0
        notification_interval   30
        contact_groups          nt-admins,managers
        }
~~~~

In dem obigen Beispiel werden maximal vier Problembenachrichtigungen zu
diesem Service versandt. Das ist so, weil das Benachrichtigungsintervall
0 in der zweiten Eskalationsdefinition angibt, dass nur eine
Benachrichtigung versandt werden soll (beginnend mit der vierten und
diese einschließend) und folgende Benachrichtigungen unterdrückt werden
sollen. Deshalb hat die dritte Eskalationsdefinition keinerlei
Auswirkungen, denn es wird nie mehr als vier Benachrichtigungen geben.

### 7.9.7. Zeitfenster-Beschränkungen

Unter normalen Umständen können Eskalationen zu jeder Zeit benutzt
werden, zu der Benachrichtigungen für einen Host oder Service versandt
werden. Dieses "Benachrichtigungs-Zeitfenster" ist festgelegt durch die
*notification\_period*-Direktive in der
[Host](objectdefinitions.md#objectdefinitions-host)- oder
[Service](objectdefinitions.md#objectdefinitions-service)-Definition.

Sie können optional Eskalationen durch die
*escalation\_period*-Direktive in der Host- oder
Service-Eskalationsdefinition beschränken, so dass sie lediglich während
bestimmter Zeitspannen benutzt werden. Wenn Sie die
*escalation\_period*-Direktive benutzen, um eine
[Zeitspanne](timeperiods.md "5.9. Zeitfenster") zu definieren, während
der die Eskalation benutzt werden kann, wird sie nur zu dieser Zeit
benutzt. Wenn Sie keine *escalation\_period*-Direktive angeben, kann die
Eskalation zu jeder Zeit innerhalb des "Benachrichtigungs-Zeitfensters"
des Hosts oder Service benutzt werden.

![](../images/note.gif) Anmerkung: eskalierte Benachrichtigungen
unterliegen weiterhin den normalen Zeitbeschränkungen, die durch die
*notification\_period*-Direktive in einer Host- oder Service-Definition
festgelegt wurden, so dass die Zeitspanne, die Sie in einer
Eskalationsdefinition angeben, ein Teil des größeren
"Benachrichtigungs-Zeitfensters" sein sollte.

### 7.9.8. Status-Beschränkungen

Wenn Sie die Eskalationsdefinition beschränken wollen, damit sie nur
benutzt wird, während sich der Host oder Service in einem bestimmten
Zustand befindet, so können Sie die *escalation\_options*-Direktive in
der Host- oder Service-Eskalationsdefinition benutzen. Wenn Sie die
*escalation\_options*-Direktive nicht verwenden, werden die Eskalationen
in jedem Status der Hosts oder Services benutzt.

* * * * *

  ---------------------------------------------------- -------------------------- --------------------------------------
  [Zurück](flapping.md)                              [Nach oben](ch07.md)      [Weiter](escalation_condition.md)
  7.8. Erkennung und Behandlung von Status-Flattern    [Zum Anfang](index.md)    7.10. Eskalations-Bedingung
  ---------------------------------------------------- -------------------------- --------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
