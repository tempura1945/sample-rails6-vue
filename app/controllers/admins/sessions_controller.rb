# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'admins/login'

    def after_sign_out_path_for(_resource)
      new_admin_session_url
    end
  end
end
