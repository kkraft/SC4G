require 'spec_helper'
include WebformHelper

describe "Webform Submission Helper" do

  before(:each) do
    @webformSubmissionHelper = WebformSubmissionHelper.new
  end

  describe "create_volunteer_from_submission" do
    before(:each) do
      FactoryGirl.create(:ws_first_name, sid: 1, data: "FirstName_1")
      FactoryGirl.create(:ws_last_name, sid: 1, data: "LastName_1")
      FactoryGirl.create(:ws_email, sid: 1, data: "Person_1@example.com")
    end

    it "create volunteer with first name, last name and email" do
      @webformSubmissionHelper.create_volunteer_from_submission(1)

      Volunteer.count.should == 1

      volunteer = Volunteer.where(:id => 1).first

      volunteer.should_not be_nil
      volunteer.first_name.should == "FirstName_1"
      volunteer.last_name.should == "LastName_1"
      volunteer.email.should == "Person_1@example.com"
    end
  end

  describe "refresh_volunteers" do
    before(:all) do
      30.times { FactoryGirl.create(:ws_first_name)}
      30.times { FactoryGirl.create(:ws_last_name)}
      30.times { FactoryGirl.create(:ws_email)}
    end

    it "should update volunteer table with all volunteers from webform_submitted_data table" do

      WebformSubmittedData.count.should == 90
      @webformSubmissionHelper.refresh_volunteers

      Volunteer.count.should == 30

      volunteer_first = Volunteer.first
      volunteer_last = Volunteer.last

      volunteer_first.first_name.should == "FirstName_" + volunteer_first.id.to_s
      volunteer_last.first_name.should == "FirstName_" + volunteer_last.id.to_s
      volunteer_first.last_name.should == "LastName_" + volunteer_first.id.to_s
      volunteer_last.last_name.should == "LastName_" + volunteer_last.id.to_s
      volunteer_first.email.should == "Person_" + volunteer_first.id.to_s + "@example.com"
      volunteer_last.email.should == "Person_" + volunteer_last.id.to_s + "@example.com"

    end

    it "should handle missing sids" do
      WebformSubmittedData.create(:nid => 5, :sid => 51, :cid => 1, :no => 0, :data => "FirstName_51")
      WebformSubmittedData.create(:nid => 5, :sid => 51, :cid => 2, :no => 0, :data => "LastName_51")
      WebformSubmittedData.create(:nid => 5, :sid => 51, :cid => 3, :no => 0, :data => "Person_51@example.com")

      WebformSubmittedData.create(:nid => 5, :sid => 112, :cid => 1, :no => 0, :data => "FirstName_112")
      WebformSubmittedData.create(:nid => 5, :sid => 112, :cid => 2, :no => 0, :data => "LastName_112")
      WebformSubmittedData.create(:nid => 5, :sid => 112, :cid => 3, :no => 0, :data => "Person_112@example.com")

      WebformSubmittedData.count.should == 96

      @webformSubmissionHelper.refresh_volunteers

      Volunteer.count.should == 32

      volunteer51 = Volunteer.where(:id => 51).first
      volunteer112 = Volunteer.where(:id => 112).first

      volunteer51.first_name.should == "FirstName_51"
      volunteer51.last_name.should == "LastName_51"
      volunteer51.email.should == "Person_51@example.com"
      volunteer112.first_name.should == "FirstName_112"
      volunteer112.last_name.should == "LastName_112"
      volunteer112.email.should == "Person_112@example.com"

    end

  end

end
