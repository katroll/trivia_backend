class Question < ApplicationRecord
  has_many :categories_questions
  has_many :categories, through: :categories_questions
end
