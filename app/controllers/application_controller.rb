class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :fetch_required_items
  before_filter :configure_permitted_parameters, if: :devise_controller?
  layout :set_layout

  def require_admin!
    unless current_user && current_user.is_admin
      flash[:alert] = "Access denied"
      respond_to do |format|
        format.html {
          redirect_to "/"
        }
        format.js {
          render js: "window.location='/'"
        }
      end
    end
  end

  def fetch_required_items
    if current_user && !request.xhr? # && request.get?
      system_setting = SystemSetting.find_by_name("cache")
      # @categories = Rails.cache.fetch("dbCat#{system_setting.value['category']}", expires_in: 1.day) {
      #   Category.select("id, name, user_id").order("created_at DESC").to_a
      # }
      @categories = Category.select("id, name, user_id, category_type").order("created_at DESC")
    end
  end

  %w(category group user meter_reading).each do |name|
    define_method "find_#{name}" do
      obj = instance_variable_set("@#{name}", name.camelize.constantize.find_by_id(params[:id]))
      unless obj
        respond_to do |format|
          format.html{
            flash[:alert] = "#{name.camelize} not found"
            redirect_to "/#{name.pluralize}"
          }
          format.js{
            render js: "displayFlash('#{name.camelize} not found', 'alert-error');"
          }
        end
      end
    end
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:email) }
  end

  def set_layout
    current_user ? "application" : "public"
  end
end
