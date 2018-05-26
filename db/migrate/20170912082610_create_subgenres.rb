class CreateSubgenres < ActiveRecord::Migration[5.1]
  def change
    create_table :subgenres do |t|
      t.string :name
      t.string :gname

      t.timestamps
    end
  end
end
