class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
