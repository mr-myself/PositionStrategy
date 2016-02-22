class User < ActiveRecord::Base
  has_many :user_company_maps
  has_many :companies, through: :user_company_maps

  validates :name,     presence: true, uniqueness: true, length: { maximum: 250 }
  validates :password, presence: true, length: { maximum: 250 }, confirmation: true, unless: :is_uid
  validates :uid,      allow_blank: true, numericality: true
  validates :email,    allow_blank: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_\.\-\+]+@[A-Za-z0-9_\.\-\+]+\.[A-Za-z0-9_\.\-\+]+\Z/ }

  before_save :password_sha512
  before_update :password_sha512
  before_update :get_rid_of_password

  attr_accessor :password_confirmation

  class << self
    def login(name, password)
      User.find_by(name: name, password: PasswordBuilder.to_sha512(password)) || false
    end

    def reset_password(email, password)
      user = self.find_by(email: email)
      ActiveRecord::Base.transaction do
        ResetToken.delete_all(email: email)
        user.update_attributes(password: PasswordBuilder.to_sha512(password))
      end
    end
  end

  def get_rid_of_password
    self.delete(:password) if self.password.blank?
  end

  def is_uid
    self.uid.present?
  end

  def password_sha512
    self.password = PasswordBuilder.to_sha512(self.password) if self.password
  end

  def my_company
    CompanyRepository::Jpn.find_my_company(self.id)
  end
end
