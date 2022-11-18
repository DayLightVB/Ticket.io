# frozen_string_literal: true

WickedPdf.config ||= {}
WickedPdf.config.merge!({
                          layout: 'pdf',
                          orientation: 'Portrait',
                          page_size: 'A4'
                        })
