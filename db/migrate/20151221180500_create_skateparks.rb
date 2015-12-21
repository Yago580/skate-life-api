class CreateSkateparks < ActiveRecord::Migration
  def change
    create_table :skateparks do |t|
      t.string :name
      t.string :address
      t.string :state
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
