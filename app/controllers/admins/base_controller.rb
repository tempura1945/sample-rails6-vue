# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    before_action :authenticate_admin!

    # ログイン後のリダイレクト先
    def after_sign_in_path_for(resource)
      if resource.is_a?(Admin)
        admin_root_path
      else
        root_path
      end
    end
  end
end
