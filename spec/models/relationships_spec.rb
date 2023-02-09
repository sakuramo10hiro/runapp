require 'rails_helper'

RSpec.describe Relationship, type: :model do
    let(:user) { FactoryBot.create(:user, name: "ユーザー", email: "user@gmail.com") }
    let(:other_user) { FactoryBot.create(:user, name: "アザーユーザー", email: "other_user@gmail.com") }
    let(:relationship) { user.relationships.build(follow_id: other_user.id) }

    it "全てのパラメーターが揃っていれば保存できる" do
      expect(relationship).to be_valid
    end

    describe "フォロー・フォロー解除がうまくいかないとき" do
      it "user_idがnilの場合は保存できない" do
        relationship.user_id = nil
        relationship.valid?
        expect(relationship.errors[:user_id]).to include("を入力してください")
      end
      it "follow_idがnilの場合は保存できない" do
        relationship.follow_id = nil
        relationship.valid?
        expect(relationship.errors[:follow_id]).to include("を入力してください")
      end
    end
end
