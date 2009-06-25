class Location < ActiveRecord::Base
  #  acts_as_geocodable
  acts_as_commentable
  acts_as_taggable

  def after_create
    self.link = self.id.to_s(36)
    self.save
  end


  def url
    unless RAILS_ENV == "development"
      "http://iamhe.re/#{self.link}"
    else
      "http://localhost:3000/#{self.link}"
    end
  end

  def to_micro_format
     <<-MICROFORMAT
      <div class='geo'>
        <abbr class='latitude' title='#{self.latitude}'>#{self.latitude}</abbr>
        <abbr class='longitude' title='#{self.longitude}'>#{self.longitude}</abbr>
      </div>
     MICROFORMAT
  end

  def to_param
    link
  end
end
