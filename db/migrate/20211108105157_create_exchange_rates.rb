class CreateExchangeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_rates do |t|
      t.string :from_type
      t.string :to_type
      t.decimal :value, precision: 19, scale: 4
      t.datetime :expires_at

      t.timestamps
    end

    add_index :exchange_rates, %i[from_type to_type], unique: true
  end
end
