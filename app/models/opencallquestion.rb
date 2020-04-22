class Opencallquestion < ActiveRecord::Base
  belongs_to :opencall
  has_many :opencallanswers, dependent: :destroy
  translates :question_text, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['question_text'].blank? }
end
