class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_tasks, through: :favorites, source: :task, dependent: :destroy
end
