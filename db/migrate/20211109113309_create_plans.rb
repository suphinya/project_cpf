class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.datetime :date
      t.datetime :time_in
      t.datetime :time_out
      t.float :OT
      t.references :user
      t.timestamps
    end
  end
end
