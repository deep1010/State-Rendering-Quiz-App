class CreateDestroys < ActiveRecord::Migration[5.1]
  def change
    create_table :destroys do |t|
      t.string :Question

      t.timestamps
    end
  end
end
