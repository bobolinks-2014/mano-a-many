class CreateUserSquarings < ActiveRecord::Migration
  def change
    create_table :user_squarings do |t|
      t.integer :user_id
      t.integer :squaring_event_id
      t.timestamps
    end
  end
end
