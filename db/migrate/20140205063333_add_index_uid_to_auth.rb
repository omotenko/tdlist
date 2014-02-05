class AddIndexUidToAuth < ActiveRecord::Migration
  def change
  	add_index :authentications, :uid
  end
end
