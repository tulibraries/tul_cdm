<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exsl="http://exslt.org/common" xmlns:ex="http://exslt.org/dates-and-times" extension-element-prefixes="exsl ex">
  <xsl:variable name="collection">
    <xsl:value-of select="metadata/manifest/contentdm_collection_id" />
  </xsl:variable>
  <xsl:variable name="foxml_dir">
    <xsl:value-of select="metadata/manifest/foxml_dir" />
  </xsl:variable>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="metadata/record">
    <xsl:copy>
      <xsl:variable name="current_time">
        <xsl:value-of select="ex:date-time()"/>
      </xsl:variable>
      <xsl:variable name="cdmfile">
        <xsl:value-of select="concat($collection,'x',CONTENTdm_number)"/>
      </xsl:variable>
      <xsl:variable name="pidPrefix">
        <xsl:value-of select="'tulcdm'"/>
      </xsl:variable>
      <xsl:variable name="pid">
        <xsl:value-of select="concat($pidPrefix,':',$cdmfile)" />
      </xsl:variable>
      <xsl:variable name="rdfAbout">
        <xsl:value-of select="concat('info:fedora/', $pid)" />
      </xsl:variable>
      <xsl:variable name="rdfResource">
        <xsl:value-of select="concat('info:fedora/afmodel:', 'ephemera')" />
      </xsl:variable>
      <exsl:document method="xml" href="{$foxml_dir}/{$cdmfile}.xml">
        <xsl:element name="foxml:digitalObject" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <xsl:attribute name="VERSION"><xsl:value-of select="1.1"/></xsl:attribute>
        <xsl:attribute name="PID"><xsl:value-of select="$pid"/></xsl:attribute>
        <xsl:attribute name="xsi:schemaLocation">info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-1.xsd</xsl:attribute>
        <foxml:objectProperties>
          <foxml:property NAME="info:fedora/fedora-system:def/model#state" VALUE="Active"/>
          <foxml:property NAME="info:fedora/fedora-system:def/model#label" VALUE="{$pidPrefix}"/>
          <foxml:property NAME="info:fedora/fedora-system:def/model#ownerId" VALUE=""/>
          <foxml:property NAME="info:fedora/fedora-system:def/model#createdDate" VALUE="{$current_time}"/>
          <foxml:property NAME="info:fedora/fedora-system:def/view#lastModifiedDate" VALUE=""/>
        </foxml:objectProperties>
        <foxml:datastream ID="RELS-EXT" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="RELS-EXT.0" LABEL="Fedora Object-to-Object Relationship Metadata" MIMETYPE="application/rdf+xml" >
            <foxml:xmlContent>
              <rdf:RDF xmlns:ns0="info:fedora/fedora-system:def/model#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
              <xsl:element name="rdf:Description">
              <xsl:attribute name="rdf:about"><xsl:value-of select="$rdfAbout"/></xsl:attribute>
              <xsl:element name="ns0:hasModel">
              <xsl:attribute name="rdf:resource"><xsl:value-of select="$rdfResource"/></xsl:attribute>
              </xsl:element>
              </xsl:element>
              </rdf:RDF>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="objectMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="objectMetadata.0" LABEL="Object metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Title"/>
                <xsl:apply-templates select="Date"/>
                <xsl:apply-templates select="Subject"/>
                <xsl:apply-templates select="Description"/>
                <xsl:apply-templates select="Format"/>
                <xsl:apply-templates select="Type"/>
                <xsl:apply-templates select="Publisher"/>
                <xsl:apply-templates select="Digital_Collection"/>
                <xsl:apply-templates select="Digital_Publisher"/>
                <xsl:apply-templates select="Digital_Specifications"/>
                <xsl:apply-templates select="Contact"/>
                <xsl:apply-templates select="Repository"/>
                <xsl:apply-templates select="Repository_Collection"/>
                <xsl:apply-templates select="Language"/>
                <xsl:apply-templates select="Identifier"/>
                <xsl:apply-templates select="Downloadable"/>
                <xsl:apply-templates select="Downloadable_OCR"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="contentdmMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="contentdmMetadata.0" LABEL="CONTENTdm metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Item_URL"/>
                <xsl:apply-templates select="OCLC_number"/>
                <xsl:apply-templates select="Date_created"/>
                <xsl:apply-templates select="Date_modified"/>
                <xsl:apply-templates select="CONTENTdm_number"/>
                <xsl:apply-templates select="CONTENTdm_file_name"/>
                <xsl:apply-templates select="CONTENTdm_file_path"/>
                <contentdm_collection_id><xsl:value-of select="$collection" /></contentdm_collection_id>
                <path_to_thumbnail><xsl:value-of select="concat('http://cdm15037.contentdm.oclc.org/utils/getthumbnail/collection/',$collection,'/id/',CONTENTdm_number)" /></path_to_thumbnail>
                <reference_url><xsl:value-of select="concat('/catalog/',$pid)" /></reference_url>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="descMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="descMetadata.0" LABEL="Descriptive metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Corporate_Name"/>
                <xsl:apply-templates select="Series"/>
                <xsl:apply-templates select="Stereotypical_Object_Note"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="geographicMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="geographicMetadata.0" LABEL="Geographic metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Geographic_Subject"/>
                <xsl:apply-templates select="Organization_Building"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="physicalMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="physicalMetadata.0" LABEL="Physical metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Folder"/>
                <xsl:apply-templates select="Location"/>
                <xsl:apply-templates select="Physical_Description"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="notationsMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="notationsMetadata.0" LABEL="Notations metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Notes"/>
                <xsl:apply-templates select="Personal_Names"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="digitalMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="digitalMetadata.0" LABEL="Digital metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="File_Name"/>
                <xsl:apply-templates select="Document_Content"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="creationMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="creationMetadata.0" LABEL="Creation metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Created"/>
                <xsl:apply-templates select="Creator"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        </xsl:element>
      </exsl:document>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Corporate_Name">
    <corporate_name><xsl:apply-templates /></corporate_name>
  </xsl:template>
  <xsl:template match="Series">
    <series><xsl:apply-templates /></series>
  </xsl:template>
  <xsl:template match="Stereotypical_Object_Note">
    <stereotypical_object_note><xsl:apply-templates /></stereotypical_object_note>
  </xsl:template>

  <xsl:template match="Title">
    <title><xsl:apply-templates /></title>
  </xsl:template>
  <xsl:template match="Date">
    <date><xsl:apply-templates /></date>
  </xsl:template>
  <xsl:template match="Subject">
    <subject><xsl:apply-templates /></subject>
  </xsl:template>
  <xsl:template match="Description">
    <description><xsl:apply-templates /></description>
  </xsl:template>
  <xsl:template match="Format">
    <format><xsl:apply-templates /></format>
  </xsl:template>
  <xsl:template match="Type">
    <type><xsl:apply-templates /></type>
  </xsl:template>
  <xsl:template match="Publisher">
    <publisher><xsl:apply-templates /></publisher>
  </xsl:template>
  <xsl:template match="Digital_Collection">
    <digital_collection><xsl:apply-templates /></digital_collection>
  </xsl:template>
  <xsl:template match="Digital_Publisher">
    <digital_publisher><xsl:apply-templates /></digital_publisher>
  </xsl:template>
  <xsl:template match="Digital_Specifications">
    <digital_specifications><xsl:apply-templates /></digital_specifications>
  </xsl:template>
  <xsl:template match="Contact">
    <contact><xsl:apply-templates /></contact>
  </xsl:template>
  <xsl:template match="Repository">
    <repository><xsl:apply-templates /></repository>
  </xsl:template>
  <xsl:template match="Repository_Collection">
    <repository_collection><xsl:apply-templates /></repository_collection>
  </xsl:template>
  <xsl:template match="Language">
    <language><xsl:apply-templates /></language>
  </xsl:template>
  <xsl:template match="Identifier">
    <identifier><xsl:apply-templates /></identifier>
  </xsl:template>
  <xsl:template match="Downloadable">
    <downloadable><xsl:apply-templates /></downloadable>
  </xsl:template>
  <xsl:template match="Downloadable_OCR">
    <downloadable_ocr><xsl:apply-templates /></downloadable_ocr>
  </xsl:template>
  <xsl:template match="Item_URL">
    <item_url><xsl:apply-templates /></item_url>
  </xsl:template>
  <xsl:template match="OCLC_number">
    <oclc_number><xsl:apply-templates /></oclc_number>
  </xsl:template>
  <xsl:template match="Date_created">
    <date_created><xsl:apply-templates /></date_created>
  </xsl:template>
  <xsl:template match="Date_modified">
    <date_modified><xsl:apply-templates /></date_modified>
  </xsl:template>
  <xsl:template match="CONTENTdm_number">
    <contentdm_number><xsl:apply-templates /></contentdm_number>
  </xsl:template>
  <xsl:template match="CONTENTdm_file_name">
    <contentdm_file_name><xsl:apply-templates /></contentdm_file_name>
  </xsl:template>
  <xsl:template match="CONTENTdm_file_path">
    <contentdm_file_path><xsl:apply-templates /></contentdm_file_path>
  </xsl:template>
  <xsl:template match="Geographic_Subject">
    <geographic_subject><xsl:apply-templates /></geographic_subject>
  </xsl:template>
  <xsl:template match="Organization_Building">
    <organization_building><xsl:apply-templates /></organization_building>
  </xsl:template>
  <xsl:template match="Folder">
    <folder><xsl:apply-templates /></folder>
  </xsl:template>
  <xsl:template match="Location">
    <location><xsl:apply-templates /></location>
  </xsl:template>
  <xsl:template match="Physical_Description">
    <physical_description><xsl:apply-templates /></physical_description>
  </xsl:template>
  <xsl:template match="Notes">
    <notes><xsl:apply-templates /></notes>
  </xsl:template>
  <xsl:template match="Personal_Names">
    <personal_names><xsl:apply-templates /></personal_names>
  </xsl:template>
  <xsl:template match="File_Name">
    <file_name><xsl:apply-templates /></file_name>
  </xsl:template>
  <xsl:template match="Document_Content">
    <document_content><xsl:apply-templates /></document_content>
  </xsl:template>
  <xsl:template match="Created">
    <created><xsl:apply-templates /></created>
  </xsl:template>
  <xsl:template match="Creator">
    <creator><xsl:apply-templates /></creator>
  </xsl:template>
</xsl:stylesheet>
