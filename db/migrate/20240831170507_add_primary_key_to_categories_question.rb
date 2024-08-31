class AddPrimaryKeyToCategoriesQuestion < ActiveRecord::Migration[7.1]
  def change
    add_column :categories_questions, :id, :primary_key
  end
end
