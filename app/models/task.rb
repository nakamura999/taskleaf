class Task < ApplicationRecord
	before_validation :set_nameless_name

	validates :name, presence: true, length: { maximum: 30 }
	validates :description, presence: true

	validate :validate_name_not_comma

	belongs_to :user

	scope :recent, -> { order(created_at: :desc) }
	# 新しい順　カスタムメソッド メソッド名recent scopeメソッドで、recentメソッド作成

	private

	def validate_name_not_comma
		errors.add(:name, "にカンマを含めることはできません") if name&.include?(',')
	end
	# オリジナル検証コード

	def set_nameless_name
		self.name = '名前無し' if name.blank?
		# blank(nilや空白)である時、'名前無し’文字列を代入
	end

end
