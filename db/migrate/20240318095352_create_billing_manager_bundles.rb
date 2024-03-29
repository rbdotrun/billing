class CreateBillingManagerBundles < ActiveRecord::Migration[7.1]
  def change
    create_table(:billing_manager_bundles, id: :uuid) do |t|
      t.references(:owner, index: true, foreign_key: { to_table: :billing_manager_owners }, type: :uuid)
      t.string(:label, null: false)
      t.timestamps
    end
  end
end
