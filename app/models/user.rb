class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true,
    uniqueness: true,
    format: {with: /[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-z0-9._-]/,
      message: ' - неправильный формат email'}

  validates :nickname, presence: true,
    uniqueness: true,
    length: {maximum: 40},
    format: {with: /[a-zA-Z0-9_]/,
      message: '- для ника используйте только латинские буквы, цифры и знак нижнее подчеркивание "_"'}

  def downcase_nickname
    nickname.downcase!
  end
end
