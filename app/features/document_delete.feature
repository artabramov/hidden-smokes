Feature: Delete document

Background: Authorize users, create collection and document
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert collection
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And save response param 'collection_id' to global param 'collection_id'
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
  And save response param 'document_id' to global param 'document_id'

@document @delete
Scenario: Delete document when document_id not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'document_id' from value '9999999999'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '404'
  And error loc is 'document_id'
  And error type is 'resource_not_found'

@document @delete
Scenario: Delete document when collection is locked
    # lock collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
  And set request param 'is_locked' from value '1'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
    # delete document
Given set request token from global param 'admin_token' 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '423'
  And error loc is 'document_id'
  And error type is 'resource_locked'

@document @delete
Scenario: Delete document when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@document @delete
Scenario: Delete document when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@document @delete
Scenario: Delete document when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@document @delete
Scenario: Delete document when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'

@document @delete
Scenario: Delete document when token is missing
Given delete request token 
  And set request placeholder 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '403'
