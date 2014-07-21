class User < ActiveRecord::Base
  has_many :spendings, dependent: :destroy
  has_many :temp_budget_plans, dependent: :destroy
  # taken from Michael Hartl's tutorial
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # the following uses Regex (lookahead assertion) to ensure there is at least a lower case and upper case letter,
  # a digit, and a special character (non-word character) with at least 7 characters
  VALID_PASSWORD_REGEX= /\A^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W).{7,}$\z/
  validates :username, presence: true, uniqueness:{case_sensitive:false}, length: {within: 7..50}
  validates :email, presence: true, uniqueness:{case_sensitive:false}, format: {with:VALID_EMAIL_REGEX}
  validates :password, presence: true, format: {with:VALID_PASSWORD_REGEX}
  # used for password digest to confirm two passwords entered match
  has_secure_password
  
  #ensure all email address are saved lower case
  before_save{self.email=email.downcase}
  
end
