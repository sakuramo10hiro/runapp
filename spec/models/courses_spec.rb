require 'rails_helper'
RSpec.describe Course, type: :model do
  before do
    @course = FactoryBot.build(:course)
  end

  describe 'コース新規登録' do
    context '新規登録がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@course).to be_valid
      end
    end

    context 'コースの新規登録がうまくいかないとき' do
      it "course_nameが空だと登録できない" do
        @course.course_name = ""
        @course.valid?
        expect(@course.errors.full_messages).to include("コース名を入力してください")
      end
      it "publicが空では登録できない" do
        @course.public = ""
        @course.valid?
        expect(@course.errors.full_messages).to include("公開設定は一覧にありません")
      end
      it "course_nameが31文字以上であれば登録できない" do
        @course.course_name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @course.valid?
        expect(@course.errors.full_messages).to include("コース名は30文字以内で入力してください")
      end
      it "distanceが空もしくは文字であれば登録できない" do
        @course.distance = "" || "aa"
        @course.valid?
        expect(@course.errors.full_messages).to include("距離を入力してください","距離は数値で入力してください")
      end
    end
  end
end
