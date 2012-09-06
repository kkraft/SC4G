FactoryGirl.define do
  factory :webform_submission_first_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 1
    no 0
    sequence(:data) { |n| "FirstName_#{n}"}
  end

  factory :webform_submission_last_name, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 2
    no 0
    sequence(:data) { |n| "LastName_#{n}"}
  end

  factory :webform_submission_email, class: WebformSubmittedData do
    nid 5
    sequence(:sid) { |n| "#{n}" }
    cid 3
    no 0
    sequence(:data) { |n| "Person_#{n}@example.com"}
  end
end