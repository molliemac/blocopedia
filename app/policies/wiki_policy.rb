class WikiPolicy < ApplicationPolicy
  def update?
    @wiki = Wiki.find(parmas[:id])
    unless @wiki.user_id == current_user.id || @wiki.public
      flash.now[:alert] = "You must own this wiki to make changes."
      render :show
    end
  end

  def standard?

  end

  def premium?

  end

  def owner?

  end
end
