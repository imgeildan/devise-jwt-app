class Goal < ApplicationRecord
  belongs_to :user
  has_many   :key_results

  validates  :title, presence: true

  def calculate_progress
    key_results.count.zero? ? 0 : 100 * key_results.completed.count / key_results.count
  end
end
