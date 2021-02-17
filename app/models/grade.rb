class Grade < ApplicationRecord
  attr_accessor :number
  start_number = 1
  end_number = 12
  validates :number, presence: true
  validates_inclusion_of :number, in: start_number..end_number
  validates :group, presence: true, format: { with: /^(?=.*[A-Z]).+$/}
end
