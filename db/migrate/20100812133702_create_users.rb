class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string    :name #presence
      t.string    :email #format
      t.integer   :mobile #length
      t.boolean   :terms_of_service, :default => false #acceptance
      t.string    :password #confirmation
      t.integer   :age #numericality
      t.string    :website #format
      t.string    :gender #inclusion
      t.string    :address #exclusion
      t.string    :company #presence, inclusion
      t.string    :title #exclusion
    end
  end

  def self.down
    drop_table :users
  end
end
