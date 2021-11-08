module Admin
  class ExchangeRatesController < ApplicationController
    before_action :set_exchange_rate!

    def edit; end

    def update
      if @exchange_rate.update(exchange_rate_params)
        flash[:success] = 'Exchange rate updated!'
        redirect_to admin_path
      else
        render :edit
      end
    end

    private

    def set_exchange_rate!
      @exchange_rate = ExchangeRate.find_by(from_type: 'USD', to_type: 'RUR')
    end

    def exchange_rate_params
      params.require(:exchange_rate).permit(:value, :expires_at)
    end
  end
end
