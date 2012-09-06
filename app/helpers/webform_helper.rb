module WebformHelper

  class WebformSubmissionHelper

    def create_volunteer_from_submission(sid)
      submission = WebformSubmittedData.where("sid = :sid", {:sid => sid})

      if submission.count > 0
        first_name = submission.where(:cid => 1).first.data
        last_name = submission.where(:cid => 2).first.data
        email = submission.where(:cid => 3).first.data

        @volunteer = Volunteer.find_or_create_by_id(sid)

        @volunteer.update_attributes(:first_name => first_name, :last_name => last_name, :email => email, :id => sid)
        @volunteer.save
      end


    end

    def refresh_volunteers
      sid = 1
      number_submissions = WebformSubmittedData.where(:cid => [1,2,3]).order("sid desc").first.sid

      while sid <= number_submissions
        create_volunteer_from_submission(sid)
        sid += 1
      end
    end
  end
end



