class RenameStartsAtToStartTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :starts_at, :start_time
  end
end
