class CreateFestivalthemeRelations < ActiveRecord::Migration
  def change
    create_table :festivaltheme_relations, id: false do |t|
      t.references :relation, polymorphic: true, index: true
      t.references :festivaltheme, index: true
    end
    Event.where("festivaltheme_id is not null").each do |e|
      FestivalthemeRelation.create(:relation => e, :festivaltheme_id => e.festivaltheme_id)
    end
    
  end
end
