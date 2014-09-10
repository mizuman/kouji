# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

State.create(:id => 0, :state => "StandBy")
State.create(:id => 1, :state => "Working")
State.create(:id => 2, :state => "Suspend")
State.create(:id => 3, :state => "Finished")
