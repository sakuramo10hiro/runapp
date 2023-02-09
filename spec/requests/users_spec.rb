require 'rails_helper'

RSpec.describe "User", type: :request do
  let!(:course1) { create(:course, user_id: current_user.id) }
  let!(:course2) { create(:course, user_id: current_user.id) }
  let!(:course3) { create(:course, user_id: not_current_user.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  before do
    sign_in current_user
    get user_path(id: current_user.id)
  end

  it "正常にレスポンスがされているか" do
    expect(response).to have_http_status(:success)
  end

  it 'ユーザー名が取得できるか' do
    expect(response.body).to include current_user.name
  end

  it '自己紹介文が取得できるか' do
    expect(response.body).to include current_user.introduction
  end

  it 'ユーザーのemailが取得できるか' do
    expect(response.body).to include current_user.email
  end
end

