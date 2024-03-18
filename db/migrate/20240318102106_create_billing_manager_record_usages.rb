class CreateBillingManagerRecordUsages < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_record_usages do |t|
      t.references(:subscription_item, index: true, foreign_key: { to_table: :billing_manager_subscription_items }, type: :uuid)
      t.string(:stripe_id, null: false)
      t.jsonb(:stripe_data, null: false)
      t.timestamps
    end
  end
end
