module UsersHelper
  def display_nickname(user)
    "@#{user.nickname}"
  end

  def navbar_color
    current_user&.interface_color
  end
end
