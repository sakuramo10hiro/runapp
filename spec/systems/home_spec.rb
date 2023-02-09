require 'rails_helper'

RSpec.describe "home", type: :system do

  before do
    driven_by(:rack_test)
    visit root_path
  end

  it 'メインタイトルが取得できるか' do
    expect(page).to have_content('Change of Run!')
  end
  
  it '機能紹介セクションが表示されているか' do
    expect(page).to have_content('Change of Runとは')
  end
end
