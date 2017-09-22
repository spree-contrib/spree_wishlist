class CreateWishedProducts < SpreeExtension::Migration[4.2]
  def self.up
    create_table :wished_products do |t|
      t.references :variant
      t.references :wishlist
      t.text :remark

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :wished_products
  end
end
