class User < ActiveRecord::Base
  validates_presence_of :name, :message => "you must have a name"
  validates_format_of :email, :with => /someone@email\.com/
  validates_length_of :mobile, :is => 8, :message => 'its too short'
  validates_acceptance_of :terms_of_service
  validates_confirmation_of :password
  validates_numericality_of :age, :only_integer => true, :minimum => 21, :message => "Only 21 and above are allowed"
  validates_format_of :website, :with => /www.something.com/
  validates_inclusion_of :gender, :in => ["male", "female"]
  validates_exclusion_of :address, :in => ["cafe", "bar"]
  validates_presence_of :company
  validates_inclusion_of :company, :in => ["A Inc", "B Inc"]
  validates_exclusion_of :title, :in => ["Dr", "Ms"]
end
