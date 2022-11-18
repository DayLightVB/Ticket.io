class Tag < ApplicationRecord
  has_and_belongs_to_many :events
  has_one_attached :avatar

  validates :name, presence: true, uniqueness: true

  scope :by_name, ->(name) { where(name: name) }

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.lowercase.strip).first_or_create!
    end
  end
end
