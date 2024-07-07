require 'csv'

class TriviaQuestionImport

  def import
    all_rows = CSV.read("lib/question_import/trivia-round-1.csv", headers: true, col_sep: ",", header_converters: :symbol)

    all_rows.each do |row|
      question = row[:question]
      answer = row[:answer]
      category = row[:category]
      
      new_question = Question.create!(
        question: question,
        answer: answer,
        bonus: row[:bonus] == "TRUE",
        final_trivia: row[:final_trivia] == "TRUE",
        double_jeopardy: row[:double_jeopardy] == "TRUE"
      )

      categories = row[:category].split(",")
        
      categories.each do |category_name|
        category = Category.find_by(name: category_name)

        if category.nil?
          category = Category.create!(name: category_name)
          puts category
        end

        new_question.categories << category
      end
    rescue => e
      puts e
    end

  end
end