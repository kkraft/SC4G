require 'spec_helper'

describe "Volunteer" do
  before(:all) do
    2.times {FactoryGirl.create(:ws_first_name)}
    2.times {FactoryGirl.create(:ws_last_name)}
    2.times {FactoryGirl.create(:ws_email)}
  end

  describe "time_to_commit" do
    before(:each) do
      FactoryGirl.create(:ws_time_to_commit_few_hours_week)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end


    it "should return the amount of time the volunteer is willing to commit" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.time_to_commit.data.should == "A_Few_Hours_per_Week"

    end
  end

  describe "organizations_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_org_interested_in_Benetech)
      FactoryGirl.create(:ws_org_interested_in_FrontlineSMS)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return ?????? or organizations the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.orgs_interested_in.count.should == 2
      @volunteer.orgs_interested_in[0].data.should == "Benetech"
      @volunteer.orgs_interested_in[1].data.should == "FrontlineSMS"
    end
  end
end

