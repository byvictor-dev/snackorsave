require 'rails_helper'

RSpec.describe BlacklistedController, type: :request do
  let!(:user)                 { create(:user).reload }
  let(:unblocked_category)    { create :merchant_category, description: 'potatoes' }
  let!(:blocked_blacklist)    { create :blacklist, user: user }
  let!(:unblocked_blacklist)  { create :blacklist, user: user, merchant_category: unblocked_category, blocked: false }
  let(:get_is_blacklisted)    { get is_blacklisted_path, params: params }

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
            merchant_category: blocked_blacklist.merchant_category,
            user: user,
            amount: 15000,
            merchant_name: 'The Lord of War'
          }

          let(:params) {
            {
              user_api_token: user.api_token,
              category: blocked_blacklist.merchant_category.description,
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
              category: unblocked_category,
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
