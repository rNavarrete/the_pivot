class Item < ActiveRecord::Base
  has_many :category_items
  has_many :categories, through: :category_items
  validates :name, presence: :true
  validates :description, length: { minimum: 25 }
  validates :price, presence: :true
  validates :price, numericality: { greater_than_or_equal_to: 0}

    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
