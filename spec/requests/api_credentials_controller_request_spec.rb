require 'rails_helper'

RSpec.describe "ApiCredentials", type: :request do
  let(:user) { create :user }

  before { sign_in user }

  describe '#update' do
    let(:put_update) { put api_credential_path(user.id) }

    it 'changes the users token' do
      expect{ put_update }.to change{ user.reload.api_token }
    end
  end

end
