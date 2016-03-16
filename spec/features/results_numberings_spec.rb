require 'rails_helper'

RSpec.feature "ResultsNumberings", type: :feature do

  before(:all) do
    1.upto 40 do
      m = FactoryGirl.create(:manuscript_list)
      m.update_index
    end
  end

  after(:all) do
    Manuscript.destroy_all
  end

  #[TODO] Implement test to it renders all factoryo content with a valid digital collection
  xit "shows items 1-20 on the first page" do
    visit "/catalog"
    click_button "Search"
    #[TODO] Need proper query
    expect(page).to find('#document').have_css("ol")
    expect(page).to find('#document').not_have_css("ol")
  end

  xit "shows items 21-40 on the second page" do
    visit "/catalog"
    click_button "Search"
    #[TODO] Need proper query
    expect(page).to have_css("li.start[21]")
  end

end
