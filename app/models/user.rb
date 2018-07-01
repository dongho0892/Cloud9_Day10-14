class User < ApplicationRecord

    has_secure_password
    has_many :memberships
    has_many :daums, through: :memberships
    has_many :posts
    
    validates :user_name, uniqueness: true
    # user_name 컬럼에 unique 속성 부여
    # 주의사항 : 칼럼(속성) 하나에 ,  ,  ,  ,  ,  조건 여러개 넣을 수 있음.
    #            칼럼(속성) 하나에 각각 넣어주어야함! (ex: uniqueness 각각 넣어주기)
    
end
