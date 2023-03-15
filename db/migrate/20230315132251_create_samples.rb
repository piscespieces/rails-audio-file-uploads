class CreateSamples < ActiveRecord::Migration[7.0]
  def change
    create_table :samples do |t|
      t.string :name
      t.references :sample_pack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
