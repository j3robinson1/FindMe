class Post < ActiveRecord::Base
  has_many :post_attachments, dependent: :destroy
  accepts_nested_attributes_for :post_attachments
  belongs_to :user
end
