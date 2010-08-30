class User < ActiveRecord::Base
  validates_presence_of :name, :message => "you must have a name"
  validates_format_of :email, :with => /^[\w\d]+@[\w\d]+\.com$/
  validates_numericality_of :mobile
  validates_exclusion_of :address, :in => ["cafe", "bar"]
  validates_confirmation_of :password
  validates_inclusion_of :gender, :in => ["male", "female"]
  validates_numericality_of :age, :only_integer => true, :minimum => 21, :message => "Only 21 and above are allowed"
  validates_length_of :website, :is => 5
  validates_size_of :company, :is => 5
  validates_presence_of :title
  validates_inclusion_of :title, :in => ["Dr", "Ms", "Mr"]
  validates_acceptance_of :terms_of_service
end
