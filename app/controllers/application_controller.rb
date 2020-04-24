class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :set_ransack

  def search
    @search_product = Product.ransack(params[:q]) 
    @products = @search_product.result.page(params[:page])
  end

  private

  def production?
    Rails.env.production?
  end

  def set_ransack
    @q = Product.ransack(params[:q])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :f_name_kana, :l_name_kana,:f_name,:l_name,:birthday])
  end
end
