class AddNameTicketsSupportToEventsTable < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :tickets, :string
    add_column :events, :support, :string
  end
end