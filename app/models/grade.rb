class Grade < ApplicationRecord
  START_NUMBER = 1
  END_NUMBER = 12
  GROUP_LETTERS_LENGTH = 1
  validates :number, presence: true
  validates_inclusion_of :number, in: START_NUMBER..END_NUMBER
  validates :group,
            presence: true,
            format: { with: /\A(?=.*[A-Z]).+\z/ },
            length: { is: GROUP_LETTERS_LENGTH}
end
