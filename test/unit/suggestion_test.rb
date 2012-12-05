require 'test_helper'
require 'leveldb'

class SuggestionTest < ActiveSupport::TestCase
  def setup
    db =  LevelDB::DB.new Rails.application.config.leveldb_dir
    db['revision_hash1'] = '{"hit": 213, "predicted_keywords": ["new_source__println", "new_source__j", "new_source__java"], "precision": 71.96, "rate": "18.95", "f-measure": "56.27", "miss": 83, "recall_hit": 213, "recall": "46.20", "technique": "Fix", "rev": "0a22d5848ea6515dff054e12547b771bedd281de", "project": "lucene", "instance": "5474.00", "top_features": false, "recall_miss": 248}'
    
  end
  
  test "find by rev" do
    s = Suggestion.find_by_rev 'revision_hash1'
    assert_equal 71.96, s.precision
    assert_equal ["new_source__println", "new_source__j", "new_source__java"], s.predicted_keywords
  end
end
