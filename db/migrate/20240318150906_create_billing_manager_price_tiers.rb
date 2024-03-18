class CreateBillingManagerPriceTiers < ActiveRecord::Migration[7.1]
  def change
    create_table(:billing_manager_price_tiers, id: :uuid) do |t|
      t.references(:price, index: true, foreign_key: { to_table: :billing_manager_prices }, type: :uuid)
      t.float(:flat_amount)
      t.float(:unit_amount)
      t.integer(:up_to)
      t.timestamps
    end

    add_index(:billing_manager_price_tiers, %i[price_id flat_amount unit_amount up_to], unique: true, name: :unique_tiers)
  end
end
