describe "RightsDatastream" do

  subject do
    datastream = TulCdm::Datastreams::RightsDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="rightsMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="rightsMetadata.0" LABEL="ContentDM metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <rights>This material is subject to copyright law and is made available for private study, scholarship, and research purposes only. For access to the original or a high resolution reproduction, and for permission to publish, please contact Temple University Libraries, Special Collections Research Center, scrc@temple.edu, 215-204-8257.</rights>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:rights) }

  context 'Rights Datastream Class' do
    it "Should not use a prefix" do
      expect(subject.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(TulCdm::Datastreams::RightsDatastream.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
