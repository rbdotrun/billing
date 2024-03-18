class CreateBillingManagerFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_features, id: :uuid do |t|
      t.references(:owner, index: true, foreign_key: { to_table: :billing_manager_owners }, type: :uuid)
      t.string(:label, null: false)
      t.text(:description)
      t.string(:stripe_id)
      t.jsonb(:stripe_data)
      t.boolean(:active, default: false, null: false)
      t.timestamps
    end

    add_index(:billing_manager_features, :stripe_id, unique: true)
  end
end
