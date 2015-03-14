class Category < ActiveRecord::Base
  has_many :events

  scope :first_level, -> { where level: 1 }
  scope :second_level, -> { where level: 2 }
  scope :third_level, -> { where level: 3 }
end
