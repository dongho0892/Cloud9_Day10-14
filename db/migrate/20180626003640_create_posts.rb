class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      
      t.string :image_path    # 이미지 업로드 관련 이미지가 저장되어있는 곳 추가함!
      
      t.integer :user_id
      t.integer :daum_id
      
      t.timestamps
    end
  end
end
