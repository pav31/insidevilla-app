class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :attachment,
                    styles: {
                      gallery_large: "1200x1200>", gallery_small: "184x120#", #used in gallery
                      catalog: "300x200#", thumb: "100x100#"
                    },
                    convert_options: {
                      thumb: "-quality 75 -strip",
                      gallery_small: "-quality 75 -strip"
                    }

  validates_attachment :attachment, content_type: { content_type: /\Aimage\/.*\Z/ },
                                    size: { in: 0..10.megabytes }

  before_save :extract_dimensions
  serialize :dimensions

  # Helper method to determine whether or not an attachment is an image.
  # @note Use only if you have a generic asset-type model that can handle different file types.
  def image?
    attachment_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  # Retrieves dimensions for image attachments
  # @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    return unless image?
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
    end
  end
end
