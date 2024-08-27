Feature: Collection insert

Background: User auth
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@collection @insert
Scenario Outline: Error when is_lock is invalid
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '<is_locked>'
  And set request param 'collection_name' from fake 'collection_name'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'is_locked'
  And error type is '<error_type>'

Examples:
| is_locked | error_type   |
| none      | missing      |
| empty     | bool_parsing |
| spaces    | bool_parsing |
| tabs      | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |
| dummy     | bool_parsing |

@collection @insert
Scenario Outline: Error when collection_name is invalid
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value 'False'
  And set request param 'collection_name' from value '<collection_name>'
 When send 'POST' request to url 'collection'
 Then response code is '422'
  And error loc is 'collection_name'
  And error type is '<error_type>'

Examples:
| collection_name | error_type       |
| none            | missing          |
| empty           | string_too_short |
| spaces          | value_error      |
| tabs            | value_error      |
| a               | string_too_short |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_too_long |

@collection @insert
Scenario Outline: Error when collection_summary is invalid
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
| a                  | string_too_short |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_too_long |

@collection @insert
Scenario Outline: When all data is correct
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '<is_locked>'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| is_locked |
| True      |
| False     |
| 1         |
| 0         |
