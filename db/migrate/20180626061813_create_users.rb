class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password_digest   # 비밀번호를 받을 때 2번 입력 받아서 암호화해서 저장함.
      t.timestamps
    end
  end
end
