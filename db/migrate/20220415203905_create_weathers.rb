class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|

      t.timestamps
    end
  end
end
