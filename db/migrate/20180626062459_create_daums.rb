class CreateDaums < ActiveRecord::Migration[5.0]
  def change
    create_table :daums do |t|
      
      t.string :title
      t.text :description
      t.string :master_name   # 카페를 만든 유저를 적어주는 것 
      
      t.timestamps
    end
  end
end
