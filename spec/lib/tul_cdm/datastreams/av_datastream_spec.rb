describe "AvDatastream" do

  subject do
    datastream = TulCdm::Datastreams::AvDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="avMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="avMetadata.0" LABEL="AV metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <avsource>WPVI</avsource>
        <clip_summary>Summary of video clip</clip_summary>
        <date_broadcast>14-06-1980</date_broadcast>
        <ensemble_identifier>blah</ensemble_identifier>
        <timecode_begin>02:42:02</timecode_begin>
        <timecode_end>03:02:14</timecode_end>
        <transcript_filename>transcript.txt</transcript_filename>
        <original_source_summary>Summary of original source video</original_source_summary>
        <original_source_title>Original Source Title</original_source_title>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:avsource) }
  it { is_expected.to have_term(:clip_summary) }
  it { is_expected.to have_term(:date_broadcast) }
  it { is_expected.to have_term(:ensemble_identifier) }
  it { is_expected.to have_term(:timecode_begin) }
  it { is_expected.to have_term(:timecode_end) }
  it { is_expected.to have_term(:transcript_filename) }
  it { is_expected.to have_term(:original_source_summary) }
  it { is_expected.to have_term(:original_source_title) }

end
