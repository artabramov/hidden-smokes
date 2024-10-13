Feature: Insert member

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@member @insert
Scenario Outline: Insert member when member_name is invalid
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from value '<member_name>'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '422'
  And error loc is 'body' and 'member_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| member_name | error_type       |
| none        | missing          |
| tabs        | string_too_short |
| spaces      | string_too_short |
| string(0)   | string_type      |
| string(257) | string_too_long  |

@member @insert
Scenario Outline: Insert member when member_name is correct
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'member_name' from value '<member_name>'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_name |
| string(1)   |
| string(256) |

@member @insert
Scenario Outline: Insert member when member_summary is invalid
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from value '<member_summary>'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '422'
  And error loc is 'body' and 'member_summary'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| member_summary | error_type      |
| string(513)    | string_too_long |

@member @insert
Scenario Outline: Insert member when member_summary is correct
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from value '<member_summary>'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_summary |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(512)    |


@member @insert
Scenario Outline: Insert member when member_contacts is invalid
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from value '<member_contacts>'
 When send 'POST' request to url 'member'
 Then response code is '422'
  And error loc is 'body' and 'member_contacts'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| member_contacts | error_type      |
| string(513)     | string_too_long |

@member @insert
Scenario Outline: Insert member when member_contacts is correct
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from value '<member_contacts>'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_contacts |
| none            |
| tabs            |
| spaces          |
| string(0)       |
| string(1)       |
| string(512)     |

@member @insert
Scenario: Insert member when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'

@member @insert
Scenario: Insert member when user is admin
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @insert
Scenario: Insert member when user is editor
    # insert member
Given set request header token from global param 'editor_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @insert
Scenario: Insert member when user is writer
    # insert member
Given set request header token from global param 'writer_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @insert
Scenario: Insert member when user is reader
    # insert member
Given set request header token from global param 'reader_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@member @insert
Scenario: Insert member when token is missing
    # insert member
Given delete request header token
  And set request body param 'is_locked' from value '0'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '403'
