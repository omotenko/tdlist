class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string  :uid
      t.string  :provider
      t.string  :name
      t.timestamps
    end
  end
end
