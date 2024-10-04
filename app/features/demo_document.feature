Feature: Create demo datafile

Background: Authorize users
Given auth with user role 'admin'

@datafile @demo
Scenario: Create demo datafile
    # select random collection
Given set request header token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'rand'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And save id from response list 'collections' to global param 'collection_id'
    # insert datafile
Given set request header token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'datafile_name' from fake 'datafile_name'
  And set request param 'datafile_summary' from fake 'datafile_summary'
  And set request param 'tags' from fake 'datafile_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'datafile'
 Then response code is '201'
