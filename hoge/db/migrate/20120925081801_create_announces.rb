class CreateAnnounces < ActiveRecord::Migration
  def change
    create_table :announces do |t|
      t.string :name
      t.string :tel
      t.string :mail
      t.datetime :stime
      t.datetime :etime
      t.string :device
      t.text :message

      t.timestamps
    end
  end
end
