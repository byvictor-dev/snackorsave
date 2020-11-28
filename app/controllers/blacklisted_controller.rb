class BlacklistedController < ApplicationController
  before_action :user, :category

  def is_blacklisted
    render error_response(403) and return unless @user.present?
    render json: {authorized: true} and return unless @category.present? && blocked_category?

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
        transaction_attempt_params
      )
    end

    def blocked_category?
      Blacklist.find_by(user: @user, merchant_category: @category)&.blocked
    end

    def error_response(status)
      {json: {}, status: status}
    end

    def user
      @user = User.find_by(api_token: params[:user_api_token])
    end

    def category
      @category = MerchantCategory.find_by(description: params[:category]&.downcase)
    end

    def transaction_attempt_params
      params.permit(:amount, :merchant_name).merge(user_id: @user.id, merchant_category_id: @category.id)
    end

end
