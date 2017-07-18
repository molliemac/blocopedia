class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators

  # check to see if a user is present of signed in.
  # If it is a premium or admin user, show all. Else, show all wikis that are public
  #scope :visible_to, -> (user){ user && ((user.premium?) || (user.admin?)) ? where(private: false) + where(private: true, user: user) : where(private: false) }

 validates :title, length: { minimum: 5 }, presence: true
 validates :body, length: { minimum: 5 }, presence: true
  
end
