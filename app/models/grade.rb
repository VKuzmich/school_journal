class Grade < ApplicationRecord
  START_NUMBER = 1
  END_NUMBER = 12
  GROUP_LETTERS_LENGTH = 1

  has_many :lessons
  has_many :students

  validates :number, presence: true
  validates :number, inclusion: START_NUMBER..END_NUMBER
  validates :letter,
            presence: true,
            format: { with: /\A(?=.*[A-Z]).+\z/ },
            length: { is: GROUP_LETTERS_LENGTH },
            uniqueness: { scope: :number}

  def grade_group
    "#{number}-#{letter}"
  end
end
