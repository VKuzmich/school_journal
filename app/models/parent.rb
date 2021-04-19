class Parent < ApplicationRecord
  belongs_to :user

  has_many :students

  delegate :email, :full_name, :address, to: :user


  def parent?
    parent.present?
  end
end
