module UsersHelper
  def display_nickname(user)
    "@#{user.nickname}"
  end
end
