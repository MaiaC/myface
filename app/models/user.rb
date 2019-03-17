class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  validates :name, presence: true

  has_many :friendships
  has_many :inverse_friends, class_name: "Friendship", foreign_key: :friend_id

  has_many :posts
  has_many :likes
  has_many :comments

  after_create :send_welcome_mail

  def friends
    friends = friendships.map { |f| f.friend if f.accepted }.compact
    friends + inverse_friends.map { |f| f.user if f.accepted }.compact
  end

  def pending_received
    requests = inverse_friends.map { |f| f.user if !f.accepted }.compact
  end

  def pending_sent
    requests = friendships.map { |f| f.friend if !f.accepted }.compact
  end

  def friends?(user)
    self.friends.include?(user)
  end

  def connection?(user)
    self.friends?(user) || self.pending_received.include?(user) || self.pending_sent.include?(user)
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id"
    friend_ids + "SELECT user_id FROM friendships WHERE friend_id = :user_id"
    feed = Post.where("user_id IN (#{friend_ids}) OR user_id = :user_id", user_id: id).order(created_at: :desc)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end      
  end

  def send_welcome_mail
    WelcomeMailer.with(user: self).welcome_email.deliver!
  end
end
