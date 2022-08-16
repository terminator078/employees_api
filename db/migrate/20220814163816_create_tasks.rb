class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task
      t.string :status
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
