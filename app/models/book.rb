class Book < ApplicationRecord
  belongs_to :publisher
  has_many :authorships , :dependent => :destroy
  has_many :authors, :through => :authorships
  has_many :rentals , :dependent => :destroy
  has_many :users, :through => :rentals
end

