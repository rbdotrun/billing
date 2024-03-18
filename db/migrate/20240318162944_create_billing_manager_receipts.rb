class CreateBillingManagerReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table(:billing_manager_receipts, id: :uuid) do |t|
      t.references(:subscription, index: true, foreign_key: { to_table: :billing_manager_receipts }, type: :uuid)
      t.timestamps
    end
  end
end
