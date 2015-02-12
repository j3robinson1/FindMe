class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :github
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
