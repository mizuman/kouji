class AddStatusToAnnounce < ActiveRecord::Migration
	def change
		add_column :announces, :status, :integer
  end
end
