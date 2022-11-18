require 'rqrcode'

class GenerateQr< ApplicationServices
  include Rails.application.routes.url_helpers

  def initialize(event)
    @event = event
  end

  def call
    event.qr_code.attach(
      io: StringIO.new(png.to_s),
      filename: "#{random_name}.png",
      content_type: 'png'
    )
  end

  private

  attr_reader :event

  def random_name
    SecureRandom.hex
  end

  def qr_url
    event_url(event)
  end

  def png
    qrcode = RQRCode::QRCode.new(qr_url)
    qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 200
    )
  end
end

























