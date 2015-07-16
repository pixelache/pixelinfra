class AddChildupdatedToPages < ActiveRecord::Migration
  def change
    add_column :pages, :child_updated_at, :datetime
    Page.all.each do |p|
      if p.root?
        p.update_column(:child_updated_at, p.updated_at)
      else
        p.root.update_column(:child_updated_at, p.updated_at)
      end
    end
  end
end
