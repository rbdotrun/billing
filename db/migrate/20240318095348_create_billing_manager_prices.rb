class CreateBillingManagerPrices < ActiveRecord::Migration[7.1]
  def change
    create_enum(:usage_type, %w[metered licensed])
    create_enum(:tiers_mode, %w[graduated volume])

    create_table :billing_manager_prices, id: :uuid do |t|
      t.references(:feature, index: true, foreign_key: { to_table: :billing_manager_features }, type: :uuid)
      t.string(:label, null: false)
      t.float(:price)
      t.boolean(:recurring, null: false, default: false)
      t.integer(:recurring_interval)
      t.integer(:recurring_interval_count)
      t.enum(:usage_type, enum_type: :usage_type)
      t.enum(:tiers_mode, enum_type: :tiers_mode)
      t.string(:stripe_id)
      t.jsonb(:stripe_data)
      t.timestamps
    end

    add_index(:billing_manager_prices, :stripe_id, unique: true)
    add_check_constraint(:billing_manager_prices, "price IS NOT NULL OR tiers_mode IS NOT NULL", name: "price_presence_constraint")
  end
end
