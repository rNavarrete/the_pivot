class Category < ActiveRecord::Base

  has_many :category_items
  has_many :items, through: :category_items
  validates :name, presence: :true

  default_scope { order('position ASC')}

  def active_items
    items.where(:status => "active")
  end

  def items_from_active_and_online_stores
    active_items.select do
      |item| item.store.authorized && item.store.online
    end
  end

end
