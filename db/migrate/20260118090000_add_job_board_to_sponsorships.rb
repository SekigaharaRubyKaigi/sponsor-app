class AddJobBoardToSponsorships < ActiveRecord::Migration[8.1]
  def change
    add_column :sponsorships, :job_board_text, :text
    add_column :sponsorships, :job_board_url, :string
  end
end
