class BlacklistedController < ApplicationController
  def is_blacklisted
    api_token = params[:user_api_token]
    merchant_name = params[:merchant_name]

    blacklist = Blacklist.find_by(
      user: User.find_by(api_token: api_token),
      merchant_name: merchant_name
    )

    blocked = true
    if blacklist
      blocked = blacklist.blocked
    end

    render json: {authorized: !blocked}
  end
end
