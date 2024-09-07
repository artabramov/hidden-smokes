Feature: Select time

@service @time
Scenario: Select time when user token is missing
When send 'GET' request to url 'time'
Then response code is '200'
