class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
	  t.string   :title
      t.date     :start_date
      t.date     :end_date
      t.integer  :user_id

      t.timestamps
    end
  end
end
