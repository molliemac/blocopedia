class AddCollaborators < ActiveRecord::Migration
  def change
     create_table :collaborators do |t|
       t.references :user, foreign_key: true
       t.references :wiki, foregin_key: true
       t.timestamps
     end
 end
end
