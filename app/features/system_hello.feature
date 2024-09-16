Feature: Systen hello

@system @hello
Scenario: Execute hello when user token is missing
When send 'GET' request to url 'system/hello'
Then response code is '200'
 And response params contain 'unix_timestamp'
 And response params contain 'timezone_name'
 And response params contain 'timezone_offset'
 And response params contain 'is_locked'
 And response contains '4' params