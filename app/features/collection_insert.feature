Feature: Insert collection

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@collection @insert
Scenario Outline: Insert collection when is_lock is invalid
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '<is_locked>'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'is_locked'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '<is_locked>'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

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
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from value '<collection_name>'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'collection_name'
  And error type is '<error_type>'

Examples:
| collection_name | error_type       |
| none            | missing          |
| tabs            | string_too_short |
| spaces          | string_too_short |
| string(0)       | string_too_short |
| string(1)       | string_too_short |
| string(129)     | string_too_long  |

@collection @insert
Scenario Outline: Insert collection when collection_name is correct
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from value '<collection_name>'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

Examples:
| collection_name |
| string(2)       |
| string(128)     |

@collection @insert
Scenario Outline: Insert collection when collection_summary is invalid
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from value '<collection_summary>'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'collection_summary'
  And error type is '<error_type>'

Examples:
| collection_summary | error_type       |
| string(513)        | string_too_long  |

@collection @insert
Scenario Outline: Insert collection when collection_summary is correct
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from value '<collection_summary>'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

Examples:
| collection_summary |
| none               |
| tabs               |
| spaces             |
| string(0)          |
| string(1)          |
| string(512)        |

@collection @insert
Scenario: Insert collection when user is reader
Given set request token from global param 'reader_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@collection @insert
Scenario: Insert collection when user is writer
Given set request token from global param 'writer_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

@collection @insert
Scenario: Insert collection when user is editor
Given set request token from global param 'editor_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

@collection @insert
Scenario: Insert collection when user is admin
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'

@collection @insert
Scenario: Insert collection when token is missing
Given delete request token
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '403'
