class Category < ApplicationRecord
  has_many :categories_questions
  has_many :questions, through: :categories_questions
end