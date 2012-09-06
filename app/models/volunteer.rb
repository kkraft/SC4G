class Volunteer < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :id
  attr_readonly :time_to_commit, :orgs_interested_in, :causes_interested_in, :languages_interested_in, :skills, :open_source_projects, :company

  has_one :company,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 17 AND sid = '#{self.id}'"}

  has_one :time_to_commit,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 19 AND sid = '#{self.id}'"}

  has_one :open_source_projects,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 22 AND sid = '#{self.id}'"}

  has_many :orgs_interested_in,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 18 AND sid = '#{self.id}'"}

  has_many :causes_interested_in,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 11 AND sid = '#{self.id}'"}

  has_many :languages_interested_in,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 13 AND sid = '#{self.id}'"}

  has_many :skills,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 14 AND sid = '#{self.id}'"}

  def open_source_projects?
    self.open_source_projects.data == "yes"
  end

end




