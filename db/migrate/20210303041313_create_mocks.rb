class CreateMocks < ActiveRecord::Migration[6.0]
  def change
    create_table :mocks do |t|
      t.decimal "rate", precision: 12, scale: 4, null: false, default: 0.0
      t.datetime "at_time", null: false

      t.timestamps
    end
  end
end
