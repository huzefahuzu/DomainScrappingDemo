class AddUserIdColumnToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :user_id, :integer
  end
end
