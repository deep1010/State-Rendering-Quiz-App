class CreateAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :attempts do |t|
      t.integer :qid
      t.string :uname
      t.string :gname
      t.string :sname
      t.integer :score
      t.integer :attempt
      t.integer :correct

      t.timestamps
    end
  end
end
