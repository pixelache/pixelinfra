class Meeting < ActiveRecord::Base
  belongs_to :meetingtype
  translates :name
  has_many :attachments, as: :item
  has_and_belongs_to_many :etherpads
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }, :allow_destroy => true
end
