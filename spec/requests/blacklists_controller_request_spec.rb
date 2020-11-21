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

end
