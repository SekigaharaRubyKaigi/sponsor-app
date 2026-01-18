class AddJobBoardAvailableToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :job_board_available, :boolean, null: false, default: false
  end
end
