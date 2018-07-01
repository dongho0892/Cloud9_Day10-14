Rails.application.routes.draw do
  
  root 'cafes#index'                            # 카페의 첫 화면으로 바꿔줌
  post 'posts/:id/comments/create'  => 'comments#create'  # 만들 때 post방식 사용 
    # post의 아이디/ 의 comments를 만들어준다.    
  delete 'comments/:id' => 'comments#destroy'      # posts의 id는 이미 알고 있음.
  
  get 'comments/destroy'

  resources :posts        # 게시물 만드는 것은 설정 완료됨.

  # authenticate
  get '/sign_up' => 'authenticate#sign_up'
  post '/sign_up' => 'authenticate#user_sign_up'
  get '/sign_in' => 'authenticate#sign_in'
  post '/sign_in' => 'authenticate#user_sign_in'
  
  delete '/sign_out' => 'authenticate#sign_out'
                        # 컨트롤러의    액션으로 보내겠다.
  get '/user_info/:user_name' => 'authenticate#user_info'
  
  # cafe
  resources :cafes, except: [:destroy]  # 이것만 빼고 만들어짐.
  post '/join_cafe/:cafe_id' => 'cafes#join_cafe', as: 'join_cafe'  
                                                    # Prefix명을 지정 가능함!
  
  
  
  
end

# 댓글을 만들때는 게시물의 id가 필요함
#        삭제 할떄는        가 필요 없음.