class Item < ActiveRecord::Base
  # attr_accessible :price, :name, :real, :decription, :weight
  
  validates :price, numericality: { greater_than: 0, allow_nil: true } 
  validates :name, :description, presence: true
  
  mount_uploader :image, ImageUploader
  has_many :positions
  has_many :carts, through: :positions
  
  has_many :comments, as: :commentable
  
  # has_one :image
  # accepts_nested_attributes_for :image
  after_initialize {  }
  after_save {  }
  after_create {  }
  after_update {  }
  after_destroy {  }

end
