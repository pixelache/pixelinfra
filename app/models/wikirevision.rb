class Wikirevision < ApplicationRecord
  belongs_to :user
  belongs_to :wikipage
  has_many :wikifiles, :dependent => :destroy
  accepts_nested_attributes_for :wikifiles, :allow_destroy => true, :reject_if => proc { |t| t['attachment'].blank? || !t['id'].blank? }
 
  def contents_linked
    if self.parsed_contents =~ /\<table/
      self.parsed_contents.gsub(/\[\[([\w\-\s]*)\]\]/, '<a href="/admin/wiki/\1">\1</a>').gsub(/(.*)\r\n\r\n/, '<p>\1</p>')
    else
      self.parsed_contents.gsub(/\[\[([\w\-\s]*)\]\]/, '<a href="/admin/wiki/\1">\1</a>') #.gsub(/(.*)\r\n\r\n/, '<p>\1</p>')
    end
  end
    

  def parsed_contents
    contents = self.contents.gsub(/\n{2,}/, "<br /><br />").gsub(/(\w*_\w*)/) {|match| "<a href='#{match.downcase}'>#{match.gsub('_', ' ')}</a>"}
  end

  def name
    wikipage.title
  end


end