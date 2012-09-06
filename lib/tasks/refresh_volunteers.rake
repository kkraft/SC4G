require  Rails.root.to_s + "/app/helpers/webform_helper.rb"
include WebformHelper

task :refresh_volunteers => :environment do
  webformHelper = WebformSubmissionHelper.new
  webformHelper.refresh_volunteers
end