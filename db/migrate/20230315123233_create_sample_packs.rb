class CreateSamplePacks < ActiveRecord::Migration[7.0]
  def change
    create_table :sample_packs do |t|
      t.string :name

      t.timestamps
    end
  end
end
