class CreateSquaringEvents < ActiveRecord::Migration
  def change
    create_table :squaring_events do |t|

      t.timestamps
    end
  end
end
