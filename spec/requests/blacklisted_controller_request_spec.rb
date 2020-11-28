require 'rails_helper'

RSpec.describe BlacklistedController, type: :request do
  let!(:user)                { create :user }
  let!(:blocked_merchant)    { create :blacklist, user: user, category: 'Bad Joo Joo' }
  let!(:authorized_merchant) { create :blacklist, user: user, category: 'Good Joo Joo', blocked: false }

  describe 'GET is_blacklisted' do
    context 'user does not exist' do
      let(:get_is_blacklisted) {
        get is_blacklisted_path,
        params: {user_api_token: 'asdf'}
      }

      it 'should respond with 403' do
        get_is_blacklisted
        expect(response.status).to eq(403)
        expect(JSON.parse(response.body)).to eq({})
      end
    end

    context 'user exists' do
      context 'blacklist does not exist' do
        let(:get_is_blacklisted) {
          get is_blacklisted_path,
          params: {user_api_token: user.api_token}
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
              user_api_token: user.api_token,
              category: 'Bad Joo Joo',
              amount: 15000,
              merchant_name: 'The Lord of War'
            }
          }

          it 'should respond with authorized:false on first request' do
            get_is_blacklisted
            expect(JSON.parse(response.body)).to eq({'authorized' => false})
          end
        end

        context 'merchant is authorized' do
          let(:get_is_blacklisted) {
            get is_blacklisted_path,
            params: {
              user_api_token: user.api_token,
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
