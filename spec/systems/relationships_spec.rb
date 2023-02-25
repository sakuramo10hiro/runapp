require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }
  let(:user2) { create(:user, name: "ユーザー2", email: "user2@gmail.com") }

  before do
    driven_by(:rack_test)
    sign_in user2
    visit user_path(id: user1.id)
  end

  it 'ユーザーをフォロー、フォロー解除できる' do 
      
    click_on 'フォロー'
    expect(page).to have_content 'フォローしました。'
    expect(user2.followings.count).to eq(1)
    expect(user1.followers.count).to eq(1)

    click_on 'フォロー解除'
    expect(page).to have_content 'フォローを解除しました。'
    expect(user2.followings.count).to eq(0)
    expect(user1.followers.count).to eq(0)
  end
end
