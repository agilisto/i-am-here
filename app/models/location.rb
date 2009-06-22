class Location < ActiveRecord::Base
  #  acts_as_geocodable
  acts_as_commentable

  def after_create
    self.link = self.id.to_s(36)
    self.save
  end

  def to_param
    link
  end
end
