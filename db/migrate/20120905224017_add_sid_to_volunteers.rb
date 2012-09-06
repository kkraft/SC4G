class AddSidToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :sid, :integer
  end
end
