class Event < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	belongs_to :event_type
end
