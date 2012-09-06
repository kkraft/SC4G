require 'spec_helper'
#require 'database_cleaner'
#DatabaseCleaner.strategy = :transaction
include WebformHelper

describe "Webform Submission Helper" do
  before(:all) do
    @webformSubmissionHelper = WebformSubmissionHelper.new
    30.times { FactoryGirl.create(:ws_first_name)}
    30.times { FactoryGirl.create(:ws_last_name)}
    30.times { FactoryGirl.create(:ws_email)}
  end

  #before(:each) do
  #  DatabaseCleaner.start
  #end
  #
  #after(:each) do
  #  DatabaseCleaner.clean
  #end

  describe "create_volunteer_from_submission" do

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


    it "should update volunteer table with all volunteers from webform_submitted_data table" do
      @webformSubmissionHelper.refresh_volunteers

      Volunteer.count.should == 30

      volunteer1 = Volunteer.where(:id => 1).first
      volunteer25 = Volunteer.where(:id => 25).first

      volunteer1.first_name.should == "FirstName_1"
      volunteer25.first_name.should == "FirstName_25"
      volunteer1.last_name.should == "LastName_1"
      volunteer25.last_name.should == "LastName_25"
      volunteer1.email.should == "Person_1@example.com"
      volunteer25.email.should == "Person_25@example.com"

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

      volunteer1 = Volunteer.where(:id => 1).first
      volunteer51 = Volunteer.where(:id => 51).first
      volunteer112 = Volunteer.where(:id => 112).first

      volunteer1.first_name.should == "FirstName_1"
      volunteer51.first_name.should == "FirstName_51"
      volunteer1.last_name.should == "LastName_1"
      volunteer51.last_name.should == "LastName_51"
      volunteer1.email.should == "Person_1@example.com"
      volunteer51.email.should == "Person_51@example.com"
      volunteer112.first_name.should == "FirstName_112"
      volunteer112.last_name.should == "LastName_112"
      volunteer112.email.should == "Person_112@example.com"

    end

  end

  #after(:all) do
  #  DatabaseCleaner.clean
  #end

end
