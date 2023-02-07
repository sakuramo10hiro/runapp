require 'rails_helper'

RSpec.describe "courses", type: :request do
  let!(:course1) { create(:course, user_id: current_user.id, course_name: "コース1", course_description: "コース1説明") }
  let!(:course2) { create(:course, user_id: not_current_user.id) }
  let!(:course3) { create(:course, user_id: not_current_user.id, course_name: "コース3", public: false) }
  let!(:comment) { create(:comment, comment_content: "コメント内容です", course_id: course1.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  describe "mypageのテスト" do
    before do
      sign_in current_user
      get mypage_path
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it "ログインユーザーのコースが表示されているか" do
      expect(response.body).to include course1.course_name
      expect(response.body).to include course1.course_description
    end

    it "ログインユーザー以外のコースが表示されていないか" do
      expect(response.body).not_to include course2.course_name
      expect(response.body).not_to include course2.course_description
    end

    it '新規作成ボタンが表示されている' do
      expect(response.body).to include '新規作成'
    end

    it 'いいねボタンを押すといいねの件数が1増える' do
      within(".favorites-container") do
        find('.link').click
        expect(page).to have_selector 'span', text: "1"
        expect(course1.favorites.count).to eq(1)
        find('.link').click
        expect(page).to have_selector 'span', text: "0"
        expect(course1.favorites.count).to eq(0)
      end
    end
  end

  describe "otherpageのテスト" do
    before do
      sign_in current_user
      get otherpage_path
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it "全てのコースが表示されているか" do
      expect(response.body).to include course1.course_name
      expect(response.body).to include course2.course_name
      expect(response.body).to include course1.course_description
      expect(response.body).to include course2.course_description
    end

    it "非公開のコースが表示されていないか" do
      expect(response.body).not_to include course3.course_name
    end

    it '新規作成ボタンが表示されている' do
      expect(response.body).to include '新規作成'
    end

    it 'いいねボタンを押すといいねの件数が1増える' do
      within(".favorites-container") do
        find('.link').click
        expect(page).to have_selector 'span', text: "1"
        expect(course1.favorites.count).to eq(1)
        find('.link').click
        expect(page).to have_selector 'span', text: "0"
        expect(course1.favorites.count).to eq(0)
      end
    end
  end

  describe "コース詳細の表示" do
    before do
      sign_in current_user
      get course_path(course1.id)
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it 'コース詳細情報が表示される' do
      expect(response.body).to include course1.course_name
      expect(response.body).to include course1.course_description
    end

    it 'コメントが表示される' do
      expect(response.body).to include comment.comment_content
    end
  end
end
