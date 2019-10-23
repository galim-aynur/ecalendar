class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.text :recurring

      t.timestamps
    end
  end
end
