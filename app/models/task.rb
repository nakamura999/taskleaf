class Task < ApplicationRecord
	has_one_attached :image
	before_validation :set_nameless_name

	validates :name, presence: true, length: { maximum: 30 }
	validates :description, presence: true

	validate :validate_name_not_comma

	belongs_to :user

	scope :recent, -> { order(created_at: :desc) }
	# 新しい順　カスタムメソッド メソッド名recent scopeメソッドで、recentメソッド作成

    def self.csv_attributes
    	["name", "description", "created_at", "updated_at"]
    end

    def self.generate_csv
    	CSV.generate(headers: true) do |csv|
    		csv << csv_attributes
    		all.each do |task|
    			csv << csv_attributes.map{ |attr| task.send(attr) }
    		end
    	end
    end

	private

	def validate_name_not_comma
		errors.add(:name, "にカンマを含めることはできません") if name&.include?(',')
	end
	# オリジナル検証コード

	def set_nameless_name
		self.name = '名前無し' if name.blank?
		# blank(nilや空白)である時、'名前無し’文字列を代入
	end
    
    # 検索条件に許可しているカラム
	def self.ransackable_attributes(auth_object = nil)
		%w[name created_at]
	end

    # 検索条件に含める関連を指定　ここでは空の配列を返すようにオーバーライド
	def self.ransackable_associations(auth_object = nil)
		[]
	end

end
