require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # ユーザ作成
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com') }
  # タスク作成
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }
  
  before do
    FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク'}
  end

  describe '一覧表示機能' do
    context 'ユーザAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end

    context 'ユーザBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end 
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:task_name) { '新規作成のテストを書く' } # デフォルトとして設定

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { '新規作成のテストを書く'}

      it '正常に登録される' do
        expect(page).to have_content('新規作成のテストを書く')
        expect(page).to have_css('.alert-success')
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { ' ' } # 上書き

    #  it 'エラーとなる' do
    #    within("#error_explanation") do
    #      expect(page).to have_content '名称を入力してください'
    #    end
    #  end
    end
  end
end
