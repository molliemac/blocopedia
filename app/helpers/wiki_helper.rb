module WikiHelper
	include ControllerPolicy

  def update?
    @wiki = Wiki.find(params[:id])

    if @wiki.private && @wiki.user_id != current_user.id && !is_collaborator(@wiki) && !is_admin?
      flash[:alert] = "You must own this wiki to make changes."
      redirect_to wiki_path(@wiki)
    end
  end

  def own?
    @wiki = Wiki.find(params[:id])
    @wiki.user_id == current_user.id
  end

  def premium?
    current_user.role == 'premium'
  end

  def delete?
    @wiki = Wiki.find(params[:id])
    unless @wiki.user_id == current_user.id || is_admin?
      flash[:alert] = "You must own this to delete it"
      redirect_to wiki_path(@wiki)
    end
  end
end
