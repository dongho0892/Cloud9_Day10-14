class Daum < ApplicationRecord
    
    has_many :memberships
    has_many :users, through: :memberships
    has_many :posts
    
    # 일단은 중복 가입 가능하게 해놓음! #

    # 인스턴스 메서드 : daum.each do ~ ....
    # def 메서드 명         =>  인스턴스 메서드
    #     로직          => 로직 안에서 self 쓸 수 있음
    # end
    
    
    # 클래스 메서드 : daum = Daum.find(~~)
    # def self.메서드 명    => 클래스 메서드
    #     로직          => 로직 안에서 self 쓸 수 없음
    # end    
    
    def is_member?(user)
        # daum.users.include? user   => 자기 자신이므로
        self.users.include?(user) #  => user => model에서는 로그인한 유저가 누군지 모름.
                        # (매개변수를 받아서 쓸 수 있음)
    end
    
end
