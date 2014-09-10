class AddMailidToAnnounces < ActiveRecord::Migration
  def change
    add_column :announces, :mailid, :string
  end
end
