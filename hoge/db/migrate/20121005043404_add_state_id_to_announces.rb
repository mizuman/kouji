class AddStateIdToAnnounces < ActiveRecord::Migration
  def change
		rename_column :Announces, :status, :state_id
  end
end
