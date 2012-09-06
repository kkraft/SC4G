require 'spec_helper'
include WebformHelper

describe "Webform Submission Helper" do
  before(:all) do
    @webformSubmissionHelper = WebformSubmissionHelper.new
    30.times { FactoryGirl.create(:webform_submission_first_name)}
    30.times { FactoryGirl.create(:webform_submission_last_name)}
    30.times { FactoryGirl.create(:webform_submission_email)}
  end

  describe "create_volunteer_from_submission" do

    it "create volunteer with first name, last name and email" do
      @webformSubmissionHelper.create_volunteer_from_submission(1)

      Volunteer.count.should == 1

      volunteer = Volunteer.where(:sid => 1).first

      volunteer.should_not be_nil
      volunteer.first_name.should == "FirstName_1"
      volunteer.last_name.should == "LastName_1"
      volunteer.email.should == "Person_1@example.com"
    end
  end

  #describe "refresh_volunteers" do
  #
  #
  #  it "should update volunteer table with all volunteers from webform_submitted_data table" do
  #    @webformSubmissionHelper.refresh_volunteers
  #
  #    Volunteer.count.should == 30
  #
  #
  #  end
  #end
  after(:all) do
    WebformSubmittedData.delete_all
  end
end
