class Goal < ApplicationRecord
	belongs_to :user
	has_many :key_results

	validates :title, presence: true
end
