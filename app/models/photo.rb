# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base
  
  has_attached_file :image, :styles => { :product => '320x320>'}
  
  validates_attachment_presence :image
  validates_attachment_size     :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/octet-stream"']
end
