class WebformSubmittedData < ActiveRecord::Base
  set_table_name "webform_submitted_data"

  attr_accessible :nid, :sid, :cid, :no, :data
end
