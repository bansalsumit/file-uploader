class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    attachments_path || root_path
  end
end
