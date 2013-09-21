Integration von NAME-PNP in das NAME-WEB Frontend
=================================================

Mit Hilfe dieser Anleitung können Sie NAME-PNP in das NAME-WEB-Frontend
integrieren. Wenn Sie NAME-PNP in das NAME-UI integrieren möchten, lesen
Sie bitte die NAME-PNP
[Dokumentation.](http://docs.pnp4nagios.org/de/pnp-0.6/start)

Links sehen Sie das "Expander"-Icon. Nach dem Klicken öffnet sich ein
Balken (unterhalb des OK-Zeichens).

Rechts im "PNP4Nagios"-Abschnitt gibt es zwei Buttons.

Nach Rechts-Klick auf einen der beiden und auswählen von "Move into
grid" wird das entsprechende Icon ins Raster verschoben.

Auswählen des neuen Icons öffnet den PNP-Graphen in einem kleinen
Fenster, das lediglich einen Zeitabschnitt anzeigt oder es wird ein
neuer Reiter erstellt, in dem die übliche PNP-Ansicht zu sehen ist.

Klicken auf"Setting" und auswählen von "Reset grid action icons"
entfernt die eingefügten Icons und stellt die Standardansicht wieder
her.

Installieren von NAME-PNP
-------------------------

1.  Installieren Sie NAME-PNP wie in der
    NAME-PNP-[Dokumentation](http://docs.pnp4nagios.org/de/pnp-0.6/start)
    beschrieben.

2.  Passen Sie die NAME-PNP-Konfiguration auf Ihre
    NAME-ICINGA-Konfiguration an. Wahrscheinlich müssen Sie hier ändern:

        #> vi npcd.cfg
            user = icinga
            group = icinga
            log_file = /var/log/icinga/npcd.log
            perfdata_spool_dir = /var/icinga/spool/
            perfdata_file = /var/icinga/perfdata.dump

        #> vi process_perfdata.cfg
            LOG_FILE = /var/log/icinga/perfdata.log
            XML_ENC = ISO-8859-1   # falls Sie Probleme mit Umlauten haben

        #> vi config.php 
            $conf['nagios_base'] = "/icinga/cgi-bin";

    > **Note**
    >
    > Stellen Sie sicher, dass Sie bestehende Pfade benutzen, legen Sie
    > sie an, falls notwendig, und/oder passen Sie die Angaben an Ihre
    > Distribution an.
    >
    > Bitte überprüfen Sie, dass die command-Definitionen für
    > "process-host-perfdata-file" und "process-service-perfdata-file"
    > (wahrscheinlich in `etc/objects/commands.cfg`) auf das gleiche
    > Zielverzeichnis zeigen, das in perfdata\_spool\_dir angegeben
    > wurde.

Template-Extensions
-------------------

Seit Version 1.5 können die Grid-Templates unberührt bleiben, weil wir
XML-Extensions integriert haben, um Grid-Template mit einfachen
Schnipseln anzupassen. Die PNP-Integration wurde mit diesen Extensions
upgrade-sicher gemacht.

Ausschnitt aus `INSTALL` in `contrib/PNP_Integration/`

    #> cat contrib/PNP_Integration/INSTALL
        ************************
        * INSTALLATION
        ************************

        * To install this addon, simply copy both xml files under templateExtensions
        * to your icinga-webs app/modules/Cronks/data/xml/extensions folder
        * and clear the app/cache/CronkTemplates folder
        * To remove it, just delete the extension files and clear the cache folder again

*Install Script*

Nachdem es sich lediglich um das Kopieren der beiden genannten Daten
handelt, gibt es kein Skript. Sorry.

> **Note**
>
> Bitte beachten Sie, dass Sie das Addon nach einem Icinga-Web-Upgrade
> erneut installieren müssen.

Erstellen Sie die Konfiguration, um die NAME-PNP Host-Seiten in das NAME-WEB zu integrieren
-------------------------------------------------------------------------------------------

> **Note**
>
> Die folgenden Zeilen beschreiben die manuelle Integration für Version
> 1.4 und früher

1.  Erstellen einer neuen Host-Grid-Ansicht:

    Bitte erstellen Sie eine Kopie von `icinga-host-template.xml` in
    `app/modules/Cronks/data/xml/grid` unter Ihrem
    Icinga-web-Installationspfad:

        #> cp /usr/local/icinga-web/app/modules/Cronks/data/xml/grid/icinga-host-template.xml \
            /usr/local/icinga-web/app/modules/Cronks/data/xml/grid/icinga-my-host-template.xml

    In der neuen Datei legen wir eine zusätzliche Feld- (field)
    Definition an:

                <field name="pnp4nagios_host_link">
                    <!-- datasource maps a data field from api call -->
                    <datasource>
                        <parameter name="field">HOST_NAME</parameter>
                    </datasource>

                    <display>
                        <parameter name="visible">true</parameter>
                        <parameter name="label">Perfdata</parameter>
                        <parameter name="width">55</parameter>

                        <parameter name="Ext.grid.Column">
                            <parameter name="menuDisabled">true</parameter>
                            <parameter name="fixed">true</parameter>
                        </parameter>

                        <parameter name="jsFunc">
                            <!-- function to display column with icon in host status grid view -->
                            <parameter>
                                <parameter name="namespace">Cronk.grid.ColumnRenderer</parameter>
                                <parameter name="function">columnImage</parameter>
                                <parameter name="type">renderer</parameter>

                                <parameter name="arguments">
                                    <parameter name="image">images/icons/application_view_gallery.png</parameter>
                                    <parameter name="css">x-icinga-grid-link</parameter>
                                    <parameter name="attr">
                                        <parameter name="qtip">Show host perfdata for this host</parameter>
                                    </parameter>
                                </parameter>
                            </parameter>

                            <!-- create cell click event for the previously defined column -->
                            <parameter>
                                <parameter name="namespace">Cronk.grid.IcingaColumnRenderer</parameter>
                                <parameter name="function">iFrameCronk</parameter>
                                <parameter name="type">cellclick</parameter>
                                <parameter name="arguments">
                                    <parameter name="title">Host perfdata for {host_name}</parameter>
                                    <parameter name="url"><![CDATA[/pnp4nagios/index.php/graph?host={host_name}&srv=_HOST_]]></parameter>
                                    <parameter name="activateOnClick">true</parameter>
                                </parameter>
                            </parameter>
                        </parameter>
                    </display>

                    <filter>
                       <parameter name="enabled">false</parameter>
                    </filter>

                    <order>
                        <parameter name="enabled">false</parameter>
                    </order>
                </field>

2.  Anlegen einer neuen Grid-Ansicht im "Data" Cronk-Container

    Editieren von `cronks.xml` im Unterverzeichnis
    `app/modules/Cronks/config/` unter NAME-WEB und hinzufügen von:

        <cronk name="gridMyHostView">
            <ae:parameter name="module">Cronks</ae:parameter>
            <ae:parameter name="action">System.ViewProc</ae:parameter>
            <ae:parameter name="hide">false</ae:parameter>
            <ae:parameter name="description">Viewing host status in a grid including perfdata link</ae:parameter>
            <ae:parameter name="name">MyHostStatus</ae:parameter>
            <ae:parameter name="image">cronks.Stats</ae:parameter>
            <ae:parameter name="categories">data</ae:parameter>
            <ae:parameter name="ae:parameter">
                <ae:parameter name="template">icinga-my-host-template</ae:parameter>
            </ae:parameter>
        </cronk>

Integrieren von NAME-PNP in NAME-WEB-Serviceansichten
-----------------------------------------------------

> **Note**
>
> Die folgenden Zeilen beschreiben die manuelle Integration für Version
> 1.4 und früher

1.  Erstellen einer neuen Service-Grid-Ansicht

    Kopieren Sie das Standard-Template "`icinga-service-template.xml`"
    von `app/modules/Cronks/data/xml/grid` in Ihren
    NAME-WEB-Installationspfad:

        #> cp /usr/local/icinga-web/app/modules/Cronks/data/xml/grid/icinga-service-template.xml \
            /usr/local/icinga-web/app/modules/Cronks/data/xml/grid/icinga-my-service-template.xml

    In der neuen Datei legen wir eine zusätzliche Feld- (field)
    Definition an:

                <field name="pnp4nagios_service_link">
                    <!-- datasource maps a data field from api call -->
                    <datasource>
                        <parameter name="field">SERVICE_NAME</parameter>
                    </datasource>

                    <display>
                        <parameter name="visible">true</parameter>
                        <parameter name="label">Perfdata</parameter>
                        <parameter name="width">55</parameter>

                        <parameter name="Ext.grid.Column">
                            <parameter name="menuDisabled">true</parameter>
                            <parameter name="fixed">true</parameter>
                        </parameter>

                        <parameter name="jsFunc">
                            <!-- function to display column with icon in host status grid view -->
                            <parameter>
                                <parameter name="namespace">Cronk.grid.ColumnRenderer</parameter>
                                <parameter name="function">columnImage</parameter>
                                <parameter name="type">renderer</parameter>

                                <parameter name="arguments">
                                    <parameter name="image">images/icons/application_view_gallery.png</parameter>
                                    <parameter name="css">x-icinga-grid-link</parameter>
                                    <parameter name="attr">
                                        <parameter name="qtip">Show perfdata for this service</parameter>
                                    </parameter>
                                </parameter>
                            </parameter>

                            <!-- create cell click event for the previously defined column -->
                            <parameter>
                                <parameter name="namespace">Cronk.grid.IcingaColumnRenderer</parameter>
                                <parameter name="function">iFrameCronk</parameter>
                                <parameter name="type">cellclick</parameter>
                                <parameter name="arguments">
                                    <parameter name="title">Service perfdata for {service_name} on {host_name}</parameter>
                                    <parameter name="url"><![CDATA[/pnp4nagios/index.php/graph?host={host_name}&srv={service_name}]]></parameter>
                                    <parameter name="activateOnClick">true</parameter>
                                </parameter>
                            </parameter>
                        </parameter>
                    </display>

                    <filter>
                        <parameter name="enabled">false</parameter>
                    </filter>

                    <order>
                        <parameter name="enabled">false</parameter>
                    </order>
                </field>

2.  Anlegen einer neuen Grid-Ansicht im "Data" Cronk-Container

    Editieren von `cronks.xml` im Unterverzeichnis
    `app/modules/Cronks/config/` unter NAME-WEB und hinzufügen von:

        <cronk name="gridMyServiceView">
            <ae:parameter name="module">Cronks</ae:parameter>
            <ae:parameter name="action">System.ViewProc</ae:parameter>
            <ae:parameter name="hide">false</ae:parameter>
            <ae:parameter name="description">Viewing service status in a grid including perfdata link</ae:parameter>
            <ae:parameter name="name">MyServiceStatus</ae:parameter>
            <ae:parameter name="image">cronks.Stats2</ae:parameter>
            <ae:parameter name="categories">data</ae:parameter>
            <ae:parameter name="ae:parameter">
                <ae:parameter name="template">icinga-my-service-template</ae:parameter>
            </ae:parameter>
        </cronk>

3.  Verwenden der neuen Grid-Ansicht als Standard-Service-Ansicht

    Bitte sichern Sie zuerst Ihre originale Ansicht:

        #> cp data/xml/grid/icinga-service-template.xml data/xml/grid/icinga-service-template.bak

    dann

        #> cp data/xml/grid/icinga-my-service-template.xml data/xml/grid/icinga-service-template.xml

    Leeren Sie den Cache wie unten beschrieben. Die Performancegraphen
    sind nun in Ihren "serviceStatus"-Cronk integriert!

Löschen des Cache
-----------------

> **Note**
>
> Bitte denken Sie daran, dass Sie nach dem Editieren von \*.xml-Dateien
> den Cache bereinigen müssen!

    #> rm -f app/cache/config/*.php

oder /path/to/clearcache.sh

    #> /usr/local/icinga-web/bin/clearcache.sh

Das war es auch schon, Sie sind fertig!

NAME-PNP
pnp und NAME-WEB
