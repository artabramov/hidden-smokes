Feature: Update user

Background: Authorize users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @update
Scenario Outline: Update user when user_id is not found
    # update user
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from value '<user_id>'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '404'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_not_found'
  And response contains '1' params

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@user @update
Scenario: Update user when user_id is invalid
    # update user
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_forbidden'
  And response contains '1' params

@user @update
Scenario Outline: Update user when first_name is invalid
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from value '<first_name>'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'body' and 'first_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| first_name | error_type       |
| none       | missing          |
| tabs       | string_too_short |
| spaces     | string_too_short |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @update
Scenario Outline: Update user when last_name is invalid
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from value '<last_name>'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'body' and 'last_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| last_name  | error_type       |
| none       | missing          |
| tabs       | string_too_short |
| spaces     | string_too_short |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @update
Scenario Outline: Update user when user_caption is invalid
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from value '<user_caption>'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'body' and 'user_caption'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_caption | error_type      |
| string(41)     | string_too_long |

@user @update
Scenario Outline: Update user when user_caption is correct
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from value '<user_caption>'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_caption |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(39)     |

@user @update
Scenario Outline: Update user when user_contacts is invalid
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from value '<user_contacts>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'body' and 'user_contacts'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_contacts | error_type      |
| string(513)   | string_too_long |

@user @update
Scenario Outline: Update user when user_contacts is correct
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from value '<user_contacts>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_contacts |
| none          |
| tabs          |
| spaces        |
| string(0)     |
| string(1)     |
| string(512)   |

@user @update
Scenario Outline: Update user when app islocked
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # update user
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # update user
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @update
Scenario Outline: Update user when user is admin
    # update user
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @update
Scenario Outline: Update user when user is editor
    # update user
Given set request header token from global param 'editor_token'
  And set request path param 'user_id' from global param 'editor_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @update
Scenario Outline: Update user when user is writer
    # update user
Given set request header token from global param 'writer_token'
  And set request path param 'user_id' from global param 'writer_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @update
Scenario Outline: Update user when user is reader
    # update user
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @update
Scenario Outline: Update user when token is missing
    # update user
Given delete request header token
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '403'
