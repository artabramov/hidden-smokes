Feature: Auth user

@user @auth
Scenario Outline: Auth user when user_login is invalid (on first step)
    # login user
Given set request body param 'user_login' from value '<user_login>'
  And set request body param 'user_password' from value 'fake_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '422'
  And error loc is 'body' and 'user_login'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_login | error_type              |
| none       | missing                 |
| tabs       | string_pattern_mismatch |
| spaces     | string_pattern_mismatch |
| string(0)  | string_pattern_mismatch |
| string(1)  | string_pattern_mismatch |
| string(41) | string_pattern_mismatch |
| john doe   | string_pattern_mismatch |
| john-doe   | string_pattern_mismatch |
| john_doe   | string_pattern_mismatch |
| иванов     | string_pattern_mismatch |

@user @auth
Scenario: Auth user when user_login not found (on first step)
    # user login
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value 'fake_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '422'
  And error loc is 'body' and 'user_login'
  And error type is 'value_invalid'
  And response contains '1' params

@user @auth
Scenario Outline: Auth user when user_password is invalid (on first step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from value '<user_password>'
 When send 'POST' request to url 'auth/login'
 Then response code is '422'
  And error loc is 'body' and 'user_password'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_password | error_type       |
| none          | missing          |
| tabs          | value_invalid    |
| spaces        | value_invalid    |
| string(0)     | string_too_short |
| string(1)     | string_too_short |
| string(5)     | string_too_short |

@user @auth
Scenario: Auth user when user_password is not matched (on first step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from value 'fake_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '422'
  And error loc is 'body' and 'user_password'
  And error type is 'value_invalid'
  And response contains '1' params

@user @auth
Scenario Outline: Auth user when user_login is invalid (on second step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from value '<user_login>'
  And generate request query param 'user_totp' from config param 'reader_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '422'
  And error loc is 'query' and 'user_login'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_login | error_type              |
| none       | missing                 |
| tabs       | string_pattern_mismatch |
| spaces     | string_pattern_mismatch |
| string(0)  | string_pattern_mismatch |
| string(1)  | string_pattern_mismatch |
| string(41) | string_pattern_mismatch |
| john doe   | string_pattern_mismatch |
| john-doe   | string_pattern_mismatch |
| john_doe   | string_pattern_mismatch |
| иванов     | string_pattern_mismatch |

@user @auth
Scenario: Auth user when user_login not found (on second step)
    # token retrieve
Given set request query param 'user_login' from fake 'user_login'
  And set request query param 'user_totp' from value '123456'
 When send 'GET' request to url 'auth/token'
 Then response code is '422'
  And error loc is 'query' and 'user_login'
  And error type is 'value_invalid'
  And response contains '1' params

@user @auth
Scenario Outline: Auth user when user_totp is invalid (on second step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'reader_login'
  And set request query param 'user_totp' from value '<user_totp>'
 When send 'GET' request to url 'auth/token'
 Then response code is '422'
  And error loc is 'query' and 'user_totp'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_totp | error_type       |
| none      | missing          |
| tabs      | string_too_long  |
| spaces    | string_too_long  |
| string(0) | string_too_short |
| string(1) | string_too_short |
| string(5) | string_too_short |

@user @auth
Scenario: Auth user when user_totp is not matched (on second step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'reader_login'
  And set request query param 'user_totp' from value '000000'
 When send 'GET' request to url 'auth/token'
 Then response code is '422'
  And error loc is 'query' and 'user_totp'
  And error type is 'value_invalid'
  And response contains '1' params

@user @auth
Scenario Outline: Auth user when token_exp is invalid (on second step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'reader_login'
  And generate request query param 'user_totp' from config param 'reader_mfa_secret'
  And set request query param 'token_exp' from value '<token_exp>'
 When send 'GET' request to url 'auth/token'
 Then response code is '422'
  And error loc is 'query' and 'token_exp'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| token_exp  | error_type         |
| tabs       | int_parsing        |
| spaces     | int_parsing        |
| string(0)  | int_parsing        |
| string(1)  | int_parsing        |
| 0          | greater_than_equal |
| -1         | greater_than_equal |

@user @auth
Scenario Outline: Auth user when token_exp is correct (on second step)
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'reader_login'
  And generate request query param 'user_totp' from config param 'reader_mfa_secret'
  And set request query param 'token_exp' from value '<token_exp>'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'reader_token'
  And delete global param 'reader_id'

Examples:
| token_exp    |
| none         |
| 4102430400   |
| 4102430400.0 |

@user @auth
Scenario: Auth user when protected mode is enabled
Given auth with user role 'admin'
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # user login
Given set request body param 'user_login' from config param 'admin_login'
  And set request body param 'user_password' from config param 'admin_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # user login
Given set request body param 'user_login' from config param 'admin_login'
  And set request body param 'user_password' from config param 'admin_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'admin_login'
  And generate request query param 'user_totp' from config param 'admin_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'admin_login'
  And generate request query param 'user_totp' from config param 'admin_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'admin_token'
  And delete global param 'admin_id'

@user @auth
Scenario: Auth user when user_role is admin
    # user login
Given set request body param 'user_login' from config param 'admin_login'
  And set request body param 'user_password' from config param 'admin_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'admin_login'
  And generate request query param 'user_totp' from config param 'admin_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'admin_token'
  And delete global param 'admin_id'

@user @auth
Scenario: Auth user when user_role is editor
    # user login
Given set request body param 'user_login' from config param 'editor_login'
  And set request body param 'user_password' from config param 'editor_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'editor_login'
  And generate request query param 'user_totp' from config param 'editor_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'editor_token'
  And delete global param 'editor_id'

@user @auth
Scenario: Auth user when user_role is writer
    # user login
Given set request body param 'user_login' from config param 'writer_login'
  And set request body param 'user_password' from config param 'writer_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'writer_login'
  And generate request query param 'user_totp' from config param 'writer_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'writer_token'
  And delete global param 'writer_id'

@user @auth
Scenario: Auth user when user_role is reader
    # user login
Given set request body param 'user_login' from config param 'reader_login'
  And set request body param 'user_password' from config param 'reader_password'
 When send 'POST' request to url 'auth/login'
 Then response code is '200'
  And response params contain 'password_accepted'
  And response contains '1' params
    # token retrieve
Given set request query param 'user_login' from config param 'reader_login'
  And generate request query param 'user_totp' from config param 'reader_mfa_secret'
 When send 'GET' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_token'
  And response contains '1' params
    # token invalidate
Given set request header token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
    # delete outdated auth data
 Then delete global param 'reader_token'
  And delete global param 'reader_id'
