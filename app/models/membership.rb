class Membership < ApplicationRecord

    belongs_to :user
    belongs_to :daum
    # validation_uniqueness_of :user_id, scope: daum_id
    # 유저 1번 - 다음아이디 1번  => 이 두개가 unique 해야 등록이 안되게끔 해줌.
end
