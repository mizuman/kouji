class State < ActiveRecord::Base
	has_many :announces, :foreign_key => 'state_id'
  attr_accessible :id, :state
end
