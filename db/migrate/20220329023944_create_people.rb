class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.text :dna_string
      t.boolean :is_mutant

      t.timestamps
    end
  end
end
