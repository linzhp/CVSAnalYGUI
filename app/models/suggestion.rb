require 'leveldb'

class Suggestion
  attr_accessor :predicted_keywords
  attr_accessor :comment_keywords
  attr_accessor :precision
  attr_accessor :recall
  attr_accessor :f_measure
  @comment_stopwords = %w(new_source__obtain new_source__http new_source__how new_source__however new_source__how
new_source__href new_source__implementation new_source__implied new_source__incidental new_source__include
new_source__included new_source__includes new_source__copyright new_source__including new_source__individuals
new_source__software new_source__information new_source__redistribute new_source__along)

  def self.find_by_rev hash_str
    db = LevelDB::DB.new Rails.application.config.leveldb_dir
    json = db[hash_str]
    return nil unless json
    data = ActiveSupport::JSON.decode json
    suggestion = Suggestion.new


    suggestion.predicted_keywords = data['predicted_keywords']

    suggestion.comment_keywords = suggestion.predicted_keywords.select { |k| @comment_stopwords.include? k}
    suggestion.predicted_keywords.delete_if {|element| @comment_stopwords.include? element}

    suggestion.precision = data['precision']
    suggestion.recall = data['recall']
    suggestion.f_measure = data['f-measure']
    return suggestion
  end
end