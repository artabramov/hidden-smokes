Feature: User login

@user @login
Scenario: Login as admin user
    # user login
Given set request param 'user_login' from config param 'admin_login'
  And set request param 'user_password' from config param 'admin_password'
 When send 'GET' request to url 'auth/login/'
 Then response code is '200'
  And response params contain 'password_accepted'
    # token retrieve
Given set request param 'user_login' from config param 'admin_login'
  And generate request param 'user_totp' from config param 'admin_mfa_secret'
 When send 'GET' request to url 'auth/token/'
 Then response code is '200'
  And response params contain 'user_token'
    # token invalidate
Given set request token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token/'
 Then response code is '200'

@user @login
Scenario: Login as editor user
    # user login
Given set request param 'user_login' from config param 'editor_login'
  And set request param 'user_password' from config param 'editor_password'
 When send 'GET' request to url 'auth/login/'
 Then response code is '200'
  And response params contain 'password_accepted'
    # token retrieve
Given set request param 'user_login' from config param 'editor_login'
  And generate request param 'user_totp' from config param 'editor_mfa_secret'
 When send 'GET' request to url 'auth/token/'
 Then response code is '200'
  And response params contain 'user_token'
    # token invalidate
Given set request token from response param 'user_token'
 When send 'DELETE' request to url 'auth/token/'
 Then response code is '200'
