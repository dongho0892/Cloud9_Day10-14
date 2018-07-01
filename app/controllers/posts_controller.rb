class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
          # @post를 사용하는 곳을 연결해서 씀.
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new    # 빈 껍데기
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.daum_id = session[:current_cafe]
    # @post.daum_id = params[:cafe_id]   # 어느 카페에 글을 적을지 알수 없음.
        
      if @post.save
        session.delete(:current_cafe)
        redirect_to @post, flash: {success: 'Post was successfully created.' }
      else
        render :new 
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update                    # 결과값이 참 거짓으로 나옴.
      if @post.update(post_params)
        redirect_to @post, flash: {success: 'Post was successfully updated.'}
      else
        render :edit
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, flash: {success: 'Post was successfully destroyed.'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])      # 우리가 볼 포스트의 값이 들어가있음.
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :daum_id, :image_path)
      
#       위 아래가 같음.             # 허가 된 것들
#     params.{title: params[:post][:title], cafe_id: [:post][cafe_id], content: [:post][:content]}
    end
end