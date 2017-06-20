class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  has_many :wikis, dependent: :destroy

  after_initialize :init_role

  before_save { self.email = email.downcase if email.present? }
  #after_create :send_confirmation_email

  # validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  enum role: [:standard, :admin, :premium]

  def init_role
    self.role ||= :standard
  end

  private

  def downgrade
    self.role = "standard"
    wikis.each do |wiki|
      wiki.make_public
    end
    save
  end
end
