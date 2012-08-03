class User < ActiveRecord::Base
	nilify_blanks
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username, :allow_blank => true, :if => :username_changed?

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :quotes, :foreign_key => :owner_id, :dependent => :nullify
  has_many :quote_activities, :dependent => :destroy  
  has_many :comments, :foreign_key => :author_id
  has_many :comment_activities, :dependent => :destroy

  def quote_activity_for(quote)
    quote_activities.find_or_initialize_by_quote_id(quote.id)
  end
    
  def comment_activity_for(comment)
     comment_activities.find_or_initialize_by_comment_id(comment.id)
  end

end
