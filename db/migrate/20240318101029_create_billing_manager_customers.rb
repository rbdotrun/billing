class CreateBillingManagerCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_manager_customers, id: :uuid do |t|
      t.references(:owner, index: true, foreign_key: { to_table: :billing_manager_owners }, type: :uuid)
      t.string(:stripe_id)
      t.jsonb(:stripe_data)
      t.timestamps
    end

    add_index(:billing_manager_customers, :stripe_id, unique: true)
  end
end
