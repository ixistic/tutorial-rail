class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :rentals , :dependent => :destroy
  has_many :books, :through => :rentals
  before_validation :assign_role

  def assign_role
    self.role = Role.find_by_name("Editor") if self.role.nil?
  end

  def admin?
    self.role.name == "Admin" if !self.role.blank?
  end

  def member?
    self.role.name == "Editor" if !self.role.blank?
  end
end
