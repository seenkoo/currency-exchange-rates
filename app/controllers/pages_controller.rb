class PagesController < ApplicationController
  def index
    @rate = CbrRatesService.call
  end
end
