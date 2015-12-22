require 'rails_helper'

describe 'Blacklight::DocumentPresenter' do

    let(:request_context) { double(:add_facet_params => '') }
    let(:document) { double }
    let(:config) { Blacklight::Configuration.new }


  subject { Blacklight::DocumentPresenter.new(document, request_context, config) }

  describe '#render_field_value' do
    it 'returns a string for single string value' do
      expect(subject.render_field_value value="Some plain text").to eq("Some plain text")
    end

    it 'returns an string for an an array with a length of 1' do
      expect(subject.render_field_value( value=["Some plain text"])).to eq("Some plain text")
    end

    it 'returns a ul for multivalue' do
     input = ["one value", "two value"]
      expect(subject.render_field_value value=input ).to start_with("<ul")
    end
  end
end
