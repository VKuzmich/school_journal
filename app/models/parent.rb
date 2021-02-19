class Parent < ApplicationRecord
  belongs_to :user

  has_one :student
end
