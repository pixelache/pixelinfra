class OpencallSerializer
  include FastJsonapi::ObjectSerializer
  attributes :subsite_id, :published, :description, :is_open, :closing_date, :slug, :name, :submitted_text, :opencallquestions
end
