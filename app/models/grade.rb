class Grade < ApplicationRecord
  START_NUMBER = 1
  private_constant :START_NUMBER
  END_NUMBER = 12
  private_constant :END_NUMBER
  GROUP_LETTERS_LENGTH = 1
  private_constant :GROUP_LETTERS_LENGTH

  has_many :lessons

  validates :number, presence: true
  validates :number, inclusion: START_NUMBER..END_NUMBER
  validates :group,
            presence: true,
            format: { with: /\A(?=.*[A-Z]).+\z/ },
            length: { is: GROUP_LETTERS_LENGTH }

  private_constant :START_NUMBER, :END_NUMBER, :GROUP_LETTERS_LENGTH
end
