class AuthenticateController < ApplicationController

    # 회원가입 페이지
    # 실제 회원 가입 로직
    # 로그인 페이지
    # 실제 로그인 로직
    # 유저 정보 페이지 - 내 정보를 눌렀을 때 내가 가입한 카페 목록만 뜨게끔 처리할 예정
    # 로그아웃 로직


    # 회원가입 페이지
    def sign_up
        # form_for 쓸거여서 빈 껍데기 만들어주기
        @user = User.new
    end
    
    # 실제 회원 가입 로직
    def user_sign_up
        @user = User.new(user_name: params[:user_name], password: params[:password],
        password_confirmation: params[:confirmation])
        if @user.save           # 저장이 잘 되나?
            redirect_to root_path, flash: {success: '회원가입 성공'}      # 잘 되면 root 페이지로 가게 끔
        else            # '/' 도 가능 ( root_path 대신 )
            puts "에러 ---------"
            p @user.errors # 오류 발생시 그 원인이 콘솔에 나옴
                # ex) @messages={:user_name=>["has already been taken"]}
            
            puts "에러 끝 ---------"
            redirect_to :back, flash: {success: '회원가입 실패'}
        end
    end
    
    # 로그인 페이지
    def sign_in
    end


    # 실제 로그인 로직
    def user_sign_in             # find_by ( 찾으려는 컬럼명 ) 
        @user = User.find_by(user_name: params[:user_name])
        if @user.present? and @user.authenticate(params[:password]) # 암호화된 문자와 사용자가 입력한 비밀번호(문자)를 비교해줌 
            session[:sign_in_user] = @user.id
            redirect_to root_path, flash: {success: '로그인 성공'}
        else
            p @user.errors # 오류 발생시 그 원인이 콘솔에 나옴
            redirect_to :back, flash: {danger: '로그인 정보 확인하세요.'}
        end
    end
    
    
    # 유저 정보 페이지 - 내 정보를 눌렀을 때 내가 가입한 카페 목록만 뜨게끔 처리할 예정
    def user_info
        
    end


    # 로그아웃 로직
    def sign_out
        session.delete(:sign_in_user)    # 라는 키로 그걸 삭제시키고  
        redirect_to :back, flash: {warning: '로그아웃됨'}      #  로그아웃 버튼을 누른 곳으로 다시 돌아감
    end

end
