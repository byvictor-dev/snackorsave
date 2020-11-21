require 'rails_helper'

RSpec.describe "BlacklistsController", type: :request do
  let(:user)      { create :user }
  let(:blacklist) { create :blacklist, user: user }

  before { sign_in user }

  context '#index' do
    let(:get_index) { get blacklists_path }

    it 'lists the blacklist items' do
      blacklist
      get_index

      expect(assigns(:blacklists).pluck(:id)).to match_array([blacklist.id])
    end
  end

  context '#create' do
    let(:post_create) { post blacklists_path, params: {blacklist: blacklist.attributes.except(:user_id)} }
    let(:blacklist)   { build :blacklist }

    it 'creates a new blacklist item for valid params' do
      expect{ post_create }.to change{ Blacklist.count }.by 1
    end
  end

  context '#update' do
    let(:patch_update) { patch blacklist_path(blacklist), params: {blacklist: {merchant_name: 'potatoes'}} }

    it 'updates the blacklist item' do
      expect{ patch_update }.to change{ blacklist.reload.merchant_name }.to 'potatoes'
    end
  end

end
