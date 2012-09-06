require 'spec_helper'

describe "Volunteer" do
  before(:all) do
    2.times {FactoryGirl.create(:ws_first_name)}
    2.times {FactoryGirl.create(:ws_last_name)}
    2.times {FactoryGirl.create(:ws_email)}
  end

  describe "company" do
    before(:each) do
      FactoryGirl.create(:ws_company)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return the amount of time the volunteer is willing to commit" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.company.data.should == "Company_1"
    end
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

    it "should return array of organizations the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.orgs_interested_in.count.should == 2
      @volunteer.orgs_interested_in[0].data.should == "Benetech"
      @volunteer.orgs_interested_in[1].data.should == "FrontlineSMS"
    end
  end

  describe "causes_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_causes_interested_in_Healthcare)
      FactoryGirl.create(:ws_causes_interested_in_Disaster_Relief)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of causes the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.causes_interested_in.count.should == 2
      @volunteer.causes_interested_in[0].data.should == "Healthcare"
      @volunteer.causes_interested_in[1].data.should == "Disaster_Relief"
    end
  end

  describe "languages_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_languages_interested_in_Ruby)
      FactoryGirl.create(:ws_languages_interested_in_Java_on_Android)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of languages the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.languages_interested_in.count.should == 2
      @volunteer.languages_interested_in[0].data.should == "Ruby"
      @volunteer.languages_interested_in[1].data.should == "Java_on_Android"
    end
  end

  describe "skills" do
    before(:each) do
      FactoryGirl.create(:ws_skills_Product_Management)
      FactoryGirl.create(:ws_skills_User_Interface_Design)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of skills the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.skills.count.should == 2
      @volunteer.skills[0].data.should == "Product_Management"
      @volunteer.skills[1].data.should == "User_Interface_Design"
    end
  end

  describe "open_source_projects" do
    before(:each) do
      FactoryGirl.create(:ws_open_source_projects_yes, sid: 1)
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)

      Volunteer.create(:first_name => "FirstName_2", :last_name => "LastName_2", :email => "Person_2@example.com", :id => 2)
      FactoryGirl.create(:ws_open_source_projects_no, sid: 2)
    end

    it "should return yes if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.open_source_projects.data.should == "yes"
    end

    it "should return no if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(2)

      @volunteer.first_name.should == "FirstName_2"
      @volunteer.open_source_projects.data.should == "no"
    end
  end

  describe "open_source_projects?" do
    before(:each) do
      Volunteer.create(:first_name => "FirstName_1", :last_name => "LastName_1", :email => "Person_1@example.com", :id => 1)
      FactoryGirl.create(:ws_open_source_projects_yes, sid: 1)

      Volunteer.create(:first_name => "FirstName_2", :last_name => "LastName_2", :email => "Person_2@example.com", :id => 2)
      FactoryGirl.create(:ws_open_source_projects_no, sid: 2)
    end

    it "should return true if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(1)

      @volunteer.first_name.should == "FirstName_1"
      @volunteer.open_source_projects?.should be_true
    end

    it "should return false if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(2)

      @volunteer.first_name.should == "FirstName_2"
      @volunteer.open_source_projects?.should be_false
    end
  end
end

