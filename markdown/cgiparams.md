Informationen zu den CGI-Parametern
===================================

Einführung
----------

Das Menü auf der linken Seite des klassischen Web-Interface enthält
Eintrage, die einen schnellen Zugriff auf die Informationen bieten, die
die meisten Leute benötigen. Sie können diese Parameter ändern oder auch
andere Optionen wählen. Einige CGIs benötigen einen Objekttyp ("host",
"hostgroup", "service" oder "servicegroup"), oftmals gefolgt von einer
oder mehreren Optionen. Der beste Weg ist es, einen Blick auf die
existierenden URLs zu werden und sie Ihren Bedürfnissen anzupassen.

Nachfolgend finden Sie eine Tabelle mit den Parametern und den CGIs, die
sie anbieten. Die Namen der CGIs sind abgekürzt (damit die Tabelle nicht
so breit wird). Eine Erklärung der Abkürzungen zusammen mit einem
Hinweis auf den Source-Code finden Sie [hier](#cgiparams_abbrev).

Nach dieser Tabelle folgt eine Erklärung der Parameter (in Bearbeitung).

Executing CGIs on the command line
----------------------------------

Anstelle ihres Browsers können sie die CGIs auch auf der Kommandozeile
ausführen, und deren Ergebnisse mit anderen Tools verarbeiten. Um einen
ersten Eindruck zu erhalten, wechseln Sie in den Ordner mit den \*.cgi
Dateien (z.B. `/usr/local/icinga/sbin`), setzen Sie einige
Umgebungsvariablen und führen Sie eines der CGIs aus.

     $> export REMOTE_USER=icingaadmin   # or choose the appropriate user
     $> export REQUEST_METHOD='GET'      # if you enter queries
     $> export QUERY_STRING='host=all'   # see the tables below

     $> ./status.cgi

Abhängig von der Anzahl von Hosts wird diese viele HTML Zeilen liefern.
Für die meisten Leute ist es schwierig, dazwischen die Informationen
herauszulesen, also sollten Sie"&csvoutput" oder "&jsonoutput" zum
QUERY\_STRING mit anderen Argumenten hinzufügen.

Setzen Sie QUERY\_STRING wie erforderlich und führen Sie das CGI aus.

Falls Sie eine Umgebungsvariable vergessen haben, werden Sie folgende
Zeilen sehen:

     $> ./status.cgi
     getcgivars(): Unsupported REQUEST_METHOD -> ''

     I'm guessing you're trying to execute the CGI from a command line.
     In order to do that, you need to set the REQUEST_METHOD environment
     variable to either "GET", "HEAD", or "POST". When using the
     GET and HEAD methods, arguments can be passed to the CGI
     by setting the "QUERY_STRING" environment variable. If you're
     using the POST method, data is read from standard input. Also of
     note: if you've enabled authentication in the CGIs, you must set the
     "REMOTE_USER" environment variable to be the name of the user you're
     "authenticated" as.

Mehr Beispiele finden Sie [here](#cgicmd).

Properties / Statustypes
------------------------

Sie können `status.cgi` benutzen, um Objekte mit einem oder mehreren
"Statustypen" (hoststatustype / servicestatustype) und mit bestimmten
Eigenschaften (hostprops / serviceprops) anzuzeigen. Jeder Statustyp /
jede Eigenschaft wird durch eine Zahl identifiziert (die
[hier](#cgiparams-filter) und [hier](#cgiparams-statustypes) am Ende des
Abschnitts zu finden sind). Bitte addieren Sie die entsprechenden Zahlen
und setzen die resultierende Summe jeweils bei der Option ein.

Das Beispiel zeigt alle Services im nicht-OK-Zustand, die weder in einer
Ausfallzeit (downtime) sind noch bestätigt (acknowledged) wurden:

     http://localhost/icinga/cgi-bin/status.cgi?host=all&servicestatustypes=29&serviceprops=10

"29" enthält auch "PENDING" Services (die seit dem Start noch nicht
geprüft wurden).

> **Note**
>
> Bitte beachten Sie, dass "properties" nur die Objekte anzeigt, die
> ALLE Bedingungen gleichzeitig erfüllen, während bei "statustypes" nur
> EINE Bedingung erfüllt sein muss (kann).

Matrix Parameter / CGIs
-----------------------

  Parameter                      avail   cmd   config   ext   hgram   hist   notif   out   log   status   map   sum   tac   trends
  ------------------------------ ------- ----- -------- ----- ------- ------ ------- ----- ----- -------- ----- ----- ----- --------
  ahas                                   X                                                                                  
  alerttypes                                                                                                    X           
  assumeinitialstates            X                                                                                          X
  assumestateretention           X                            X                                                             X
  assumestatesduringnotrunning   X                                                                                          X
  attr [4]                               X                                                                                  
  backtrack                      X                            X                                                             X
  breakdown                                                   X                                                             
  broadcast\_notification                X                                                                                  
  childoptions                           X                                                                                  
  cmd\_mod                               X                                                                                  
  cmd\_typ                               X                                                                                  
  columns                                                                                        X                          
  com\_author                            X                                                                                  
  com\_data                              X                                                                                  
  com\_id                                X                                                                                  
  contact                                                                    X                                              
  createimage                                                 X                                                             
  csvoutput                      X             [2]      [2]                  [2]     [2]   [2]   [2]            [2]         
  displaytype                                                                                                   X           
  down\_id                               X                                                                                  
  eday                           X                            X                                                 X           X
  ehour                          X                            X                                                 X           X
  embedded                       X                      X     X       X      X       X     X     X        X     X     X     
  emin                           X                            X                                                 X           X
  emon                           X                            X                                                 X           X
  end\_time                              X                                   X[5]                                           
  esec                           X                            X                                                 X           X
  eyear                          X                            X                                                 X           X
  fixed                                  X                                                                                  
  force\_check                           X                                                                                  
  force\_notification                    X                                                                                  
  full\_log\_entries             X                                                                                          
  get\_date\_parts               X                                                                                          
  graphevents                                                 X                                                             
  graphstatetypes                                             X                                                             
  host                           X       X              X     X       X      X                   X              X           X
  hostgroup                      X       X              X             X[5]   X[5]                X              X           
  hostprops                                                                                      X                          
  hoststates                                                                                                    X           
  hoststatustypes                                                                                X                          
  hours                                  X                                                                                  
  includesoftstates              X                                                                                          
  initialassumedhoststate        X                                                                                          X
  initialassumedservicestate     X                                                                                          X
  initialstateslogged                                         X                                                             
  input                                                       X                                                             X
  item\_name [5]                               X                                                                            X
  jsonoutput [2][3]              X             X        X                    X       X     X     X              X     X     
  limit [5]                                    X        X             X      X             X     X              X           
  minutes                                X                                                                                  
  navbarsearch                                                                                   X                          
  newstatesonly                                               X                                                             
  nodowntime                                                          X                                                     
  noflapping                                                          X                                                     
  nofrills                                                            X                    X                                
  noheader                       X                      X     X       X      X       X     X     X        X     X     X     X
  not\_dly                               X                                                                                  
  notimebreaks                                                        X                    X                                
  nosystem                                                            X                                                     
  oldestfirst [6]                                                                          X                                
  order [5]                                                           X      X                                              
  paused [7]                                            X                            X           X        X           X     
  performance\_data                      X                                                                                  
  persistent                             X                                                                                  
  plugin\_output                         X                                                                                  
  plugin\_state                          X                                                                                  
  ptc                                    X                                                                                  
  report                                                                                                        X           
  report\_type                   X                                                                                          
  rpttimeperiod                  X                                                                                          
  sched\_dly                             X                                                                                  
  sday                           X                            X                                                 X           
  search\_string [5]                           X                                                 X                          
  send\_notification                     X                                                                                  
  service                        X       X              X     X       X      X                                              X
  servicefilter                                                                                  X                          
  servicegroup                   X       X              X             X[5]   X[5]                X              X           
  serviceprops                                                                                   X                          
  servicestates                                                                                                 X           
  servicestatustypes                                                                             X                          
  service\_divisor                                                                   X                                      
  shour                          X                            X                                                 X           
  showscheduleddowntime          X                                                                                          
  show\_log\_entries             X                                                                                          
  smin                           X                            X                                                 X           
  smon                           X                            X                                                 X           
  sortoption                                            X                                        X                          
  sorttype                                              X                                        X                          
  ssec                           X                            X                                                 X           
  standardreport                                                                                                X           
  start [5]                                    X        X             X      X             X     X                          
  start\_time                            X                                   X[5]                                           
  statetype                                                           X                                                     
  statetypes                                                                                                    X           
  sticky\_ack                            X                                                                                  
  style                                                                                          X                          
  syear                          X                            X                                                 X           X
  t1                             X                            X                                                 X           X
  t2                             X                            X                                                 X           X
  timeperiod                     X                            X              X[5]                               X           X
  trigger                                X                                                                                  
  ts\_end [5]                                                         X      X                                              
  ts\_start [5]                                                       X      X                                              
  type                                         X        X             X      X                                              

Einzelheiten zu den Parametern
------------------------------

Mehr Informationen zu den einzelnen Parametern finden Sie nachfolgend.
Für ein tiefergehendes Verständnis sollten Sie einen Blick auf den
Source-Code werfen.

  Parameter                                                                 Beschreibung                                                                                                                                                Mögl. Werte                                                                                                                                                              Beispiel                                                       Anmerkungen
  ------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  [ahas](#cgiparams-ahas)                                                   Der Befehl beeinflusst den Host und seine Services                                                                                                                                                                                                                                                                                   ahas                                                           
  [alerttypes](#cgiparams-alerttypes)                                       Host- und/oder Service-Alarme anzeigen                                                                                                                      1=Host-Alarme; 2=Service-Alarme; 3=Host- und Service-Alarme                                                                                                              alerttypes=3                                                   
  [assumeinitialstates](#cgiparams-assumeinitialstates)                                                                                                                                                                                 yes; no                                                                                                                                                                                                                                 
  [assumestatesduringnotrunning](#cgiparams-assumestatesduringnotrunning)                                                                                                                                                               yes; no                                                                                                                                                                                                                                 
  [assumestateretention](#cgiparams-assumestateretention)                                                                                                                                                                               yes; no                                                                                                                                                                                                                                 
  [attr](#cgiparams-attr)                                                   Zurücksetzen der modifizierten Attribute und keine Veränderungen mehr zulassen                                                                              0                                                                                                                                                                        attr=0                                                         siehe [4]
  [backtrack](#cgiparams-backtrack)                                         Wieviele Archiv-Log-Dateien sollen durchsucht werden, um den initialen Zustand zu ermitteln                                                                 0-n                                                                                                                                                                      backtrack=1                                                    Bitte beachten Sie, dass die Verarbeitung der Archivdateien eine Weile dauern kann
  [breakdown](#cgiparams-breakdown)                                         Aufteilen der Daten nach Zeitbereich                                                                                                                        0=monatlich; 1=Tag des Monats; 2=Tag der Woche; 3=stündlich                                                                                                              breakdown=2                                                    
  [broadcast\_notification](#cgiparams-broadcast_notification)              Benachrichtigung an alle Kontakte versenden ("non-escalated" und "escalated")                                                                                                                                                                                                                                                        broadcast\_notification                                        
  [childoptions](#cgiparams-childoptions)                                   Ausfallzeitbehandlung für abhängige Hosts                                                                                                                   0=ohne Berücksichtigung von abh. Hosts; 1="triggered downtime" für abh. Hosts planen; 2="non-triggered downtime" für abh. Hosts planen                                   childoptions=1                                                 
  [cmd\_mod](#cgiparams-cmd_mod)                                            Command mode                                                                                                                                                1, 2                                                                                                                                                                     cmd\_mod=2                                                     1 zeigt das Bestaetigungsformular; 2 schickt direkt ab
  [cmd\_typ](#cgiparams-cmd_typ)                                            Command type                                                                                                                                                0 - 169, 999                                                                                                                                                             cmd\_typ=160                                                   Einzelheiten siehe .../include/common.h
  [columns](#cgiparams-columns)                                             Anzahl von Übersichtsspalten                                                                                                                                \>= 1                                                                                                                                                                                                                                   Default ist 3
  [com\_author](#cgiparams-com_author)                                      Autor des Kommentars                                                                                                                                        ein gültiger Benutzer                                                                                                                                                    com\_author=icingaadmin                                        Kann ggf. von der Einstellung von "lock\_author\_names" in cgi.cfg abhängen
  [com\_data](#cgiparams-com_data)                                          Inhalt des Kommentars                                                                                                                                       eine Zeichenkette (urlencoded)                                                                                                                                                                                                          
  [com\_id](#cgiparams-com_id)                                              Id des Kommentars                                                                                                                                                                                                                                                                                                                                                                                   
  [contact](#cgiparams-contact)                                             Ein gültiger Kontakt als Mail-Empfänger                                                                                                                                                                                                                                                                                                                                                             
  [createimage](#cgiparams-createimage)                                                                                                                                                                                                                                                                                                                                                                          createimage                                                    
  [csvoutput](#cgiparams-csvoutput)                                         Ob die Ausgabe im CSV-Format sein soll                                                                                                                      yes;no                                                                                                                                                                                                                                  Diese Option setzt automatisch "noheader". In fast allen CGIs verfügbar (siehe [2])
  [displaytype](#cgiparams-displaytype)                                     Typ der Alarmauswertung                                                                                                                                     1=recent alerts; 2=alert totals; 3=top alerts; 4=hostgroup alert totals; 5=host alert totals; 6=service alert totals; 7=servicegroup alert totals                                                                                       
  [down\_id](#cgiparams-down_id)                                            ID der Ausfallzeit                                                                                                                                                                                                                                                                                                                                                                                  
  [eday](#cgiparams-eday)                                                   Ende des maßgeschneiderten Zeitfensters (Tag)                                                                                                                                                                                                                                                                                                                                                       Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [ehour](#cgiparams-ehour)                                                 Ende des maßgeschneiderten Zeitfensters (Stunde)                                                                                                                                                                                                                                                                                                                                                    Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [embedded](#cgiparams-embedded)                                           verschiedenen HTML-Code und SSI-header/footer weglassen                                                                                                                                                                                                                                                                              embedded                                                       
  [emin](#cgiparams-emin)                                                   Ende des maßgeschneiderten Zeitfensters (Minute)                                                                                                                                                                                                                                                                                                                                                    Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [emon](#cgiparams-emon)                                                   Ende des maßgeschneiderten Zeitfensters (Monat)                                                                                                                                                                                                                                                                                                                                                     Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [end\_time](#cgiparams-end_time)                                          Endzeit der festen Ausfallzeit                                                                                                                                                                                                                                                                                                                                                                      Format "MM-DD-YYYY HH:MI"
  [esec](#cgiparams-esec)                                                   Ende des maßgeschneiderten Zeitfensters (Sekunde)                                                                                                                                                                                                                                                                                                                                                   Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [eyear](#cgiparams-eyear)                                                 Ende des maßgeschneiderten Zeitfensters (Jahr)                                                                                                                                                                                                                                                                                                                                                      Nur gültig bei "maßgeschneiderten" Zeitfenstern
  [fixed](#cgiparams-fixed)                                                 Feste oder flexible Ausfallzeit                                                                                                                             0=flexible, \>0=fixed                                                                                                                                                                                                                   
  [force\_check](#cgiparams-force_check)                                    Die Service-Prüfung wird erzwungen                                                                                                                                                                                                                                                                                                   forcecheck                                                     
  [force\_notification](#cgiparams-force_notification)                      Benachrichtigung ungeachtet von Restriktionen versenden (Zeitfenster oder andere)                                                                                                                                                                                                                                                    force\_notification                                            
  [full\_log\_entries](#cgiparams-full_log_entries)                         Vollständige oder gekürzte Log-Eintrage anzeigen                                                                                                                                                                                                                                                                                     full\_log\_entries                                             Default ist gekürzte Ansicht
  [get\_date\_parts](#cgiparams-get_date_parts)                             maßgeschneiderte Zeitbereiche ermitteln                                                                                                                                                                                                                                                                                              get\_date\_parts                                               
  [graphevents](#cgiparams-graphevents)                                     Welche Objekte in welchem Zustand dargestellt werden sollen                                                                                                                                                                                                                                                                          graphevents=112 (alle Service-Probleme)                        Ein logisches ODER von: 1=Host up; 2=Host down; 4=Host unreachable; 8=Service OK; 16=Service Warning; 32=Service Unknown; 64=Service Critical
  [graphstatetypes](#cgiparams-graphstatetypes)                             Hard- und/oder Soft-Zustande darstellen                                                                                                                     1=Soft-states; 2=Hard states; 3=Hard- und Soft-states                                                                                                                    graphstatetypes=3                                              
  [host](#cgiparams-host)                                                   Alle Hosts oder einen bestimmten Host auswählen, dessen Service angezeigt werden sollen                                                                     all; \<host name\>                                                                                                                                                       host=monitor                                                   Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B. "%20" statt eines Leerzeichens)
  [hostgroup](#cgiparams-hostgroup)                                         Alle Hostgruppen oder eine bestimmte Hostgruppe auswählen, deren Hosts und Services angezeigt werden sollen                                                 all; \<hostgroup name\>                                                                                                                                                  hostgroup=linux-boxes                                          Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B. "%20" statt eines Leerzeichens)
  [hostprops](#cgiparams-hostprops)                                         Alle Hosts auswählen, die dem angegebenen Bitmuster entsprechen. Bitte beachten Sie, dass die Hosts ALLE angegebenen Bedingungen entsprechen müssen                                                                                                                                                                                  hostprops=131088 (aktive Prüfungen, die deaktiviert sind)      Ein logisches ODER der Bedingungen, die in include/cgiutils.c angegeben sind [[1]](#cgiparams-filter) (HOST AND SERVICE FILTER PROPERTIES)
  [hoststates](#cgiparams-hoststates)                                       Der Zustand, in dem der Host sein sollte                                                                                                                    1 - 7                                                                                                                                                                    hoststates=3 (Hosts in einem Problemzustand)                   Ein logisches ODER der Zustände: 1=DOWN; 2=UNREACHABLE; 4=UP
  [hoststatustypes](#cgiparams-hoststatustypes)                             Der Zustand, in dem der Host sein sollte                                                                                                                    1 - 15                                                                                                                                                                   hoststatustypes=12 (Hosts in einem Problemzustand)             Ein logisches ODER der Zustände: 1=Pending; 2=Up; 4=Down; 8=Unreachable
  [hours](#cgiparams-hours)                                                 Dauer der flexiblen Ausfallzeit in Stunden (siehe "minutes")                                                                                                \>= 0                                                                                                                                                                                                                                   Nur gültig für flexible Ausfallzeiten
  [includesoftstates](#cgiparams-includesoftstates)                         "soft"-Zustände einschließen                                                                                                                                yes; no                                                                                                                                                                  includesoftstate=yes                                           Default: "soft"-Zustände nicht berücksichtigen
  [initialassumedhoststate](#cgiparams-initialassumedhoststate)                                                                                                                                                                                                                                                                                                                                                                                                                 
  [initialassumedservicestate](#cgiparams-initialassumedservicestate)                                                                                                                                                                                                                                                                                                                                                                                                           
  [initialstateslogged](#cgiparams-initialstateslogged)                                                                                                                                                                                                                                                                                                                                                                                                                         
  [input](#cgiparams-input)                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  [item\_name](#cgiparams-item_name)                                        Suche nach exakter Übereinstimmung der angegebenen Zeichenkette (für regex-Suche siehe [search\_string](#cgiparams-search_string))                                                                                                                                                                                                   item\_name=localhost                                           [5]
  [jsonoutput](#cgiparams-jsonoutput)                                       Ob die Ausgabe im json-Format sein soll                                                                                                                     yes;no                                                                                                                                                                                                                                  Diese Option setzt automatisch "noheader". In fast allen CGIs verfügbar (siehe [2])
  [limit](#cgiparams-limit)                                                 max. Anzahl von anzuzeigenden Einträgen pro Seite                                                                                                           1-n                                                                                                                                                                      limit=10                                                       Nutzbar für Paging-Fähigkeit [5], ausgenommen summary.cgi, default=25.
  [minutes](#cgiparams-minutes)                                             Dauer der flexiblen Ausfallzeit (siehe "hours")                                                                                                             \>= 0                                                                                                                                                                                                                                   
  [navbarsearch](#cgiparams-navbarsearch)                                                                                                                                                                                                                                                                                                                                                                                                                                       
  [newstatesonly](#cgiparams-newstatesonly)                                 Nur "neue" Zustände anzeigen                                                                                                                                yes; no                                                                                                                                                                  newstatesonly=yes                                              Default: alle Zustände anzeigen
  [nodowntime](#cgiparams-nodowntime)                                       Ausfallzeiten nicht anzeigen                                                                                                                                                                                                                                                                                                         nodowntime                                                     
  [noflapping](#cgiparams-noflapping)                                       "Flatter"-Alarme nicht anzeigen                                                                                                                                                                                                                                                                                                      noflapping                                                     
  [nofrills](#cgiparams-nofrills)                                           Don't display frills (?)                                                                                                                                                                                                                                                                                                             nofrills                                                       
  [noheader](#cgiparams-noheader)                                           Globale Statusinformationen weglassen und nur Status-Details anzeigen                                                                                                                                                                                                                                                                noheader                                                       
  [not\_dly](#cgiparams-not_dly)                                            Benachrichtigung um n Minuten verzögern                                                                                                                     \>= 0                                                                                                                                                                                                                                   
  [notimebreaks](#cgiparams-notimebreaks)                                   Don't display timebreaks (?)                                                                                                                                                                                                                                                                                                                                                                        
  [nosystem](#cgiparams-nosystem)                                           Keine Systemmeldungen anzeigen                                                                                                                                                                                                                                                                                                       nosystem                                                       Default: Systemmeldungen (des NAME-ICINGA-Prozesses) anzeigen
  [oldestfirst](#cgiparams-oldestfirst)                                     Sortierreihenfolge umdrehen                                                                                                                                                                                                                                                                                                          oldestfirst                                                    Default: aktuelle Einträge zuerst anzeigen; siehe [6]
  [order](#cgiparams-order)                                                 Sortierreihenfolge festlegen                                                                                                                                old2new / new2old                                                                                                                                                        order=old2new                                                  Default: aktuelle Einträge zuerst anzeigen; siehe [5]
  [paused](#cgiparams-paused)                                               Stoppt den automatischen Update                                                                                                                                                                                                                                                                                                      paused                                                         
  [performance\_data](#cgiparams-performance_data)                          Die als Performance-Daten zu sendende Zeichenkette                                                                                                                                                                                                                                                                                                                                                  
  [persistent](#cgiparams-persistent)                                       Der Kommentar ist persistent, wenn diese Option gesetzt ist                                                                                                                                                                                                                                                                          persistent                                                     
  [plugin\_output](#cgiparams-plugin_output)                                Die als Plugin-Output zu sendende Zeichenkette                                                                                                                                                                                                                                                                                                                                                      Die Länge ist begrenzt durch den Wert von MAX\_INPUT\_LENGTH (festgelegt während des Compile-Vorgangs)
  [plugin\_state](#cgiparams-plugin_state)                                  Zustand des Plugins festlegen                                                                                                                               0=OK; 1=Warning; 2=Critical; 3=Unknown                                                                                                                                   plugin\_state=2                                                
  [ptc](#cgiparams-ptc)                                                     Der Befehl wird an abhängige Hosts propagiert                                                                                                                                                                                                                                                                                        ptc                                                            
  [report](#cgiparams-report)                                               Report erzeugen                                                                                                                                                                                                                                                                                                                      report                                                         
  [report\_type](#cgiparams-report_type)                                    Reporttyp auswählen                                                                                                                                         hostgroups; servicegroups; hosts; services                                                                                                                               report\_type=hostgroups                                        
  [rpttimeperiod](#cgiparams-rpttimeperiod)                                 Angeben eines Zeitfensters, die für den Availability-Bericht benutzt wird                                                                                   Eins der definierten Zeitfenster                                                                                                                                                                                                        Benutzen Sie den Kurznamen der Zeitfenster-Definition
  [sched\_dly](#cgiparams-sched_dly)                                        Befehlsausführung um n Minuten verzögern                                                                                                                    \>= 0                                                                                                                                                                                                                                   
  [sday](#cgiparams-sday)                                                   Start des maßgeschneiderten Zeitfensters (Tag)                                                                                                                                                                                                                                                                                                                                                      
  [search\_string](#cgiparams-search_string)                                Suche nach der angegebenen Zeichenkette (Hosts, Services, etc) mit Hilfe von regulären Ausdrücken                                                                                                                                                                                                                                                                                                   [5]
  [send\_notification](#cgiparams-send_notification)                        Eine Benachrichtigung für die Bestätigung senden                                                                                                            0=disabled, 1=enabled (default)                                                                                                                                          send\_notification                                             [5] cmd.cgi erfordert 0|1 Werte, wenn nicht gesetzt, wird 1 als Standard verwendet. Siehe auch [Bug \#2926](https://dev.icinga.org/issues/2926) für weitere Informationen.
  [service](#cgiparams-service)                                             Alle oder einen bestimmten Service auswählen, der angezeigt werden soll                                                                                     all; \<service description\>                                                                                                                                             service=PING                                                   Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B. "%20" statt einen Leerzeichens)
  [servicefilter](#cgiparams-servicefilter)                                 Nur Service selektieren, deren Beschreibung auf das angegebene Muster passt                                                                                                                                                                                                                                                          servicefilter=Current; servicefilter=[PL]                      Das Muster ist abhängig von Groß-/Kleinschreibung. Reguläre Ausdrucke scheinen bis zu NAME-ICINGA 1.6 zu funktionieren. Siehe [search\_string](#cgiparams-search_string)
  [servicegroup](#cgiparams-servicegroup)                                   Alle oder eine bestimmte Servicegruppe auswählen, deren Hosts und Services angezeigt werden sollen                                                          all; \<servicegroup name\>                                                                                                                                               servicegroup=disk                                              Spezielle Zeichen im Namen müssen kodiert werden ("urlencoded", z.B. "%20" statt einen Leerzeichens)
  [serviceprops](#cgiparams-serviceprops)                                   Alle Services auswählen, die dem angegebenen Bitmuster entsprechen. Bitte beachten Sie, dass die Services ALLE angegebenen Bedingungen entsprechen müssen                                                                                                                                                                            serviceprops=131088 (aktive Prüfungen, die deaktiviert sind)   Ein logisches ODER der Bedingungen, die in include/cgiutils.c angegeben sind [[1]](#cgiparams-filter) (HOST AND SERVICE FILTER PROPERTIES)
  [servicestates](#cgiparams-servicestates)                                 Zustand, in dem die Services sein sollten                                                                                                                                                                                                                                                                                            servicestates=56 (Services in einem Problemzustand)            Ein logisches ODER der Zustände: 8=Warning; 16=Unknown; 32=Critical; 64=OK
  [servicestatustypes](#cgiparams-servicestatustypes)                       Zustand, in dem die Services sein sollten                                                                                                                   1 - 31                                                                                                                                                                   servicestatustype=28 (services in problem state)               Ein logisches ODER der Zustände: 1=Pending; 2=OK, 4=Warning; 8=Unknown; 16=Critical
  [service\_divisor](#cgiparams-service_divisor)                            Wichtigkeit der Service in Relation zu Hosts                                                                                                                \>=1                                                                                                                                                                                                                                    Services sind 1/n so wichtig wie Hosts. Default: n=4
  [shour](#cgiparams-shour)                                                 Start des maßgeschneiderten Zeitfensters (Stunde)                                                                                                                                                                                                                                                                                                                                                   Nur gültig für flexible Ausfallzeiten
  [showscheduleddowntime](#cgiparams-showscheduleddowntime)                 Geplante Ausfallzeiten anzeigen                                                                                                                             yes; no                                                                                                                                                                                                                                 Default: yes
  [show\_log\_entries](#cgiparams-show_log_entries)                         Log-Eintrage anzeigen                                                                                                                                                                                                                                                                                                                show\_log\_entries                                             Default: keine Log-Einträge anzeigen
  [smin](#cgiparams-smin)                                                   Start des maßgeschneiderten Zeitfensters (Minute)                                                                                                                                                                                                                                                                                                                                                   Nur gültig für flexible Ausfallzeiten
  [smon](#cgiparams-smon)                                                   Start des maßgeschneiderten Zeitfensters (Monat)                                                                                                                                                                                                                                                                                                                                                    Nur gültig für flexible Ausfallzeiten
  [sortoption](#cgiparams-sortoption)                                       Angeben der Spalte, nach der sortiert werden soll                                                                                                           1-n                                                                                                                                                                      sortoption=3                                                   Default ist Spalte 1
  [sorttype](#cgiparams-sorttype)                                           Sortierrichtung für die Spalte, die über "sortoption=\<n\>" angegeben wurde                                                                                 1=ascending; 2=decending                                                                                                                                                 sorttype=2                                                     
  [ssec](#cgiparams-ssec)                                                   Start des maßgeschneiderten Zeitfensters (Sekunde)                                                                                                                                                                                                                                                                                                                                                  Nur gültig für flexible Ausfallzeiten
  [standardreport](#cgiparams-standardreport)                               Standard-Report                                                                                                                                             1=recent alerts; 2=recent host alerts; 3=recent service alerts; 4=top host alert producers; 5=top service alert producers                                                                                                               
  [start](#cgiparams-start)                                                 Ergebniszähler                                                                                                                                                                                                                                                                                                                                                                                      [5] Nutzbar für Paging-Fähigkeit
  [start\_time](#cgiparams-start_time)                                      Start der festen Ausfallzeit                                                                                                                                                                                                                                                                                                                                                                        Format "MM-DD-YYYY HH:MI" (kann ggf. von Ihren Ländereinstellungen abhängen, das ist aber unklar)
  [statetype](#cgiparams-statetype)                                         Hard- und/oder Soft-states                                                                                                                                  0=Hard- und Soft-states; 1=Soft-states; 2=Hard-states                                                                                                                    statetype=2                                                    
  [statetypes](#cgiparams-statetypes)                                       Hard- und/oder Soft-states                                                                                                                                  1=Soft-states; 2=Hard-states; 3=Hard- und Soft-states                                                                                                                    statetypes=2                                                   
  [sticky\_ack](#cgiparams-sticky_ack)                                      Die Bestätigung ist "sticky"                                                                                                                                0=disabled, 1=enabled (default)                                                                                                                                          sticky\_ack                                                    [5] cmd.cgi erfordert 0|1 Werte, wenn nicht gesetzt, wird 1 als Standard verwendet. Siehe auch [Bug \#2926](https://dev.icinga.org/issues/2926) für weitere Informationen.
  [style](#cgiparams-style)                                                 Angabe der anzuzeigenden Informationen                                                                                                                      overview; detail; summary; grid; hostdetail                                                                                                                                                                                             Trifft nur auf die Objekttypen "hostgroups" und "servicegroups" zu; hostdetail=host status details; detail=service status details; summary=status summary; grid=status grid;
  [syear](#cgiparams-syear)                                                 Start des maßgeschneiderten Zeitfensters (Jahr)                                                                                                                                                                                                                                                                                                                                                     Nur gültig für flexible Ausfallzeiten
  [t1](#cgiparams-t1)                                                       Startpunkt eines maßgeschneiderten Zeitfensters                                                                                                                                                                                                                                                                                      t1=1296109300                                                  Unix timestamp
  [t2](#cgiparams-t2)                                                       Endpunkt eines maßgeschneiderten Zeitfensters                                                                                                                                                                                                                                                                                        t2=1296189360                                                  Unix timestamp
  [timeperiod](#cgiparams-timeperiod)                                       Zeitfenster, das für den "Availability report" benutzt werden soll                                                                                          today; yesterday; thisweek; lastweek; thismonth; lastmonth; thisquarter; lastquarter; thisyear; lastyear; last24hours; last7days; last31days; custom                     timeperiod=lastmonth                                           
  [trigger](#cgiparams-trigger)                                             Die Ausfallzeit wird von der Downtime-ID \<n\> ausgelöst                                                                                                    Eine gültige Downtime-ID                                                                                                                                                                                                                
  [ts\_end](#cgiparams-ts_end)                                              Daten bis zu ts\_end anzeigen (Unix-Timestamp)                                                                                                              Ein gültiger Unix-Timestamp                                                                                                                                                                                                             siehe [5]
  [ts\_start](#cgiparams-ts_start)                                          Daten ab ts\_start anzeigen (Unix-Timestamp)                                                                                                                Ein gültiger Unix-Timestamp                                                                                                                                                                                                             siehe [5]
  [type](#cgiparams-type)                                                   Objekttyp                                                                                                                                                   hosts; hostgroups; services; servicegroups; contacts; contactgroups; timeperiods; commands; hostescalations; serviceescalations; hostdependencies; servicedependencies   type=hosts                                                     

> **Note**
>
> Seit 1.8 gibt es 'scroll' als Parameter für status.cgi. Dies dient
> dazu, die aktuelle Scrollposition abzuspeichern und
> wiederherzustellen. Dies ist nicht essenziell, da diese Variable nur
> intern verwendet wird, wenn refresh\_type=javascript gesetzt ist in
> der cgi.cfg

[1] Logisches ODER bedeutet, dass die jeweiligen Zahlen addiert werden.
Es werden dann die Objekte angezeigt, die ALLE Bedingungen erfüllen.

[2] Verfügbar ab NAME-ICINGA 1.4.

[3] avail, log, notif, out, status, sum: Alle Views/Reports unterstützen
jsonoutput; config: Alle Typen außer command expansion; ext: Alle Views
außer hostgroup/servicegroup info (immer außer Performance-Daten); tac:
Datenausgabe im json-Format. Mehr Informationen finden Sie im
[NAME-ICINGA-Wiki](https://wiki.icinga.org/display/howtos/Using+JSON+export+in+Classic-UI).

[4] Verfügbar ab NAME-ICINGA 1.7.

[5] Verfügbar ab NAME-ICINGA 1.8.

[6] Entfällt ab NAME-ICINGA 1.8.

[7] Undokumentiert seit NAME-ICINGA 1.2.

Abkürzungen, CGIs, Verweise
---------------------------

Abkürzungen, die in der ersten Tabelle benutzt werden, Beziehungen zu
CGIs- und Menüeintragen sowie Verweise auf den Source-Code in
\<icinga-core\>/cgis.

  Abkürzung   CGI                 Menüeintrag                                                                  Source-Code
  ----------- ------------------- ---------------------------------------------------------------------------- -----------------
  avail       avail.cgi           Availability                                                                 avail.c
  cmd         cmd.cgi             N/A                                                                          cmd.c
  config      config.cgi          Configuration                                                                config.c
  ext         extinfo.cgi         Comments, Downtime, Process Info, Performance Info, Schedulung Info          extinfo.c
  hgram       histogram.cgi       Alert Histogram                                                              histogram.c
  hist        history.cgi         Alert History                                                                history.c
  notif       notifications.cgi   Notifications                                                                notifications.c
  out         outages.cgi         Network Outages                                                              outages.c
  log         showlog.cgi         Event Log                                                                    showlog.c
  status      status.cgi          Hostgroup Overview, Servicegroup Overview, Host Problems, Service Problems   status.c
  map         statusmap.cgi       Status Map                                                                   statusmap.c
  summary     summary.cgi         Alert Summary                                                                summary.c
  tac         tac.cgi             N/A                                                                          tac.c
  trends      trends.cgi          Trends                                                                       trends.c

Host und Service Filter Properties
----------------------------------

**Ausschnitt aus include/cgiutils.h**

    /****************** HOST AND SERVICE FILTER PROPERTIES  *******************/

    #define HOST_SCHEDULED_DOWNTIME         1
    #define HOST_NO_SCHEDULED_DOWNTIME      2
    #define HOST_STATE_ACKNOWLEDGED         4
    #define HOST_STATE_UNACKNOWLEDGED       8
    #define HOST_CHECKS_DISABLED            16
    #define HOST_CHECKS_ENABLED             32
    #define HOST_EVENT_HANDLER_DISABLED     64
    #define HOST_EVENT_HANDLER_ENABLED      128
    #define HOST_FLAP_DETECTION_DISABLED    256
    #define HOST_FLAP_DETECTION_ENABLED     512
    #define HOST_IS_FLAPPING                1024
    #define HOST_IS_NOT_FLAPPING            2048
    #define HOST_NOTIFICATIONS_DISABLED     4096
    #define HOST_NOTIFICATIONS_ENABLED      8192
    #define HOST_PASSIVE_CHECKS_DISABLED    16384
    #define HOST_PASSIVE_CHECKS_ENABLED     32768
    #define HOST_PASSIVE_CHECK              65536
    #define HOST_ACTIVE_CHECK               131072
    #define HOST_HARD_STATE                 262144
    #define HOST_SOFT_STATE                 524288
    #define HOST_STATE_HANDLED              1048576
    #define HOST_NOT_ALL_CHECKS_DISABLED    2097152

    #define SERVICE_SCHEDULED_DOWNTIME      1
    #define SERVICE_NO_SCHEDULED_DOWNTIME   2
    #define SERVICE_STATE_ACKNOWLEDGED      4
    #define SERVICE_STATE_UNACKNOWLEDGED    8
    #define SERVICE_CHECKS_DISABLED         16
    #define SERVICE_CHECKS_ENABLED          32
    #define SERVICE_EVENT_HANDLER_DISABLED  64
    #define SERVICE_EVENT_HANDLER_ENABLED   128
    #define SERVICE_FLAP_DETECTION_ENABLED  256
    #define SERVICE_FLAP_DETECTION_DISABLED 512
    #define SERVICE_IS_FLAPPING             1024
    #define SERVICE_IS_NOT_FLAPPING         2048
    #define SERVICE_NOTIFICATIONS_DISABLED  4096
    #define SERVICE_NOTIFICATIONS_ENABLED   8192
    #define SERVICE_PASSIVE_CHECKS_DISABLED 16384
    #define SERVICE_PASSIVE_CHECKS_ENABLED  32768
    #define SERVICE_PASSIVE_CHECK           65536
    #define SERVICE_ACTIVE_CHECK            131072
    #define SERVICE_HARD_STATE              262144
    #define SERVICE_SOFT_STATE              524288
    #define SERVICE_STATE_HANDLED           1048576
    #define SERVICE_NOT_ALL_CHECKS_DISABLED 2097152

Host und Service Statustypen
----------------------------

**Excerpt from include/statusdata.h**

    /*************************** SERVICE STATES ***************************/
    #define SERVICE_PENDING  1
    #define SERVICE_OK       2
    #define SERVICE_WARNING  4
    #define SERVICE_UNKNOWN  8
    #define SERVICE_CRITICAL 16

    /**************************** HOST STATES ****************************/
    #define HOST_PENDING     1
    #define HOST_UP          2
    #define HOST_DOWN        4
    #define HOST_UNREACHABLE 8

CGIs
Parameter
CGIs
Filtereigenschaften (filter properties)
hostprops
serviceprops
CGIs
Statustypen (status types)
hoststatustypes
servicestatustypes
CGI-Parameter
ahas
CGI-Parameter
alerttypes
CGI-Parameter
assumeinitialstates
CGI-Parameter
assumestateretention
CGI-Parameter
assumestatesduringnotrunning
CGI-Parameter
attr
CGI-Parameter
backtrack
CGI-Parameter
breakdown
CGI-Parameter
broadcast\_notification
CGI-Parameter
childoptions
CGI-Parameter
cmd\_mod
CGI-Parameter
cmd\_typ
CGI-Parameter
columns
CGI-Parameter
com\_author
CGI-Parameter
com\_data
CGI-Parameter
com\_id
CGI-Parameter
contact
CGI-Parameter
createimage
CGI-Parameter
csvoutput
CGI-Parameter
displaytype
CGI-Parameter
down\_id
CGI-Parameter
eday
CGI-Parameter
ehour
CGI-Parameter
embedded
CGI-Parameter
emin
CGI-Parameter
emon
CGI-Parameter
end\_time
CGI-Parameter
esec
CGI-Parameter
eyear
CGI-Parameter
fixed
CGI-Parameter
force\_check
CGI-Parameter
force\_notification
CGI-Parameter
full\_log\_entries
CGI-Parameter
get\_date\_parts
CGI-Parameter
graphevents
CGI-Parameter
graphstatetypes
CGI-Parameter
host
CGI-Parameter
hostgroup
CGI-Parameter
hostprops
CGI-Parameter
hoststates
CGI-Parameter
hoststatustypes
CGI-Parameter
hours
CGI-Parameter
includesoftstates
CGI-Parameter
initialassumedhoststate
CGI-Parameter
initialassumedservicestate
CGI-Parameter
initialstateslogged
CGI-Parameter
input
CGI-Parameter
item\_name
CGI-Parameter
jsonoutput
CGI-Parameter
limit
CGI-Parameter
minutes
CGI-Parameter
navbarsearch
CGI-Parameter
newstatesonly
CGI-Parameter
nodowntime
CGI-Parameter
noflapping
CGI-Parameter
nofrills
CGI-Parameter
noheader
CGI-Parameter
not\_dly
CGI-Parameter
notimebreaks
CGI-Parameter
nosystem
CGI-Parameter
oldestfirst
CGI-Parameter
order
CGI-Parameter
paused
CGI-Parameter
performance\_data
CGI-Parameter
persistent
CGI-Parameter
plugin\_output
CGI-Parameter
plugin\_state
CGI-Parameter
ptc
CGI-Parameter
report
CGI-Parameter
report\_type
CGI-Parameter
rpttimeperiod
CGI-Parameter
sched\_dly
CGI-Parameter
sday
CGI-Parameter
search\_string
CGI-Parameter
send\_notification
CGI-Parameter
service
CGI-Parameter
servicefilter
CGI-Parameter
servicegroup
CGI-Parameter
serviceprops
CGI-Parameter
servicestates
CGI-Parameter
servicestatustypes
CGI-Parameter
service\_divisor
CGI-Parameter
shour
CGI-Parameter
showscheduleddowntime
CGI-Parameter
show\_log\_entries
CGI-Parameter
smin
CGI-Parameter
smon
CGI-Parameter
sortoption
CGI-Parameter
sorttype
CGI-Parameter
ssec
CGI-Parameter
standardreport
CGI-Parameter
start
CGI-Parameter
start\_time
CGI-Parameter
statetype
CGI-Parameter
statetypes
CGI-Parameter
sticky\_ack
CGI-Parameter
style
CGI-Parameter
syear
CGI-Parameter
t1
CGI-Parameter
t2
CGI-Parameter
timeperiod
CGI-Parameter
trigger
CGI-Parameter
ts\_end
CGI-Parameter
ts\_start
CGI-Parameter
type
