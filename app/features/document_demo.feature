Feature: Create document

Background: Authorize users
Given auth with user role 'admin'

@document @demo
Scenario: Create demo document
    # select random collection
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'rand'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And save id from response list 'collections' to global param 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
