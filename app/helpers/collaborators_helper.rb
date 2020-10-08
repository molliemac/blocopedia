module CollaboratorsHelper
	def find_collaborator(user)
		Collaborator.where(user_id: user, wiki_id: @wiki)
	end
end
