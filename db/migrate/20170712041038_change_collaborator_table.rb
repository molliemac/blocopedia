class ChangeCollaboratorTable < ActiveRecord::Migration
  def change
  	change_table :collaborators do |t|
	    add_index :users, :id, unique: true
	    add_index :wikis, :id, unique: true
	    add_index :collaborators, :id, unique: true
	    add_index :collaborators, :user_id
	    add_index :collaborators, :wiki_id
	  end
	end
end
