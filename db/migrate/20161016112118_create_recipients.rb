class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.text :email_address, index:true
      t.json :dictionary, default: Hash.new
      t.timestamps
    end
  end
end
