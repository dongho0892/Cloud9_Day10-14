class CafesController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
                                    # 얘네를 제외하고 확인을 해야함.
    # 전체 카페 목록 보여주기
        # => 로그인 했을 때 - 유저가 가입한 카페목록
        # => 로그인 하지 않았을 때 - 전체 카페목록       : 구분되어야함!
    # 카페 내용물(글 들의 리스트 등...)을 보여주는 show 페이지
    # 카페를 개설하는 페이지
    # 카페를 실제로 개설하는 로직
    # 카페 정보를 수정하는 페이지
    # 카페 정보를 실제로 수정하는 로직

    # 전체 카페 목록 보여주기
        # => 로그인 했을 때 - 유저가 가입한 카페목록
        # => 로그인 하지 않았을 때 - 전체 카페목록       : 구분되어야함!
        
    def index
        @cafes = Daum.all
        # if user_signed_in?
        #     @cafes = current_user.daums  # 카페 목록 보여주면 됨.
        # else
        #     @cafes = Daum.all
        # end
    end
    
    # 카페 내용물(글 들의 리스트 등...)을 보여주는 show 페이지
    
    def show
       @cafe = Daum.find(params[:id]) # 카페 아이디를 찾는데, 넘어온 것을 받아서 넣어줌. 
# 1     
       session[:current_cafe] = @cafe.id
        # 1번 카페서 글을 쓰다가 취소하고 2번 카페로 넘어갔다가, 3번 갔다가 등등... 해도 유지됨.

# 2         
        # 창 여러개 열었을 때, 문제가 있을 수 있음 => 

    end
    
    # form_for 사용 가능 => resources 로 routes 만들어줬으므로
    
    # 카페를 개설하는 페이지
    def new
        @cafe = Daum.new
    end
    
    # 카페를 실제로 개설하는 로직
    
    def create
        @cafe = Daum.new(daum_params)
        @cafe.master_name = current_user.user_name
            # 현재 유저의 이름을 넣어준다.
        # p params
        if @cafe.save               # join table.. 왼쪽과 오른쪽을 이어준다. 
            Membership.create(user_id: current_user.id, daum_id: @cafe.id)
            redirect_to cafe_path(@cafe), flash: {success: "카페 개설 완료 땡큐" }
                 # 객체 자체를 넣어본다.(시도)
        else
            p @cafe.errors  # 오류 발생시 원인을 보여줄 수 있음. / 왜 rollback이 났는지 등...
            redirect_to :back, flash: {danger: "카페 개설에 실패 ㅠㅠ"} 
        end
    end
    
    
    def join_cafe # 카페 가입 할 때, 멤버쉽을 만들어줌으로서...
    
    
        #(클래스메서드)
        cafe = Daum.find(params[:cafe_id])  # 사용자가 가입하려는 카페
        # 이 카페에 로그인된 유저가 가입 되어있는지 확인
        # if cafe.users.include? current_user   # membership을 이용해 join해서 자료를 가져 옴.
        if cafe.is_member?(current_user)  #=> current_user를 파라미터로서 is_member?()로 보내서 처리하고 T / F 값을 보내줌.
            # 가입 실패
            redirect_to :back, flash: {danger: "카페 가입에 실패했습니다. 이미 가입된 카페입니다."}
        else
            # 가입 성공
            Membership.create(daum_id: params[:cafe_id], user_id: current_user.id)
        
        # 현재 이 카페에서 가입한 유저 중에 지금 로그인한 유저가 있니?
        # 있으면 => 이미 가입했다고 표시
        # 없으면 => 가입 시키기
            redirect_to :back, flash: {success: "카페 가입에 성공하였습니다."}
        end
    end             # 문제점.. 중복가입이 안막힘..
    
    # 대안 1. 가입 버튼 안보이게 하는 것.   (사용자 화면) => model 코딩( 메서드 )
    
    # 대안 2. 중복가입 체크 후 진행         (서버에서 로직 조작) => model에 조건 추가 ( validation )
    
    
    
    
    
    
    
    # 카페 정보를 수정하는 페이지
    def edit

    end
    
    # 카페 정보를 실제로 수정하는 로직
    def update
        if @cafe.update()
        redirect_to cafe_path(@cafe), flash: {success: " 카페 정보 수정 완료 땡큐" }
        end
    end
    
    
    
    private
    def daum_params
        params.require(:daum).permit(:title, :description)
            # daum 키를 받아와서 이중 #얘네만 쓰겠다.
        # :params => {:daum, => title => "...", 
    end
end