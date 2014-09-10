class Announce < ActiveRecord::Base
	belongs_to :state
  attr_accessible :title, :device, :etime, :mail, :message, :name, :stime, :tel, :state_id
  validates :name, 	:presence => true
  validates :tel,	:presence => true
  validates :device,	:presence => true
	scope :working, where("state_id = 1")
	scope :finished, where("state_id = 3")
  scope :not_finished, where("NOT state_id = 3")
	scope :last_24_hours, lambda{
		where("etime > ?", 24.hours.ago ) 
	}

end
