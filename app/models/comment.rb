class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  # scope
    scope :comment_order, -> { order(created_at: :desc) }
end
