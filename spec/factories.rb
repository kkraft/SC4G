FactoryGirl.define do

  # first name
  factory :ws_first_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 1
    no 0
    sequence(:data) { |n| "FirstName_#{n}"}
  end

  #last name

  factory :ws_last_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 2
    no 0
    sequence(:data) { |n| "LastName_#{n}"}
  end

  #email

  factory :ws_email, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 3
    no 0
    sequence(:data) { |n| "Person_#{n}@example.com"}
  end

  #company

  factory :ws_company, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 17
    no 0
    sequence(:data) { |n| "Company_#{n}"}
  end

  #time to commit

  factory :ws_time_to_commit_few_hours_week, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 19
    no 0
    data "A_Few_Hours_per_Week"
  end

  #organizations interested in

  factory :ws_org_interested_in_Benetech, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 18
    no 0
    data "Benetech"
  end

  factory :ws_org_interested_in_FrontlineSMS, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 18
    no 1
    data "FrontlineSMS"
  end

  #causes interested in

  factory :ws_causes_interested_in_Healthcare, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 11
    no 0
    data "Healthcare"
  end

  factory :ws_causes_interested_in_Disaster_Relief, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 11
    no 1
    data "Disaster_Relief"
  end

  #languages interested in

  factory :ws_languages_interested_in_Ruby, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 13
    no 0
    data "Ruby"
  end

  factory :ws_languages_interested_in_Java_on_Android, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 13
    no 1
    data "Java_on_Android"
  end

  #skills

  factory :ws_skills_Product_Management, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 14
    no 0
    data "Product_Management"
  end

  factory :ws_skills_User_Interface_Design, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 14
    no 1
    data "User_Interface_Design"
  end

  # open source projects ?
  factory :ws_open_source_projects_yes, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 22
    no 0
    data "yes"
  end

  factory :ws_open_source_projects_no, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 22
    no 0
    data "no"
  end






end