class CreateTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :trades, do |t|
      t.symbol :text
    end
  end
end
