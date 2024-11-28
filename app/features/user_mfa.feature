Feature: Retrieve MFA

Background: Auth users
    # auth users
Given auth with user role 'admin'

@user @mfa
Scenario: Retrieve MFA when lock mode is enabled
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
  And save response param 'mfa_url' to global param 'mfa_url'
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '200'
  And response content is not empty
    # delete user
 When send 'GET' request to url 'user/:user_id'
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @mfa
Scenario: Retrieve MFA
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_caption' from fake 'user_caption'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
  And save response param 'mfa_url' to global param 'mfa_url'
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '200'
  And response content is not empty
    # delete user
 When send 'GET' request to url 'user/:user_id'
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
