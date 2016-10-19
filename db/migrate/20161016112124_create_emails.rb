class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.references :recipient, index:true

      t.boolean :tracked
      t.json :subject
      t.datetime :sent_on, index:true
      t.timestamps
    end
  end
end