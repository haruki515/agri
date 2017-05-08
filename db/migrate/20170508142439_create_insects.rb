class CreateInsects < ActiveRecord::Migration[5.0]
  def change
    create_table :insects do |t|

      t.timestamps
    end
  end
end
