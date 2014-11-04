class Store < ActiveRecord::Base
  before_validation :remove_slug_spaces

	validates :name, :slug, uniqueness: true
  has_many :items
  has_many :orders
  belongs_to :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  def remove_slug_spaces
    self.slug.gsub!(/[" "]/, '_')
  end

  def completed_orders
    orders.where(:status => "completed")
  end

  def paid_orders
    orders.where(:status => "paid")
  end

  def canceled_orders
    orders.where(:status => "canceled")
  end

  def recent_orders
    orders.where(:status => "ordered")
  end
end
