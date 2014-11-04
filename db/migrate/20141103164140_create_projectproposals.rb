class CreateProjectproposals < ActiveRecord::Migration
  def change
    create_table :projectproposals do |t|
      t.string :name
      t.references :project, index: true
      t.text :description
      t.text :long_description
      t.integer :primary_initiator_id
      t.string :cosupporters
      t.string :producer
      t.string :treasurer
      t.string :documentation
      t.string :communication
      t.string :additional_experts
      t.string :reporting
      t.string :imagined_participants
      t.string :equipment
      t.string :budget
      t.string :external_funding
      t.string :inkind
      t.string :people_expertise
      t.string :where
      t.string :when
      t.string :when_will_it_end
      t.text :why
      t.string :slug

      t.timestamps
    end
  end
end
