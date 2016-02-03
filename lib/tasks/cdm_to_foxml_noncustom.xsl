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
        <xsl:value-of select="concat('info:fedora/afmodel:', 'noncustom')" />
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
                <xsl:apply-templates select="ADA_Note"/>
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
                <xsl:apply-templates select="Title"/>
                <xsl:apply-templates select="Date"/>
                <xsl:apply-templates select="Subject"/>
                <xsl:apply-templates select="Description"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        <foxml:datastream ID="rightsMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
          <foxml:datastreamVersion ID="rightsMetadata.0" LABEL="Rights metadata" MIMETYPE="text/xml">
            <foxml:xmlContent>
              <fields>
                <xsl:apply-templates select="Rights"/>
              </fields>
            </foxml:xmlContent>
          </foxml:datastreamVersion>
        </foxml:datastream>
        </xsl:element>
      </exsl:document>
    </xsl:copy>
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
  <xsl:template match="ADA_Note">
    <ada_note><xsl:apply-templates /></ada_note>
  </xsl:template>
  <xsl:template match="Rights">
    <rights><xsl:apply-templates /></rights>
  </xsl:template>
</xsl:stylesheet>
