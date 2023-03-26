require_relative '..\models\current_order'
class ApplicationController < ActionController::Base
    include Authentication
    before_action :set_current_user
    
    protect_from_forgery with: :exception
    include SessionsHelper

    def set_current_user
        if session[:user_id]
            Current.user = User.find(session[:user_id])
        end   
    end

    def require_user_logged_in!
        redirect_to sign_in_path, alert: "You must be sign in to do that." if Current.user.nil?        
    end

    def set_theme
        @current_theme ||= "full"
    end
    
    def load_cart
        @cart ||= Cart.new(session[:cart])
    end
    
    def load_current_order
        session[:order] ||= {}
        @current_order ||= Current_Order.new(session[:order])
    end
    
    def cart
        @cart
    end
    
    before_action :set_theme
    before_action :load_cart
    before_action :current_user
    before_action :load_current_order
    
    helper_method :cart
    helper_method :current_order
end
