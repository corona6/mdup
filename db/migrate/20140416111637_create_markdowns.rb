class CreateMarkdowns < ActiveRecord::Migration
  def change
    create_table :markdowns do |t|
      t.string :key
      t.text :data
      t.string :pass

      t.timestamps
    end
  end
end
