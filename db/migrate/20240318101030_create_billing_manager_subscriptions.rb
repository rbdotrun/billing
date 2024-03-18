class CreateBillingManagerSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_subscriptions, id: :uuid do |t|
      t.references(:customer, index: true, foreign_key: { to_table: :billing_manager_customers }, type: :uuid)
      t.string(:stripe_id)
      t.jsonb(:stripe_data)
      t.timestamps
    end
  end
end
