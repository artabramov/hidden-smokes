Feature: Insert collection

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@collection @insert
Scenario Outline: Insert collection when is_lock is invalid
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '<is_locked>'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'body' and 'is_locked'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| is_locked | error_type   |
| none      | missing      |
| tabs      | bool_parsing |
| spaces    | bool_parsing |
| +1        | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |
| 123       | bool_parsing |
| string(0) | bool_parsing |
| string(8) | bool_parsing |

@collection @insert
Scenario Outline: Insert collection when is_lock is correct
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '<is_locked>'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| is_locked |
| TRUE      |
| True      |
| true      |
| YES       |
| yes       |
| Y         |
| y         |
| FALSE     |
| False     |
| false     |
| NO        |
| no        |
| N         |
| n         |
| 1         |
| 0         |

@collection @insert
Scenario Outline: Insert collection when collection_name is invalid
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from value '<collection_name>'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'body' and 'collection_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| collection_name | error_type       |
| none            | missing          |
| tabs            | string_too_short |
| spaces          | string_too_short |
| string(0)       | string_type      |
| string(257)     | string_too_long  |

@collection @insert
Scenario Outline: Insert collection when collection_name is correct
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from value '<collection_name>'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| collection_name |
| string(1)       |
| string(256)     |

@collection @insert
Scenario Outline: Insert collection when collection_summary is invalid
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from value '<collection_summary>'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'body' and 'collection_summary'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| collection_summary | error_type       |
| string(513)        | string_too_long  |

@collection @insert
Scenario Outline: Insert collection when collection_summary is correct
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from value '<collection_summary>'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| collection_summary |
| none               |
| tabs               |
| spaces             |
| string(0)          |
| string(1)          |
| string(512)        |

@collection @insert
Scenario: Insert collection when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @insert
Scenario: Insert collection when user is admin
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @insert
Scenario: Insert collection when user is editor
    # insert collection
Given set request header token from global param 'editor_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @insert
Scenario: Insert collection when user is writer
    # insert collection
Given set request header token from global param 'writer_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @insert
Scenario: Insert collection when user is reader
    # insert collection
Given set request header token from global param 'reader_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@collection @insert
Scenario: Insert collection when token is missing
    # insert collection
Given delete request header token
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '403'
