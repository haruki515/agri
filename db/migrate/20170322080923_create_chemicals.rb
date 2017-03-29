class CreateChemicals < ActiveRecord::Migration[5.0]
  def change
    create_table :chemicals do |t|
      t.integer :code, null: false
      t.string :category
      t.string :name, null: false
      t.string :official_name
      t.string :ingredient
      t.string :active_ingredient
      t.float :concentration
      t.integer :mixture_count
      t.string :usefulness
      t.string :use_category
      t.datetime :registered_at
      t.datetime :registered_end
      t.timestamps
    end
  end
end
