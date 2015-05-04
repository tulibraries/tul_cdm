describe "NotationsDatastream" do

  subject do
    datastream = TulCdm::Datastreams::ObjectDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="notationsMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="notationsMetadata.0" LABEL="notations metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <title>Work Title</title>
        <date>2015-04-21</date>
        <subject>Miscelleneous</subject>
        <description>Lorem ipsum dolor sit amet, at cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</title>
        <format>Text</format>
        <type>Manuscript</type>
        <publisher>Random Object Press</publisher>
        <digital_collection>Test Object Collection</digital_collection>
        <digital_specifications></digital_specificaitons>
        <contact>fred@example.com</contact>
        <repository>Random Repository</repository>
        <repository_collection>Any Object Collection</repository_collection>
        <language>English</language>
        <identifier>AB1234</identifier>
        <downloadable>Yes</downloadable>
        <downloadable_ocr>Yes</downloadable_ocr>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:title) }
  it { is_expected.to have_term(:date) }
  it { is_expected.to have_term(:subject) }
  it { is_expected.to have_term(:description) }
  it { is_expected.to have_term(:format) }
  it { is_expected.to have_term(:type) }
  it { is_expected.to have_term(:publisher) }
  it { is_expected.to have_term(:digital_collection) }
  it { is_expected.to have_term(:digital_publisher) }
  it { is_expected.to have_term(:digital_specifications) }
  it { is_expected.to have_term(:contact) }
  it { is_expected.to have_term(:repository) }
  it { is_expected.to have_term(:repository_collection) }
  it { is_expected.to have_term(:language) }
  it { is_expected.to have_term(:identifier) }
  it { is_expected.to have_term(:downloadable) }
  it { is_expected.to have_term(:downloadable_ocr) }

end
