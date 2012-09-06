FactoryGirl.define do
  factory :ws_first_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 1
    no 0
    sequence(:data) { |n| "FirstName_#{n}"}
  end

  factory :ws_last_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 2
    no 0
    sequence(:data) { |n| "LastName_#{n}"}
  end

  factory :ws_email, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 3
    no 0
    sequence(:data) { |n| "Person_#{n}@example.com"}
  end

  factory :ws_time_to_commit_few_hours_week, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 19
    no 0
    data "A_Few_Hours_per_Week"
  end

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


end