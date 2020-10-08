module ControllerPolicy

  def is_collaborator(wiki)
    wiki.collaborators.each do |collaborator|
      if collaborator['user_id'] == current_user.id then return true end
    end
    false
  end

  def is_owner?(wiki)
    wiki.user_id == current_user.id
  end

  def is_admin?
    current_user.role == 'admin'
  end
end