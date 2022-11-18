module ProfilesHelper
  def users_role
    if current_user.has_role? :admin or current_user.has_role? :moderator or current_user.has_role? :gatekeeper or current_user.has_role? :manager
      
    end
  end
end
