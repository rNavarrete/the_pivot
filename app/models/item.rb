class Item < ActiveRecord::Base
  store_accessor :options, :sizes, :colors

  has_many :order_items
  has_many :category_items
  has_many :categories, through: :category_items
  belongs_to :store

  validates :store_id, presence: true
  validates :name, presence: true
  validates :description, length: { minimum: 25 }
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0}
  validates :status, inclusion: ['active', 'retired', 'Active', 'Retired']
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://placekitten.com/g/400/400"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  default_scope { order('id ASC')}

  def self.active
    where(status: 'active')
  end

  def self.items_from_active_and_online_stores
    active.select do
      |item| item.store.authorized && item.store.online
    end
  end

  def status=(new_status)
    super(new_status.downcase)
  end

  def self.custom_items
    Item.first(10).select do |item|
      item.store.authorized == true || item.store.online == true
    end
  end
end
