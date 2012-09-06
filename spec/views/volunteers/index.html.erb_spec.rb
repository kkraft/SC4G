require 'spec_helper'

describe "volunteers/index" do
  before(:each) do
    assign(:volunteers, [
      stub_model(Volunteer,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email"
      ),
      stub_model(Volunteer,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of volunteers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
