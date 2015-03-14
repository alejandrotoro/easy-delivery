class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_type_id
      t.string :device_id
      t.string :user_id
      t.string :extra_info

      t.timestamps null: false
    end
  end
end
