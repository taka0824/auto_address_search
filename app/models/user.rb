class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_many :books, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy

    has_many :follower, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followed, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following_user, through: :follower, source: :followed
    has_many :follower_user, through: :followed, source: :follower

    def follow(user_id)
      follower.create(followed_id: user_id)
    end

    def unfollow(user_id)
      follower.find_by(followed_id: user_id).destroy
    end

    def following?(user)
      following_user.include?(user)
    end

    def self.search(search,word)
      # 引数でどのマッチの種類なのかと、テキストボックスに入力した内容を渡している
      if search == "forward_match"
        @user = User.where("name LIKE?","#{word}%")
        # 第一引数でwhereの対象カラム、第二引数で文字列を渡している
      elsif search == "backward_match"
        @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
        @user = User.where(name: "#{word}")
      elsif search == "partial_match"
        @user = User.where("name LIKE?","%#{word}%")
      else
        @user = User.all
      end
    end

    attachment :profile_image
    validates :introduction, length: {maximum: 50}
    validates :name,
      presence: true,
      length: { maximum: 20, minimum: 2 }
end
