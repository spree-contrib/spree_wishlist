class Spree::Wishlist < ActiveRecord::Base
  belongs_to :user, :class_name => Spree.user_class.to_s, :foreign_key => 'user_id'
  has_many :wished_products
  attr_accessible :name, :is_private, :is_default
  before_create :set_access_hash

  validates :name, :presence => true

  def include?(variant_id)
    self.wished_products.active.map(&:variant_id).include? variant_id.to_i
  end

  def to_param
    self.access_hash
  end

  def self.get_by_param(param)
    Spree::Wishlist.find_by_access_hash(param)
  end

  def can_be_read_by?(user)
    !self.is_private? || user == self.user
  end

  def is_default=(value)
    self['is_default'] = value
    if self.is_default?
      Spree::Wishlist.update_all({:is_default => false}, ["id != ? AND is_default = ? AND user_id = ?", self.id, true, self.user_id])
    end
  end

  def is_public?
    !self.is_private?
  end

  private

  def set_access_hash
    self.access_hash = Digest::SHA1.hexdigest("--#{user_id}--#{user.password_salt}--#{Time.now}--")
  end
end
