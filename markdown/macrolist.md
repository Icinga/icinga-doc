Standard-Makros in NAME-ICINGA
==============================

In NAME-ICINGA verfügbare Standard-Makros sind hier aufgelistet.
On-Demand-Makros und Makros für Benutzervariablen sind [hier](#macros)
beschrieben.

Makro-Geltungsbereich
---------------------

Obwohl Makros in allen Befehlen benutzt werden können, die Sie
definieren, sind sie ggf. nicht "gültig" innerhalb eines bestimmten
Befehlstyps. Zum Beispiel sind einige Makros vielleicht nur gültig bei
Service-Benachrichtigungen, andere vielleicht nur bei Host-Prüfungen. Es
gibt zehn Arten von Befehlen, die NAME-ICINGA erkennt und
unterschiedlich behandelt. Dies sind:

1.  Service-Prüfungen

2.  Service-Benachrichtigungen

3.  Host-Prüfungen

4.  Host-Benachrichtigungen

5.  Service-[Eventhandler](#eventhandlers) und/oder ein globaler
    Service-Eventhandler

6.  Host-[Eventhandler](#eventhandlers) und/oder ein globaler
    Host-Eventhandler

7.  [OCSP](#configmain-ocsp_command) Befehl

8.  [OCNAME-HP](#configmain-ochp_command) Befehl

9.  Service-[Performance-Daten](#perfdata) Befehle

10. Host-[Performance-Daten](#perfdata) Befehle

Die nachfolgenden Aufstellungen enthalten alle aktuell in NAME-ICINGA
verfügbaren Makros zusammen mit einer kurzen Beschreibung und den
Befehlstypen, in denen sie gelten. Wenn ein Makro in einem Befehl
benutzt wird, in dem es nicht gültig ist, wird es durch eine leere
Zeichenkette ersetzt. Es ist zu beachten, dass Makros aus Großbuchstaben
bestehen und in Dollarzeichen (\$) eingeschlossen werden.

Makroverfügbarkeits-Aufstellung
-------------------------------

**Legende:**

  ------ -----------------------------------------------------------------
  Nein   Das Makro ist nicht verfügbar
  Ja     Das Makro ist verfügbar
  ------ -----------------------------------------------------------------

  -------- -------- -------- -------- -------- -------- -------- -------- --------
  **Makron **Servic **Servic **Host-P **Host-B **Servic **Host-E **Servic **Host-P
  ame**    e-Prüfun e-Benach rüfungen enachric e-Eventh venthand e-Perf-D erf-Date
           gen**    richtigu **       htigunge andler   ler      aten**   n**
                    ngen**            n**      und      und               
                                               [OCSP](# [OCNAME-          
                                               configma HP](#con          
                                               in-ocsp_ figmain-          
                                               command) ochp_com          
                                               **       mand)**           

  Host-Mak
  ros:
  [^3^](#m
  acrolist
  -note3)

  [\$HOSTN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  AME\$](#                                                                
  macrolis                                                                
  t-hostna                                                                
  me)                                                                     

  [\$HOSTD Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ISPLAYNA                                                                
  ME\$](#m                                                                
  acrolist                                                                
  -hostdis                                                                
  playname                                                                
  )                                                                       

  [\$HOSTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  LIAS\$](                                                                
  #macroli                                                                
  st-hosta                                                                
  lias)                                                                   

  [\$HOSTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  DDRESS\$                                                                
  ](#macro                                                                
  list-hos                                                                
  taddress                                                                
  )                                                                       

  [\$HOSTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  DDRESS6\                                                                
  $](#macr                                                                
  olist-ho                                                                
  staddres                                                                
  s6)                                                                     

  [\$HOSTS Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TATE\$](                   [^1^](#m                                     
  #macroli                   acrolist                                     
  st-hosts                   -note1)                                      
  tate)                                                                   

  [\$HOSTS Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TATEID\$                   [^1^](#m                                     
  ](#macro                   acrolist                                     
  list-hos                   -note1)                                      
  tstateid                                                                
  )                                                                       

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTSTATE                                                                
  \$](#mac                                                                
  rolist-l                                                                
  asthosts                                                                
  tate)                                                                   

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTSTATE                                                                
  ID\$](#m                                                                
  acrolist                                                                
  -lasthos                                                                
  tstateid                                                                
  )                                                                       

  [\$HOSTS Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TATETYPE                   [^1^](#m                                     
  \$](#mac                   acrolist                                     
  rolist-h                   -note1)                                      
  oststate                                                                
  type)                                                                   

  [\$HOSTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TTEMPT\$                                                                
  ](#macro                                                                
  list-hos                                                                
  tattempt                                                                
  )                                                                       

  [\$MAXHO Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  STATTEMP                                                                
  TS\$](#m                                                                
  acrolist                                                                
  -maxhost                                                                
  attempts                                                                
  )                                                                       

  [\$HOSTE Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  VENTID\$                                                                
  ](#macro                                                                
  list-hos                                                                
  teventid                                                                
  )                                                                       

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTEVENT                                                                
  ID\$](#m                                                                
  acrolist                                                                
  -lasthos                                                                
  teventid                                                                
  )                                                                       

  [\$HOSTP Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROBLEMID                                                                
  \$](#mac                                                                
  rolist-h                                                                
  ostprobl                                                                
  emid)                                                                   

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTPROBL                                                                
  EMID\$](                                                                
  #macroli                                                                
  st-lasth                                                                
  ostprobl                                                                
  emid)                                                                   

  [\$HOSTL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ATENCY\$                                                                
  ](#macro                                                                
  list-hos                                                                
  tlatency                                                                
  )                                                                       

  [\$HOSTE Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  XECUTION                   [^1^](#m                                     
  TIME\$](                   acrolist                                     
  #macroli                   -note1)                                      
  st-hoste                                                                
  xecution                                                                
  time)                                                                   

  [\$HOSTD Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  URATION\                                                                
  $](#macr                                                                
  olist-ho                                                                
  stdurati                                                                
  on)                                                                     

  [\$HOSTD Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  URATIONS                                                                
  EC\$](#m                                                                
  acrolist                                                                
  -hostdur                                                                
  ationsec                                                                
  )                                                                       

  [\$HOSTD Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OWNTIME\                                                                
  $](#macr                                                                
  olist-ho                                                                
  stdownti                                                                
  me)                                                                     

  [\$HOSTP Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ERCENTCH                                                                
  ANGE\$](                                                                
  #macroli                                                                
  st-hostp                                                                
  ercentch                                                                
  ange)                                                                   

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPNAME                                                                
  \$](#mac                                                                
  rolist-h                                                                
  ostgroup                                                                
  name)                                                                   

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPNAME                                                                
  S\$](#ma                                                                
  crolist-                                                                
  hostgrou                                                                
  pnames)                                                                 

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTCHECK                                                                
  \$](#mac                                                                
  rolist-l                                                                
  asthostc                                                                
  heck)                                                                   

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTSTATE                                                                
  CHANGE\$                                                                
  ](#macro                                                                
  list-las                                                                
  thoststa                                                                
  techange                                                                
  )                                                                       

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTUP\$]                                                                
  (#macrol                                                                
  ist-last                                                                
  hostup)                                                                 

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTDOWN\                                                                
  $](#macr                                                                
  olist-la                                                                
  sthostdo                                                                
  wn)                                                                     

  [\$LASTH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTUNREA                                                                
  CHABLE\$                                                                
  ](#macro                                                                
  list-las                                                                
  thostunr                                                                
  eachable                                                                
  )                                                                       

  [\$HOSTO Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  UTPUT\$]                   [^1^](#m                                     
  (#macrol                   acrolist                                     
  ist-host                   -note1)                                      
  output)                                                                 

  [\$LONGH Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OSTOUTPU                   [^1^](#m                                     
  T\$](#ma                   acrolist                                     
  crolist-                   -note1)                                      
  longhost                                                                
  output)                                                                 

  [\$HOSTP Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ERFDATA\                   [^1^](#m                                     
  $](#macr                   acrolist                                     
  olist-ho                   -note1)                                      
  stperfda                                                                
  ta)                                                                     

  [\$HOSTC Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HECKCOMM                                                                
  AND\$](#                                                                
  macrolis                                                                
  t-hostch                                                                
  eckcomma                                                                
  nd)                                                                     

  [\$HOSTA Nein     Nein     Nein     Ja       Nein     Nein     Nein     Nein
  CKAUTHOR                                                                
  \$](#mac                                                                
  rolist-h                                                                
  ostackau                                                                
  thor)                                                                   
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$HOSTA Nein     Nein     Nein     Ja       Nein     Nein     Nein     Nein
  CKAUTHOR                                                                
  NAME\$](                                                                
  #macroli                                                                
  st-hosta                                                                
  ckauthor                                                                
  name)                                                                   
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$HOSTA Nein     Nein     Nein     Ja       Nein     Nein     Nein     Nein
  CKAUTHOR                                                                
  ALIAS\$]                                                                
  (#macrol                                                                
  ist-host                                                                
  ackautho                                                                
  ralias)                                                                 
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$HOSTA Nein     Nein     Nein     Ja       Nein     Nein     Nein     Nein
  CKCOMMEN                                                                
  T\$](#ma                                                                
  crolist-                                                                
  hostackc                                                                
  omment)                                                                 
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$HOSTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CTIONURL                                                                
  \$](#mac                                                                
  rolist-h                                                                
  ostactio                                                                
  nurl)                                                                   

  [\$HOSTN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OTESURL\                                                                
  $](#macr                                                                
  olist-ho                                                                
  stnotesu                                                                
  rl)                                                                     

  [\$HOSTN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  OTES\$](                                                                
  #macroli                                                                
  st-hostn                                                                
  otes)                                                                   

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSERV                                                                
  ICES\$](                                                                
  #macroli                                                                
  st-total                                                                
  hostserv                                                                
  ices)                                                                   

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSERV                                                                
  ICESOK\$                                                                
  ](#macro                                                                
  list-tot                                                                
  alhostse                                                                
  rvicesok                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSERV                                                                
  ICESWARN                                                                
  ING\$](#                                                                
  macrolis                                                                
  t-totalh                                                                
  ostservi                                                                
  ceswarni                                                                
  ng)                                                                     

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSERV                                                                
  ICESUNKN                                                                
  OWN\$](#                                                                
  macrolis                                                                
  t-totalh                                                                
  ostservi                                                                
  cesunkno                                                                
  wn)                                                                     

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSERV                                                                
  ICESCRIT                                                                
  ICAL\$](                                                                
  #macroli                                                                
  st-total                                                                
  hostserv                                                                
  icescrit                                                                
  ical)                                                                   

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Hostgrou
  p-Makros
  :

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPALIA                                                                
  S\$](#ma                                                                
  crolist-                                                                
  hostgrou                                                                
  palias)                                                                 
  [^5^](#m                                                                
  acrolist                                                                
  -note5)                                                                 

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPMEMB                                                                
  ERS\$](#                                                                
  macrolis                                                                
  t-hostgr                                                                
  oupmembe                                                                
  rs)                                                                     
  [^5^](#m                                                                
  acrolist                                                                
  -note5)                                                                 

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPNOTE                                                                
  S\$](#ma                                                                
  crolist-                                                                
  hostgrou                                                                
  pnotes)                                                                 
  [^5^](#m                                                                
  acrolist                                                                
  -note5)                                                                 

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPNOTE                                                                
  SURL\$](                                                                
  #macroli                                                                
  st-hostg                                                                
  roupnote                                                                
  surl)                                                                   
  [^5^](#m                                                                
  acrolist                                                                
  -note5)                                                                 

  [\$HOSTG Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ROUPACTI                                                                
  ONURL\$]                                                                
  (#macrol                                                                
  ist-host                                                                
  groupact                                                                
  ionurl)                                                                 
  [^5^](#m                                                                
  acrolist                                                                
  -note5)                                                                 

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Service-
  Makros:

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEDESC\$                                                                
  ](#macro                                                                
  list-ser                                                                
  vicedesc                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEDISPLA                                                                
  YNAME\$]                                                                
  (#macrol                                                                
  ist-serv                                                                
  icedispl                                                                
  ayname)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CESTATE\ [^2^](#m                                                       
  $](#macr acrolist                                                       
  olist-se -note2)                                                        
  rvicesta                                                                
  te)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CESTATEI [^2^](#m                                                       
  D\$](#ma acrolist                                                       
  crolist- -note2)                                                        
  services                                                                
  tateid)                                                                 

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEST                                                                
  ATE\$](#                                                                
  macrolis                                                                
  t-lastse                                                                
  rvicesta                                                                
  te)                                                                     

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEST                                                                
  ATEID\$]                                                                
  (#macrol                                                                
  ist-last                                                                
  services                                                                
  tateid)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CESTATET                                                                
  YPE\$](#                                                                
  macrolis                                                                
  t-servic                                                                
  estatety                                                                
  pe)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEATTEMP                                                                
  T\$](#ma                                                                
  crolist-                                                                
  servicea                                                                
  ttempt)                                                                 

  [\$MAXSE Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  RVICEATT                                                                
  EMPTS\$]                                                                
  (#macrol                                                                
  ist-maxs                                                                
  erviceat                                                                
  tempts)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEISVOLA                                                                
  TILE\$](                                                                
  #macroli                                                                
  st-servi                                                                
  ceisvola                                                                
  tile)                                                                   

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEEVENTI                                                                
  D\$](#ma                                                                
  crolist-                                                                
  servicee                                                                
  ventid)                                                                 

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEEV                                                                
  ENTID\$]                                                                
  (#macrol                                                                
  ist-last                                                                
  servicee                                                                
  ventid)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEPROBLE                                                                
  MID\$](#                                                                
  macrolis                                                                
  t-servic                                                                
  eproblem                                                                
  id)                                                                     

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEPR                                                                
  OBLEMID\                                                                
  $](#macr                                                                
  olist-la                                                                
  stservic                                                                
  eproblem                                                                
  id)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CELATENC                                                                
  Y\$](#ma                                                                
  crolist-                                                                
  servicel                                                                
  atency)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEEXECUT [^2^](#m                                                       
  IONTIME\ acrolist                                                       
  $](#macr -note2)                                                        
  olist-se                                                                
  rviceexe                                                                
  cutionti                                                                
  me)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEDURATI                                                                
  ON\$](#m                                                                
  acrolist                                                                
  -service                                                                
  duration                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEDURATI                                                                
  ONSEC\$]                                                                
  (#macrol                                                                
  ist-serv                                                                
  icedurat                                                                
  ionsec)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEDOWNTI                                                                
  ME\$](#m                                                                
  acrolist                                                                
  -service                                                                
  downtime                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEPERCEN                                                                
  TCHANGE\                                                                
  $](#macr                                                                
  olist-se                                                                
  rviceper                                                                
  centchan                                                                
  ge)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEGROUPN                                                                
  AME\$](#                                                                
  macrolis                                                                
  t-servic                                                                
  egroupna                                                                
  me)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEGROUPN                                                                
  AMES\$](                                                                
  #macroli                                                                
  st-servi                                                                
  cegroupn                                                                
  ames)                                                                   

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICECH                                                                
  ECK\$](#                                                                
  macrolis                                                                
  t-lastse                                                                
  rviceche                                                                
  ck)                                                                     

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEST                                                                
  ATECHANG                                                                
  E\$](#ma                                                                
  crolist-                                                                
  lastserv                                                                
  icestate                                                                
  change)                                                                 

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEOK                                                                
  \$](#mac                                                                
  rolist-l                                                                
  astservi                                                                
  ceok)                                                                   

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEWA                                                                
  RNING\$]                                                                
  (#macrol                                                                
  ist-last                                                                
  servicew                                                                
  arning)                                                                 

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEUN                                                                
  KNOWN\$]                                                                
  (#macrol                                                                
  ist-last                                                                
  serviceu                                                                
  nknown)                                                                 

  [\$LASTS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICECR                                                                
  ITICAL\$                                                                
  ](#macro                                                                
  list-las                                                                
  tservice                                                                
  critical                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEOUTPUT [^2^](#m                                                       
  \$](#mac acrolist                                                       
  rolist-s -note2)                                                        
  erviceou                                                                
  tput)                                                                   

  [\$LONGS Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  ERVICEOU [^2^](#m                                                       
  TPUT\$]( acrolist                                                       
  #macroli -note2)                                                        
  st-longs                                                                
  erviceou                                                                
  tput)                                                                   

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEPERFDA [^2^](#m                                                       
  TA\$](#m acrolist                                                       
  acrolist -note2)                                                        
  -service                                                                
  perfdata                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CECHECKC                                                                
  OMMAND\$                                                                
  ](#macro                                                                
  list-ser                                                                
  vicechec                                                                
  kcommand                                                                
  )                                                                       

  [\$SERVI Nein     Ja       Nein     Nein     Nein     Nein     Nein     Nein
  CEACKAUT                                                                
  HOR\$](#                                                                
  macrolis                                                                
  t-servic                                                                
  eackauth                                                                
  or)                                                                     
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$SERVI Nein     Ja       Nein     Nein     Nein     Nein     Nein     Nein
  CEACKAUT                                                                
  HORNAME\                                                                
  $](#macr                                                                
  olist-se                                                                
  rviceack                                                                
  authorna                                                                
  me)                                                                     
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$SERVI Nein     Ja       Nein     Nein     Nein     Nein     Nein     Nein
  CEACKAUT                                                                
  HORALIAS                                                                
  \$](#mac                                                                
  rolist-s                                                                
  erviceac                                                                
  kauthora                                                                
  lias)                                                                   
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$SERVI Nein     Ja       Nein     Nein     Nein     Nein     Nein     Nein
  CEACKCOM                                                                
  MENT\$](                                                                
  #macroli                                                                
  st-servi                                                                
  ceackcom                                                                
  ment)                                                                   
  [^8^](#m                                                                
  acrolist                                                                
  -note8)                                                                 

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CEACTION                                                                
  URL\$](#                                                                
  macrolis                                                                
  t-servic                                                                
  eactionu                                                                
  rl)                                                                     

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CENOTESU                                                                
  RL\$](#m                                                                
  acrolist                                                                
  -service                                                                
  notesurl                                                                
  )                                                                       

  [\$SERVI Ja       Ja       Nein     Nein     Ja       Nein     Ja       Nein
  CENOTES\                                                                
  $](#macr                                                                
  olist-se                                                                
  rvicenot                                                                
  es)                                                                     

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Serviceg
  roup-Mak
  ros:

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEGROUPA                                                                
  LIAS\$](                                                                
  #macroli                                                                
  st-servi                                                                
  cegroupa                                                                
  lias)                                                                   
  [^6^](#m                                                                
  acrolist                                                                
  -note6)                                                                 

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEGROUPM                                                                
  EMBERS\$                                                                
  ](#macro                                                                
  list-ser                                                                
  vicegrou                                                                
  pmembers                                                                
  )                                                                       
  [^6^](#m                                                                
  acrolist                                                                
  -note6)                                                                 

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEGROUPN                                                                
  OTES\$](                                                                
  #macroli                                                                
  st-servi                                                                
  cegroupn                                                                
  otes)                                                                   
  [^6^](#m                                                                
  acrolist                                                                
  -note6)                                                                 

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEGROUPN                                                                
  OTESURL\                                                                
  $](#macr                                                                
  olist-se                                                                
  rvicegro                                                                
  upnotesu                                                                
  rl)                                                                     
  [^6^](#m                                                                
  acrolist                                                                
  -note6)                                                                 

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEGROUPA                                                                
  CTIONURL                                                                
  \$](#mac                                                                
  rolist-s                                                                
  ervicegr                                                                
  oupactio                                                                
  nurl)                                                                   
  [^6^](#m                                                                
  acrolist                                                                
  -note6)                                                                 

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Contact-
  Makros:

  [\$CONTA Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CTNAME\$                                                                
  ](#macro                                                                
  list-con                                                                
  tactname                                                                
  )                                                                       

  [\$CONTA Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CTALIAS\                                                                
  $](#macr                                                                
  olist-co                                                                
  ntactali                                                                
  as)                                                                     

  [\$CONTA Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CTEMAIL\                                                                
  $](#macr                                                                
  olist-co                                                                
  ntactema                                                                
  il)                                                                     

  [\$CONTA Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CTPAGER\                                                                
  $](#macr                                                                
  olist-co                                                                
  ntactpag                                                                
  er)                                                                     

  [\$CONTA Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CTADDRES                                                                
  Sn\$](#m                                                                
  acrolist                                                                
  -contact                                                                
  address)                                                                

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Contactg
  roup-Mak
  ros:

  [\$CONTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CTGROUPA                                                                
  LIAS\$](                                                                
  #macroli                                                                
  st-conta                                                                
  ctgroupa                                                                
  lias)                                                                   
  [^7^](#m                                                                
  acrolist                                                                
  -note7)                                                                 

  [\$CONTA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CTGROUPM                                                                
  EMBERS\$                                                                
  ](#macro                                                                
  list-con                                                                
  tactgrou                                                                
  pmembers                                                                
  )                                                                       
  [^7^](#m                                                                
  acrolist                                                                
  -note7)                                                                 

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Auswertu
  ngsmakro
  s:

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSUP\          [^4^](#m          [^4^](#m                            
  $](#macr          acrolist          acrolist                            
  olist-to          -note4)           -note4)                             
  talhosts                                                                
  up)                                                                     
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSDOW          [^4^](#m          [^4^](#m                            
  N\$](#ma          acrolist          acrolist                            
  crolist-          -note4)           -note4)                             
  totalhos                                                                
  tsdown)                                                                 
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSUNR          [^4^](#m          [^4^](#m                            
  EACHABLE          acrolist          acrolist                            
  \$](#mac          -note4)           -note4)                             
  rolist-t                                                                
  otalhost                                                                
  sunreach                                                                
  able)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSDOW          [^4^](#m          [^4^](#m                            
  NUNHANDL          acrolist          acrolist                            
  ED\$](#m          -note4)           -note4)                             
  acrolist                                                                
  -totalho                                                                
  stsdownu                                                                
  nhandled                                                                
  )                                                                       
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTSUNR          [^4^](#m          [^4^](#m                            
  EACHABLE          acrolist          acrolist                            
  UNHANDLE          -note4)           -note4)                             
  D\$](#ma                                                                
  crolist-                                                                
  totalhos                                                                
  tsunreac                                                                
  hableunh                                                                
  andled)                                                                 
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTPROB          [^4^](#m          [^4^](#m                            
  LEMS\$](          acrolist          acrolist                            
  #macroli          -note4)           -note4)                             
  st-total                                                                
  hostprob                                                                
  lems)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  HOSTPROB          [^4^](#m          [^4^](#m                            
  LEMSUNHA          acrolist          acrolist                            
  NDLED\$]          -note4)           -note4)                             
  (#macrol                                                                
  ist-tota                                                                
  lhostpro                                                                
  blemsunh                                                                
  andled)                                                                 
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  OK\$](#m          acrolist          acrolist                            
  acrolist          -note4)           -note4)                             
  -totalse                                                                
  rvicesok                                                                
  )                                                                       
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  WARNING\          acrolist          acrolist                            
  $](#macr          -note4)           -note4)                             
  olist-to                                                                
  talservi                                                                
  ceswarni                                                                
  ng)                                                                     
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  CRITICAL          acrolist          acrolist                            
  \$](#mac          -note4)           -note4)                             
  rolist-t                                                                
  otalserv                                                                
  icescrit                                                                
  ical)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  UNKNOWN\          acrolist          acrolist                            
  $](#macr          -note4)           -note4)                             
  olist-to                                                                
  talservi                                                                
  cesunkno                                                                
  wn)                                                                     
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  WARNINGU          acrolist          acrolist                            
  NHANDLED          -note4)           -note4)                             
  \$](#mac                                                                
  rolist-t                                                                
  otalserv                                                                
  iceswarn                                                                
  ingunhan                                                                
  dled)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  CRITICAL          acrolist          acrolist                            
  UNHANDLE          -note4)           -note4)                             
  D\$](#ma                                                                
  crolist-                                                                
  totalser                                                                
  vicescri                                                                
  ticalunh                                                                
  andled)                                                                 
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICES          [^4^](#m          [^4^](#m                            
  UNKNOWNU          acrolist          acrolist                            
  NHANDLED          -note4)           -note4)                             
  \$](#mac                                                                
  rolist-t                                                                
  otalserv                                                                
  icesunkn                                                                
  ownunhan                                                                
  dled)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICEP          [^4^](#m          [^4^](#m                            
  ROBLEMS\          acrolist          acrolist                            
  $](#macr          -note4)           -note4)                             
  olist-to                                                                
  talservi                                                                
  ceproble                                                                
  ms)                                                                     
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  [\$TOTAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SERVICEP          [^4^](#m          [^4^](#m                            
  ROBLEMSU          acrolist          acrolist                            
  NHANDLED          -note4)           -note4)                             
  \$](#mac                                                                
  rolist-t                                                                
  otalserv                                                                
  iceprobl                                                                
  emsunhan                                                                
  dled)                                                                   
  [^10^](#                                                                
  macrolis                                                                
  t-note10                                                                
  )                                                                       

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Benachri
  chtigung
  smakros:

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONT                                                                
  YPE\$](#                                                                
  macrolis                                                                
  t-notifi                                                                
  cationty                                                                
  pe)                                                                     

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONR                                                                
  ECIPIENT                                                                
  S\$](#ma                                                                
  crolist-                                                                
  notifica                                                                
  tionreci                                                                
  pients)                                                                 

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONI                                                                
  SESCALAT                                                                
  ED\$](#m                                                                
  acrolist                                                                
  -notific                                                                
  ationise                                                                
  scalated                                                                
  )                                                                       

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONA                                                                
  UTHOR\$]                                                                
  (#macrol                                                                
  ist-noti                                                                
  fication                                                                
  author)                                                                 

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONA                                                                
  UTHORNAM                                                                
  E\$](#ma                                                                
  crolist-                                                                
  notifica                                                                
  tionauth                                                                
  orname)                                                                 

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONA                                                                
  UTHORALI                                                                
  AS\$](#m                                                                
  acrolist                                                                
  -notific                                                                
  ationaut                                                                
  horalias                                                                
  )                                                                       

  [\$NOTIF Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  ICATIONC                                                                
  OMMENT\$                                                                
  ](#macro                                                                
  list-not                                                                
  ificatio                                                                
  ncomment                                                                
  )                                                                       

  [\$HOSTN Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  OTIFICAT                                                                
  IONNUMBE                                                                
  R\$](#ma                                                                
  crolist-                                                                
  hostnoti                                                                
  fication                                                                
  number)                                                                 

  [\$HOSTN Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  OTIFICAT                                                                
  IONID\$]                                                                
  (#macrol                                                                
  ist-host                                                                
  notifica                                                                
  tionid)                                                                 

  [\$SERVI Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CENOTIFI                                                                
  CATIONNU                                                                
  MBER\$](                                                                
  #macroli                                                                
  st-servi                                                                
  cenotifi                                                                
  cationnu                                                                
  mber)                                                                   

  [\$SERVI Nein     Ja       Nein     Ja       Nein     Nein     Nein     Nein
  CENOTIFI                                                                
  CATIONID                                                                
  \$](#mac                                                                
  rolist-s                                                                
  erviceno                                                                
  tificati                                                                
  onid)                                                                   

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Datums-/
  Zeitmakr
  os:

  [\$LONNA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ME-GDATE                                                                
  TIME\$](                                                                
  #macroli                                                                
  st-longd                                                                
  atetime)                                                                

  [\$SHORT Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  DATETIME                                                                
  \$](#mac                                                                
  rolist-s                                                                
  hortdate                                                                
  time)                                                                   

  [\$DATE\ Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  $](#macr                                                                
  olist-da                                                                
  te)                                                                     

  [\$TIME\ Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  $](#macr                                                                
  olist-ti                                                                
  me)                                                                     

  [\$TIMET Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  \$](#mac                                                                
  rolist-t                                                                
  imet)                                                                   

  [\$ISVAL Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  IDTIME:\                                                                
  $](#macr                                                                
  olist-is                                                                
  validtim                                                                
  e)                                                                      
  [^9^](#m                                                                
  acrolist                                                                
  -note9)                                                                 

  [\$NEXTV Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ALIDTIME                                                                
  :\$](#ma                                                                
  crolist-                                                                
  nextvali                                                                
  dtime)                                                                  
  [^9^](#m                                                                
  acrolist                                                                
  -note9)                                                                 

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  Dateimak
  ros:

  [\$MAINC Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ONFIGFIL                                                                
  E\$](#ma                                                                
  crolist-                                                                
  mainconf                                                                
  igfile)                                                                 

  [\$STATU Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SDATAFIL                                                                
  E\$](#ma                                                                
  crolist-                                                                
  statusda                                                                
  tafile)                                                                 

  [\$COMME Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  NTDATAFI                                                                [^5^](#m
  LE\$](#m                                                                acrolist
  acrolist                                                                -note5)
  -comment                                                                
  datafile                                                                
  )                                                                       

  [\$DOWNT Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  IMEDATAF                                                                
  ILE\$](#                                                                
  macrolis                                                                
  t-downti                                                                
  medatafi                                                                
  le)                                                                     

  [\$RETEN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TIONDATA                                                                
  FILE\$](                                                                
  #macroli                                                                
  st-reten                                                                
  tiondata                                                                
  file)                                                                   

  [\$OBJEC Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  TCACHEFI                                                                
  LE\$](#m                                                                
  acrolist                                                                
  -objectc                                                                
  achefile                                                                
  )                                                                       

  [\$TEMPF Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ILE\$](#                                                                
  macrolis                                                                
  t-tempfi                                                                
  le)                                                                     

  [\$TEMPP Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ATH\$](#                                                                
  macrolis                                                                
  t-temppa                                                                
  th)                                                                     

  [\$LOGFI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  LE\$](#m                                                                
  acrolist                                                                
  -logfile                                                                
  )                                                                       

  [\$RESOU Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  RCEFILE\                                                                
  $](#macr                                                                
  olist-re                                                                
  sourcefi                                                                
  le)                                                                     

  [\$COMMA Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  NDFILE\$                                                                
  ](#macro                                                                
  list-com                                                                
  mandfile                                                                
  )                                                                       

  [\$HOSTP Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  ERFDATAF                                                                
  ILE\$](#                                                                
  macrolis                                                                
  t-hostpe                                                                
  rfdatafi                                                                
  le)                                                                     

  [\$SERVI Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  CEPERFDA                                                                
  TAFILE\$                                                                
  ](#macro                                                                
  list-ser                                                                
  viceperf                                                                
  datafile                                                                
  )                                                                       

  **Makron **Servic **Servic **Host-  **Host-  **Servic **Host-  **Servic **Host-
  ame**    e-       e-       Prüfunge Benachri e-       Eventhan e-       Perf-Dat
           Prüfunge Benachri n**      chtigung Eventhan dler     Perf-Dat en**
           n**      chtigung          en**     dler     und      en**     
                    en**                       und      [OCNAME-          
                                               [OCSP](# HP](#con          
                                               configma figmain-          
                                               in-ocsp_ ochp_com          
                                               command) mand)**           
                                               **                         

  verschie
  dene
  Makros:

  [\$PROCE Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  SSSTARTT                                                                
  IME\$](#                                                                
  macrolis                                                                
  t-proces                                                                
  sstartti                                                                
  me)                                                                     

  [\$EVENT Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  STARTTIM                                                                
  E\$](#ma                                                                
  crolist-                                                                
  eventsta                                                                
  rttime)                                                                 

  [\$ADMIN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  EMAIL\$]                                                                
  (#macrol                                                                
  ist-admi                                                                
  nemail)                                                                 

  [\$ADMIN Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  PAGER\$]                                                                
  (#macrol                                                                
  ist-admi                                                                
  npager)                                                                 

  [\$ARGn\ Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  $](#macr                                                                
  olist-ar                                                                
  g)                                                                      

  [\$USERn Ja       Ja       Ja       Ja       Ja       Ja       Ja       Ja
  \$](#mac                                                                
  rolist-u                                                                
  ser)                                                                    
  -------- -------- -------- -------- -------- -------- -------- -------- --------

