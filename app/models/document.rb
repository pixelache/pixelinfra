class Document < ActiveRecord::Base
  #belongs_to :documenttype
  belongs_to :subsite
  translates :title, :description
  has_one :attachment, as: :item
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['description'].blank? }
  accepts_nested_attributes_for :attachment, reject_if: proc {|x| x['attachedfile'].blank? }
  validates_presence_of :title, :date_of_release, :subsite_id
  
end
