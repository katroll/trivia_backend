class Question < ApplicationRecord
  acts_as_paranoid

  has_many :categories_questions
  has_many :categories, through: :categories_questions

  scope :active, -> { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.current)
  end

  def really_destroy!
    super
  end

  def deleted?
    deleted_at.present?
  end
end