**Makrobeschreibungen**

  ---------------- -------------------------------------------------------
  Host-Makros:
  [^3^](#macrolist
  -note3)

  \$HOSTNAME\$     Kurzname für den Host (z.B. "biglinuxbox"). Dieser Wert
                   wird aus der *host\_name*-Direktive in der
                   [Host-Definition](#objectdefinitions-host) genommen.

  \$HOSTDISPLAYNAM Ein alternativer Anzeigename für den Host. Dieser Wert
  E\$              wird aus der *display\_name*-Direktive in der
                   [Host-Definition](#objectdefinitions-host) genommen.

  \$HOSTALIAS\$    Langname/Beschreibung für den Host. Dieser Wert wird
                   aus der *alias*-Direktive in der
                   [Host-Definition](#objectdefinitions-host) genommen.

  \$HOSTADDRESS\$  Adresse des Hosts. Dieser Wert wird aus der
                   *address*-Direktive in der
                   [Host-Definition](#objectdefinitions-host) genommen.

  \$HOSTADDRESS\$  Sekundäre/IPv6-Adresse des Hosts. Dieser Wert wird aus
                   der *address6*-Direktive in der
                   [Host-Definition](#objectdefinitions-host) genommen.

  \$HOSTSTATE\$    Eine Zeichenkette, die den aktuellen Status des Hosts
                   angibt ("UP", "DOWN" oder "UNREACHABLE").

  \$HOSTSTATEID\$  Eine Zahl, die dem aktuellen Status des Hosts
                   entspricht: 0=UP, 1=DOWN, 2=UNREACHABLE.

  \$LASTHOSTSTATE\ Eine Zeichenkette, die den letzten Status des Hosts
  $                angibt ("UP", "DOWN" oder "UNREACHABLE").

  \$LASTHOSTSTATEI Eine Zahl, die dem letzten Status des Hosts entspricht:
  D\$              0=UP, 1=DOWN, 2=UNREACHABLE.

  \$HOSTSTATETYPE\ Eine Zeichenkette, die den [Statustyp](#statetypes) der
  $                aktuellen Host-Prüfung angibt ("HARD" oder "SOFT"). Ein
                   Soft-Status tritt auf, wenn eine Host-Prüfung einen
                   nicht-OK (nicht-UP) Status zurückliefert und noch
                   Wiederholungen anstehen. Ein Hard-Status liegt vor,
                   wenn die Anzahl der Host-Prüfungs-Wiederholungen einen
                   maximal definierten Wert erreicht hat.

  \$HOSTATTEMPT\$  Die Anzahl der aktuellen Host-Prüfungs-Wiederholungen.
                   Wenn dies beispielsweise das zweite Mal ist, dass der
                   Host erneut geprüft wird, dann steht hier die Zahl
                   zwei. Die aktuelle Wiederholungsanzahl ist eigentlich
                   nur dann sinnvoll, wenn man Eventhandler für
                   Soft-Zustände schreibt, die auf einer bestimmten Aktion
                   für diese entsprechende Zahl basieren.

  \$MAXHOSTATTEMPT Die max. Prüfversuche, wie sie für den aktuellen Host
  S\$              definiert sind. Nützlich, wenn man Host-Eventhandler
                   für "Soft"-Zustände schreibt, die eine bestimmte Aktion
                   ausführen basierend auf der Host-Wiederholungsanzahl.

  \$HOSTEVENTID\$  Eine global eindeutige Zahl verbunden mit dem aktuellen
                   Status des Hosts. Jedes Mal, wenn eine Host- (oder
                   Service-) Statusänderung eintritt, wird eine globale
                   Ereignis-ID-Nummer um eins (1) erhöht. Falls bei einem
                   Host keine Statusänderung eintritt, wird dieses Makro
                   auf Null (0) gesetzt.

  \$LASTHOSTEVENTI Die vorherige (global eindeutige) Ereigniszahl, die für
  D\$              den Host vergeben wurde.

  \$HOSTPROBLEMID\ Eine global eindeutige Zahl verbunden mit dem aktuellen
  $                Problemstatus des Hosts. Jedes Mal, wenn ein Host (oder
                   Service) von einem UP- oder OK-Status in einen
                   Problemzustand wechselt, wird eine globale Problem-ID
                   um eins (1) erhöht. Dieses Makro wird ungleich Null
                   sein, wenn der Host sich gerade in einem Zustand
                   ungleich UP befindet. Statuswechsel zwischen Zuständen
                   ungleich UP (z.B. DOWN oder UNREACHABLE) erhöhen diese
                   Problem-ID nicht. Wenn sich der Host gerade in einem
                   UP-Zustand befindet, wird dieses Makro auf Null (0)
                   gesetzt. In Kombination mit Eventhandlern kann dieses
                   Makro benutzt werden, um automatisch ein Trouble-Ticket
                   zu eröffnen, wenn Hosts das erste Mal einen
                   Problemzustand erreichen.

  \$LASTHOSTPROBLE Die vorherige (global eindeutige) Ereigniszahl, die für
  MID\$            den Host vergeben wurde. In Kombination mit
                   Eventhandlern kann dieses Makro benutzt werden, um
                   automatisch ein Trouble-Ticket zu schließen, wenn Hosts
                   in einen UP-Status zurückkehren.

  \$HOSTLATENCY\$  Eine (Fließkomma-) Zahl, die die Anzahl von Sekunden
                   angibt, um die eine *geplante* Host-Prüfung nach der
                   eigentlichen Planungszeit stattfand. Wenn
                   beispielsweise eine Prüfung für 03:14:15 geplant war
                   und erst um 03:14:17 ausgeführt wurde, dann beträgt die
                   Verzögerung 2.0 Sekunden. On-Demand-Host-Prüfungen
                   haben eine Verzögerung von null Sekunden.

  \$HOSTEXECUTIONT Eine (Fließkomma-) Zahl, die die Dauer der Ausführung
  IME\$            einer Host-Prüfung in Sekunden angibt.

  \$HOSTDURATION\$ Eine Zeichenkette, die die Zeitdauer angibt, die sich
                   der Host im aktuellen Status befindet. Das Format ist
                   "XXh YYm ZZs" und gibt die Stunden, Minuten und
                   Sekunden an.

  \$HOSTDURATIONSE Eine Zahl, die die Zeitdauer in Sekunden angibt, die
  C\$              sich der Host im aktuellen Status befindet.

  \$HOSTDOWNTIME\$ Eine Zahl, die die aktuelle "Downtime-Tiefe" für den
                   Host angibt. Wenn dieser Host sich gerade in einer
                   Phase einer [geplanten Downtime](#downtime) befindet,
                   ist dieser Wert größer als Null. Ist der Host nicht
                   gerade in einer Downtime-Phase, ist dieser Wert Null.

  \$HOSTPERCENTCHA Eine (Fließkomma-) Zahl, die den prozentualen
  NGE\$            Statuswechsel angibt, dem der Host unterworfen war.
                   Dieser Wert wird vom [flap
                   detection](#flapping)-Algorithmus benutzt.

  \$HOSTGROUPNAME\ Der Kurzname der Hostgruppe, zu der dieser Host gehört.
  $                Dieser Wert wird aus der *hostgroup\_name*-Direktive in
                   der
                   [hostgroup-Definition](#objectdefinitions-hostgroup)
                   entnommen. Wenn der Host zu mehreren Hostgruppen
                   gehört, enthält dieses Makro nur einen der Namen.

  \$HOSTGROUPNAMES Eine Komma-separierte Liste der Kurznamen aller
  \$               Hostgruppen, zu denen dieser Host gehört.

  \$LASTHOSTCHECK\ Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  $                seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt eine Prüfung des Hosts stattfand.

  \$LASTHOSTSTATEC Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  HANGE\$          seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt ein Statuswechsel des Hosts stattfand.

  \$LASTHOSTUP\$   Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
                   seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Host in einem
                   UP-Zustand befand.

  \$LASTHOSTDOWN\$ Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
                   seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Host in einem
                   DOWN-Zustand befand.

  \$LASTHOSTUNREAC Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  HABLE\$          seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Host in einem
                   UNREACHABLE-Zustand befand.

  \$HOSTOUTPUT\$   Die erste Zeile von Textausgaben der letzten
                   Host-Prüfung (z.B. "Ping OK")

  \$LONGHOSTOUTPUT Die vollständige Textausgabe (außer der ersten Zeile)
  \$               der letzten Host-Prüfung.

  \$HOSTPERFDATA\$ Dieses Makro enthält jegliche
                   [Performance-Daten](#perfdata), die von der letzten
                   Host-Prüfung geliefert worden sein könnten.

  \$HOSTCHECKCOMMA Dieses Makro enthält den Namen des Befehls (zusammen
  ND\$             mit übergebenen Argumenten), der zur Host-Prüfung
                   benutzt wurde.

  \$HOSTACKAUTHOR\ Eine Zeichenkette, die den Namen des Benutzers enthält,
  $[^8^](#macrolis der das Host-Problem bestätigt hat. Dieses Makro ist
  t-note8)         nur gültig bei Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$HOSTACKAUTHORN Eine Zeichenkette, die den Kurznamen der Kontaktperson
  AME\$[^8^](#macr (falls zutreffend) enthält, die das Host-Problem
  olist-note8)     bestätigt hat. Dieses Makro ist nur gültig bei
                   Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$HOSTACKAUTHORA Eine Zeichenkette, die den Alias der Kontaktperson
  LIAS\$[^8^](#mac (falls zutreffend) enthält, die das Host-Problem
  rolist-note8)    bestätigt hat. Dieses Makro ist nur gültig bei
                   Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$HOSTACKCOMMENT Eine Zeichenkette, die den Bestätigungskommentar
  \$[^8^](#macroli enthält, den der Benutzer eingegeben hat, der das
  st-note8)        Host-Problem bestätigt hat. Dieses Makro ist nur gültig
                   bei Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$HOSTACTIONURL\ Der Action-URL für den Host. Dieses Makro kann andere
  $                Makros enthalten (z.B. \$HOSTNAME\$), was nützlich sein
                   kann, wenn man den Hostnamen an eine Web-Seite
                   übergeben will.

  \$HOSTNOTESURL\$ Der Anmerkungs-URL für den Host. Dieses Makro kann
                   andere Makros enthalten (z.B. \$HOSTNAME\$), was
                   nützlich sein kann, wenn man den Hostnamen an eine
                   Web-Seite übergeben will.

  \$HOSTNOTES\$    Anmerkungen für den Host. Dieses Makro kann andere
                   Makros enthalten (z.B. \$HOSTNAME\$), was nützlich sein
                   kann, wenn man Hostspezifische Statusinformationen in
                   der Beschreibung haben möchte.

  \$TOTALHOSTSERVI Die Gesamtzahl von Services, die mit dem Host verbunden
  CES\$            sind.

  \$TOTALHOSTSERVI Die Gesamtzahl von Services im OK-Zustand, die mit dem
  CESOK\$          Host verbunden sind.

  \$TOTALHOSTSERVI Die Gesamtzahl von Services im WARNING-Zustand, die mit
  CESWARNING\$     dem Host verbunden sind.

  \$TOTALHOSTSERVI Die Gesamtzahl von Services im UNKNOWN-Zustand, die mit
  CESUNKNOWN\$     dem Host verbunden sind.

  \$TOTALHOSTSERVI Die Gesamtzahl von Services im CRITICAL-Zustand, die
  CESCRITICAL\$    mit dem Host verbunden sind.

  Hostgroup-Makros
  :
  [^5^](#macrolist
  -note5)

  \$HOSTGROUPALIAS Der Langname / Alias entweder des 1) Hostgruppennamens,
  \$[^5^](#macroli der als On-Demand-Makro-Argument übergeben wurde oder
  st-note5)        2) der primären Hostgruppe, die mit dem aktuellen Host
                   verbunden ist (falls sie nicht im Zusammenhang mit
                   einem On-Demand-Makro benutzt wurde). Dieser Wert wird
                   aus der *alias*-Direktive in der
                   [hostgroup-Definition](#objectdefinitions-hostgroup)
                   genommen.

  \$HOSTGROUPMEMBE Eine Komma-separierte Liste aller Hosts, die entweder
  RS\$[^5^](#macro 1) zu dem Hostgruppennamen gehören, der als
  list-note5)      On-Demand-Makro-Argument übergeben wurde, oder 2) zu
                   der primären Hostgruppe gehören, die mit dem aktuellen
                   Host verbunden ist (falls sie nicht im Zusammenhang mit
                   einem On-Demand-Makro benutzt wurde).

  \$HOSTGROUPNOTES Die Anmerkungen, die verbunden sind mit entweder 1) dem
  \$[^5^](#macroli Hostgroup-Namen, der als On-Demand-Makro-Argument
  st-note5)        übergeben wurde oder 2) der primären Hostgruppe, die
                   mit dem aktuellen Host verbunden ist (falls sie nicht
                   im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der *notes*-Direktive in
                   der
                   [hostgroup-Definition](#objectdefinitions-hostgroup)
                   genommen.

  \$HOSTGROUPNOTES Der Anmerkungs-URL, der verbunden ist mit entweder 1)
  URL\$[^5^](#macr dem Hostgroup-Namen, der als On-Demand-Makro-Argument
  olist-note5)     übergeben wurde oder 2) der primären Hostgruppe, die
                   mit dem aktuellen Host verbunden ist (falls sie nicht
                   im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der *notes\_url*-Direktive
                   in der
                   [hostgroup-Definition](#objectdefinitions-hostgroup)
                   genommen.

  \$HOSTGROUPACTIO Der Action-URL, der verbunden ist mit entweder 1) dem
  NURL\$[^5^](#mac Hostgroup-Namen, der als On-Demand-Makro-Argument
  rolist-note5)    übergeben wurde oder 2) der primären Hostgruppe, die
                   mit dem aktuellen Host verbunden ist (falls sie nicht
                   im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der
                   *action\_url*-Direktive in der
                   [hostgroup-Definition](#objectdefinitions-hostgroup)
                   genommen.

  Service-Makros:

  \$SERVICEDESC\$  Der Langname/die Beschreibung des Service (z.B. "Main
                   Website"). Dieser Wert wird aus der
                   *description*-Direktive der
                   [Service-Definition](#objectdefinitions-service)
                   genommen.

  \$SERVICEDISPLAY Ein alternativer Anzeigename für den Service. Dieser
  NAME\$           Wert wird aus der *display\_name*-Direktive der
                   [Service-Definition](#objectdefinitions-service)
                   genommen.

  \$SERVICESTATE\$ Eine Zeichenkette, die den aktuellen Status des Service
                   anzeigt ("OK", "WARNING", "UNKNOWN" oder "CRITICAL").

  \$SERVICESTATEID Eine Zahl, die dem aktuellen Status des Service
  \$               entspricht: 0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN.

  \$LASTSERVICESTA Eine Zeichenkette, die den letzten Status des Service
  TE\$             angibt ("OK", "WARNING", "UNKNOWN" oder "CRITICAL").

  \$LASTSERVICESTA Eine Zahl, die dem letzten Status des Service
  TEID\$           entspricht: 0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN.

  \$SERVICESTATETY Eine Zeichenkette, die den [Statustyp](#statetypes) für
  PE\$             die aktuelle Service-Prüfung anzeigt ("HARD" oder
                   "SOFT"). Ein Soft-Status tritt auf, wenn eine
                   Service-Prüfung einen nicht-OK Status zurückliefert und
                   noch Wiederholungen anstehen. Ein Hard-Status liegt
                   vor, wenn die Anzahl der Service-Prüfungswiederholungen
                   einen maximal definierten Wert erreicht hat.

  \$SERVICEATTEMPT Die Anzahl der aktuellen
  \$               Service-Prüfungswiederholungen. Wenn dies
                   beispielsweise das zweite Mal ist, dass der Service
                   erneut geprüft wird, dann steht hier die Zahl zwei. Die
                   aktuelle Wiederholungsanzahl ist eigentlich nur dann
                   sinnvoll, wenn man Eventhandler für Soft-Zustände
                   schreibt, die auf einer bestimmten Aktion für diese
                   entsprechende Zahl basieren.

  \$MAXSERVICEATTE Die max. Prüfversuche, wie sie für den aktuellen
  MPTS\$           Service definiert sind. Nützlich, wenn man
                   Service-Eventhandler für "Soft"-Zustände schreibt, die
                   eine bestimmte Aktion ausführen basierend auf der
                   Service-Wiederholungsanzahl.

  \$SERVICEISVOLAT Zeigt an, ob der Service als sprunghaft ("volatile")
  ILE\$            markiert ist: 0 = not volatile, 1 = volatile.

  \$SERVICEEVENTID Eine global eindeutige Zahl verbunden mit dem aktuellen
  \$               Status des Service. Jedes Mal, wenn eine Service- (oder
                   Host-) Statusänderung eintritt, wird eine globale
                   Ereignis-ID-Nummer um eins (1) erhöht. Falls bei einem
                   Service keine Statusänderung eintritt, wird dieses
                   Makro auf Null (0) gesetzt.

  \$LASTSERVICEEVE Die vorherige (global eindeutige) Ereigniszahl, die für
  NTID\$           den Service vergeben wurde.

  \$SERVICEPROBLEM Eine global eindeutige Zahl verbunden mit dem aktuellen
  ID\$             Problemstatus des Service. Jedes Mal, wenn ein Service
                   (oder Host) von einem UP- oder OK-Status in einen
                   Problemzustand wechselt, wird eine globale Problem-ID
                   um eins (1) erhöht. Dieses Makro wird ungleich Null
                   sein, wenn der Service sich gerade in einem Zustand
                   ungleich OK befindet. Statuswechsel zwischen Zuständen
                   ungleich OK (z.B. DOWN oder UNREACHABLE) erhöhen diese
                   Problem-ID nicht. Wenn sich der Service gerade in einem
                   OK-Zustand befindet, wird dieses Makro auf Null (0)
                   gesetzt. In Kombination mit Eventhandlern kann dieses
                   Makro benutzt werden, um automatisch ein Trouble-Ticket
                   zu eröffnen, wenn Services das erste Mal einen
                   Problemzustand erreichen.

  \$LASTSERVICEPRO Die vorherige (global eindeutige) Ereigniszahl, die für
  BLEMID\$         den Service vergeben wurde. In Kombination mit
                   Eventhandlern kann dieses Makro benutzt werden, um
                   automatisch ein Trouble-Ticket zu schließen, wenn
                   Services zu einem Up-Status zurückkehren.

  \$SERVICELATENCY Eine (Fließkomma-) Zahl, die die Anzahl von Sekunden
  \$               angibt, um die eine *geplante* Service-Prüfung nach der
                   eigentlichen Planungszeit stattfand. Wenn
                   beispielsweise eine Prüfung für 03:14:15 geplant war
                   und erst um 03:14:17 ausgeführt wurde, dann beträgt die
                   Verzögerung 2.0 Sekunden.

  \$SERVICEEXECUTI Eine (Fließkomma-) Zahl, die die Dauer der Ausführung
  ONTIME\$         einer Service-Prüfung in Sekunden angibt.

  \$SERVICEDURATIO Eine Zeichenkette, die die Zeitdauer angibt, die sich
  N\$              der Service im aktuellen Status befindet. Das Format
                   ist "XXh YYm ZZs" und gibt die Stunden, Minuten und
                   Sekunden an.

  \$SERVICEDURATIO Eine Zahl, die die Zeitdauer in Sekunden angibt, die
  NSEC\$           sich der Service im aktuellen Status befindet.

  \$SERVICEDOWNTIM Eine Zahl, die die aktuelle "Downtime-Tiefe" für den
  E\$              Service angibt. Wenn dieser Service sich gerade in
                   einer Phase einer [geplanten Downtime](#downtime)
                   befindet, ist dieser Wert größer als Null. Ist der
                   Service nicht gerade in einer Downtime-Phase, ist
                   dieser Wert Null.

  \$SERVICEPERCENT Eine (Fließkomma-) Zahl, die den prozentualen
  CHANGE\$         Statuswechsel angibt, der der Service unterworfen war.
                   Dieser Wert wird vom [flap
                   detection](#flapping)-Algorithmus benutzt.

  \$SERVICEGROUPNA Der Kurzname der Servicegruppe, zu der dieser Service
  ME\$             gehört. Dieser Wert wird aus der
                   *servicegroup\_name*-Direktive in der
                   [servicegroup-Definition](#objectdefinitions-servicegro
                   up)
                   entnommen. Wenn der Service zu mehreren Servicegruppen
                   gehört, enthält dieses Makro nur einen der Namen.

  \$SERVICEGROUPNA Eine Komma-separierte Liste von Kurznamen aller
  MES\$            Servicegruppen, zu denen dieser Service gehört.

  \$LASTSERVICECHE Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  CK\$             seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt eine Prüfung des Service stattfand.

  \$LASTSERVICESTA Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  TECHANGE\$       seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt ein Statuswechsel des Service stattfand.

  \$LASTSERVICEOK\ Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  $                seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Service in
                   einem OK-Zustand befand.

  \$LASTSERVICEWAR Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  NING\$           seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Service in
                   einem WARNING-Zustand befand.

  \$LASTSERVICEUNK Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  NOWN\$           seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Service in
                   einem UNKNOWN-Zustand befand.

  \$LASTSERVICECRI Dieses ist ein Zeitstempel im time\_t-Format (Sekunden
  TICAL\$          seit der UNIX-Epoche), der die Zeit angibt, zu der
                   zuletzt festgestellt wurde, dass sich der Service in
                   einem CRITICAL-Zustand befand.

  \$SERVICEOUTPUT\ Die erste Zeile von Textausgaben der letzten
  $                Service-Prüfung (z.B. "Ping OK")

  \$LONGSERVICEOUT Die vollständige Textausgabe (außer der ersten Zeile)
  PUT\$            der letzten Service-Prüfung.

  \$SERVICEPERFDAT Dieses Makro enthält jegliche
  A\$              [Performance-Daten](#perfdata), die von der letzten
                   Service-Prüfung geliefert worden sein könnten.

  \$SERVICECHECKCO Dieses Makro enthält den Namen des Befehls (zusammen
  MMAND\$          mit übergebenen Argumenten), der zur Service-Prüfung
                   benutzt wurde.

  \$SERVICEACKAUTH Eine Zeichenkette, die den Namen des Benutzers enthält,
  OR\$[^8^](#macro der das Service-Problem bestätigt hat. Dieses Makro ist
  list-note8)      nur gültig bei Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$SERVICEACKAUTH Eine Zeichenkette, die den Kurznamen der Kontaktperson
  ORNAME\$[^8^](#m (falls zutreffend) enthält, die das Service-Problem
  acrolist-note8)  bestätigt hat. Dieses Makro ist nur gültig bei
                   Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$SERVICEACKAUTH Eine Zeichenkette, die den Alias der Kontaktperson
  ORALIAS\$[^8^](# (falls zutreffend) enthält, die das Service-Problem
  macrolist-note8) bestätigt hat. Dieses Makro ist nur gültig bei
                   Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$SERVICEACKCOMM Eine Zeichenkette, die den Bestätigungskommentar
  ENT\$[^8^](#macr enthält, den der Benutzer eingegeben hat, der das
  olist-note8)     Service-Problem bestätigt hat. Dieses Makro ist nur
                   gültig bei Benachrichtigungen, bei denen das Makro
                   \$NOTIFICATIONTYPE\$ auf "ACKNOWLEDGEMENT" gesetzt ist.

  \$SERVICEACTIONU Der Action-URL für den Service. Dieses Makro kann
  RL\$             andere Makros enthalten (z.B. \$HOSTNAME\$ oder
                   \$SERVICEDESC\$), was nützlich sein kann, wenn man den
                   Servicenamen an eine Web-Seite übergeben will.

  \$SERVICENOTESUR Der Anmerkungs-URL für den Service. Dieses Makro kann
  L\$              andere Makros enthalten (z.B. \$HOSTNAME\$ oder
                   \$SERVICEDESC\$), was nützlich sein kann, wenn man den
                   Servicenamen an eine Web-Seite übergeben will.

  \$SERVICENOTES\$ Anmerkungen für den Service. Dieses Makro kann andere
                   Makros enthalten (z.B. \$HOSTNAME\$ oder
                   \$SERVICEDESC\$), was nützlich sein kann, wenn man
                   Servicespezifische Statusinformationen in der
                   Beschreibung haben möchte.

  Servicegroup-Mak
  ros:
  [^6^](#macrolist
  -note6)

  \$SERVICEGROUPAL Der Langname / Alias entweder des 1)
  IAS\$[^6^](#macr Servicegroup-Namens, der als On-Demand-Makro-Argument
  olist-note6)     übergeben wurde oder 2) der primären Servicegruppe, die
                   mit dem aktuellen Service verbunden ist (falls sie
                   nicht im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der *alias*-Direktive in
                   der
                   [servicegroup-Definition](#objectdefinitions-servicegro
                   up)
                   genommen.

  \$SERVICEGROUPME Eine Komma-separierte Liste aller Services, die
  MBERS\$[^6^](#ma entweder 1) zu dem Servicegruppennamen gehören, der als
  crolist-note6)   On-Demand-Makro-Argument übergeben wurde, oder 2) zu
                   der primären Servicegruppe gehören, die mit dem
                   aktuellen Service verbunden ist (falls sie nicht im
                   Zusammenhang mit einem On-Demand-Makro benutzt wurde).

  \$SERVICEGROUPNO Die Anmerkungen, die verbunden sind mit entweder 1) dem
  TES\$[^6^](#macr Servicegroup-Namen, der als On-Demand-Makro-Argument
  olist-note6)     übergeben wurde oder 2) der primären Servicegruppe, die
                   mit dem aktuellen Host verbunden ist (falls sie nicht
                   im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der *notes*-Direktive in
                   the
                   [servicegroup-Definition](#objectdefinitions-servicegro
                   up)
                   genommen.

  \$SERVICEGROUPNO Der Anmerkungs-URL, der verbunden sind mit entweder 1)
  TESURL\$[^6^](#m dem Servicegroup-Namen, der als
  acrolist-note6)  On-Demand-Makro-Argument übergeben wurde oder 2) der
                   primären Servicegruppe, die mit dem aktuellen Service
                   verbunden ist (falls sie nicht im Zusammenhang mit
                   einem On-Demand-Makro benutzt wurde). Dieser Wert wird
                   aus der *notes\_url*-Direktive in der
                   [servicegroup-Definition](#objectdefinitions-servicegro
                   up)
                   genommen.

  \$SERVICEGROUPAC Der Action-URL, der verbunden sind mit entweder 1) dem
  TIONURL\$[^6^](# Servicegroup-Namen, der als On-Demand-Makro-Argument
  macrolist-note6) übergeben wurde oder 2) der primären Servicegruppe, die
                   mit dem aktuellen Service verbunden ist (falls sie
                   nicht im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der
                   *action\_url*-Direktive in der
                   [servicegroup-Definition](#objectdefinitions-servicegro
                   up)
                   genommen.

  Contact-Makros:

  \$CONTACTNAME\$  Kurzname für den Kontakt (z.B. "mmustermann"), der über
                   ein Host- oder Service-Problem informiert wird. Dieser
                   Wert wird aus der *contact\_name*-Direktive in der
                   [contact-Definition](#objectdefinitions-contact)
                   genommen.

  \$CONTACTALIAS\$ Langname/Beschreibung für den Kontakt, der informiert
                   wird. Dieser Wert wird aus der *alias*-Direktive in der
                   [contact-Definition](#objectdefinitions-contact)
                   genommen.

  \$CONTACTEMAIL\$ e-Mail-Adresse für den Kontakt, der informiert wird.
                   Dieser Wert wird aus der *email*-Direktive in der
                   [contact-Definition](#objectdefinitions-contact)
                   genommen.

  \$CONTACTPAGER\$ Pager-Nummer/-Adresse für den Kontakt, der informiert
                   wird. Dieser Wert wird aus der *pager*-Direktive in der
                   [contact-Definition](#objectdefinitions-contact)
                   genommen.

  \$CONTACTADDRESS Adresse für den Kontakt, der informiert wird. Jeder
  n\$              Kontakt kann sechs verschiedene Adressen haben
                   (zusätzlich zur e-Mail-Adresse und Pager-Nummer). Die
                   Makros für diese Adressen sind \$CONTACTADDRESS1\$ -
                   \$CONTACTADDRESS6\$. Dieser Wert wird aus der
                   *addressx*-Direktive in der
                   [contact-Definition](#objectdefinitions-contact)
                   genommen.

  \$CONTACTGROUPNA Der Kurzname für die Kontaktgruppe, deren Mitglied der
  ME\$             Kontakt ist. Dieser Wert wird aus der
                   *contact\_group*-Direktive in der
                   [contactgroup-Definition](#objectdefinitions-contactgro
                   up)
                   genommen.

  \$CONTACTGROUPNA Eine Komma-separierte Liste der Kurznamen aller
  MES\$            Kontaktgruppen, deren Mitglied dieser Kontakt ist.

  Contactgroup-Mak
  ros:
  [^5^](#macrolist
  -note5)

  \$CONTACTGROUPAL Der Langname / Alias entweder des 1)
  IAS\$[^7^](#macr Contactgroup-Namens, der als On-Demand-Makro-Argument
  olist-note7)     übergeben wurde oder 2) der primären Kontaktgruppe, die
                   mit dem aktuellen Kontakt verbunden ist (falls sie
                   nicht im Zusammenhang mit einem On-Demand-Makro benutzt
                   wurde). Dieser Wert wird aus der *alias*-Direktive in
                   der
                   [contactgroup-Definition](#objectdefinitions-contactgro
                   up)
                   genommen.

  \$CONTACTGROUPME Eine Komma-separierte Liste aller Kontakte, die
  MBERS\$[^7^](#ma entweder 1) zu dem Kontaktgruppennamen gehören, der als
  crolist-note7)   On-Demand-Makro-Argument übergeben wurde, oder 2) zu
                   der primären Kontaktgruppe gehören, die mit dem
                   aktuellen Kontakt verbunden ist (falls sie nicht im
                   Zusammenhang mit einem On-Demand-Makro benutzt wurde).

  Auswertungs-Makr
  os:

  \$TOTALHOSTSUP\$ Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
                   in einem UP-Zustand befinden.

  \$TOTALHOSTSDOWN Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  \$               in einem DOWN-Zustand befinden.

  \$TOTALHOSTSUNRE Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  ACHABLE\$        in einem UNREACHABLE-Zustand befinden.

  \$TOTALHOSTSDOWN Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  UNHANDLED\$      in einem DOWN-Status befinden und "unbehandelt" sind.
                   Unbehandelte Host-Probleme sind solche, die nicht
                   bestätigt sind, sich nicht in einer geplanten Downtime
                   befinden, und für die Prüfungen momentan aktiviert
                   sind.

  \$TOTALHOSTSUNRE Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  ACHABLEUNHANDLED in einem UNREACHABLE-Status befinden und "unbehandelt"
  \$               sind. Unbehandelte Host-Probleme sind solche, die nicht
                   bestätigt sind, sich nicht in einer geplanten Downtime
                   befinden, und für die Prüfungen momentan aktiviert
                   sind.

  \$TOTALHOSTPROBL Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  EMS\$            in einem DOWN- oder UNREACHABLE-Status befinden.

  \$TOTALHOSTPROBL Dieses Makro gibt die Gesamtzahl der Hosts an, die sich
  EMSUNHANDLED\$   in einem DOWN- oder UNREACHABLE-Status befinden und
                   "unbehandelt" sind. Unbehandelte Host-Probleme sind
                   solche, die nicht bestätigt sind, sich nicht in einer
                   geplanten Downtime befinden, und für die Prüfungen
                   momentan aktiviert sind.

  \$TOTALSERVICESO Dieses Makro gibt die Gesamtzahl der Services an, die
  K\$              sich in einem OK-Status befinden.

  \$TOTALSERVICESW Dieses Makro gibt die Gesamtzahl der Services an, die
  ARNING\$         sich in einem WARNING-Status befinden.

  \$TOTALSERVICESC Dieses Makro gibt die Gesamtzahl der Services an, die
  RITICAL\$        sich in einem CRITICAL-Status befinden.

  \$TOTALSERVICESU Dieses Makro gibt die Gesamtzahl der Services an, die
  NKNOWN\$         sich in einem UNKNOWN-Status befinden.

  \$TOTALSERVICESW Dieses Makro gibt die Gesamtzahl der Services an, die
  ARNINGUNHANDLED\ sich in einem WARNING-Status befinden und "unbehandelt"
  $                sind. Unbehandelte Service-Probleme sind solche, die
                   nicht bestätigt sind, sich nicht in einer geplanten
                   Downtime befinden, und für die Prüfungen momentan
                   aktiviert sind.

  \$TOTALSERVICESC Dieses Makro gibt die Gesamtzahl der Services an, die
  RITICALUNHANDLED sich in einem CRITICAL-Status befinden und
  \$               "unbehandelt" sind. Unbehandelte Service-Probleme sind
                   solche, die nicht bestätigt sind, sich nicht in einer
                   geplanten Downtime befinden, und für die Prüfungen
                   momentan aktiviert sind.

  \$TOTALSERVICESU Dieses Makro gibt die Gesamtzahl der Services an, die
  NKNOWNUNHANDLED\ sich in einem UNKNOWN-Status befinden und "unbehandelt"
  $                sind. Unbehandelte Service-Probleme sind solche, die
                   nicht bestätigt sind, sich nicht in einer geplanten
                   Downtime befinden, und für die Prüfungen momentan
                   aktiviert sind.

  \$TOTALSERVICEPR Dieses Makro gibt die Gesamtzahl der Services an, die
  OBLEMS\$         sich in einem WARNING-, CRITICAL- oder UNKNOWN-Status
                   befinden.

  \$TOTALSERVICEPR Dieses Makro gibt die Gesamtzahl der Services an, die
  OBLEMSUNHANDLED\ sich in einem WARNING-, CRITICAL- oder UNKNOWN-Status
  $                befinden und "unbehandelt" sind. Unbehandelte
                   Service-Probleme sind solche, die nicht bestätigt sind,
                   sich nicht in einer geplanten Downtime befinden, und
                   für die Prüfungen momentan aktiviert sind.

  Benachrichtigung
  s-Makros:

  \$NOTIFICATIONTY Eine Zeichenkette, die den Typ der Benachrichtigung
  PE\$             angibt, die versandt wird ("PROBLEM", "RECOVERY",
                   "ACKNOWLEDGEMENT", "FLAPPINGSTART", "FLAPPINGSTOP",
                   "FLAPPINNAME-GDISABLED", "DOWNTIMESTART", "DOWNTIMEEND"
                   oder "DOWNTIMECANCELLED").

  \$NOTIFICATIONRE Eine Komma-separierte Liste der Kurznamen von allen
  CIPIENTS\$       Kontakten, die über den Host oder Service
                   benachrichtigt werden.

  \$NOTIFICATIONIS Eine Ganzzahl, die angibt, ob diese Benachrichtigung an
  ESCALATED\$      normale Kontakte für den Host oder Service versandt
                   wurde, oder ob sie eskaliert wurde. 0 = normale
                   (nicht-eskalierte) Benachrichtigung, 1 = eskalierte
                   Benachrichtigung

  \$NOTIFICATIONAU Eine Zeichenkette, die den Namen des Benutzers angibt,
  THOR\$           der die Benachrichtigung geschrieben hat. Falls das
                   \$NOTIFICATIONTYPE\$-Makro auf "DOWNTIMESTART" oder
                   "DOWNTIMEEND" gesetzt ist, wird es der Name des
                   Benutzers sein, der die Downtime für den Host oder
                   Service geplant hat. Falls das
                   \$NOTIFICATIONTYPE\$-Makro auf "ACKNOWLEDGEMENT"
                   gesetzt ist, wird es der Name des Benutzers sein, der
                   das Problem für den Host oder Service bestätigt hat.
                   Falls das \$NOTIFICATIONTYPE\$-Makro auf "CUSTOM"
                   gesetzt ist, wird es der Name des Benutzers sein, der
                   die benutzerdefinierte Benachrichtigung für den Host
                   oder Service ausgelöst hat.

  \$NOTIFICATIONAU Eine Zeichenkette, die den Kurznamen des Kontakts
  THORNAME\$       (falls zutreffend) enthält, der im Makro
                   \$NOTIFICATIONAUTHOR\$ angegeben wurde.

  \$NOTIFICATIONAU Eine Zeichenkette, die den Alias des Kontakts (falls
  THORALIAS\$      zutreffend) enthält, der im Makro
                   \$NOTIFICATIONAUTHOR\$ angegeben wurde.

  \$NOTIFICATIONCO Eine Zeichenkette, die den Kommentar des Benutzers
  MMENT\$          angibt, der die Benachrichtigung geschrieben hat. Falls
                   das \$NOTIFICATIONTYPE\$-Makro auf "DOWNTIMESTART" oder
                   "DOWNTIMEEND" gesetzt ist, wird es der Kommentar des
                   Benutzers sein, der die Downtime für den Host oder
                   Service geplant hat. Falls das
                   \$NOTIFICATIONTYPE\$-Makro auf "ACKNOWLEDGEMENT"
                   gesetzt ist, wird es der Kommentar des Benutzers sein,
                   der das Problem für den Host oder Service bestätigt
                   hat. Falls das \$NOTIFICATIONTYPE\$-Makro auf "CUSTOM"
                   gesetzt ist, wird es der Kommentar des Benutzers sein,
                   der die benutzerdefinierte Benachrichtigung für den
                   Host oder Service ausgelöst hat.

  \$HOSTNOTIFICATI Die aktuelle Benachrichtigungsnummer für den Host. Die
  ONNUMBER\$       Benachrichtigungsnummer wird jedes Mal um eins (1)
                   erhöht, wenn eine neue Benachrichtigung für den Host
                   versandt wird (außer bei Bestätigungen). Die
                   Benachrichtigungsnummer wird auf Null (0)
                   zurückgesetzt, wenn der Host wieder im UP-Zustand ist
                   (*nachdem* die Benachrichtigung versandt wurde). Die
                   Benachrichtungsnummer wird weder durch Bestätigungen
                   noch durch Benachrichtigungen über "Flap detection"
                   oder geplante Downtimes erhöht.

  \$HOSTNOTIFICATI Eine eindeutige Zahl, die eine Host-Benachrichtigung
  ONID\$           identifiziert. Benachrichtigungsnummern sind eindeutig
                   sowohl für Host- als auch Service-Benachrichtigungen,
                   so dass Sie diese eindeutige Zahl als primären
                   Schlüssel in einer Benachrichtigungs-Datenbank benutzen
                   können. Benachrichtigungsnummern sollten über den
                   Restart des NAME-ICINGA- Prozesses hinweg eindeutig
                   bleiben, solange Sie "state retention" aktiviert haben.
                   Die Benachrichtigungsnummer wird für jede neue
                   Host-Benachrichtigung um eins (1) erhöht, unabhängig
                   von der Anzahl der benachrichtigten Kontakte.

  \$SERVICENOTIFIC Die aktuelle Benachrichtigungsnummer für den Service.
  ATIONNUMBER\$    Die Benachrichtigungsnummer wird jedes Mal um eins (1)
                   erhöht, wenn eine neue Benachrichtigung für den Service
                   versandt wird (außer bei Bestätigungen). Die
                   Benachrichtigungsnummer wird auf Null (0)
                   zurückgesetzt, wenn der Service wieder im OK-Zustand
                   ist (*nachdem* die Benachrichtigung versandt wurde).
                   Die Benachrichtungsnummer wird weder durch
                   Bestätigungen noch durch Benachrichtigungen über "Flap
                   detection" oder geplante Downtimes erhöht.

  \$SERVICENOTIFIC Eine eindeutige Zahl, die eine Service-Benachrichtigung
  ATIONID\$        identifiziert. Benachrichtigungsnummern sind eindeutig
                   sowohl für Host- als auch Service-Benachrichtigungen,
                   so dass Sie diese eindeutige Zahl als primären
                   Schlüssel in einer Benachrichtigungs-Datenbank benutzen
                   können. Benachrichtigungsnummern sollten über den
                   Restart des NAME-ICINGA- Prozesses hinweg eindeutig
                   bleiben, solange Sie "state retention" aktiviert haben.
                   Die Benachrichtigungsnummer wird für jede neue
                   Service-Benachrichtigung um eins (1) erhöht, unabhängig
                   von der Anzahl der benachrichtigten Kontakte.

  Datum-/Zeit-Makr
  os:

  \$LONNAME-GDATET Aktueller Datum-/Zeitstempel (z.B. *Fri Oct 13 00:30:28
  IME\$            CDT 2000*). Das Datum-Format ist festgelegt durch die
                   [date\_format](#configmain-date_format)-Direktive.

  \$SHORTDATETIME\ Aktueller Datum-/Zeitstempel (z.B. *10-13-2000
  $                00:30:28*). Das Datum-Format ist festgelegt durch die
                   [date\_format](#configmain-date_format)-Direktive.

  \$DATE\$         Aktueller Datumstempel (z.B. *10-13-2000*). Das
                   Datum-Format ist festgelegt durch die
                   [date\_format](#configmain-date_format)-Direktive.

  \$TIME\$         Aktueller Zeitstempel (z.B. *00:30:28*).

  \$TIMET\$        Aktueller Zeitstempel im time\_t-Format (Sekunden seit
                   der UNIX-Epoche).

  \$ISVALIDTIME:\$ Dies ist ein spezielles On-Demand-Makro, das 1 oder 0
  [^9^](#macrolist zurückliefert, abhängig davon, ob eine bestimmte Zeit
  -note9)          innerhalb einer angegebenen Zeitperiode gültig ist. Es
                   gibt zwei Arten, dieses Makro zu benutzen:
                   
                   1.  **\$ISVALIDTIME:24x7\$** wird auf "1" gesetzt, wenn
                       die aktuelle Zeit innerhalb der "24x7"-Zeitperiode
                       gültig ist. Falls nicht, wird es auf "0" gesetzt.
                   
                   2.  **\$ISVALIDTIME:24x7:timestamp\$** wird auf "1"
                       gesetzt, wenn die durch das "timestamp"-Argument
                       angegebene Zeit (die im time\_t-Format sein muss)
                       innerhalb der "24x7"-Zeitperiode gültig ist. Falls
                       nicht, wird es auf "0" gesetzt.
                   
                   

  \$NEXTVALIDTIME: Dies ist ein spezielles On-Demand-Makro, das die
  \$[^9^](#macroli nächste gültige Zeit (im time\_t-Format) für eine
  st-note9)        angebene Zeitperiode zurückliefert. Es gibt zwei Arten,
                   dieses Makro zu benutzen:
                   
                   1.  **\$NEXTVALIDTIME:24x7\$** wird die nächste gültige
                       Zeit zurückliefern - ab der aktuellen Zeit -
                       innerhalb der "24x7"-Zeitperiode.
                   
                   2.  **\$NEXTVALIDTIME:24x7:timestamp\$** wird die
                       nächste gültige Zeit zurückliefern - ab der durch
                       das "timestamp"-Argument angegebenen Zeit (die im
                       time\_t-Format sein muss) - innerhalb der
                       "24x7"-Zeitperiode.
                   
                   Falls keine gültige Zeit innerhalb der angegebenen
                   Zeitperiode gefunden werden kann, wird das Makro auf
                   "0" gesetzt.

  Datei-Makros:

  \$MAINCONFIGFILE Der Standort der
  \$               [Hauptkonfigurationsdatei](#configmain) (main config
                   file).

  \$STATUSDATAFILE Der Standort der
  \$               [Statusdaten-Datei](#configmain-status_file) (main
                   config file).

  \$COMMENTDATAFIL Der Standort der Kommentardaten-Datei (comment data
  E\$              file).

  \$DOWNTIMEDATAFI Der Standort der Ausfallzeitendaten-Datei (downtime
  LE\$             data file).

  \$RETENTIONDATAF Der Standort der
  ILE\$            [Aufbewahrungsdaten-Datei](#configmain-state_retention_
                   file)
                   (retention data file).

  \$OBJECTCACHEFIL Der Standort der
  E\$              [Objektzwischenspeicherungs-Datei](#configmain-object_c
                   ache_file)
                   (object cache file).

  \$TEMPFILE\$     Der Standort der [temporären
                   Datei](#configmain-temp_file) (temp file).

  \$TEMPPATH\$     Das durch die [temp
                   path](#configmain-temp_path)-Variable festgelegte
                   Verzeichnis.

  \$LOGFILE\$      Der Standort der [Protokolldatei](#configmain-log_file)
                   (log file).

  \$RESOURCEFILE\$ Der Standort der
                   [Ressource-Datei](#configmain-resource_file) (resource
                   file).

  \$COMMANDFILE\$  Der Standort der
                   [Befehlsdatei](#configmain-command_file) (command
                   file).

  \$HOSTPERFDATAFI Der Standort der Host-Performancedaten-Datei (host
  LE\$             performance data file; falls definiert).

  \$SERVICEPERFDAT Der Standort der Service-Performancedaten-Datei
  AFILE\$          (service performance data file; falls definiert).

  Verschiedene
  Makros:

  \$PROCESSSTARTTI Zeitstempel im time\_t-Format (Sekunden seit der
  ME\$             UNIX-Epoche), die angibt, wann der NAME-ICINGA-Prozess
                   das letzte Mal neu/wieder gestartet wurde. Sie können
                   die Laufzeit durch Subtraktion von \$PROCESSSTARTTIME\$
                   von [\$TIMET\$](#macrolist-timet) ermitteln.

  \$EVENTSTARTTIME Zeitstempel im time\_t-Format (Sekunden seit der
  \$               UNIX-Epoche), die angibt, wann der NAME-ICINGA-Prozess
                   begann, Ereignisse (Prüfungen, usw.) zu verarbeiten.
                   Sie können die Zeit, die NAME-ICINGA zum Start
                   benötigte, durch Subtraktion von \$PROCESSSTARTTIME\$
                   von \$EVENTSTARTTIMET\$ ermitteln.

  \$ADMINEMAIL\$   Globale administrative e-Mail-Adresse. Dieser Wert wird
                   aus der
                   [admin\_email](#configmain-admin_email)-Direktive
                   genommen.

  \$ADMINPAGER\$   Globale administrative Pager-Nummer/-Adresse. Dieser
                   Wert wird aus der
                   [admin\_pager](#configmain-admin_email)-Direktive
                   genommen.

  \$ARGn\$         Das *n*-te an den Befehl (Benachrichtigung,
                   Eventhandler, Service-Prüfungen, usw.) übergebene
                   Argument. NAME-ICINGA unterstützt bis zu 32
                   Argument-Makros (\$ARG1\$ bis \$ARG32\$).

  \$USERn\$        Das *n*-te benutzerdefinierbare Makro. Benutzermakros
                   können in ein oder mehreren [resource
                   files](#configmain-resource_file) definiert werden.
                   NAME-ICINGA unterstützt bis zu 256 User-Makros
                   (\$USER1\$ bis \$USER256\$).
  ---------------- -------------------------------------------------------

**Anmerkungen**

**^1^** Diese Makros sind nicht gültig für den Host, dem sie zugeordnet
sind, wenn der Host gerade geprüft wird (denn die Werte konnten noch
nicht ermittelt werden).

**^2^** Diese Makros sind nicht gültig für den Service, dem sie
zugeordnet sind, wenn der Service gerade geprüft wird (denn die Werte
konnten noch nicht ermittelt werden).

**^3^** Wenn Host-Makros in Service-bezogenen Befehlen benutzt werden
(z.B. Service-Benachrichtigungen, Eventhandler, usw.) verweisen sie auf
den Host, dem der Service zugeordnet ist.

**^4^** Wenn Host- und Service-Auswertungsmakros in Benachrichtigungen
benutzt werden, werden die Summen gefiltert, um so nur die Hosts und
Services zu berücksichtigen, für die die Kontaktperson berechtigt ist
(z.B. Hosts und Services, für die sie Benachrichtigungen erhalten soll).

**^5^** Diese Makros sind normalerweise der ersten/primären Hostgruppe
des aktuellen Hosts zugeordnet. Sie können deshalb in vielen Fällen als
Host-Makros angesehen werden. Allerdings sind diese Makros nicht als
On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Hostgroup-Makros benutzt werden, wenn Sie den Namen einer
Hostgruppe an das Makro übergeben. Beispielsweise würde
\$HOSTGROUPMEMBERS:hg1\$ eine komma-separierte Liste aller
(Host)-Mitglieder der Hostgruppe *hg1* zurückliefern.

**^6^** Diese Makros sind normalerweise der ersten/primären
Servicegruppe des aktuellen Service zugeordnet. Sie können deshalb in
vielen Fällen als Service-Makros angesehen werden. Allerdings sind diese
Makros nicht als On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Servicegroup-Makros benutzt werden, wenn Sie den Namen einer
Servicegruppe an das Makro übergeben. Beispielsweise würde
\$SERVICEGROUPMEMBERS:sg1\$ eine komma-separierte Liste aller
(Service)-Mitglieder der Servicegruppe *sg1* zurückliefern.

**^7^** Diese Makros sind normalerweise der ersten/primären
Kontaktgruppe des aktuellen Kontakts zugeordnet. Sie können deshalb in
vielen Fällen als Kontakt-Makros angesehen werden. Allerdings sind diese
Makros nicht als On-Demand-Makros verfügbar. Statt dessen können sie als
On-Demand-Contaktgroup-Makros benutzt werden, wenn Sie den Namen einer
Kontaktgruppe an das Makro übergeben. Beispielsweise würde
\$CONTACTGROUPMEMBERS:cg1\$ eine komma-separierte Liste aller
(Kontakt)-Mitglieder der Kontaktgruppe *cg1* zurückliefern.

**^8^** Diese Bestätigungsmakros sind veraltet. Nutzen Sie statt dessen
die mehr generischen Makros \$NOTIFICATIONAUTHOR\$,
\$NOTIFICATIONAUTHORNAME\$, \$NOTIFICATIONAUTHORALIAS\$ oder
\$NOTIFICATIONCOMMENT\$

**^9^** Diese Makros sind nur als On-Demand-Makros verfügbar - d.h. Sie
müssen ein zusätzliches Argument übergeben, um sie zu nutzen. Diese
Makros sind nicht als Umgebungsvariablen verfügbar.

**^10^** Auswertungsmakros sind nicht als Umgebungsvariablen verfügbar,
wenn die Option
[use\_large\_installation\_tweaks](#configmain-use_large_installation_tweaks)
aktiviert ist, weil sie ziemlich CPU-intensiv zu berechnen sind.

Makros
Standardmakros in NAME-ICINGA
Makros
Summary Macros
Makros
\$HOSTNAME\$
Makros
\$HOSTDISPLAYNAME\$
Makros
\$HOSTALIAS\$
Makros
\$HOSTADDRESS\$
Makros
\$HOSTSTATE\$
Makros
\$HOSTSTATEID\$
Makros
\$LASTHOSTSTATE\$
Makros
\$LASTHOSTSTATEID\$
Makros
\$HOSTSTATETYPE\$
Makros
\$HOSTATTEMPT\$
Makros
\$MAXHOSTATTEMPTS\$
Makros
\$HOSTEVENTID\$
Makros
\$LASTHOSTEVENTID\$
Makros
\$HOSTPROBLEMID\$
Makros
\$LASTHOSTPROBLEMID\$
Makros
\$HOSTLATENCY\$
Makros
\$HOSTEXECUTIONTIME\$
Makros
\$HOSTDURATION\$
Makros
\$HOSTDURATIONSEC\$
Makros
\$HOSTDOWNTIME\$
Makros
\$HOSTPERCENTCHANGE\$
Makros
\$HOSTGROUPNAME\$
Makros
\$HOSTGROUPNAMES\$
Makros
\$LASTHOSTCHECK\$
Makros
\$LASTHOSTSTATECHANGE\$
Makros
\$LASTHOSTUP\$
Makros
\$LASTHOSTDOWN\$
Makros
\$LASTHOSTUNREACHABLE\$
Makros
\$HOSTOUTPUT\$
Makros
\$LONGHOSTOUTPUT\$
Makros
\$HOSTPERFDATA\$
Makros
\$HOSTCHECKCOMMAND\$
Makros
\$HOSTACKAUTHOR\$
Makros
\$HOSTACKAUTHORNAME\$
Makros
\$HOSTACKAUTHORALIAS\$
Makros
\$HOSTACKCOMMENT\$
Makros
\$HOSTACTIONURL\$
Makros
\$HOSTNOTESURL\$
Makros
\$HOSTNOTES\$
Makros
\$TOTALHOSTSERVICES\$
Makros
\$TOTALHOSTSERVICESOK\$
Makros
\$TOTALHOSTSERVICESWARNING\$
Makros
\$TOTALHOSTSERVICESUNKNOWN\$
Makros
\$TOTALHOSTSERVICESCRITICAL\$
Makros
\$HOSTGROUPALIAS\$
Makros
\$HOSTGROUPMEMBERS\$
Makros
\$HOSTGROUPNOTES\$
Makros
\$HOSTGROUPNOTESURL\$
Makros
\$HOSTGROUPACTIONURL\$
Makros
\$SERVICEDESC\$
Makros
\$SERVICEDISPLAYNAME\$
Makros
\$SERVICESTATE\$
Makros
\$SERVICESTATEID\$
Makros
\$LASTSERVICESTATE\$
Makros
\$LASTSERVICESTATEID\$
Makros
\$SERVICESTATETYPE\$
Makros
\$SERVICEATTEMPT\$
Makros
\$MAXSERVICEATTEMPTS\$
Makros
\$SERVICEISVOLATILE\$
Makros
\$SERVICEEVENTID\$
Makros
\$LASTSERVICEEVENTID\$
Makros
\$SERVICEPROBLEMID\$
Makros
\$LASTSERVICEPROBLEMID\$
Makros
\$SERVICELATENCY\$
Makros
\$SERVICEEXECUTIONTIME\$
Makros
\$SERVICEDURATION\$
Makros
\$SERVICEDURATIONSEC\$
Makros
\$SERVICEDOWNTIME\$
Makros
\$SERVICEPERCENTCHANGE\$
Makros
\$SERVICEGROUPNAME\$
Makros
\$SERVICEGROUPNAMES\$
Makros
\$LASTSERVICECHECK\$
Makros
\$LASTSERVICESTATECHANGE\$
Makros
\$LASTSERVICEOK\$
Makros
\$LASTSERVICEWARNING\$
Makros
\$LASTSERVICEUNKNOWN\$
Makros
\$LASTSERVICECRITICAL\$
Makros
\$SERVICEOUTPUT\$
Makros
\$LONGSERVICEOUTPUT\$
Makros
\$SERVICEPERFDATA\$
Makros
\$SERVICECHECKCOMMAND\$
Makros
\$SERVICEACKAUTHOR\$
Makros
\$SERVICEACKAUTHORNAME\$
Makros
\$SERVICEACKAUTHORALIAS\$
Makros
\$SERVICEACKCOMMENT\$
Makros
\$SERVICEACTIONURL\$
Makros
\$SERVICENOTESURL\$
Makros
\$SERVICENOTES\$
Makros
\$SERVICEGROUPALIAS\$
Makros
\$SERVICEGROUPMEMBERS\$
Makros
\$SERVICEGROUPNOTES\$
Makros
\$SERVICEGROUPNOTESURL\$
Makros
\$SERVICEGROUPACTIONURL\$
Makros
\$CONTACTNAME\$
Makros
\$CONTACTALIAS\$
Makros
\$CONTACTEMAIL\$
Makros
\$CONTACTPAGER\$
Makros
\$CONTACTADDRESSn\$
Makros
\$CONTACTGROUPALIAS\$
Makros
\$CONTACTGROUPMEMBERS\$
Makros
\$TOTALHOSTSUP\$
Makros
\$TOTALHOSTSDOWN\$
Makros
\$TOTALHOSTSUNREACHABLE\$
Makros
\$TOTALHOSTSDOWNUNHANDLED\$
Makros
\$TOTALHOSTSUNREACHABLEUNHANDLED\$
Makros
\$TOTALHOSTPROBLEMS\$
Makros
\$TOTALHOSTPROBLEMSUNHANDLED\$
Makros
\$TOTALSERVICESOK\$
Makros
\$TOTALSERVICESWARNING\$
Makros
\$TOTALSERVICESCRITICAL\$
Makros
\$TOTALSERVICESUNKNOWN\$
Makros
\$TOTALSERVICESWARNINGUNHANDLED\$
Makros
\$TOTALSERVICESCRITICALUNHANDLED\$
Makros
\$TOTALSERVICESUNKNOWNUNHANDLED\$
Makros
\$TOTALSERVICEPROBLEMS\$
Makros
\$TOTALSERVICEPROBLEMSUNHANDLED\$
Makros
\$NOTIFICATIONTYPE\$
Makros
\$NOTIFICATIONRECIPIENTS\$
Makros
\$NOTIFICATIONISESCALATED\$
Makros
\$NOTIFICATIONAUTHOR\$
Makros
\$NOTIFICATIONAUTHORNAME\$
Makros
\$NOTIFICATIONAUTHORALIAS\$
Makros
\$NOTIFICATIONCOMMENT\$
Makros
\$HOSTNOTIFICATIONNUMBER\$
Makros
\$HOSTNOTIFICATIONID\$
Makros
\$SERVICENOTIFICATIONNUMBER\$
Makros
\$SERVICENOTIFICATIONID\$
Makros
\$LONGDATETIME\$
Makros
\$SHORTDATETIME\$
Makros
\$DATE\$
Makros
\$TIME\$
Makros
\$TIMET\$
Makros
\$MAINCONFIGFILE\$
Makros
\$STATUSDATAFILE\$
Makros
\$COMMENTDATAFILE\$
Makros
\$DOWNTIMEDATAFILE\$
Makros
\$RETENTIONDATAFILE\$
Makros
\$OBJECTCACHEFILE\$
Makros
\$TEMPFILE\$
Makros
\$TEMPPATH\$
Makros
\$LOGFILE\$
Makros
\$RESOURCEFILE\$
Makros
\$COMMANDFILE\$
Makros
\$HOSTPERFDATAFILE\$
Makros
\$SERVICEPERFDATAFILE\$
Makros
\$PROCESSSTARTTIME\$
Makros
\$EVENTSTARTTIME\$
Makros
\$ADMINEMAIL\$
Makros
\$ADMINPAGER\$
Makros
\$ARGn\$
Makros
\$USERn\$
Makros
\$HOSTNAME\$
Makros
\$HOSTDISPLAYNAME\$
Makros
\$HOSTALIAS\$
Makros
\$HOSTADDRESS\$
Makros
\$HOSTSTATE\$
Makros
\$HOSTSTATEID\$
Makros
\$LASTHOSTSTATE\$
Makros
\$LASTHOSTSTATEID\$
Makros
\$HOSTSTATETYPE\$
Makros
\$HOSTATTEMPT\$
Makros
\$MAXHOSTATTEMPTS\$
Makros
\$HOSTEVENTID\$
Makros
\$LASTHOSTEVENTID\$
Makros
\$HOSTPROBLEMID\$
Makros
\$LASTHOSTPROBLEMID\$
Makros
\$HOSTLATENCY\$
Makros
\$HOSTEXECUTIONTIME\$
Makros
\$HOSTDURATION\$
Makros
\$HOSTDURATIONSEC\$
Makros
\$HOSTDOWNTIME\$
Makros
\$HOSTPERCENTCHANGE\$
Makros
\$HOSTGROUPNAME\$
Makros
\$HOSTGROUPNAMES\$
Makros
\$LASTHOSTCHECK\$
Makros
\$LASTHOSTSTATECHANGE\$
Makros
\$LASTHOSTUP\$
Makros
\$LASTHOSTDOWN\$
Makros
\$LASTHOSTUNREACHABLE\$
Makros
\$HOSTOUTPUT\$
Makros
\$LONGHOSTOUTPUT\$
Makros
\$HOSTPERFDATA\$
Makros
\$HOSTCHECKCOMMAND\$
Makros
\$HOSTACKAUTHOR\$
Makros
\$HOSTACKAUTHORNAME\$
Makros
\$HOSTACKAUTHORALIAS\$
Makros
\$HOSTACKCOMMENT\$
Makros
\$HOSTNOTESURL\$
Makros
\$HOSTNOTES\$
Makros
\$TOTALHOSTSERVICES\$
Makros
\$TOTALHOSTSERVICESOK\$
Makros
\$TOTALHOSTSERVICESWARNING\$
Makros
\$TOTALHOSTSERVICESUNKNOWN\$
Makros
\$TOTALHOSTSERVICESCRITICAL\$
Makros
\$HOSTGROUPALIAS\$
Makros
\$HOSTGROUPMEMBERS\$
Makros
\$HOSTGROUPNOTES\$
Makros
\$HOSTGROUPNOTESURL\$
Makros
\$HOSTGROUPACTIONURL\$
Makros
\$SERVICEDESC\$
Makros
\$SERVICEDISPLAYNAME\$
Makros
\$SERVICESTATE\$
Makros
\$SERVICESTATEID\$
Makros
\$LASTSERVICESTATE\$
Makros
\$LASTSERVICESTATEID\$
Makros
\$SERVICESTATETYPE\$
Makros
\$SERVICEATTEMPT\$
Makros
\$MAXSERVICEATTEMPTS\$
Makros
\$SERVICEISVOLATILE\$
Makros
\$SERVICEEVENTID\$
Makros
\$LASTSERVICEEVENTID\$
Makros
\$SERVICEPROBLEMID\$
Makros
\$LASTSERVICEPROBLEMID\$
Makros
\$SERVICELATENCY\$
Makros
\$SERVICEEXECUTIONTIME\$
Makros
\$SERVICEDURATION\$
Makros
\$SERVICEDURATIONSEC\$
Makros
\$SERVICEDOWNTIME\$
Makros
\$SERVICEPERCENTCHANGE\$
Makros
\$SERVICEGROUPNAME\$
Makros
\$SERVICEGROUPNAMES\$
Makros
\$LASTSERVICECHECK\$
Makros
\$LASTSERVICESTATECHANGE\$
Makros
\$LASTSERVICEOK\$
Makros
\$LASTSERVICEWARNING\$
Makros
\$LASTSERVICEUNKNOWN\$
Makros
\$LASTSERVICECRITICAL\$
Makros
\$SERVICEOUTPUT\$
Makros
\$LONGSERVICEOUTPUT\$
Makros
\$SERVICEPERFDATA\$
Makros
\$SERVICECHECKCOMMAND\$
Makros
\$SERVICEACKAUTHOR\$
Makros
\$SERVICEACKAUTHORNAME\$
Makros
\$SERVICEACKAUTHORALIAS\$
Makros
\$SERVICEACKCOMMENT\$
Makros
\$SERVICEACTIONURL\$
Makros
\$SERVICENOTESURL\$
Makros
\$SERVICENOTES\$
Makros
\$SERVICEGROUPALIAS\$
Makros
\$SERVICEGROUPMEMBERS\$
Makros
\$SERVICEGROUPNOTES\$
Makros
\$SERVICEGROUPNOTESURL\$
Makros
\$SERVICEGROUPNOTES\$
Makros
\$CONTACTNAME\$
Makros
\$CONTACTALIAS\$
Makros
\$CONTACTEMAIL\$
Makros
\$CONTACTPAGER\$
Makros
\$CONTACTADDRESSn\$
Makros
\$CONTACTGROUPNAME\$
Makros
\$CONTACTGROUPNAMES\$
Makros
\$CONTACTGROUPALIAS\$
Makros
\$CONTACTGROUPMEMBERS\$
Makros
\$TOTALHOSTSUP\$
Makros
\$TOTALHOSTSDOWN\$
Makros
\$TOTALHOSTSUNREACHABLE\$
Makros
\$TOTALHOSTSDOWNUNHANDLED\$
Makros
\$TOTALHOSTSUNREACHABLEUNHANDLED\$
Makros
\$TOTALHOSTPROBLEMS\$
Makros
\$TOTALHOSTPROBLEMSUNHANDLED\$
Makros
\$TOTALSERVICESOK\$
Makros
\$TOTALSERVICESWARNING\$
Makros
\$TOTALSERVICESCRITICAL\$
Makros
\$TOTALSERVICESUNKNOWN\$
Makros
\$TOTALSERVICESWARNINGUNHANDLED\$
Makros
\$TOTALSERVICESCRITICALUNHANDLED\$
Makros
\$TOTALSERVICESUNKNOWNUNHANDLED\$
Makros
\$TOTALSERVICEPROBLEMS\$
Makros
\$TOTALSERVICEPROBLEMSUNHANDLED\$
Makros
\$NOTIFICATIONTYPE\$
Makros
\$NOTIFICATIONRECIPIENTS\$
Makros
\$NOTIFICATIONISESCALATED\$
Makros
\$NOTIFICATIONAUTHOR\$
Makros
\$NOTIFICATIONAUTHORNAME\$
Makros
\$NOTIFICATIONAUTHORALIAS\$
Makros
\$NOTIFICATIONCOMMENT\$
Makros
\$HOSTNOTIFICATIONNUMBER\$
Makros
\$HOSTNOTIFICATIONID\$
Makros
\$SERVICENOTIFICATIONNUMBER\$
Makros
\$SERVICENOTIFICATIONID\$
Makros
\$LONGDATETIME\$
Makros
\$SHORTDATETIME\$
Makros
\$DATE\$
Makros
\$TIME\$
Makros
\$TIMET\$
Makros
\$MAINCONFIGFILE\$
Makros
\$STATUSDATAFILE\$
Makros
\$COMMENTDATAFILE\$
Makros
\$DOWNTIMEDATAFILE\$
Makros
\$RETENTIONDATAFILE\$
Makros
\$OBJECTCACHEFILE\$
Makros
\$TEMPFILE\$
Makros
\$TEMPPATH\$
Makros
\$LOGFILE\$
Makros
\$RESOURCEFILE\$
Makros
\$COMMANDFILE\$
Makros
\$HOSTPERFDATAFILE\$
Makros
\$SERVICEPERFDATAFILE\$
Makros
\$PROCESSSTARTTIME\$
Makros
\$EVENTSTARTTIME\$
Makros
\$ADMINEMAIL\$
Makros
\$ADMINPAGER\$
Makros
\$ARGn\$
Makros
\$USERn\$
Makros
Host-Makros
Makros
Hostgroup-Makros
Makros
Service-Makros
Makros
Servicegroup-Makros
Makros
Contact-Makros
Makros
Contactgroup-Makros
Makros
Benachrichtigungs-Makros
Makros
Datum-/Zeit-Makros
Makros
Datei-Makros
Makros
Verschiedene Makros
Makros
Auswertungsmakros
