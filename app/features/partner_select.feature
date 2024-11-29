Feature: Select partner

Background: Auth users and create partner
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'company_email'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'

@partner @select
Scenario Outline: Select partner when partner_id not found
Given set request header token from global param 'reader_token' 
  And set request path param 'partner_id' from value '<partner_id>'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '404'
  And error loc is 'path' and 'partner_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_id  |
| -1         |
| 0          |
| 9999999999 |

@partner @select
Scenario: Select partner when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # select partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # select partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'partner_name'
  And response params contain 'partner_type'
  And response params contain 'partner_region'
  And response params contain 'partner_website'
  And response params contain 'partner_contacts'
  And response params contain 'partner_summary'
  And response params contain 'partnerpic_url'
  And response contains '12' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @select
Scenario: Select partner when user is admin
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'partner_name'
  And response params contain 'partner_type'
  And response params contain 'partner_region'
  And response params contain 'partner_website'
  And response params contain 'partner_contacts'
  And response params contain 'partner_summary'
  And response params contain 'partnerpic_url'
  And response contains '12' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @select
Scenario: Select partner when user is editor
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'partner_name'
  And response params contain 'partner_type'
  And response params contain 'partner_region'
  And response params contain 'partner_website'
  And response params contain 'partner_contacts'
  And response params contain 'partner_summary'
  And response params contain 'partnerpic_url'
  And response contains '12' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @select
Scenario: Select partner when user is writer
Given set request header token from global param 'writer_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'partner_name'
  And response params contain 'partner_type'
  And response params contain 'partner_region'
  And response params contain 'partner_website'
  And response params contain 'partner_contacts'
  And response params contain 'partner_summary'
  And response params contain 'partnerpic_url'
  And response contains '12' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @select
Scenario: Select partner when user is reader
Given set request header token from global param 'reader_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'partner_name'
  And response params contain 'partner_type'
  And response params contain 'partner_region'
  And response params contain 'partner_website'
  And response params contain 'partner_contacts'
  And response params contain 'partner_summary'
  And response params contain 'partnerpic_url'
  And response contains '12' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @select
Scenario: Select partner when token is missing
Given delete request header token
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'GET' request to url 'partner/:partner_id'
 Then response code is '403'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
