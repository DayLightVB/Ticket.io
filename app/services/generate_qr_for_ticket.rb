require 'rqrcode'

class GenerateQrForTicket < ApplicationServices
  include Rails.application.routes.url_helpers

  def initialize(ticket)
    @ticket = ticket
  end

  def call
    image_name = SecureRandom.hex

    IO.binwrite("tmp/#{image_name}.png", png.to_s)

    blob = ActiveStorage::Blob.create_after_upload!(
      io: File.open("tmp/#{image_name}.png"),
      filename: image_name,
      content_type: 'png'
    )

    ticket.qr_code.attach(blob)
  end

  private

  attr_reader :ticket

  def qr_url
    ticket_url(@ticket.uuid)
  end

  def png
    qrcode = RQRCode::QRCode.new(qr_url)
    qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      size: 400
    )
  end
end

