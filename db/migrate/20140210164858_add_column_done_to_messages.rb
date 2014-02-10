class AddColumnDoneToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :done, :string
  end
end
