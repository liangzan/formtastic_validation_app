class User < ActiveRecord::Base
  validates_presence_of :name, :message => "its not right baby"
  validates_uniqueness_of :email
  validates_length_of :mobile, :is => 4, :message => 'its wrong'
end
