class WebformSubmittedData < ActiveRecord::Base
  self.table_name = "webform_submitted_data"
  attr_accessible :nid, :sid, :cid, :no, :data

  belongs_to :volunteer, :foreign_key => 'id'
end
