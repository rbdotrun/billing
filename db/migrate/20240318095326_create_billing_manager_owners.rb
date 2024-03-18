class CreateBillingManagerOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_owners, id: :uuid do |t|
      t.string(:parent_type, null: false)
      t.string(:parent_id, null: false)
      t.string(:stripe_id, null: false)
      t.timestamps
    end
  end
end
