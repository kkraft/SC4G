module WebformHelper

  class WebformSubmissionHelper

    def create_volunteer_from_submission(sid)
      submission = WebformSubmittedData.where("sid = :sid", {:sid => sid})

      first_name = submission.where(:cid => 1).select("data").first.data
      last_name = submission.where(:cid => 2).select("data").first.data
      email = submission.where(:cid => 3).select("data").first.data

      Volunteer.create(:sid => sid, :first_name => first_name, :last_name => last_name, :email => email)
    end

    def refresh_volunteers

    end
  end
end



