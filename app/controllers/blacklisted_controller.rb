class BlacklistedController < ApplicationController
  before_action :find_user

  def is_blacklisted
    render_error_response(403) and return unless @user.present?
    render json: {authorized: true} and return unless blocked_category?

    record = get_transaction_record(user)

    render json: {authorized: !record.new_record?}
    record.save
  end


  private

    def get_transaction_record(user)
      TransactionAttempt.where(
        created_at: 15.minutes.ago..DateTime.now
      ).find_or_initialize_by(
        user: user,
        amount: @amount,
        category_id: @category,
        merchant_name: @merchant_name
      )
    end

    def blocked_category?
      Blacklist.find_by(user: user, category: @category)&.blocked
    end

    def render_error_response(status)
      render json: {}, status: status
    end

    def find_user
      @user = User.find_by(api_token: params[:user_api_token])
    end

    def trnsaction_attempt_params
      params.permit(:amount, :category, :merchant_name).merge(user_id: @user.id)
    end

end
