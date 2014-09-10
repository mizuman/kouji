class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
			t.integer :id
			t.string :state
      t.timestamps
    end
  end
end
