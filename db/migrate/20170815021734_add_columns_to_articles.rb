class AddColumnsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :status, :integer
    add_column :articles, :read_count, :integer
    add_column :articles, :category, :integer   
  end
end
