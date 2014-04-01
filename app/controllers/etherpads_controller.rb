class EtherpadsController < InheritedResources::Base
  actions :index
  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite

  def index
    @etherpads = apply_scopes(Etherpad).not_private.order("lower(etherpads.name)")
  end
end