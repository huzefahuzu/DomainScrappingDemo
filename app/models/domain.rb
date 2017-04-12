class Domain < ActiveRecord::Base
  belongs_to :user
  has_many :domain_ranks

  before_validation :limits_check, on: :create
  def limits_check
    if !(self.user.domains.count < GeneralConfig.domain_limit)
      errors.add(:url, "allowed url limits reached")
      false
    else
      self.user.domains.count < GeneralConfig.domain_limit
    end
  end
end
