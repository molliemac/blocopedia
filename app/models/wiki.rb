class Wiki < ActiveRecord::Base
  #has_many :collaborators
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  belongs_to :user

  # check to see if a user is present of signed in.
  # If it is a premium or admin user, show all. Else, show all wikis that are public
  #scope :visible_to, -> (user){ user && ((user.premium?) || (user.admin?)) ? where(private: false) + where(private: true, user: user) : where(private: false) }

  # make private wikis public
  def make_public
    self.private = false
    save
    self.collaborators.clear
  end
  
end
