require 'spec_helper'

describe "volunteers/show" do
  before(:each) do
    @volunteer = assign(:volunteer, stub_model(Volunteer,
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
  end
end
