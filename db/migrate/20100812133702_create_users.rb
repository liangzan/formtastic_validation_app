class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string    :name     #presence
      t.string    :email    #format
      t.integer   :mobile   #length, numericality
      t.string    :address  #exclusion
      t.string    :password #confirmation
      t.string    :gender   #inclusion
      t.integer   :age      #numericality
      t.string    :website
      t.string    :company  #size of
      t.string    :title    #presence, inclusion
      t.boolean   :terms_of_service, :default => false #acceptance
    end
  end

  def self.down
    drop_table :users
  end
end
