module ProfilesHelper

  def friendship_button(user) 
    case
      when current_user.nil?
        link_to 'Send Request', new_user_session_path
      when current_user == user
        return
      when current_user.already_friends?(user)
        link_to 'Remove Friend', remove_friend_user_path(user.id), method: :delete, class: 'btn btn-danger btn-sm'
      when current_user.already_sent_request?(user)
        link_to 'Cancel Request', remove_request_user_path(user.id), method: :delete, class: 'btn btn-danger btn-sm'
      else
        link_to 'Send Request', send_request_user_path(user.id), method: :post, class: 'btn btn-primary btn-sm'
    end
  end

  def edit_profile_button(user)
    link_to 'Edit Profile',  edit_user_profile_path(user.username) if current_user == user
  end

  def name_details(user)
    if user.profile.first_name || user.profile.last_name
      "Name: #{@user.profile.fullname.titlecase}"
    end
  end
end
