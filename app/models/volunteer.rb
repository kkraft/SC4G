class Volunteer < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :id
  attr_readonly :time_to_commit, :orgs_interested_in

  has_one :time_to_commit,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 19 AND sid = '#{self.id}'"}

  has_many :orgs_interested_in,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 18 AND sid = '#{self.id}'"}

end




