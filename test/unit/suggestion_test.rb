require 'test_helper'
require 'leveldb'

class SuggestionTest < ActiveSupport::TestCase
  def setup
    db =  LevelDB::DB.new Rails.application.config.leveldb_dir
    db['revision_hash1'] = '{"hit": 213, "predicted_keywords": ["new_source__println", "new_source__j", "new_source__java"], "precision": 71.96, "rate": "18.95", "f-measure": "56.27", "miss": 83, "recall_hit": 213, "recall": "46.20", "technique": "Fix", "rev": "0a22d5848ea6515dff054e12547b771bedd281de", "project": "lucene", "instance": "5474.00", "top_features": false, "recall_miss": 248}'
    db['ff6b5e6ca047e31e6d3e81ee230e6b6d7fa0b3ff'] = '{"hit": 237, "predicted_keywords": ["added_delta__==", "new_rev_loc", "new_source__getmacrorecorder", "new_source__getmarker", "new_source__propertieschanged", "new_source__actionevent", "new_source__actionlistener", "deleted_delta__&&", "new_source__actionperformed", "new_source__getmode", "new_source__public", "new_source__getname", "new_source__published", "new_source__add", "new_source__purpose", "new_source__handle", "new_source__put", "new_source__added", "new_source__addelement", "new_source__parserrule", "new_source__getposition", "new_source__addlayoutcomponent", "new_source__getpreferredsize", "new_source__r", "new_source__getproperty"], "precision": "35.85", "rate": "47.09", "f-measure": "43.21", "miss": 424, "recall_hit": 237, "recall": "54.36", "technique": "Fix", "rev": "ff6b5e6ca047e31e6d3e81ee230e6b6d7fa0b3ff", "project": "jedit", "instance": "866.00", "top_features": false, "recall_miss": 199}'
    db['ff7d85fa56ac4a5fb0d07940e9b67bbc06d829f2'] = '{"hit": 196, "predicted_keywords": ["new_source__documents", "new_rev_loc", "new_source__contributions", "new_source__on", "new_source__one", "new_source__software", "new_source__http", "new_source__open", "new_source__copy", "new_source__copyright", "new_source__source", "new_source__however", "new_source__acknowledgment", "new_source__special", "new_source__id", "new_source__contract", "new_source__or", "new_source__order", "new_source__return", "new_source__if", "new_source__org", "new_source__current", "new_source__other", "new_source__otherwise", "new_source__obtain"], "precision": "60.31", "rate": "30.32", "f-measure": "45.33", "miss": 129, "recall_hit": 195, "recall": "36.31", "technique": "Fix", "rev": "ff7d85fa56ac4a5fb0d07940e9b67bbc06d829f2", "project": "lucene", "instance": "1662.00", "top_features": false, "recall_miss": 342}'
  end
  
  test "find by rev" do
    s = Suggestion.find_by_rev 'revision_hash1'
    assert_equal 71.96, s.precision
    assert_equal ["new_source__println", "new_source__j", "new_source__java"], s.predicted_keywords
    
    s = Suggestion.find_by_rev 'ff6b5e6ca047e31e6d3e81ee230e6b6d7fa0b3ff'
    assert_equal "43.21", s.f_measure
    
    s = Suggestion.find_by_rev 'ff7d85fa56ac4a5fb0d07940e9b67bbc06d829f2'
    assert_equal "36.31", s.recall
  end
end
