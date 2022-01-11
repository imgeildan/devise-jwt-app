class KeyResult < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates  :title, presence: true

  enum status: %w[not_started in_progress completed]
end
