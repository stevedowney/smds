class User < ActiveRecord::Base
	nilify_blanks
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body
  validate :username, :presence => true

  has_many :quotes, :foreign_key => :owner_id, :dependent => :nullify
  has_many :quote_activities, :class_name => "UserQuoteActivity", :dependent => :destroy  
  has_many :comments, :foreign_key => :author_id

  def activity_for(quote)
     quote_activities.find_or_initialize_by_quote_id(quote.id)
  end

end
