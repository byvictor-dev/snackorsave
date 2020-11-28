require 'rails_helper'

RSpec.describe BlacklistedController, type: :request do
  let!(:user)                { create(:user).reload }
  let!(:blocked_blacklist)   { create :blacklist, user: user, category_id: 1 }
  let!(:unblocked_blacklist) { create :blacklist, user: user, category_id: 2, blocked: false }
  let(:get_is_blacklisted)   { get is_blacklisted_path, params: params }

  describe 'GET is_blacklisted' do
    context 'user does not exist' do
      let(:params) { {user_api_token: 'asdf'} }

      it 'should respond with 403' do
        get_is_blacklisted

        expect(response.status).to eq(403)
        expect(JSON.parse(response.body)).to eq({})
      end
    end

    context 'user exists' do
      context 'blacklist does not exist' do
        let(:params) {{user_api_token: user.api_token} }

        it 'should respond with authorized:true' do
          get_is_blacklisted

          expect(JSON.parse(response.body)).to eq({'authorized' => true})
        end
      end

      context 'blacklist exists' do
        context 'category is blocked' do
          let(:transaction_attempt) { create :transaction_attempt,
            category_id: 1,
            user: user,
            amount: 15000,
            merchant_name: 'The Lord of War'
          }

          let(:params) {
            {
              user_api_token: user.api_token,
              category: 1,
              amount: 15000,
              merchant_name: 'The Lord of War'
            }
          }

          it 'should respond with {authorized: false} on first request' do
            get_is_blacklisted

            expect(JSON.parse(response.body)).to eq({'authorized' => false})
          end

          it 'should respond with {authorized: true} on second request in 15 minutes' do
            transaction_attempt
            get_is_blacklisted

            expect(JSON.parse(response.body)).to eq({'authorized' => true})
          end
        end

        context 'category is not blocked' do
          let(:params) {
            {
              user_api_token: user.api_token,
              category: 2,
              amount: 15000,
              merchant_name: 'The Lord of War'
            }
          }

          it 'should respond with {authorized: true}' do
            get_is_blacklisted

            expect(JSON.parse(response.body)).to eq({'authorized' => true})
          end
        end
      end
    end
  end
end
