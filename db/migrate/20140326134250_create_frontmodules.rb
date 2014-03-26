class CreateFrontmodules < ActiveRecord::Migration
  def change
    create_table :frontmodules do |t|
      t.string :name
      t.string :partial_name

      t.timestamps
    end
    execute("insert into frontmodules (name, partial_name) values ('Three latest posts', 'three_posts'), ('Calendar', 'calendar'), ('Micro-residencies', 'microresidencies'), ('From the Archive (random)', 'from_the_archive')")
  end
end
