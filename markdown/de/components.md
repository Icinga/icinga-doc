![Icinga](../images/logofullsize.png "Icinga")

12.2. Komponenten

[Zurück](db_intro.md) 

Kapitel 12. IDOUtils

 [Weiter](configido.md)

* * * * *

12.2. Komponenten
-----------------

12.2.1. [Überblick](components.md#overview)

12.2.2. [IDOMOD](components.md#idomod)

12.2.3. [LOG2IDO](components.md#log2ido)

12.2.4. [FILE2SOCK](components.md#file2sock)

12.2.5. [IDO2DB](components.md#ido2db)

### 12.2.1. Überblick

Es gibt vier Hauptkomponenten, aus denen die IDO-Utilities bestehen:

1.  IDOMOD-Event-Broker-Modul

2.  LOG2IDO-Utility

3.  FILE2SOCK-Utility

4.  IDO2DB-Daemon

Jede Komponente wird auf den folgenden Seiten genauer beschrieben.

### 12.2.2. IDOMOD

Die IDO-Utilities enthalten ein Icinga-Event-Broker-Modul (IDOMOD.O),
das die Daten des Icinga-Daemon exportiert.

Wenn wir annehmen, dass Icinga mit aktivierten Event-Broker-Modul
kompiliert wurde (das ist der Default), dann können Sie Icinga
konfigurieren, dass das IDOMOD-Modul während der Laufzeit geladen wird.
Sobald das Modul vom Icinga-Daemon geladen wird, kann es auf die Daten
und die Logik des laufenden Icinga-Prozesses zugreifen.

**Abbildung 12.5. Geladenes IDOMOD-Event-Broker-Modul**

![Geladenes IDOMOD-Event-Broker-Modul](../images/fig5.png)

\

Das IDOMOD-Modul wurde konzipiert, um sowohl Konfigurationsdaten als
auch Informationen über verschiedene Laufzeitereignisse, die während des
Überwachungsprozesses auftreten, aus dem Icinga-Daemon zu exportieren.
Das Modul kann diese Daten an eine normale Datei, einen Unix-Domain-
oder einen TCP-Socket senden.

**Abbildung 12.6. IDOMOD-Möglichkeiten**

![IDOMOD-Möglichkeiten](../images/fig6.png)

\

Das IDOMOD-Modul schreibt die Daten in einem Format, dass der
IDO2DB-Daemon (wird später beschrieben) verstehen kann.

Falls das IDOMOD-Modul die Daten in eine Datei schreibt, dann können Sie
es so konfigurieren, die Ausgabedatei regelmäßig rotiert und/oder mit
einem vordefinierten Icinga-Befehl verarbeitet wird. Dies kann nützlich
sein, wenn Sie die Ausgabedatei zu einer anderen Maschine übertragen
möchten (mit SSH, etc.) oder den Inhalt mit dem FILE2SOCK-Utility (wird
später beschrieben) an den IDO2DB-Daemon senden möchten.

Falls dasIDOMOD-Modul die Daten an einen TCP- oder Unix-Domain-Socket
schickt, dann gibt es ein wenig Schutz gegen Verbindungsabbrüche. Das
Modul wird versuchen, die Ausgaben zwischenzuspeichern, bis es sich
(erneut) mit dem Socket verbinden kann. Dies ist hilfreich, wenn der
Prozess, der den Socket anlegt bzw. darauf lauscht, (erneut) gestartet
werden muss.

### 12.2.3. LOG2IDO

Das LOG2IDO-Utility wurde entwickelt, damit Sie über den IDO2DB-Daemon
([wird später beschrieben](components.md#ido2db "12.2.5. IDO2DB"))
historische Datei aus Icinga-, Nagios- und NetSaint-Log-Dateien in eine
Datenbank importieren können. Das Utility funktioniert, indem
historische Log-Dateidaten in einem Format, das der IDO2DB-Daemon
versteht, an eine normale Datei, ein Unix-Domain- oder ein TCP-Socket
geschickt werden. Der IDO2DB-Daemon kann dann genutzt werden, um diese
Ausgaben zu verarbeiten und die Informationen in einer Datenbank zu
speichern.

**Abbildung 12.7. LOG2IDO-Utility**

![LOG2IDO-Utility](../images/fig7.png)

\

### 12.2.4. FILE2SOCK

Das FILE2SOCK-Utility ist ziemlich simpel. Es liest Eingaben von einer
normalen Daten (oder STDIN) und schickt diese Daten entweder an einen
Unix-Domain- oder einen TCP-Socket. Die gelesenen Datei werden nicht
bearbeitet, bevor sie an den Socket geschickt werden.

**Abbildung 12.8. FILE2SOCK-Utility**

![FILE2SOCK-Utility](../images/fig8.png)

\

Dieses Utility ist nützlich, wenn Sie die Ausgaben den
IDOMOD-Event-Broker-Moduls und/oder des LOG2IDO-Utilitys in eine normale
Datei umleiten. Sobald diese Komponenten ihre Ausgaben in eine Datei
geschrieben haben, können Sie das FILE2SOCK-Utility nutzen, um den
Inhalt der Datei an den TCP- oder den Unix-Domain-Socket des
IDO2DB-Daemons zu schicken.

### 12.2.5. IDO2DB

Das IDO2DB-Utility ist gedacht, um die Datenausgaben der IDOMOD- und
LOG2IDO-Komponenten zu nehmen und in einer MySQL, Oracle- oder
PostgreSQL-Datenbank zu speichern.

Beim Start des IDO2DB-Daemons legt dieser entweder einen TCP- oder einen
Unix-Domain-Socket an und warten auf Client, die sich verbinden. IDO2DB
kann entweder als einzelner, als Multiprozess-Daemon oder unter INETD
laufen (wenn ein TCP-Socket verwendet wird).

**Abbildung 12.9. IDO2DB-Daemon**

![IDO2DB-Daemon](../images/fig9.png)

\

Mehrere Clients können sich mit dem Socket des IDO2DB-Daemons verbinden
und gleichzeitig Daten übertragen. Für jeden neuen Client, der sich
verbindet, wird ein separater IDO2DB-Prozess erzeugt. Die Daten jedes
Clients werden gelesen und in einer benutzerdefinierten Datenbank für
spätere Abfragen und Verarbeitung gespeichert.

**Abbildung 12.10. IDO2DB mit mehreren Clients**

![IDO2DB mit mehreren Clients](../images/fig10.png)

\

Der IDO2DB-Daemon unterstützt im Moment MySQL-, Oracle- und
PostgreSQL-Datenbanken.

* * * * *

  -------------------------- -------------------------- -----------------------------------
  [Zurück](db_intro.md)    [Nach oben](ch12.md)      [Weiter](configido.md)
  12.1. Einleitung           [Zum Anfang](index.md)    12.3. Konfiguration der IDOUtils
  -------------------------- -------------------------- -----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
