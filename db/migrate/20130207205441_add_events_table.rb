class AddEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :link
      t.string :artist
      t.string :event_date
      t.string :venue
      t.string :location
      t.timestamps
    end
  end
end
