class BlacklistedController < ApplicationController
  before_action :find_user

  def is_blacklisted
    render error_response(403) and return unless @user.present?
    render json: {authorized: true} and return unless blocked_category?

    record = get_transaction_record
    authorized = !record.new_record?
    record.save

    render json: {authorized: authorized}
  end


  private

    def get_transaction_record
      TransactionAttempt.where(
        created_at: 15.minutes.ago..DateTime.now
      ).find_or_initialize_by(
        user:           @user,
        amount:         params[:amount],
        category_id:    params[:category],
        merchant_name:  params[:merchant_name]
      )
    end

    def blocked_category?
      Blacklist.find_by(user: @user, category_id: params[:category])&.blocked
    end

    def error_response(status)
      {json: {}, status: status}
    end

    def find_user
      @user = User.find_by(api_token: params[:user_api_token])
    end

    def transaction_attempt_params
      params.permit(:amount, :merchant_name).merge(user_id: @user.id)
    end

end
