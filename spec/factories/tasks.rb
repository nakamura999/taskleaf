FactoryBot.define do
	factory :task do
		name { 'テストをかく' }
		description { 'Rspec & Capybara & FactoryBot を準備する' }
		user
	end
end