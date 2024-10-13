Feature: Update member

Background: Auth users and create member
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
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

@member @update
Scenario Outline: Update member when member_id not found
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from value '<member_id>'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '404'
  And error loc is 'path' and 'member_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_id  |
| -1         |
| 0          |
| 9999999999 |

@member @update
Scenario Outline: Update member when member_name is invalid
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from value '<member_name>'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '422'
  And error loc is 'body' and 'member_name'
  And error type is '<error_type>'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_name | error_type       |
| none        | missing          |
| tabs        | string_too_short |
| spaces      | string_too_short |
| string(0)   | string_type      |
| string(257) | string_too_long  |

@member @update
Scenario Outline: Update member when member_name is correct
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from value '<member_name>'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
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

@member @update
Scenario Outline: Update member when member_summary is invalid
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from value '<member_summary>'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '422'
  And error loc is 'body' and 'member_summary'
  And error type is '<error_type>'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_summary | error_type      |
| string(513)    | string_too_long |

@member @update
Scenario Outline: Update member when member_summary is correct
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from value '<member_summary>'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
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

@member @update
Scenario Outline: Update member when member_contacts is invalid
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from value '<member_contacts>'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '422'
  And error loc is 'body' and 'member_contacts'
  And error type is '<error_type>'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

Examples:
| member_contacts | error_type      |
| string(513)     | string_too_long |

@member @update
Scenario Outline: Update member when member_contacts is correct
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from value '<member_contacts>'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
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

@member @update
Scenario Outline: Update member when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # update member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # update member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @update
Scenario Outline: Update member when user is admin
    # update member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @update
Scenario Outline: Update member when user is editor
    # update member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @update
Scenario Outline: Update member when user is writer
    # update member
Given set request header token from global param 'writer_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @update
Scenario Outline: Update member when user is reader
Given set request header token from global param 'reader_token' 
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

# @member @update
Scenario Outline: Update member when token is missing
Given delete request header token
  And set request path param 'member_id' from global param 'member_id'
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'PUT' request to url 'member/:member_id'
 Then response code is '403'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
