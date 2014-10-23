require 'blacklight/catalog'

class LandingController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  include TulCdm::SolrHelper::Behaviors
  
  def index
    
    
  
  end
end
