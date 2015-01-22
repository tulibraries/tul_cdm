require "rails_helper"

RSpec.describe DigitalCollectionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/digital_collections").to route_to("digital_collections#index")
    end

    it "routes to #new" do
      expect(:get => "/digital_collections/new").to route_to("digital_collections#new")
    end

    it "routes to #show" do
      expect(:get => "/digital_collections/1").to route_to("digital_collections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/digital_collections/1/edit").to route_to("digital_collections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/digital_collections").to route_to("digital_collections#create")
    end

    it "routes to #update" do
      expect(:put => "/digital_collections/1").to route_to("digital_collections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/digital_collections/1").to route_to("digital_collections#destroy", :id => "1")
    end

  end
end
