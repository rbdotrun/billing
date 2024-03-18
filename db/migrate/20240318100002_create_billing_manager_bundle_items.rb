class CreateBillingManagerBundleItems < ActiveRecord::Migration[7.1]
  def change
    create_table(:billing_manager_bundle_items, id: :uuid) do |t|
      t.references(:bundle, index: true, foreign_key: { to_table: :billing_manager_bundles }, type: :uuid)
      t.references(:price, index: true, foreign_key: { to_table: :billing_manager_prices }, type: :uuid)
      t.timestamps
    end
  end
end
