class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z]+\z/}

  validates :address,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_.,!"" ]+\z/}

  validates_length_of :first_name, :last_name, :address, within: 3..40

  validates :phone, presence: true,
          format: {
            with:  /(\+38)\(?\d{3}\)?[\-]?(\d{3}[\-]\d{2}\d{2}|\d{3}-\d{4})/ ,
            message: I18n.t("model.user.message")
          }

  validates_each :first_name, :last_name, :address do |record, attr, value|
    record.errors.add(attr, I18n.t('.model.user.must_start_with_upper_case')) if value =~ /\A[a-z]/
  end
end
