Feature: Select document

Background: Auth users and upload document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file

@document @select
Scenario Outline: Select document when document_id not found
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from value '<document_id>'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '404'
  And error loc is 'path' and 'document_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| document_id |
| -1           |
| 0            |
| 9999999999   |

@document @select
Scenario Outline: Select document when document_id is invalid
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from value '<document_id>'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'path' and 'document_id'
  And error type is '<error_type>'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| document_id | error_type  |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

# @document @select
# Scenario: Select document when collection is locked
#     # lock collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request body param 'is_locked' from value '1'
#   And set request body param 'collection_name' from fake 'collection_name'
#  When send 'PUT' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'
#   And response contains '1' params
#     # select document
# Given set request header token from global param 'reader_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request path param 'document_id' from global param 'document_id'
#  When send 'GET' request to url 'collection/:collection_id/document/:document_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'updated_date'
#   And response params contain 'user_id'
#   And response params contain 'collection_id'
#   And response params contain 'document_summary'
#   And response params contain 'comments_count'
#   And response params contain 'revisions_count'
#   And response params contain 'revisions_size'
#   And response params contain 'downloads_count'
#   And response params contain 'document_tags'
#   And response params contain 'document_user'
#   And response params contain 'latest_revision'
#   And response contains '14' params
#     # delete document
# Given set request header token from global param 'admin_token' 
#   And set request path param 'document_id' from global param 'document_id'
#  When send 'DELETE' request to url 'document/:document_id'
#  Then response code is '200'
#   And response params contain 'document_id'
#   And response contains '1' params

@document @select
Scenario: Select document when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'member_id'
  And response params contain 'document_name'
  And response params contain 'document_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'document_tags'
  And response params contain 'document_user'
  And response params contain 'document_collection'
  And response params contain 'document_member'
  And response params contain 'latest_revision'
  And response contains '17' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @select
Scenario: Select document when user is admin
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'member_id'
  And response params contain 'document_name'
  And response params contain 'document_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'document_tags'
  And response params contain 'document_user'
  And response params contain 'document_collection'
  And response params contain 'document_member'
  And response params contain 'latest_revision'
  And response contains '17' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @select
Scenario: Select document when user is editor
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'member_id'
  And response params contain 'document_name'
  And response params contain 'document_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'document_tags'
  And response params contain 'document_user'
  And response params contain 'document_collection'
  And response params contain 'document_member'
  And response params contain 'latest_revision'
  And response contains '17' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @select
Scenario: Select document when user is writer
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'member_id'
  And response params contain 'document_name'
  And response params contain 'document_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'document_tags'
  And response params contain 'document_user'
  And response params contain 'document_collection'
  And response params contain 'document_member'
  And response params contain 'latest_revision'
  And response contains '17' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @select
Scenario: Select document when user is reader
    # select document
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'member_id'
  And response params contain 'document_name'
  And response params contain 'document_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'document_tags'
  And response params contain 'document_user'
  And response params contain 'document_collection'
  And response params contain 'document_member'
  And response params contain 'latest_revision'
  And response contains '17' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @select
Scenario: Select document when token is missing
    # select document
Given delete request header token
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
