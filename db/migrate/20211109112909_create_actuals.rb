class CreateActuals < ActiveRecord::Migration[6.0]
  def change
    create_table :actuals do |t|
      t.datetime :date
      t.datetime :time_in
      t.datetime :time_out
      t.float :OT
      t.references :user
      t.references :plan
      t.timestamps
    end
  end
end
