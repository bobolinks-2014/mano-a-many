class CreateSquaringEvents < ActiveRecord::Migration
  def change
    create_table :squaring_events do |t|
      t.integer :group_id
      t.timestamps
    end
  end
end
