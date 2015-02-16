class String
  def longest_word
    words = self.split(" ")
    words.sort! { |a, b| b.length <=> a.length }
    words[0]
  end
end