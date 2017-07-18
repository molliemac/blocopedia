class WikisController < ApplicationController
  include WikiHelper

  before_action :authenticate_user!
  before_action :update?, except: [:index, :create, :new, :show]
  before_action :delete?, only: [:destroy]
  #after_action :verify_authorized, except: [:index, :new, :show, :create, :edit]

  def index
    @wikis = Wiki.where(user_id: current_user.id)
  end

  def show
    @wiki = Wiki.find(params[:id])
    options = { autolink: true, filter_html: true }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    @body = markdown.render(@wiki.body)
  end

  def new
    #if current_user
    @wiki = Wiki.new
  end

  def create
    # if current User
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user = current_user
    #authorize @wiki

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
    #authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    #authorize @wiki

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
    #authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki. Try again."
      render :show
    end
  end
end
