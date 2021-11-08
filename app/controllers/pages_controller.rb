class PagesController < ApplicationController
  def index
    @rate = ExchangeRate.find_by(from_type: 'USD', to_type: 'RUR')
  end
end
