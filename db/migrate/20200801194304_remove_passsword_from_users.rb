class RemovePassswordFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :passsword, :string
  end
end
