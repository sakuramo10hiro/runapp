require 'rails_helper'

RSpec.describe 'courses', type: :system do
  let!(:course1) { create(:course, user_id: current_user.id, course_name: "コース1", course_description: "コース1説明") }
  let!(:course2) { create(:course, user_id: not_current_user.id, course_name: "コース2") }
  let!(:course3) { create(:course, user_id: not_current_user.id, course_name: "コース3", public: false) }
  let!(:comment1) { create(:comment, comment_content: "コメント内容1", course_id: course1.id, user_id: user1.id) }
  let!(:comment2) { create(:comment, comment_content: "コメント内容2", course_id: course1.id, user_id: user1.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }

  before do
    driven_by(:rack_test)
    sign_in current_user
  end

  describe '自分のコースが表示される' do
    before do
      visit mypage_path
    end

    it 'コースのcourse_nameが表示される' do
      expect(page).to have_content 'コース1'
    end

    it 'コース説明が表示される' do
      expect(page).to have_content 'コース1説明'
    end

    it '他のユーザーのコースが表示されない' do
      expect(page).not_to have_content 'コース2'
      expect(page).not_to have_content 'コース3'
    end

    it 'いいねボタンを押すと件数が1増える' do
      within (".favorites-container"), match: :first do
        find('.link').click
        expect(page).to have_content "1"
        find('.link').click
        expect(page).to have_content "0"
      end
    end
  end

  describe 'コースの作成' do
    before do
      visit mypage_path
    end

    it '新規作成画面に遷移する' do
      click_on '新規作成', match: :first
      expect(page).to have_content '新規コース投稿'
    end

    it 'コースの作成ができる' do
      visit  new_course_path

      fill_in 'course[course_name]', with: '新規作成コース1'
      fill_in 'course[course_description]', with: '新規作成メモ'
      fill_in 'course[distance]', with: '1.5'
      choose 'course_road_type_1'
      choose 'course_route_2'
      choose 'course_toilet_1'
      choose  'course_undulation_2'
      choose  'course_signal_1'
      fill_in 'course[address]', with: '東京都千代田区千代田1-1'
      select  '公開', from: 'course[public]'

      click_on '投稿する'
      expect(page).to have_content '新規作成コース1'
      expect(page).to have_content '新規作成メモ'
      expect(page).to have_content '1.5 km' 
    end
  end

  describe 'コースの編集' do
    before do
      visit mypage_path
    end

    it '編集画面に遷移する' do
      find(".edit-link").click
      expect(page).to have_content 'コース編集'
    end

    it 'コースの編集ができる' do
      visit  edit_course_path(course1.id)

      fill_in 'course[course_name]', with: '編集コース1'
      fill_in 'course[distance]', with: '3.0'
      select  '公開', from: 'course[public]'

      click_on '編集完了'
      expect(page).to have_content '編集コース1'
    end
  end

  describe 'コースの削除' do
    before do
      visit mypage_path
    end

    it '削除ボタンを押すとコースが削除できる' do
      find(".delete-link").click
      expect(page).not_to have_content 'コース1'
    end
  end

  describe '全員のコースが表示される' do
    before do
      visit otherpage_path
    end

    it 'コース名が表示される' do
      expect(page).to have_content 'コース1'
      expect(page).to have_content 'コース2'
    end

    it '非公開のコースは表示されない' do
      expect(page).not_to have_content 'コース3'
    end
  end

  describe 'コース詳細が表示される' do
    before do
      visit mypage_path
    end

    it 'コース詳細画面に遷移する' do
      click_on 'コース1', match: :first
      expect(page).to have_content 'コース1'
      expect(page).to have_content 'コース1説明'
    end
  end

  describe 'コース詳細ページのコメント作成' do
    before do
      visit course_path(course1.id)
    end

    it 'コメントが作成できる' do
      fill_in 'comment[comment_content]', with: 'コメント内容'

      click_on 'コメントする'
      expect(page).to have_content 'コメント内容'
    end
  end

  describe 'コース詳細ページのコメントが表示される' do
    before do
      visit course_path(course1.id)
    end
    
    it 'コメント投稿者が表示される' do
      expect(page).to have_content 'ユーザー1'
    end

    it 'コメント内容が表示される' do
      expect(page).to have_content 'コメント内容1'
      expect(page).to have_content 'コメント内容2'
    end
  end
end
