namespace :domainrankupdate do
  desc "All available domain rank scraping takes place"
  task :domain_rank_update => :environment do
    RankUpdaterJob.new.perform
  end
end

