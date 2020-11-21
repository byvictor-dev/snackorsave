class ApplicationController < ActionController::Base

  private

    def after_sign_in_path(resource)
      stored_location_for(resource) || blacklists_path
    end
end
