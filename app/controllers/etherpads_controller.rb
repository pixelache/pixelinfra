class EtherpadsController < InheritedResources::Base
  actions :index
  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  has_scope :by_event
  has_scope :by_documenttype
  handles_sortable_columns
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "lower(name) #{direction}"
      when "last_edited"
        "#{column} #{direction}, lower(name) ASC"
      else
        "last_edited DESC"
      end
    end
    @etherpads = apply_scopes(Etherpad).not_private.order(order).page(params[:page]).per(100) #"etherpads.last_edited desc, lower(etherpads.name)")
    @etherpad_events = @etherpads.map(&:events).flatten.compact
  end
end