class Task < ApplicationRecord
  # validation
  validates :name, presence: true, length: { maximum: 30 }
  validate:validate_name_not_including_comma
  validates :description, length: { maximum: 200 }
  validates :due_date,  presence: true, date:true;

  # has_many, belongs_to
  has_one_attached :image
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user, dependent: :destroy

  # scope
  scope :recent, -> { order(created_at: :desc) }

  # class
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil )
    %w[name created_at due_date]
  end

  def self.ransackable_associations(auth_object = nil )
    []
  end

  def self.csv_attributes
    ["name", "description", "due_date"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    imported_num = 0

    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      if task.valid?
        task.save!
        imported_num += 1
      end
    end

    imported_num
  end

  private
    def validate_name_not_including_comma
      errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    end
end
