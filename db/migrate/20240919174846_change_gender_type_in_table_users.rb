class ChangeGenderTypeInTableUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :gender, :string
  end
end
