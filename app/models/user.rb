class User < ActiveRecord::Base
  validates_presence_of :name, :mobile
  validates_uniqueness_of :email
  validates_length_of :mobile, :is => 4, :message => 'its wrong'
end
