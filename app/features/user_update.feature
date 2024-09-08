Feature: Update user

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @update
Scenario: Update user when user_id is invalid
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from value 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'user_id'
  And error type is 'resource_forbidden'

@user @update
Scenario Outline: Update user when first_name is invalid
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from value '<first_name>'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'first_name'
  And error type is '<error_type>'

Examples:
| first_name | error_type       |
| none       | missing          |
| tabs       | value_error      |
| spaces     | value_error      |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @update
Scenario Outline: Update user when last_name is invalid
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from value '<last_name>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'last_name'
  And error type is '<error_type>'

Examples:
| last_name  | error_type       |
| none       | missing          |
| tabs       | value_error      |
| spaces     | value_error      |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @update
Scenario Outline: Update user when user_signature is invalid
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from value '<user_signature>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'user_signature'
  And error type is '<error_type>'

Examples:
| user_signature | error_type      |
| string(41)     | string_too_long |

@user @update
Scenario Outline: Update user when user_signature is correct
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from value '<user_signature>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| user_signature |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(39)     |

@user @update
Scenario Outline: Update user when user_contacts is invalid
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_contacts' from value '<user_contacts>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '422'
  And error loc is 'user_contacts'
  And error type is '<error_type>'

Examples:
| user_contacts | error_type      |
| string(513)   | string_too_long |

@user @update
Scenario Outline: Update user when user_contacts is correct
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_contacts' from value '<user_contacts>'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| user_contacts |
| none          |
| tabs          |
| spaces        |
| string(0)     |
| string(1)     |
| string(512)   |

@user @update
Scenario Outline: Update user when user is reader
Given set request token from global param 'reader_token'
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @update
Scenario Outline: Update user when user is writer
Given set request token from global param 'writer_token'
  And set request placeholder 'user_id' from global param 'writer_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @update
Scenario Outline: Update user when user is editor
Given set request token from global param 'editor_token'
  And set request placeholder 'user_id' from global param 'editor_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @update
Scenario Outline: Update user when user is admin
Given set request token from global param 'admin_token'
  And set request placeholder 'user_id' from global param 'admin_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @update
Scenario Outline: Update user when token is missing
Given delete request token
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'PUT' request to url 'user/:user_id'
 Then response code is '403'
