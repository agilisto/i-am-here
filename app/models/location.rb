class Location < ActiveRecord::Base
#  acts_as_geocodable

  def after_create
    self.link = self.id.to_s(36)
    self.save
  end
end
