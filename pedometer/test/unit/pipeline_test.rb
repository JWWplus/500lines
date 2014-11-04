require 'test/unit'
require_relative '../../models/pipeline'
require_relative '../../models/upload'

class PipelineTest < Test::Unit::TestCase

  def test_new_combined_data
    file_path = 'test/data/female-167-70_1-100-10-bagwalk.txt'
    upload = Upload.find(file_path)
    pipeline = Pipeline.run(upload)

    assert_equal upload.user, pipeline.user
    assert_equal upload.trial, pipeline.trial
    assert pipeline.parser
    assert pipeline.processor
    assert pipeline.analyzer

    assert_equal 'female', pipeline.user.gender
    assert_equal 167, pipeline.user.height
    assert_equal 70, pipeline.user.stride

    assert_equal '1', pipeline.trial.name
    assert_equal 100, pipeline.trial.rate
    assert_equal 10, pipeline.trial.steps
    assert_equal 'bagwalk', pipeline.trial.method

    assert_equal 12, pipeline.analyzer.steps
    assert_equal 840.0, pipeline.analyzer.distance
    assert_equal 8, pipeline.analyzer.time
  end

  def test_new_separated_data
    file_path = 'test/data/female-167-70_2-100-10-bagwalk.txt'
    upload = Upload.find(file_path)
    pipeline = Pipeline.run(upload)
    
    assert_equal upload.user, pipeline.user
    assert_equal upload.trial, pipeline.trial
    assert pipeline.parser
    assert pipeline.processor
    assert pipeline.analyzer

    assert_equal 'female', pipeline.user.gender
    assert_equal 167, pipeline.user.height
    assert_equal 70, pipeline.user.stride

    assert_equal '2', pipeline.trial.name
    assert_equal 100, pipeline.trial.rate
    assert_equal 10, pipeline.trial.steps
    assert_equal 'bagwalk', pipeline.trial.method  

    assert_equal 12, pipeline.analyzer.steps
    assert_equal 840.0, pipeline.analyzer.distance
    assert_equal 9, pipeline.analyzer.time  
  end

end