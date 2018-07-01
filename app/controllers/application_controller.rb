class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
    helper_method :user_signed_in?, :current_user

    def user_signed_in?       # t / f를 리턴함. 현재 유저가 있는지 없는지 여부
        session[:sign_in_user].present?    
    end
    
    def authenticate_user!
        #로그인 되지 않았을 경우에 로그인 페이지로 이동시켜주는 것
        redirect_to sign_in_path unless user_signed_in?
                  #  '/sign_in'
    end
    
    def current_user
        # 로그인 되었을 경우 현재 로그인된 유저 정보를 받아서 검색을 한다.
        @current_user = User.find(session[:sign_in_user]) if user_signed_in?
    end


end