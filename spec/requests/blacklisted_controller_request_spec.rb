require 'rails_helper'

RSpec.describe BlacklistedController, type: :request do
  let(:user)      { create :user,  api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4' }
  let(:blacklist) { create :blacklist, user: user, merchant_name: 'Bad Joo Joo' }
  let(:params) { {user_api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4', merchant_name: 'Bad Joo Joo'} }

  describe 'GET is_blacklisted' do
    let(:get_is_blacklisted) {
      get is_blacklisted_path,
      params: params
    }

    context 'user_api_token and merchant_name params are valid' do
      it 'expects merchant to be unauthorized' do
        get_is_blacklisted
        expect(JSON.parse(response.body)).to eq({'authorized'=> false})
      end
    end

    context 'user_api_token param is invalid' do
      let(:params) { {merchant_name: 'Bad Joo Joo'} }

      it 'expects merchant to be unauthorized' do
        get_is_blacklisted
        expect(JSON.parse(response.body)).to eq({'authorized'=> false})
      end
    end

    context 'merchant_name param is invalid' do
      let(:params) { {user_api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4'} }

      it 'expects merchant to be unauthorized' do
        get_is_blacklisted
        expect(JSON.parse(response.body)).to eq({'authorized'=> false})
      end
    end
  end
end
