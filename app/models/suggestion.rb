require 'leveldb'

class Suggestion
  attr_accessor :predicted_keywords
  attr_accessor :precision
  attr_accessor :recall
  attr_accessor :f_measure 
  
  def self.find_by_rev hash_str
    db = LevelDB::DB.new Rails.application.config.leveldb_dir
    json = db[hash_str]
    data = ActiveSupport::JSON.decode json
    suggestion = Suggestion.new
    suggestion.predicted_keywords = data['predicted_keywords']
    suggestion.precision = data['precision']
    suggestion.recall = data['recall']
    suggestion.f_measure = data['f-measure']
    return suggestion 
  end
end