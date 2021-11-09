class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.date :date
      t.time :in
      t.time :out
      t.integer :ot
      t.references :user
    end
  end
end
