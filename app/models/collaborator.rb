class Collaborator < ActiveRecord::Base
	belongs_to :user
	belongs_to :wiki

	validates :user_id, presence: true
	validates :wik_id, presence: true
end
