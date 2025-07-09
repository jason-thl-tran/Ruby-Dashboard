class CreateWells < ActiveRecord::Migration[8.0]
  def change
    create_table :wells do |t|
      t.string :name
      t.string :state
      t.float :md
      t.float :tvd
      t.string :status

      t.timestamps
    end
  end
end
