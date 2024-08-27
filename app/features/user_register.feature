Feature: User register

@user @register
Scenario Outline: When user_login is invalid
Given set request param 'user_login' from value '<user_login>'
  And set request param 'user_password' from value 'abcdef'
  And set request param 'first_name' from value 'John'
  And set request param 'last_name' from value 'Doe'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_login'
  And error type is '<error_type>'

Examples:
| user_login                                | error_type              |
| none                                      | missing                 |
| empty                                     | string_pattern_mismatch |
| spaces                                    | string_pattern_mismatch |
| tabs                                      | string_pattern_mismatch |
| a                                         | string_pattern_mismatch |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_pattern_mismatch |
| john doe                                  | string_pattern_mismatch |
| john-doe                                  | string_pattern_mismatch |
| john_doe                                  | string_pattern_mismatch |
| иванов                                    | string_pattern_mismatch |

@user @register
Scenario Outline: When user_password is invalid
Given set request param 'user_login' from value 'johndoe'
  And set request param 'user_password' from value '<user_password>'
  And set request param 'first_name' from value 'John'
  And set request param 'last_name' from value 'Doe'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_password'
  And error type is '<error_type>'

Examples:
| user_password | error_type  |
| none          | missing     |
| empty         | too_short   |
| spaces        | value_error |
| tabs          | value_error |
| a             | too_short   |
| aaaaa         | too_short   |

@user @register
Scenario Outline: When first_name is invalid
Given set request param 'user_login' from value 'johndoe'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from value '<first_name>'
  And set request param 'last_name' from value 'Doe'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'first_name'
  And error type is '<error_type>'

Examples:
| first_name                                | error_type       |
| none                                      | missing          |
| empty                                     | string_too_short |
| spaces                                    | value_error      |
| tabs                                      | value_error      |
| a                                         | string_too_short |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_too_long  |

@user @register
Scenario Outline: When last_name is invalid
Given set request param 'user_login' from value 'johndoe'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from value 'John'
  And set request param 'last_name' from value '<last_name>'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'last_name'
  And error type is '<error_type>'

Examples:
| last_name                                 | error_type       |
| none                                      | missing          |
| empty                                     | string_too_short |
| spaces                                    | value_error      |
| tabs                                      | value_error      |
| a                                         | string_too_short |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_too_long  |

@user @register
Scenario: When user register
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'POST' request to url 'user'
 Then response code is '200'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'