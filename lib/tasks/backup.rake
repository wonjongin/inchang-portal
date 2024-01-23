namespace :backup do
  desc "Back up the production database file"
  task db: :environment do
    today = Date.today.to_s
    FileUtils.cp(File.join(Rails.root, 'db', 'production.sqlite3' ), File.join(Rails.root, 'backup', "#{today}.sqlite3"))
    puts("Backup Done!")
  end

end
