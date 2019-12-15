class User < ApplicationRecord
  # attr_accessor
  attr_accessor :remember_token

  # callback
  before_save { self.email.downcase! }
  has_secure_password

  # validation
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduce, length: { maximum: 150 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # has_many, belongs_to
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
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

  # csv export
  def self.csv_attributes
    [ "name", "email", "admin", "introduce", "sex", "birthday",  "password", "password_confirmation"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  # csv import transaction
  def self.import(file)
    imported_num = 0

    CSV.foreach(file.path, headers: true) do |row|
      user = new
      # *csv_attributes = ("name", "email", "admin", "introduce", "sex", "birthday",  "password_digest" )
      user.attributes = row.to_hash.slice(*csv_attributes)
      if user.valid?
        user.save!
        imported_num +=1
      end
    end
    imported_num
  end

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

  # 与えられた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
