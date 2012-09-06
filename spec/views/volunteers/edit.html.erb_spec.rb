require 'spec_helper'

describe "volunteers/edit" do
  before(:each) do
    @volunteer = assign(:volunteer, stub_model(Volunteer,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit volunteer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => volunteers_path(@volunteer), :method => "post" do
      assert_select "input#volunteer_first_name", :name => "volunteer[first_name]"
      assert_select "input#volunteer_last_name", :name => "volunteer[last_name]"
      assert_select "input#volunteer_email", :name => "volunteer[email]"
    end
  end
end
