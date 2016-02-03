module TulCdm::Datastreams

  class ObjectDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.title(:index_as=>[:sortable, :stored_searchable], :type=>:string)
      t.date(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
      t.subject(:index_as=>[:facetable, :stored_searchable], :type=>:string)
      t.description index_as: :stored_searchable
      t.format(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
      t.type(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
      t.publisher(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
      t.digital_collection(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
      t.digital_publisher(:index_as=>[:sortable, :stored_searchable], :type=>:string)
      t.digital_specifications
      t.contact index_as: :displayable
      t.contributor(index_as: [:displayable, :stored_searchable], :type=>:string)
      t.repository(:index_as=>[:facetable, :stored_searchable], :type=>:string)
      t.repository_collection(:index_as=>[:facetable, :stored_searchable], :type=>:string)
      t.language(index_as: [:facetable, :displayable], type: :string)
      t.identifier(:index_as=>[:displayable, :sortable, :stored_searchable], :type=>:string)
      t.volume(:index_as=>[:displayable, :sortable, :stored_searchable], :type=>:string)
      t.series(:index_as=>[:displayable, :sortable, :stored_searchable], :type=>:string)
      t.resolution(:index_as=>[:displayable, :stored_searchable], :type=>:string)
      t.ada_note index_as: :displayable
      t.downloadable index_as: [:facetable, :displayable]
      t.downloadable_ocr index_as: [:facetable, :displayable]
    end

    def self.xml_template
      Nokogiri::XML.parse("<fields/>")
    end

    def prefix
      ""
    end

  end

end
