require "active-fedora"
require "open-uri"
require "fileutils"

module CDMUtils
  def self.list(server)
    cdm_url = "#{server}/dmwebservices/index.php?q=dmGetCollectionList/xml"
    xml = Nokogiri::XML(open(cdm_url))
    all_aliases = xml.xpath("/collections/collection/alias/text()")
  end

  def self.getCollectionName(server, coll)
    cdm_url = "#{server}/dmwebservices/index.php?q=dmGetCollectionParameters/#{coll}/xml"
    xml = Nokogiri::XML(open(cdm_url))
    xml.xpath("/parameters/name/text()").to_s
  end

  private
  def download_one_collection(config, coll)
    Download.init_download
    Download.download(config, coll)
  end
  module_function :download_one_collection # :nodoc:

  def download_all_collections(config)
    Download.init_download
    Download.download(config)
  end
  module_function :download_all_collections # :nodoc:

  class Download
    def self.init_download
      OpenURI::Buffer.send :remove_const, 'StringMax'
      OpenURI::Buffer.const_set 'StringMax', 0
    end

    def self.get_compound_document_content (config, cdm_coll, document)

      # Instrumentation
      compound_document_number = 0

      # Get the CDM pointer to the compound object
      xml_doc = Nokogiri::XML(document)
      compound_object_xpath = "//record[CONTENTdm_file_name[contains(text(), '.cpd')]]"
      compound_object_xpath << "[position() <= 1]" if Rails.env.test? # Limit test scope
      compound_object_xpath << "[position() <= 6]" if Rails.env.development? # Limit development scope
      compound_object_xpath << "/CONTENTdm_number"
      pointers = xml_doc.xpath(compound_object_xpath)

      # For each compound object
      pointers.each do |item_ptr|
        cdm_num = item_ptr.text

        # Initialize the OCR text buffer
        compound_document_content = ''

        # Get the pointers to all of the pages of the compound object
        api_path = "#{config['cdm_server']}/dmwebservices/index.php?q=dmGetCompoundObjectInfo/#{cdm_coll}/#{cdm_num}/xml"
        compound_object_info_xml = Nokogiri::XML(open(api_path))
        pageptrs = compound_object_info_xml.xpath("//pageptr")

        # Instrumentation
        page_count = 0

        pageptrs.each do |pageptr|
          print "."
          page_xpath = "//record[CONTENTdm_number[.='#{pageptr.text}']]"
          xml_ItemInfo = xml_doc.xpath(page_xpath).first
          document_content = xml_ItemInfo.xpath('Document_Content').text
          compound_document_content << " " if compound_document_content.size > 0
          compound_document_content << document_content if document_content.size > 0

          page_count += 1
          break if page_count >= 12 and Rails.env.test?

        end

        print "#"

        # Get the path to the Document Content mode. We will put the compound ocr text here
        ocr_xpath = "//record[CONTENTdm_number[.='#{cdm_num}']]/Document_Content"
        ocr_xml = xml_doc.at_xpath(ocr_xpath)
        ocr_xml.content = compound_document_content

        # Show progress
        compound_document_number += 1
        puts "\nProcessed compound document #{compound_document_number} of #{pointers.count}" unless Rails.env.test?
        break if compound_document_number >= 10 and Rails.env.test?  # Limit test scope

      end

      xml_compound_document = xml_doc.xpath("//record[CONTENTdm_file_name[contains(text(), '.cpd')]]")
      xml_text = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<metadata>\n  " + xml_compound_document.to_xml + "\n</metadata>"
      xml_text.gsub("</record><record>", "</record>\n  <record>")
    end

    def self.download(config, coll=nil)
      # coll is the collection to import
      # If coll is nil, then import all the available collections
      ocr_compound_collections = ['p245801coll12']
      user = config['cdm_user']
      password = config['cdm_password']

      #put back later
      #build_xml_url = "#{config['cdm_server']}/cgi-bin/admin/exportxml.exe?CISODB=%2F#{coll}&CISOTYPE=custom&CISOPAGE=&CISOPTRLIST=&title=Title&altern=Alternate_Title&relati=Series&date=Date&hidden=Hidden_Date&contri=Narrator&descri=Content_Summary&descra=Notes&subjec=Subject&subjea=Corporate_Name&subjed=Personal_Names&format=Format&type=Type&publis=Publisher&langua=Language&rights=Rights&reposi=Repository&reposa=Repository_Collection&digitb=Digital_Collection&publia=Digital_Publisher&source=Physical_Description&digita=Digital_Specifications&contac=Contact&create=Created&folder=Location&tbd=Acknowledgment&identi=Master_Identifier&ada=ADA_Note&file=File_Name&find=Item_URL&dmoclcno=OCLC_number&dmcreated=Date_created&dmmodified=Date_modified&dmrecord=CONTENTdm_number&cdmfile=CONTENTdm_file_name&cdmpath=CONTENTdm_file_path&CISOMODE1=rep&CISOMODE2=rep"
      #open(build_xml_url, :http_basic_authentication=>[user, password])

      cdm_url = "#{config['cdm_server']}/dmwebservices/index.php?q=dmGetCollectionList/xml"
      xml = Nokogiri::XML(open(cdm_url))
      FileUtils::mkdir_p config['cdm_download_dir']
      all_aliases = xml.xpath("/collections/collection/alias/text()")
      harvested_count = 0
      all_aliases.length.times do |i|
        new_coll = all_aliases[i].to_s
        test_coll = "/"+coll if coll
        if coll.nil? or new_coll.eql?(test_coll)
          dl_url = config['cdm_server']+"/cgi-bin/admin/getfile.exe?CISOMODE=1&CISOFILE="+new_coll+"/index/description/export.xml"
          xmlFilePath = "#{config['cdm_download_dir']}" + new_coll + ".xml"
          source_url = open(dl_url, :http_basic_authentication=>[user, password])
          file = File.read source_url
          if (ocr_compound_collections.include? coll)
            file = get_compound_document_content(config, new_coll[1..-1], file)
          end
          File.open(Rails.root + xmlFilePath, 'w') { |f| f.write(file) }
          puts "\nSuccessfully harvested #{new_coll}" unless Rails.env.test?
          harvested_count += 1
        end
      end
      harvested_count
    end
  end

  def conform(doc, collection_file_name, target_dir)
    Convert.conform(doc, collection_file_name, target_dir)
  end
  module_function :conform # :nodoc:

  def convert_file(file_name, foxml_dir)
    Convert.convert_file(file_name, foxml_dir)
  end
  module_function :convert_file # :nodoc:

  class Convert

    def self.insert_downloadable_tag(document)
      # Inserts default downloadable tag if it doesn't exist
      xml_doc = Nokogiri::XML(document)
      xml_doc.xpath("//record").each do |xml_element|
        if xml_element.xpath("Downloadable").empty?
          # Prohibit download by default
          xml_element.add_child("<Downloadable>No</Downloadable>")
        end
      end
      xml_doc.to_xml
    end

    def self.insert_downloadable_ocr_tag(document)
      # Inserts default downloadable tag if it doesn't exist
      xml_doc = Nokogiri::XML(document)
      xml_doc.xpath("//record").each do |xml_element|
        if xml_element.xpath("Downloadable_OCR").empty?
          # Prohibit download by default
          xml_element.add_child("<Downloadable_OCR>No</Downloadable_OCR>")
        end
      end
      xml_doc.to_xml
    end

    def self.conform(doc, collection_file_name, target_dir)

      #Insert new downloadable tags
      doc = insert_downloadable_tag(doc)
      doc = insert_downloadable_ocr_tag(doc)

      # relacement array
      replacements = [
        #Strip out any bad keying from CDM
        ["&amp<", "<"],
        ["&quot<", "<"],
        ["", ""],

        #Normalize inconsistent CDM metadata vocabulary
        #So ugly -- remove when vocab is normalized by staff
        ["<Filename>", "<File_Name>"],
        ["<Created_by>", "<Created>"],
        ["<Personal_Name>", "<Personal_Names>"],
        ["<Organization>", "<Organization_Building>"],
        ["<Organization-Building>", "<Organization_Building>"],
        ["<Note>", "<Notes>"],
        ["<Title_Alternative>", "<Alternate_Title>"],
        ["<Call_Number>", "<Local_Call_Number>"],
        ["<Audio_Filename>", "<File_Name>"],
        ["<Video_Filename>", "<File_Name>"],

        ["</Filename>", "</File_Name>"],
        ["</Created_by>", "</Created>"],
        ["</Personal_Name>", "</Personal_Names>"],
        ["</Organization>", "</Organization_Building>"],
        ["</Organization-Building>", "</Organization_Building>"],
        ["</Note>", "</Notes>"],
        ["</Title_Alternative>", "</Alternate_Title>"],
        ["</Call_Number>", "</Local_Call_Number>"],
        ["</Audio_Filename>", "</File_Name>"],
        ["</Video_Filename>", "</File_Name>"],

        ["<Filename/>", "<File_Name/>"],
        ["<Created_by/>", "<Created/>"],
        ["<Personal_Name/>", "<Personal_Names/>"],
        ["<Organization/>", "<Organization_Building/>"],
        ["<Organization-Building/>", "<Organization_Building/>"],
        ["<Note/>", "<Notes/>"],
        ["<Title_Alternative/>", "<Alternate_Title/>"],
        ["<Call_Number/>", "<Local_Call_Number/>"],
        ["<Audio_Filename/>", "<File_Name/>"],
        ["<Video_Filename/>", "<File_Name/>"],
        ["Content_Summary", "Description"],
        ["<metadata>", "<metadata>\n  <manifest>\n    <contentdm_collection_id>#{collection_file_name}</contentdm_collection_id>\n    <Rails_Root>#{Rails.root}</Rails_Root>\n    <foxml_dir>#{target_dir}</foxml_dir>\n  </manifest>"]
      ]

      # perform replacement
      replacements.each do |r|
        doc1 = doc
        doc = doc1.gsub(r.first, r.last)
      end

     doc
    end

    def self.convert_file(file_name, foxml_dir)
      fname = File.basename(file_name, ".xml")
      text = File.read(file_name)
      conformed_text = CDMUtils.conform(text, fname, foxml_dir)

      FileUtils::mkdir_p foxml_dir
      File.open(file_name, "w") { |file| file.puts conformed_text }

      case fname
        #clipping
        when 'p15037coll7'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_clipping.xsl #{file_name}`

        #ephemera
        when 'p16002coll6', 'p16002coll7'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_ephemera.xsl #{file_name}`

        #photograph
        when 'p15037coll5', 'p245801coll13', 'p15037coll17', 'p15037coll10', 'p15037coll3', 'p15037coll15', 'p245801coll0', 'p16002coll3', 'p16002coll2', 'p15037coll8', 'p16002coll13', 'p16002coll17', 'p16002coll19'

          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_photograph.xsl #{file_name}`

        #manuscript
        when 'p15037coll18', 'p16002coll4', 'p15037coll19', 'p16002coll14'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_manuscript.xsl #{file_name}`

        #pamphlet
        when 'p16002coll5', 'p15037coll14'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_pamphlet.xsl #{file_name}`

        #periodical
        when 'p15037coll4', 'p15037coll9', 'p15037coll6', 'p16002coll8', 'p245801coll12'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_periodical.xsl #{file_name}`

        #poster
        when 'p16002coll9'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_poster.xsl #{file_name}`

        #scholarship
        when 'p15037coll12', 'p245801coll10'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_scholarship.xsl #{file_name}`

        #sheet music
        when 'p15037coll1'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_sheetmusic.xsl #{file_name}`

        #video
        when 'p15037coll2'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_video.xsl #{file_name}`

        #audio
        when 'p16002coll1'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_audio.xsl #{file_name}`

        #oral history
        when 'p16002coll21'
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_oralhistory.xsl #{file_name}`

        else
          `xsltproc #{Rails.root}/lib/tasks/cdm_to_foxml_noncustom.xsl #{file_name}`
      end

      puts "XSLT transformation complete for #{fname}".green

      # Delete the source XML file
      File.delete(file_name)
    end
  end

  def ingest_file(file_name)
    Ingest.ingest_file(file_name)
  end
  module_function :ingest_file # :nodoc:

  class Ingest
    def self.ingest_file(file_name)
      print "Ingest: #{File.basename(file_name)} ..."
      pid = ActiveFedora::FixtureLoader.import_to_fedora(file_name)
      print "\b\b\b(#{pid}) ..."
      status = ActiveFedora::FixtureLoader.index(pid)
      print "\b\b\bDone.\n"
      File.delete(file_name)

      { solr_status: status["responseHeader"]["status"], pid: pid }
    end
  end

  def index(type)
    Index.index(type)
  end
  module_function :index # :nodoc:

  class Index
    def self.find(type_str, pid)
      case type_str
      when 'photograph' then object = Photograph.find(pid)
      when 'poster' then object = Poster.find(pid)
      when 'pamphlet' then object = Pamphlet.find(pid)
      when 'manuscript' then object = Manuscript.find(pid)
      when 'sheetmusic' then object = Sheetmusic.find(pid)
      when 'clipping' then object = Clipping.find(pid)
      when 'ephemera' then object = Ephemera.find(pid)
      when 'periodical' then object = Periodical.find(pid)
      when 'scholarship' then object = Scholarship.find(pid)
      when 'audio' then object = Audio.find(pid)
      when 'video' then object = Video.find(pid)
      when 'transcript' then object = Transcript.find(pid)
      else nil
      end
    end

    def self.index(type)
      type_str = type.to_s.downcase
      collection_count = 0
      ActiveFedora::Base.connection_for_pid('changeme:1') #Fake obj for Rubydora
      ActiveFedora::Base.fedora_connection[0].connection.search(nil) do |object|
        if object.pid.starts_with?(type_str + ':')
          obj = find(type_str, object.pid)
          obj.to_solr
          status = obj.update_index
          if (status["responseHeader"]["status"] == 0) then
            collection_count += 1
            puts "#{obj} indexed".green
          else
            puts "#{obj} failed. #{status['responseHeader']['status']}".red
          end
        end
      end
      collection_count
    end
  end
end
