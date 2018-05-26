class AddLl50ToAttempts < ActiveRecord::Migration[5.1]
  def change
    add_column :attempts, :ll50, :integer
  end
end
