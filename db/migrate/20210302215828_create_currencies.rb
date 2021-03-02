class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.decimal "rate", precision: 12, scale: 4
      t.string "currency_from", null: false
      t.string "currency_to", null: false
      t.string "resource", null: false
      t.integer "frequency", null: false, default: 86_400

      t.timestamps
    end
  end
end
