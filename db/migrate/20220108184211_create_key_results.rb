class CreateKeyResults < ActiveRecord::Migration[6.1]
  def change
    create_table :key_results do |t|
      t.string   :title
      t.integer  :user_id
      t.integer  :goal_id
      t.integer  :status, default: 0
      t.timestamps
    end
  end
end
