class Comment < ApplicationRecord
    # 한 게시글당 여러 댓글
    belongs_to :post
end
