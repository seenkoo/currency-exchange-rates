# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class CbrRatesService < ApplicationService
  def call
    xml_doc = Nokogiri::XML(URI.open("https://www.cbr.ru/scripts/XML_daily.asp?"))
    xml_el = xml_doc.xpath('//Valute[@ID="R01235"]/Value') # USD
    rate_text = xml_el.text
    rate_text.sub(',', '.').to_f
  end
end
