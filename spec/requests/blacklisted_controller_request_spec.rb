require 'rails_helper'

RSpec.describe BlacklistedController, type: :request do
  let!(:user)                { create :user,  api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4' }
  let!(:blocked_merchant)    { create :blacklist, user: user, merchant_name: 'Bad Joo Joo' }
  let!(:authorized_merchant) { create :blacklist, user: user, merchant_name: 'Good Joo Joo', blocked: false }

  describe 'GET is_blacklisted' do
    context 'user does not exist' do
      let(:get_is_blacklisted) {
        get is_blacklisted_path,
        params: {user_api_token: 'asdf'}
      }

      it 'should respond with 404' do
        get_is_blacklisted
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({})
      end
    end

    context 'user exists' do
      context 'blacklist does not exist' do
        let(:get_is_blacklisted) {
          get is_blacklisted_path,
          params: {user_api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4'}
        }

        it 'should respond with authorized:true' do
          get_is_blacklisted
          expect(JSON.parse(response.body)).to eq({'authorized' => true})
        end
      end

      context 'blacklist exists' do
        context 'merchant is blocked' do
          let(:get_is_blacklisted) {
            get is_blacklisted_path,
            params: {
              user_api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4',
              merchant_name: 'Bad Joo Joo'
            }
          }

          it 'should respond with authorized:false' do
            get_is_blacklisted
            expect(JSON.parse(response.body)).to eq({'authorized' => false})
          end
        end

        context 'merchant is authorized' do
          let(:get_is_blacklisted) {
            get is_blacklisted_path,
            params: {
              user_api_token: '5ef19d5d-d0d9-421c-93cd-e7d0187d54c4',
              merchant_name: 'Good Joo Joo'
            }
          }

          it 'should respond with authorized:true' do
            get_is_blacklisted
            expect(JSON.parse(response.body)).to eq({'authorized' => true})
          end
        end
      end
    end
  end
end
