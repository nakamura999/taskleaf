class Task < ApplicationRecord
	validates :name, presence: true, length: { maximum: 30 }
	validates :description, presence: true

	validate :validate_name_not_comma

	private

	def validate_name_not_comma
		errors.add(:name, "にカンマを含めることはできません") if name&.include?(',')
	end
	# オリジナル検証コード

end
