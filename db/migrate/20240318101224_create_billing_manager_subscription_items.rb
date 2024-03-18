class CreateBillingManagerSubscriptionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_subscription_items, id: :uuid do |t|
      t.references(:subscription, index: true, foreign_key: { to_table: :billing_manager_subscriptions }, type: :uuid)
      t.references(:price, index: true, foreign_key: { to_table: :billing_manager_prices }, type: :uuid)
      t.integer(:quantity, default: 1, null: false)
      t.timestamps
    end

    add_index(:billing_manager_subscription_items, %i[subscription_id price_id], unique: true, name: :unique_price_feature)
  end
end
