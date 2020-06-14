require 'rails_helper'

describe 'タスク管理機能', type: :system do
		# ユーザーを作成
		let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
		let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
		let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

		before do
			# ユーザーAでログインする
			FactoryBot.create(:task, name: '最初のタスク', user: user_a)
			visit login_path
			fill_in 'session[email]', with: login_user.email
			fill_in 'session[password]', with: login_user.password
			click_button 'ログイン'
		end
        
        # 共通部分　it_behaves_like
		shared_examples_for 'ユーザーAが作成したタスクが表示される' do
			it { expect(page).to have_content '最初のタスク' }
		end

        describe '一覧機能' do
			context 'ユーザーAがログインしている時' do
				let(:login_user) { user_a }

				it_behaves_like 'ユーザーAが作成したタスクが表示される'
			end
		end

		context 'ユーザーBがログインしている時' do
			let(:login_user) { user_b }

			it 'ユーザーAが作成したタスクが表示されない' do
				# ユーザーAが作成したタスクの名称が画面上に表示されない
				expect(page).to have_no_content '最初のタスク'
			end
		end

		describe '詳細表示機能' do
			context 'ユーザーAがログインしている時' do
				let(:login_user) { user_a }

				before do
					visit task_path(task_a)
				end

				it_behaves_like 'ユーザーAが作成したタスクが表示される'
			end
		end

		describe '新規作成機能' do
			let(:login_user) { user_a }

			before do
				visit new_task_path
				fill_in 'task[name]', with: task_name
				fill_in 'task[description]', with: task_description
				click_button '登録する'
			end

			context '新規作成画面で名称を入力した時' do
				let(:task_name) { '新規作成のテストを書く' }
				let(:task_description) { '新規作成のテストを記入' }

				it '正常に登録される' do
					expect(page).to have_content '登録しました'
					# have_selector HTML内の特定の要素(CSSセレクタ)を指定。alert-succcesのCSSクラスについたテキスト’新規作成・・・’があるか確認している
				end
			end

			context '新規作成画面で名称を入力しなかったと時「名前無し」が登録される' do
				let(:task_name) { '' }
				let(:task_description) { '新規作成のテストを記入' }
				# let上記で定義してあるが、上書きで空白にしている

				it '名前無しが登録される' do
					expect(page).to have_content '名前無し'
				end
			end

			context '新規作成画面で詳しい説明を入力しなかったと時' do
				let(:task_name) { '' }
				let(:task_description) { '' }
				# let上記で定義してあるが、上書きで空白にしている

				it 'エラーとなる' do
					within '#error_explanation' do
						expect(page).to have_content '入力してください'
					end
				end
			end
		end
end