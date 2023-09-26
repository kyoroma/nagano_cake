class ChangeItemsIntroductionToAllowNull < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :introduction, :text, null: true
  end
end
