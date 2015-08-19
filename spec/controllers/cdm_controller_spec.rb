require 'rails_helper'

RSpec.describe CdmController, type: :controller do

  describe "GET #stereotypicalabout" do
    it "returns http success" do
      get :stereotypicalabout
      expect(response).to have_http_status(:success)
    end
  end

end
