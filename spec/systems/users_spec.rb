require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:course1) { create(:course, user_id: current_user.id) }
  let!(:course2) { create(:course, user_id: current_user.id) }
  let!(:course3) { create(:course, user_id: not_current_user.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  before do
    driven_by(:rack_test)
    sign_in current_user
    visit user_path(id: current_user.id)
  end

  it 'ユーザー名が取得できるか' do
    expect(page).to have_content "ログインユーザー"
  end

  it 'ユーザーのemailが取得できるか' do
    expect(page).to have_content "login@gmail.com"
  end

  it '投稿コース数が取得できるか' do
    expect(page).to have_content "投稿コース・・・2"
  end

  it '編集画面に遷移する' do
    click_on 'プロフィール編集'
    expect(page).to have_content 'プロフィール編集'
  end

  it '編集画面からプロフィール画面に遷移する' do
    visit edit_user_registration_path
    click_on 'マイページへ戻る'
    expect(page).to have_content "ログインユーザー"
    expect(page).to have_content "login@gmail.com"
  end
end
