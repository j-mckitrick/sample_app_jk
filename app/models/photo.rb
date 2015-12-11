class Photo < ActiveRecord::Base
  belongs_to :deal

  def image_file=(data)
    self.filename = data.original_filename
    self.content_type = data.content_type.chomp
    self.binary_data = data.read
  end
end
