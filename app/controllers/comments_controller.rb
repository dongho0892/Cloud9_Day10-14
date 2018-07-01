class CommentsController < ApplicationController
  def create
    comment = Comment.new
    comment.content = params[:content]
    comment.post_id = params[:id]   # 이 부분은 url로 넘어감
    comment.save
    redirect_to :back
  end

  def destroy
    comment = Comment.find(params[:id])     # 댓글의 아이디!
    comment.destroy
    redirect_to :back
  end
end
