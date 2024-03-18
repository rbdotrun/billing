class CreateBillingManagerOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_owners, id: :uuid do |t|
      t.string(:parent_type)
      t.string(:parent_id)
      t.string(:stripe_publishable_key, null: false)
      t.string(:stripe_secret_key, null: false)
      t.timestamps
    end
  end
end
