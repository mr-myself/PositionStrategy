namespace :reset_token do

  task delete: :environment do
    ResetToken.delete_all("created_at <= '#{Time.current.yesterday}'")
  end
end
