require 'rails_helper'
RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント作成' do
    context 'コメント投稿がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿がうまくいかないとき' do
      it "comment_contentが空では投稿できない" do
        @comment.comment_content = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメント内容を入力してください")
      end
      it "comment_contentが100文字以上であれば登録できない" do
        @comment.comment_content = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメント内容は100文字以内で入力してください")
      end
    end
  end
end
