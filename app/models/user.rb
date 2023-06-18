class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
    uniqueness: true,
    format: {with: /.+@.+\..+/}

  validates :nickname, presence: true,
    uniqueness: true,
    length: {maximum: 40},
    format: {with: /\A\w+\z/}

  after_validation :downcase_nickname

  def downcase_nickname
    nickname.downcase!
  end
end
