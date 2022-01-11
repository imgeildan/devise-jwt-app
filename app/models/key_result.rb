class KeyResult < ApplicationRecord
	belongs_to :user
	belongs_to :goal

	enum status: [:not_started, :in_progress, :completed]

	validates :title, presence: true
end
