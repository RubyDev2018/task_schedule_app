class User < ApplicationRecord
  # 画像upload
  mount_uploader :image, ImageUploader

  before_save { self.email.downcase! }
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduce, length: { maximum: 150 }


  has_many :tasks, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorites_tasks, through: :favorites, source: :task, dependent: :destroy

 # # ====================自分がフォローしているユーザーとの関連 ====================
 has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
 # # 中間テーブルを介してfollowerモデルのUser(フォローされる側)を集めることをfollowingsと定義
 has_many :followings, through: :following_relationships

 # # ====================自分がフォローされるユーザーとの関連 =======================
 has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
 # # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
 has_many :followers, through: :follower_relationships

 # favorite function method
 def favorite?(task)
   favorites.find_by(task_id: task.id)
 end

  def favorite!(task)
    favorites.create!(task_id: task.id)
  end

 def unfavorite!(task)
   favorites.find_by(task_id: task.id).destroy
 end

 # follow/unfollow function method
 def following?(other_user)
   following_relationships.find_by(following_id: other_user.id)
 end

 def follow!(other_user)
   following_relationships.create!(following_id: other_user.id)
 end

 def unfollow!(other_user)
   following_relationships.find_by(following_id: other_user.id).destroy
 end

end
