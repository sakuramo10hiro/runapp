require 'rails_helper'
RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.create(:comment)
  end

  describe 'コメント作成' do
    context 'コメント投稿がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿がうまくいかないとき' do
      it "commentが空では投稿できない" do
        @question.comment_content = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it "contentが空では登録できない" do
        @question.content = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("質問内容を入力してください")
      end
      it "titleが33文字以上であれば登録できない" do
        @question.title = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @question.valid?
        expect(@question.errors.full_messages).to include("質問名は32文字以内で入力してください")
      end
    end
  end
end
