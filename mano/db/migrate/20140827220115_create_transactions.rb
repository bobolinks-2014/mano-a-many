class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :debtor_id
      t.integer :creditor_id
      t.integer :squaring_event_id
      t.float   :amount
      t.text    :description
      t.boolean :approved
      t.boolean :closed
      t.boolean :private_trans

      t.timestamps
    end
  end
end

 