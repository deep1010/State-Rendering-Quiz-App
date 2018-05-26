class AddLlpassToAttempts < ActiveRecord::Migration[5.1]
  def change
    add_column :attempts, :llpass, :integer
  end
end
