Feature: Create demo mediafile

Background: Authorize users
Given auth with user role 'admin'

@mediafile @demo
Scenario: Create demo mediafile
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
    # insert mediafile
Given set request header token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'mediafile_name' from fake 'mediafile_name'
  And set request param 'mediafile_summary' from fake 'mediafile_summary'
  And set request param 'tags' from fake 'mediafile_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '201'
