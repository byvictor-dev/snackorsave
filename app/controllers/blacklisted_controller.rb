class BlacklistedController < ApplicationController
  before_action :api_token, :category, :merchant_name

  def is_blacklisted
    user = User.find_by(api_token: @api_token)
    render_error_response(403) and return unless user.present?
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
        category: @category,
        merchant_name: @merchant_name
      )
    end

    def blocked_category?
      Blacklist.find_by(user: user, category: @category)&.blocked
    end

    def render_error_response(status)
      render json: {}, status: status
    end

    def api_token
      @api_token ||= params[:user_api_token]
    end

    def category
      @category ||= params[:category]
    end

    def merchant_name
      @merchant_name ||= params[:merchant_name]
    end
end
