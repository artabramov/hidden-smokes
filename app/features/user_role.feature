Feature: Update user role

Background: Authorize users and register a new user
    # authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # register a new user
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And save response param 'user_id' to global param 'user_id'

@user @role
Scenario: Update role when self user_id
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'admin_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'admin'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '403'
  And error loc is 'user_id'
  And error type is 'resource_forbidden'

@user @role
Scenario: Update role when user_id is not found
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from value '99999999'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'admin'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '404'
  And error loc is 'user_id'
  And error type is 'resource_not_found'

@user @role
Scenario Outline: Update role when user_role is invalid
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value '<user_role>'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '422'
  And error loc is 'user_role'
  And error type is '<error_type>'

Examples:
| user_role | error_type |
| none      | missing    |
| tabs      | enum       |
| spaces    | enum       |
| string(0) | enum       |
| string(1) | enum       |
| ADMIN     | enum       |
| EDITOR    | enum       |
| WRITER    | enum       |
| READER    | enum       |

@user @role
Scenario Outline: Update role when user_role is correct
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value '<user_role>'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| user_role |
| reader    |
| writer    |
| editor    |
| admin     |

@user @role
Scenario Outline: Update role when is_active is invalid
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '<is_active>'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '422'
  And error loc is 'is_active'
  And error type is '<error_type>'

Examples:
| is_active | error_type   |
| none      | missing      |
| tabs      | bool_parsing |
| spaces    | bool_parsing |
| string(0) | bool_parsing |
| yep       | bool_parsing |
| nope      | bool_parsing |
| a         | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |

@user @role
Scenario Outline: Update role when is_active is correct
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '<is_active>'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| is_active |
| TRUE      |
| true      |
| FALSE     |
| false     |
| YES       |
| yes       |
| NO        |
| no        |
| Y         |
| y         |
| N         |
| n         |
| 1         |
| 0         |

@user @role
Scenario: Update role when user is admin 
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '200'
  And response params contain 'user_id'

@user @role
Scenario: Update role when user is editor 
Given set request token from global param 'editor_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@user @role
Scenario: Update role when user is writer 
Given set request token from global param 'writer_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@user @role
Scenario: Update role when user is reader 
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@user @role
Scenario: Update role when token is missing
Given delete request token
  And set request placeholder 'user_id' from global param 'user_id'
  And set request param 'is_active' from value '1'
  And set request param 'user_role' from value 'reader'
 When send 'PUT' request to url 'user/:user_id/role'
 Then response code is '403'