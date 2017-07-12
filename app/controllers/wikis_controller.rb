class WikisController < ApplicationController

  before_action :authorize_user, except: [:index, :show]
  def index
    #anyone
    @wikis = policy_scope(Wiki)
  end

  def show
    #anyone
    @wiki = Wiki.find(params[:id])
  end

  def new
    #if current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    # if current User
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "Error. Could not save the wiki."
      render :new
    end
  end

  def edit
    # if current user
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki has been updated."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end


  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki. Try again."
      render :show
    end
  end

  

  private

  def authorize_user
    # @wikis = Wiki.find(params[:id])
    unless current_user
      flash[:alert]= "You must be logged in to do that. Sign up or log in now!"
      redirect_to root_path
    end
  end

  def clear_collaborators
    @wiki = Wiki.find(params[:id])
    if @wiki.private == false
      @wiki.collaborators.clear
    end
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
