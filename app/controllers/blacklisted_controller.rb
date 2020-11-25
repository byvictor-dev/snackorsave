class BlacklistedController < ApplicationController
  before_action :api_token, :merchant_name

  def is_blacklisted
    user = User.find_by(api_token: @api_token)

    if user
      blacklist = Blacklist.find_by(user: user, merchant_name: @merchant_name)

      render json: {authorized: !blacklist&.blocked}
    else
      render_error_response(404)
    end
  end

  def render_error_response(status)
    render json: {}, status: status
  end

  def api_token
    @api_token = params[:user_api_token]
  end

  def merchant_name
    @merchant_name = params[:merchant_name]
  end
end
