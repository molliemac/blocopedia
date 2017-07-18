class CollaboratorsController < ApplicationController
  #include Pundit
  #skip_after_action :verify_authorized

  def new
    @wiki_collaborators = []
    @wiki = params['wiki_id']
    @collaborators = Wiki.find(@wiki).collaborators
    @collaborators.each { |collaborator| @wiki_collaborators.push(collaborator.user) }
    @collaborator = Collaborator.new
  end

	def create
    @collaborator = Collaborator.new( user_id: find_user(params['collaborator']['user_id']), wiki_id: @wiki)

    if @collaborator.save
      flash['notice'] = "Collaborator added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash['alert'] = "Unable to add collaborator, could not find user"
      redirect_to edit_wiki_path(@wiki)
    end
  end


  def destroy

    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed from wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator could not be removed."
      redirect_to edit_wiki_path(@wiki)
    end
  end
  
  def find_user(email)
    user = User.find_by(email: email)
    if user.nil?
      return
    else
      user.id
    end
  end
end
