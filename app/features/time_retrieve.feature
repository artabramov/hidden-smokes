Feature: Retrieve current time

@time @retrieve
Scenario: Retrieve time
   # retrieve hello
When send 'GET' request to url 'time'
Then response code is '200'
 And response params contain 'unix_timestamp'
 And response params contain 'timezone_name'
 And response params contain 'timezone_offset'
 And response contains '3' params
