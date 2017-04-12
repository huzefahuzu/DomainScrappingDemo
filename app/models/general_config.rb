class GeneralConfig < ActiveRecord::Base
  
  TWELVE_NOON = "12pm"
  MAX_DOMAIN_LIMIT = 3

  def self.basics_config
    if self.first
      self.first.cron_time
    else
      TWELVE_NOON
    end
  end

  def self.domain_limit
    if self.first
      self.first.domain_limit
    else
      MAX_DOMAIN_LIMIT
    end
  end
end
