class AddColumnToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :is_agent, :boolean, default: false
  end
end
