class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :introduction, :text
    add_column :users, :region, :string
  end
end
