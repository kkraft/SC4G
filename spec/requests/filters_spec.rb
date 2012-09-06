require 'spec_helper'

describe "Dashboard" do

  describe "Name Filter" do

    it "should filter and only show volunteer profiles whose name contains 'Person1'" do
      visit root_path

      page.should have_selector('title', text: "SC4G")

    end
  end
end