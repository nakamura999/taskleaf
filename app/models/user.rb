class User < ApplicationRecord
	# (gem bcryptによるhas_secure_password)データベースのカラムに対応しないカラムの追加 password / password_confirmation
	has_secure_password

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	# uniquenessデータが一意になっているか

	has_many :tasks
end
