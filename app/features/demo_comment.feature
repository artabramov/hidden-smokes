Feature: Create demo comment

Background: Authorize users
Given auth with user role 'admin'

@comment @demo
Scenario: Create demo comment
    # select random mediafile
Given set request header token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'rand'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And save id from response list 'mediafiles' to global param 'mediafile_id'
    # insert mediafile
Given set request header token from global param 'admin_token' 
  And set request param 'mediafile_id' from global param 'mediafile_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
