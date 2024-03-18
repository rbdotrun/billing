class CreateBillingManagerPrices < ActiveRecord::Migration[7.1]
  def change
    create_enum(:usage_type, %w[metered licensed])

    create_table :billing_manager_prices, id: :uuid do |t|
      t.references(:feature, index: true, foreign_key: { to_table: :billing_manager_features }, type: :uuid)
      t.string(:label, null: false)
      t.float(:price, null: false)
      t.boolean(:recurring, null: false, default: false)
      t.integer(:recurring_interval)
      t.integer(:recurring_interval_count)
      t.enum(:usage_type, enum_type: :usage_type, null: false, default: "licensed")
      t.string(:stripe_id)
      t.jsonb(:stripe_data)
      t.timestamps
    end
  end
end
