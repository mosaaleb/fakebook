class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Callbacks
  after_create :create_profile

  # Validations
  validates :username, presence: true

  # Associations
  has_one :profile
  has_many :requests, foreign_key: "receiver_id", dependent: :destroy
  has_many :pending_friends, through: :requests, source: :sender

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  has_many :posts, dependent: :destroy

  has_many :comments

  has_many :likes
  has_many :liked_comments, through: :likes, source: :likable, source_type: 'Comment'
  has_many :liked_posts, through: :likes, source: :likable, source_type: 'Post'  


  # Instance methods
  # comment or post
  def liked(likable)
    likable.kind_of?(Comment) ? liked_comments << likable : liked_posts << likable
  end

end
