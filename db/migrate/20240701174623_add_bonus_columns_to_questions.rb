class AddBonusColumnsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :bonus, :boolean
    add_column :questions, :final_trivia, :boolean
    add_column :questions, :double_jeopardy, :boolean
  end
end
