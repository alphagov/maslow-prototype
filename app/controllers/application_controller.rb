class ApplicationController < ActionController::Base
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :record_not_found

  protect_from_forgery

  private
  def record_not_found
    render :text => "404 Not Found", :status => 404
  end
end
