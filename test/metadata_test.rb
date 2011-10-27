require File.dirname(__FILE__) + '/test_helper'

class MetadataTest < Test::Unit::TestCase

  include TestConnection

  def setup
    @conn=get_test_connection
  end

  def test_metadata_uses_initial_values
    data = {'key1' => 'value1', 'key2' => 'value2'}
    metadata = OpenStack::Compute::Metadata.new(@conn, 'blah', data)
    assert_equal('value1', metadata['key1'])
    assert_equal('value2', metadata['key2'])
    assert_equal(nil, metadata['key0'])
  end

  def test_metadata_presents_saved_values
    metadata = OpenStack::Compute::Metadata.new(@conn, 'blah')
    metadata['key3'] = 'value3'
    assert_equal('value3', metadata['key3'])
    assert_equal(nil, metadata['key0'])
  end

  def test_metadata_looks_up_values_if_none_provided
    data = {'metadata' => {'key4' => 'value4'}}
    json = JSON.generate(data)
    response = mock()
    response.stubs(:code => "200", :body => json)
    @conn.stubs(:req).returns(response)
    metadata = OpenStack::Compute::Metadata.new(@conn, 'blah')
    assert_equal('value4', metadata['key4'])
    assert_equal(nil, metadata['key0'])
  end

  def test_metadata_save_nil
    conn = mock()
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata.save # do nothing or we'd likely be deleting unintentionally
  end

  def test_metadata_save
    data = {'key1' => 'value1', 'key3' => 'value3'}
    json = JSON.generate({'metadata' => data})
    response = mock()
    response.stubs(:code => "200", :body => json)
    conn = mock()
    req = conn.expects(:req)
    req.with('PUT', 'blah/metadata', :data => json).returns(response)
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.save
  end

  def test_metadata_update_all
    data_in = {'key5' => 'value5', 'key6' => 'value6'}
    data_out = {'key5' => 'value5', 'key6' => 'value6', 'key7' => 'value7'}
    json_in = JSON.generate({'metadata' => data_in})
    json_out = JSON.generate({'metadata' => data_out})
    response = mock()
    response.stubs(:code => "200", :body => json_out)
    conn = mock()
    req = conn.expects(:req)
    req.with('POST', 'blah/metadata', :data => json_in)
    req.returns(response)
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata['key5'] = 'value5'
    metadata['key6'] = 'value6'
    metadata.update
    assert_equal('value5', metadata['key5'])
    assert_equal('value6', metadata['key6'])
    assert_equal('value7', metadata['key7'])
  end

  def test_metadata_update_some_keys
    json1 = JSON.generate({'meta' => {'key1' => 'value1'}})
    response1 = mock()
    response1.stubs(:code => "200", :body => json1)
    json2 = JSON.generate({'meta' => {'key2' => 'value2'}})
    response2 = mock()
    response2.stubs(:code => "200", :body => json2)
    conn = mock()
    req1 = conn.expects(:req)
    req1.with('PUT', 'blah/metadata/key1', :data => json1).returns(response1)
    req2 = conn.expects(:req)
    req2.with('PUT', 'blah/metadata/key2', :data => json2).returns(response2)
    data = {'key1' => 'value1', 'key2' => 'value2', 'key3' => 'value3'}
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.update(['key1', 'key2'])
  end

  def test_metadata_update_one_key
    json = JSON.generate({'meta' => {'key2' => 'value2'}})
    response = mock()
    response.stubs(:code => "200", :body => json)
    conn = mock()
    req = conn.expects(:req)
    req.with('PUT', 'blah/metadata/key2', :data => json)
    req.returns(response)
    data = {'key1' => 'value1', 'key2' => 'value2'}
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.update('key2')
  end

  def test_metadata_update_nonexistent_key
    data = {'key1' => 'value1', 'key2' => 'value2'}
    conn = mock()
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.update('key3') # just asserting nothing is called on conn
  end

  def test_metadata_update_nil
    conn = mock()
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata.update # just asserting nothing is called on the connection
  end

  def test_refresh_one_key
    json = JSON.generate({'meta' => {'key1' => 'value1'}})
    response = mock()
    response.stubs(:code => "200", :body => json)
    conn = mock()
    conn.expects(:req).with('GET', 'blah/metadata/key1').returns(response)
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata.refresh('key1')
    assert_equal('value1', metadata['key1'])
  end

  def test_refresh_some_keys_with_key_not_found
    json = JSON.generate({'meta' => {'key1' => 'value1'}})
    response = mock()
    response.stubs(:code => "200", :body => json)
    not_found = mock()
    not_found.stubs(:code => "404")
    conn = mock()
    conn.expects(:req).with('GET', 'blah/metadata/key1').returns(response)
    conn.expects(:req).with('GET', 'blah/metadata/key0').returns(not_found)
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata.refresh(['key1', 'key0'])
    assert_equal('value1', metadata['key1'])
    assert(metadata['key0'].nil?)
  end

  def test_delete_a_key
    response = mock()
    response.stubs(:code => "204")
    conn = mock()
    conn.expects(:req).with('DELETE', 'blah/metadata/key1').returns(response)
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah')
    metadata.delete!('key1')
  end

  def test_delete_a_key_with_prior_information
    response = mock()
    response.stubs(:code => "204")
    conn = mock()
    conn.expects(:req).with('DELETE', 'blah/metadata/key1').returns(response)
    data = {'key1' => 'value1', 'key2' => 'value2'}
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.delete!('key1')
    assert(metadata['key1'].nil?)
    assert_equal('value2', metadata['key2'])
  end

  def test_delete_keys_softly
    conn = mock()
    data = {'key1' => 'value1', 'key2' => 'value2', 'key3' => 'value3'}
    metadata = OpenStack::Compute::Metadata.new(conn, 'blah', data)
    metadata.delete(['key1', 'key3'])
    assert(metadata['key1'].nil?)
    assert_equal('value2', metadata['key2'])
    assert(metadata['key3'].nil?)
  end
  
end
