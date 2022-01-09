class Goal < ApplicationRecord
	belongs_to :user
	has_many :key_results
end
